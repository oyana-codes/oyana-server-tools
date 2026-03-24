local Registry = require('core.registry')

local Commands = {}

function Commands.registerRoot(ctx)
  ctx.logger.info('Registered /ost command root')
  -- Hook into BeamMP chat command handling here.
end

function Commands.dispatch(ctx, playerId, command, args)
  Registry.each(function(tool)
    if type(tool.onCommand) == 'function' then
      tool.onCommand(ctx, playerId, command, args)
    end
  end)
end

return Commands
