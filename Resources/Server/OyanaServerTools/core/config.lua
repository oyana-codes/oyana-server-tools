local Config = {}

function Config.load()
  return {
    namespace = 'OST',
    enabledTools = {
      countdown = true,
      flood = true,
      map = true,
      admin = true,
    }
  }
end

return Config
