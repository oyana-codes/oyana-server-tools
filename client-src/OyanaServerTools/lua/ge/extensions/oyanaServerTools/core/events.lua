local Events = {}

function Events.handle(eventName, payload)
  print(('[OST][client event] %s %s'):format(eventName, tostring(payload or '')))
end

return Events
