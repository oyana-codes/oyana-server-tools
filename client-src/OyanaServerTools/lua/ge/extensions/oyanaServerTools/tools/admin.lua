local Tool = {}

function Tool.init(ctx)
  ctx.logger.info('Client admin tool ready')
  ctx.ui.emit('OST:UI:FeatureReady', 'admin')
end

return Tool
