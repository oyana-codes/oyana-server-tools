local Tool = {
  name = 'admin'
}

function Tool.init(ctx)
  ctx.logger.info('Admin tool ready')
end

function Tool.onCommand(ctx, playerId, _playerName, command, args)
  if command ~= 'tools' then
    return false
  end

  if not ctx.permissions.isAdmin(playerId) then
    ctx.logger.warn(('Player %s tried to access admin tools'):format(tostring(playerId)))
    ctx.commands.reply(playerId, 'You do not have permission to use admin tools.')
    return true
  end

  local action = args and args[1] or 'list'
  ctx.events.sendToPlayer(playerId, 'OST:Admin:Action', { action = action })
  ctx.commands.reply(playerId, ('Admin action requested: %s'):format(action))
  return true
end

return Tool
