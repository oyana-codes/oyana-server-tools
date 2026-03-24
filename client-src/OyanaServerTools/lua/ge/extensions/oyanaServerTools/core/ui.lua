local UI = {}

local function triggerGuiHook(name, payload)
  if guihooks and guihooks.trigger then
    guihooks.trigger(name, payload)
    return true
  end
  return false
end

function UI.emit(eventName, payload)
  print(('[OST][ui] %s %s'):format(eventName, tostring(payload or '')))

  if eventName == 'OST:UI:CountdownState' and type(payload) == 'table' then
    local text = tostring(payload.secondsLeft or '')
    if payload.active and tonumber(payload.secondsLeft or 0) > 0 then
      triggerGuiHook('ScenarioFlashMessage', {
        payload.label or 'Countdown',
        1,
        'event:>UI>Career>Buy_01',
        false,
      })
      triggerGuiHook('toastrMsg', {
        type = 'info',
        title = payload.label or 'Countdown',
        msg = text,
      })
    elseif payload.completed then
      triggerGuiHook('ScenarioFlashMessage', {
        payload.label or 'Countdown',
        2,
        'event:>UI>Career>Buy_01',
        true,
      })
    end
  end

  -- Placeholder for a custom HTML/JS bridge.
  -- Replace with the real BeamNG UI communication mechanism when wired.
end

return UI
