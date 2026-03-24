local Shared = require('tools.countdown.shared')
local Config = require('tools.countdown.config')

local Tool = {
  name = 'countdown'
}

local function clampSeconds(seconds)
  if seconds < Config.minSeconds then
    return Config.minSeconds
  end
  if seconds > Config.maxSeconds then
    return Config.maxSeconds
  end
  return seconds
end

local function buildStatePayload(ctx)
  local state = ctx.state.countdown
  return {
    active = state.active and 'true' or 'false',
    label = state.label,
    secondsLeft = state.secondsLeft,
    totalSeconds = state.totalSeconds,
  }
end

local function emitState(ctx, eventName)
  ctx.events.broadcast(eventName, buildStatePayload(ctx))
end

local function syncStateToPlayer(ctx, playerId)
  local state = ctx.state.countdown
  if not state.active then
    return
  end

  ctx.events.sendToPlayer(playerId, Shared.START, buildStatePayload(ctx))
end

local function stopCountdown(ctx, reason)
  local state = ctx.state.countdown
  if not state.active and reason ~= 'complete' then
    return false
  end

  state.active = false
  state.nextTickAt = nil

  if reason == 'complete' then
    emitState(ctx, Shared.COMPLETE)
  else
    emitState(ctx, Shared.STOP)
  end

  ctx.logger.info(('Countdown stopped (%s)'):format(reason or 'manual'))
  return true
end

local function startCountdown(ctx, playerId, requestedSeconds, label)
  local seconds = clampSeconds(tonumber(requestedSeconds) or Config.defaultSeconds)
  local state = ctx.state.countdown
  state.active = true
  state.secondsLeft = seconds
  state.totalSeconds = seconds
  state.label = label or Config.defaultLabel
  state.startedBy = playerId
  state.nextTickAt = os.clock() + 1

  emitState(ctx, Shared.START)
  ctx.logger.info(('Player %s started countdown for %s seconds'):format(tostring(playerId), tostring(seconds)))
  return seconds
end

function Tool.init(ctx)
  ctx.logger.info('Countdown tool ready')
end

function Tool.onPlayerJoining(ctx, playerId)
  syncStateToPlayer(ctx, playerId)
end

function Tool.onCommand(ctx, playerId, _playerName, command, args)
  if command ~= 'countdown' then
    return false
  end

  local action = args and args[1] or 'start'

  if action == 'stop' then
    if stopCountdown(ctx, 'manual') then
      ctx.commands.reply(playerId, 'Countdown stopped.')
    else
      ctx.commands.reply(playerId, 'No active countdown to stop.')
    end
    return true
  end

  local seconds = action
  local labelParts = {}
  for index = 2, #(args or {}) do
    table.insert(labelParts, args[index])
  end
  local label = #labelParts > 0 and table.concat(labelParts, ' ') or Config.defaultLabel

  local startedSeconds = startCountdown(ctx, playerId, seconds, label)
  ctx.commands.reply(playerId, ('Countdown started for %d seconds (%s).'):format(startedSeconds, label))
  return true
end

function Tool.update(ctx, now)
  local state = ctx.state.countdown
  if not state.active then
    return
  end

  local currentTime = now or os.clock()
  if not state.nextTickAt or currentTime < state.nextTickAt then
    return
  end

  state.secondsLeft = state.secondsLeft - 1
  state.nextTickAt = currentTime + 1

  if state.secondsLeft <= 0 then
    state.secondsLeft = 0
    stopCountdown(ctx, 'complete')
    return
  end

  emitState(ctx, Shared.TICK)
end

Tool.startCountdown = startCountdown
Tool.stopCountdown = stopCountdown

return Tool
