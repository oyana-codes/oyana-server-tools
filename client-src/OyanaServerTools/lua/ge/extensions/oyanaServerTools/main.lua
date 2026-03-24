local M = {}

local Logger = require('lua/ge/extensions/oyanaServerTools/core/logger')
local State = require('lua/ge/extensions/oyanaServerTools/core/state')
local UI = require('lua/ge/extensions/oyanaServerTools/core/ui')
local Events = require('lua/ge/extensions/oyanaServerTools/core/events')
local Countdown = require('lua/ge/extensions/oyanaServerTools/tools/countdown')
local Flood = require('lua/ge/extensions/oyanaServerTools/tools/flood')
local Map = require('lua/ge/extensions/oyanaServerTools/tools/map')
local Admin = require('lua/ge/extensions/oyanaServerTools/tools/admin')

local tools = { Countdown, Flood, Map, Admin }
local registeredEvents = {
  'OST:Countdown:Start',
  'OST:Countdown:Tick',
  'OST:Countdown:Stop',
  'OST:Countdown:Complete',
  'OST:Flood:Start',
  'OST:Flood:Stop',
  'OST:Map:Detected',
  'OST:Admin:Action',
}

local function buildContext()
  return {
    state = State,
    ui = UI,
    logger = Logger,
  }
end

local function initTools()
  local ctx = buildContext()
  for _, tool in ipairs(tools) do
    if type(tool.init) == 'function' then
      tool.init(ctx)
    end
  end
end

local function registerBeamMPHandlers()
  if type(AddEventHandler) ~= 'function' then
    Logger.warn('AddEventHandler unavailable; OST client will only run in local test mode')
    return
  end

  for _, eventName in ipairs(registeredEvents) do
    AddEventHandler(eventName, function(payload)
      M.onServerEvent(eventName, payload)
    end)
  end

  Logger.info('Registered BeamMP client event handlers')
end

function M.onExtensionLoaded()
  Logger.info('Client extension loaded')
  initTools()
  registerBeamMPHandlers()
end

function M.onServerEvent(eventName, payload)
  Events.handle(eventName, payload)
end

return M
