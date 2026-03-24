local Registry = require('core.registry')

local Commands = {}

local function splitWords(text)
  local words = {}
  for token in string.gmatch(text or '', '%S+') do
    table.insert(words, token)
  end
  return words
end

function Commands.registerRoot(ctx)
  ctx.logger.info('Registered /ost command root')
  ctx.logger.info('Hook Server.handleChatMessage(playerId, message) into BeamMP chat callbacks')
end

function Commands.dispatch(ctx, playerId, command, args)
  Registry.each(function(tool)
    if type(tool.onCommand) == 'function' then
      tool.onCommand(ctx, playerId, command, args)
    end
  end)
end

function Commands.handleChatMessage(ctx, playerId, message)
  local tokens = splitWords(message)
  if #tokens == 0 then
    return false
  end

  local root = table.remove(tokens, 1)
  if root ~= '/ost' and root ~= 'ost' then
    return false
  end

  local command = table.remove(tokens, 1) or 'help'
  Commands.dispatch(ctx, playerId, command, tokens)
  return true
end

return Commands
