frozen = false

function tvRP.toggleFreeze()
   frozen = not frozen
    if frozen then
      FreezeEntityPosition(GetPlayerPed(-1), true)
    else
      FreezeEntityPosition(GetPlayerPed(-1), false)
    end
end