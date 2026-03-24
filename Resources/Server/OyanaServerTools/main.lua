local Registry = require('core.registry')
local Events = require('core.events')
local Commands = require('core.commands')
local Logger = require('core.logger')
local Config = require('core.config')

local Server = {
  ctx = nil,
  tickEventName = 'OST:Core:Tick',
  tickIntervalMs = 250,
}

local function buildContext()
  return {
    config = Config.load(),
    events = Events,
    commands = Commands,
    logger = Logger,
    state = require('core.state'),
    maps = require('core.maps'),
    permissions = require('core.permissions'),
    players = require('core.players'),
  }
end

local function init()
  Server.ctx = buildContext()
  Registry.loadTools(Server.ctx)
  Commands.registerRoot(Server.ctx)
  Logger.info('Oyana Server Tools initialized')
end

function Server.handleChatMessage(playerId, playerName, message)
  if not Server.ctx then
    return false
  end
  return Commands.handleChatMessage(Server.ctx, playerId, playerName, message)
end

function Server.handlePlayerJoining(playerId)
  if not Server.ctx then
    return
  end

  Server.ctx.players.set(playerId, {
    id = playerId,
    name = MP and MP.GetPlayerName and MP.GetPlayerName(playerId) or tostring(playerId),
  })

  Registry.each(function(tool)
    if type(tool.onPlayerJoining) == 'function' then
      tool.onPlayerJoining(Server.ctx, playerId)
    end
  end)
end

function Server.handlePlayerDisconnect(playerId)
  if not Server.ctx then
    return
  end

  Server.ctx.players.set(playerId, nil)

  Registry.each(function(tool)
    if type(tool.onPlayerDisconnect) == 'function' then
      tool.onPlayerDisconnect(Server.ctx, playerId)
    end
  end)
end

function Server.update(now)
  if not Server.ctx then
    return
  end

  Registry.each(function(tool)
    if type(tool.update) == 'function' then
      tool.update(Server.ctx, now or os.clock())
    end
  end)
end

local function registerBeamMPHooks()
  if not MP or type(MP.RegisterEvent) ~= 'function' then
    Logger.warn('BeamMP MP API not present yet; running in dry mode')
    return
  end

  MP.RegisterEvent('onInit', 'OST_OnInit')
  MP.RegisterEvent('onChatMessage', 'OST_OnChatMessage')
  MP.RegisterEvent('onPlayerJoining', 'OST_OnPlayerJoining')
  MP.RegisterEvent('onPlayerDisconnect', 'OST_OnPlayerDisconnect')
  MP.RegisterEvent(Server.tickEventName, 'OST_OnTick')

  Logger.info('Registered BeamMP event hooks')
end

function OST_OnInit()
  init()

  if MP and type(MP.CreateEventTimer) == 'function' then
    MP.CancelEventTimer(Server.tickEventName)
    MP.CreateEventTimer(Server.tickEventName, Server.tickIntervalMs)
    Logger.info(('Registered tick timer every %d ms'):format(Server.tickIntervalMs))
  else
    Logger.warn('MP.CreateEventTimer unavailable; countdown ticking disabled')
  end
end

function OST_OnTick()
  Server.update(os.clock())
end

function OST_OnChatMessage(playerId, playerName, message)
  local handled = Server.handleChatMessage(playerId, playerName, message)
  if handled then
    return 1
  end
  return 0
end

function OST_OnPlayerJoining(playerId)
  Server.handlePlayerJoining(playerId)
end

function OST_OnPlayerDisconnect(playerId)
  Server.handlePlayerDisconnect(playerId)
end

registerBeamMPHooks()

return Server
