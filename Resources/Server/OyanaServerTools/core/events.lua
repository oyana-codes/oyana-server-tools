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

local function triggerClientEvent(playerId, eventName, payload)
  if MP and type(MP.TriggerClientEvent) == 'function' then
    return MP.TriggerClientEvent(playerId, eventName, Events.encode(payload))
  end

  print(('[OST][dry-run][event] %s -> %s %s'):format(tostring(playerId), eventName, Events.encode(payload)))
  return true
end

function Events.broadcast(eventName, payload)
  local ok, err = triggerClientEvent(-1, eventName, payload)
  if ok == false then
    print(('[OST][broadcast][error] %s %s'):format(eventName, tostring(err or 'unknown error')))
  end
end

function Events.sendToPlayer(playerId, eventName, payload)
  local ok, err = triggerClientEvent(playerId, eventName, payload)
  if ok == false then
    print(('[OST][sendToPlayer][error] %s -> %s %s'):format(tostring(playerId), eventName, tostring(err or 'unknown error')))
  end
end

return Events
