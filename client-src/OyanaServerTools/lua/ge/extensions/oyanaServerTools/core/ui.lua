local UI = {}

function UI.emit(eventName, payload)
  print(('[OST][ui] %s %s'):format(eventName, tostring(payload or '')))
  -- Replace with BeamNG UI bridge, guihooks, or custom interface wiring.
end

return UI
