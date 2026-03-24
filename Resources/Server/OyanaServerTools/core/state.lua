local State = {
  tools = {},
  countdown = {
    active = false,
    secondsLeft = 0,
    totalSeconds = 0,
    label = 'Countdown',
    startedBy = nil,
    nextTickAt = nil,
  },
  flood = {
    active = false,
    speed = 0,
    preset = nil,
  }
}

return State
