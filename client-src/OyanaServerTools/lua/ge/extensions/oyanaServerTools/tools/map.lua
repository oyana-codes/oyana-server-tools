local Tool = {}

function Tool.init(ctx)
  ctx.logger.info('Client map tool ready')
  ctx.ui.emit('OST:UI:FeatureReady', 'map')
end

return Tool
