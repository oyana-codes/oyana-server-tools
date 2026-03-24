local Tool = {}

function Tool.init(ctx)
  ctx.logger.info('Client countdown tool ready')
  ctx.ui.emit('OST:UI:FeatureReady', 'countdown')
end

return Tool
