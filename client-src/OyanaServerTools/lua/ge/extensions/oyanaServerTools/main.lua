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

function M.onExtensionLoaded()
  Logger.info('Client extension loaded')
  initTools()
end

function M.onServerEvent(eventName, payload)
  Events.handle(eventName, payload)
end

return M
