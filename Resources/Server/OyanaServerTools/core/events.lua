local Events = {}

local function escapeValue(value)
  local text = tostring(value or '')
  text = text:gsub('%%', '%%25')
  text = text:gsub(';', '%%3B')
  text = text:gsub('=', '%%3D')
  return text
end

function Events.encode(payload)
  if type(payload) ~= 'table' then
    return tostring(payload or '')
  end

  local parts = {}
  for key, value in pairs(payload) do
    table.insert(parts, tostring(key) .. '=' .. escapeValue(value))
  end
  table.sort(parts)
  return table.concat(parts, ';')
end

function Events.broadcast(eventName, payload)
  local encoded = Events.encode(payload)
  print(('[OST][broadcast] %s %s'):format(eventName, encoded))
  -- Replace with BeamMP broadcast wrapper, for example:
  -- MP.TriggerClientEvent(-1, eventName, encoded)
end

function Events.sendToPlayer(playerId, eventName, payload)
  local encoded = Events.encode(payload)
  print(('[OST][sendToPlayer] %s -> %s %s'):format(tostring(playerId), eventName, encoded))
  -- Replace with BeamMP targeted wrapper, for example:
  -- MP.TriggerClientEvent(playerId, eventName, encoded)
end

return Events
