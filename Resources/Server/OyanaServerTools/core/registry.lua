local Registry = {
  tools = {}
}

local toolPaths = {
  'tools.countdown.server',
  'tools.flood.server',
  'tools.map.server',
  'tools.admin.server',
}

function Registry.loadTools(ctx)
  for _, path in ipairs(toolPaths) do
    local ok, tool = pcall(require, path)
    if ok and tool then
      table.insert(Registry.tools, tool)
      if type(tool.init) == 'function' then
        tool.init(ctx)
      end
      ctx.logger.info(('Loaded tool: %s'):format(tool.name or path))
    else
      ctx.logger.error(('Failed loading tool %s: %s'):format(path, tostring(tool)))
    end
  end
end

function Registry.each(fn)
  for _, tool in ipairs(Registry.tools) do
    fn(tool)
  end
end

return Registry
