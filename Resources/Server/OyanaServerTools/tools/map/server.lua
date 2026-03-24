local Tool = {
  name = 'map'
}

function Tool.init(ctx)
  local currentMap = ctx.maps.getCurrentMap()
  ctx.logger.info(('Map tool ready on %s'):format(currentMap))
end

function Tool.onCommand(ctx, playerId, _playerName, command, _args)
  if command ~= 'map' then
    return false
  end

  local currentMap = ctx.maps.getCurrentMap()
  ctx.events.sendToPlayer(playerId, 'OST:Map:Detected', { map = currentMap })
  ctx.commands.reply(playerId, ('Current map: %s'):format(currentMap))
  return true
end

return Tool
