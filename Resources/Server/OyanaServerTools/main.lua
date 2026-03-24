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

init()

return Server
