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
  ctx.logger.info('BeamMP hook active: onChatMessage -> OST_OnChatMessage')
end

function Commands.reply(playerId, message)
  if MP and type(MP.SendChatMessage) == 'function' then
    MP.SendChatMessage(playerId, '[OST] ' .. message)
    return
  end

  print(('[OST][reply] %s %s'):format(tostring(playerId), message))
end

function Commands.dispatch(ctx, playerId, playerName, command, args)
  local handled = false
  Registry.each(function(tool)
    if type(tool.onCommand) == 'function' then
      local result = tool.onCommand(ctx, playerId, playerName, command, args)
      if result == true then
        handled = true
      end
    end
  end)
  return handled
end

function Commands.handleChatMessage(ctx, playerId, playerName, message)
  local tokens = splitWords(message)
  if #tokens == 0 then
    return false
  end

  local root = table.remove(tokens, 1)
  if root ~= '/ost' and root ~= 'ost' then
    return false
  end

  local command = table.remove(tokens, 1) or 'help'

  if command == 'help' then
    Commands.reply(playerId, 'Commands: /ost countdown <seconds> [label], /ost countdown stop, /ost map, /ost flood start <preset>, /ost flood stop')
    return true
  end

  local handled = Commands.dispatch(ctx, playerId, playerName, command, tokens)
  if not handled then
    Commands.reply(playerId, ('Unknown command: %s'):format(command))
  end
  return true
end

return Commands
