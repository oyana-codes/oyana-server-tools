local Tool = {
  name = 'flood'
}

function Tool.init(ctx)
  ctx.logger.info('Flood tool ready')
end

function Tool.onCommand(ctx, playerId, _playerName, command, args)
  if command ~= 'flood' then
    return false
  end

  local mapName = ctx.maps.getCurrentMap()
  if not ctx.maps.supports(mapName, 'flood') then
    ctx.logger.warn(('Flood not supported on map %s'):format(mapName))
    ctx.commands.reply(playerId, ('Flood is not supported on %s.'):format(mapName))
    return true
  end

  local action = args and args[1] or 'start'

  if action == 'stop' then
    ctx.state.flood.active = false
    ctx.events.broadcast('OST:Flood:Stop', { active = 'false' })
    ctx.commands.reply(playerId, 'Flood stopped.')
    return true
  end

  local preset = args and args[2] or 'normal'
  ctx.state.flood.active = true
  ctx.state.flood.preset = preset
  ctx.events.broadcast('OST:Flood:Start', { active = 'true', preset = preset })
  ctx.logger.info(('Player %s started flood preset %s'):format(tostring(playerId), tostring(preset)))
  ctx.commands.reply(playerId, ('Flood started with preset %s.'):format(preset))
  return true
end

return Tool
