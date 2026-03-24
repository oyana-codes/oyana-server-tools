local Tool = {}

function Tool.init(ctx)
  ctx.logger.info('Client flood tool ready')
  ctx.ui.emit('OST:UI:FeatureReady', 'flood')
end

return Tool
