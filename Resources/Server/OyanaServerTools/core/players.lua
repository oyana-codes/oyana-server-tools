local Players = {
  byId = {}
}

function Players.set(playerId, data)
  Players.byId[playerId] = data
end

function Players.get(playerId)
  return Players.byId[playerId]
end

return Players
