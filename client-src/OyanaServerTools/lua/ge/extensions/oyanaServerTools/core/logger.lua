local Logger = {}

local function log(level, message)
  print(('[OST][client][%s] %s'):format(level, message))
end

function Logger.info(message) log('INFO', message) end
function Logger.warn(message) log('WARN', message) end
function Logger.error(message) log('ERROR', message) end

return Logger
