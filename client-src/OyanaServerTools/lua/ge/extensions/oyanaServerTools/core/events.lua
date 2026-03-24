local Events = {
  handlers = {}
}

local function decodeValue(value)
  local text = tostring(value or '')
  text = text:gsub('%%3D', '=')
  text = text:gsub('%%3B', ';')
  text = text:gsub('%%25', '%%')

  if text == 'true' then
    return true
  end
  if text == 'false' then
    return false
  end

  local numberValue = tonumber(text)
  if numberValue ~= nil then
    return numberValue
  end

  return text
end

function Events.decode(payload)
  if type(payload) == 'table' then
    return payload
  end

  local result = {}
  local raw = tostring(payload or '')
  if raw == '' then
    return result
  end

  for pair in string.gmatch(raw, '[^;]+') do
    local key, value = pair:match('([^=]+)=(.*)')
    if key then
      result[key] = decodeValue(value)
    end
  end

  return result
end

function Events.register(eventName, handler)
  Events.handlers[eventName] = Events.handlers[eventName] or {}
  table.insert(Events.handlers[eventName], handler)
end

function Events.handle(eventName, payload)
  local decoded = Events.decode(payload)
  print(('[OST][client event] %s'):format(eventName))

  local handlers = Events.handlers[eventName] or {}
  for _, handler in ipairs(handlers) do
    handler(decoded)
  end
end

return Events
