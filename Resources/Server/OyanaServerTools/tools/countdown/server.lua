local Tool = {
  name = 'countdown'
}

function Tool.init(ctx)
  ctx.logger.info('Countdown tool ready')
end

function Tool.onCommand(ctx, playerId, command, args)
  if command ~= 'countdown' then
    return
  end

  local seconds = tonumber(args and args[1]) or 5
  ctx.state.countdown.active = true
  ctx.state.countdown.secondsLeft = seconds
  ctx.events.broadcast('OST:Countdown:Start', tostring(seconds))
  ctx.logger.info(('Player %s started countdown for %s seconds'):format(tostring(playerId), tostring(seconds)))
end

return Tool
