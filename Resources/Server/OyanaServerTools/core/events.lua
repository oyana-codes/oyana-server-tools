local Events = {}

function Events.broadcast(eventName, payload)
  print(('[OST][broadcast] %s %s'):format(eventName, tostring(payload or '')))
  -- Replace with BeamMP TriggerClientEvent broadcast wrapper.
end

function Events.sendToPlayer(playerId, eventName, payload)
  print(('[OST][sendToPlayer] %s -> %s %s'):format(tostring(playerId), eventName, tostring(payload or '')))
  -- Replace with BeamMP TriggerClientEvent(playerId, eventName, payload)
end

return Events
