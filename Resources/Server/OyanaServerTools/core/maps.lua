local capabilities = require('config.maps')

local Maps = {}

function Maps.getCurrentMap()
  return 'west_coast_usa'
end

function Maps.supports(mapName, capability)
  local entry = capabilities[mapName]
  if not entry or not entry.supports then
    return false
  end
  return entry.supports[capability] == true
end

return Maps
