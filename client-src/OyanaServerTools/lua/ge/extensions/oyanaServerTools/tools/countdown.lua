local Events = require('lua/ge/extensions/oyanaServerTools/core/events')
local Sounds = require('lua/ge/extensions/oyanaServerTools/core/sounds')

local Tool = {}

local function emitUi(ctx, extra)
  local state = {
    active = ctx.state.countdown.active,
    secondsLeft = ctx.state.countdown.secondsLeft,
    totalSeconds = ctx.state.countdown.totalSeconds,
    label = ctx.state.countdown.label,
    completed = extra and extra.completed or false,
  }

  ctx.ui.emit('OST:UI:CountdownState', state)
end

function Tool.init(ctx)
  ctx.logger.info('Client countdown tool ready')

  Events.register('OST:Countdown:Start', function(payload)
    ctx.state.countdown.active = payload.active == true
    ctx.state.countdown.secondsLeft = payload.secondsLeft or 0
    ctx.state.countdown.totalSeconds = payload.totalSeconds or payload.secondsLeft or 0
    ctx.state.countdown.label = payload.label or 'Countdown'
    Sounds.play('ost_countdown_start')
    emitUi(ctx)
  end)

  Events.register('OST:Countdown:Tick', function(payload)
    ctx.state.countdown.active = payload.active == true
    ctx.state.countdown.secondsLeft = payload.secondsLeft or 0
    ctx.state.countdown.totalSeconds = payload.totalSeconds or ctx.state.countdown.totalSeconds
    ctx.state.countdown.label = payload.label or ctx.state.countdown.label
    Sounds.play('ost_countdown_tick')
    emitUi(ctx)
  end)

  Events.register('OST:Countdown:Stop', function(payload)
    ctx.state.countdown.active = false
    ctx.state.countdown.secondsLeft = payload.secondsLeft or 0
    ctx.state.countdown.label = payload.label or ctx.state.countdown.label
    Sounds.play('ost_countdown_stop')
    emitUi(ctx)
  end)

  Events.register('OST:Countdown:Complete', function(payload)
    ctx.state.countdown.active = false
    ctx.state.countdown.secondsLeft = 0
    ctx.state.countdown.label = payload.label or ctx.state.countdown.label
    Sounds.play('ost_countdown_complete')
    emitUi(ctx, { completed = true })
  end)

  ctx.ui.emit('OST:UI:FeatureReady', 'countdown')
end

return Tool
