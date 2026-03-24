local Tool = {
  name = 'flood'
}

function Tool.init(ctx)
  ctx.logger.info('Flood tool ready')
end

function Tool.onCommand(ctx, playerId, command, args)
  if command ~= 'flood' then
    return
  end

  local mapName = ctx.maps.getCurrentMap()
  if not ctx.maps.supports(mapName, 'flood') then
    ctx.logger.warn(('Flood not supported on map %s'):format(mapName))
    return
  end

  local action = args and args[1] or 'start'

  if action == 'stop' then
    ctx.state.flood.active = false
    ctx.events.broadcast('OST:Flood:Stop', '{}')
    return
  end

  local preset = args and args[2] or 'normal'
  ctx.state.flood.active = true
  ctx.state.flood.preset = preset
  ctx.events.broadcast('OST:Flood:Start', preset)
  ctx.logger.info(('Player %s started flood preset %s'):format(tostring(playerId), tostring(preset)))
end

return Tool
