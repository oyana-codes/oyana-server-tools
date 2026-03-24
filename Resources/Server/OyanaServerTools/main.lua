local Registry = require('core.registry')
local Events = require('core.events')
local Commands = require('core.commands')
local Logger = require('core.logger')
local Config = require('core.config')

local Server = {
  ctx = nil,
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

function Server.handleChatMessage(playerId, message)
  if not Server.ctx then
    return false
  end
  return Commands.handleChatMessage(Server.ctx, playerId, message)
end

function Server.update(dt)
  if not Server.ctx then
    return
  end

  Registry.each(function(tool)
    if type(tool.update) == 'function' then
      tool.update(Server.ctx, os.clock())
    end
  end)
end

init()

return Server
