local Players = {
  byId = {}
}

function Players.set(playerId, data)
  if data == nil then
    Players.byId[playerId] = nil
    return
  end

  Players.byId[playerId] = data
end

function Players.get(playerId)
  return Players.byId[playerId]
end

return Players
