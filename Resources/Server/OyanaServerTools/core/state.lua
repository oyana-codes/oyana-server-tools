local State = {
  tools = {},
  countdown = {
    active = false,
    secondsLeft = 0,
  },
  flood = {
    active = false,
    speed = 0,
    preset = nil,
  }
}

return State
