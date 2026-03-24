local Tool = {
  name = 'admin'
}

function Tool.init(ctx)
  ctx.logger.info('Admin tool ready')
end

function Tool.onCommand(ctx, playerId, command, args)
  if command ~= 'tools' then
    return
  end

  if not ctx.permissions.isAdmin(playerId) then
    ctx.logger.warn(('Player %s tried to access admin tools'):format(tostring(playerId)))
    return
  end

  local action = args and args[1] or 'list'
  ctx.events.sendToPlayer(playerId, 'OST:Admin:Action', action)
end

return Tool
