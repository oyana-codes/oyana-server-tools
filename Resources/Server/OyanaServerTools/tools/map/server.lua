local Tool = {
  name = 'map'
}

function Tool.init(ctx)
  local currentMap = ctx.maps.getCurrentMap()
  ctx.logger.info(('Map tool ready on %s'):format(currentMap))
end

function Tool.onCommand(ctx, playerId, command, _args)
  if command ~= 'map' then
    return
  end

  local currentMap = ctx.maps.getCurrentMap()
  ctx.events.sendToPlayer(playerId, 'OST:Map:Detected', currentMap)
end

return Tool
