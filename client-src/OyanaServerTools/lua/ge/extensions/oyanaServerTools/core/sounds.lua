local Sounds = {}

function Sounds.play(name)
  print(('[OST][sound] %s'):format(name))

  if Engine and Engine.Audio and Engine.Audio.playOnce then
    Engine.Audio.playOnce(name)
    return
  end
end

return Sounds
