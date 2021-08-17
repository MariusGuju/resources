local doors = {}

local LockHotkey = {0,46	}



RegisterNetEvent('vrpdoorsystem:load')

AddEventHandler('vrpdoorsystem:load', function(list)

  doors = list

end)





RegisterNetEvent('vrpdoorsystem:statusSend')

AddEventHandler('vrpdoorsystem:statusSend', function(i, status)

  doors[i].locked = status

end)





function searchIdDoor()

  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

  for k,v in pairs(doors) do

    if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 1.5 then

      return k

    end

  end

  return 0

end





Citizen.CreateThread(function()

  while true do

    Citizen.Wait(1)

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    for k,v in pairs(doors) do

      if Vdist(v.x,v.y,v.z,x,y,z) < 3.0 then

        if v.locked then

          Draw3DText(v.x+0.63,v.y,v.z+0.53, "Usa ~r~Incuiata")

        else

          Draw3DText(v.x+0.63,v.y,v.z+0.53, "Usa ~g~Descuiata")

        end

      end

    end

  end

end)





Citizen.CreateThread(function()

  while true do

    Citizen.Wait(10)

    if IsControlJustPressed(table.unpack(LockHotkey)) then

      local id = searchIdDoor()

      if id ~= 0 then

        TriggerServerEvent("vrpdoorsystem:open", id)

      end

    end

  end

end)





Citizen.CreateThread(function()

  while true do

    Citizen.Wait(10)

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    for k,v in pairs(doors) do

      if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 5 then

          local door = GetClosestObjectOfType(v.x,v.y,v.z, 1.0, v.hash, false, false, false)

          if door ~= 0 then

            SetEntityCanBeDamaged(door, false)

            if v.locked == false then

              NetworkRequestControlOfEntity(door)

              FreezeEntityPosition(door, false)

            else

              local locked, heading = GetStateOfClosestDoorOfType(v.hash, v.x,v.y,v.z, locked, heading)

              if heading > -0.02 and heading < 0.02 then

                NetworkRequestControlOfEntity(door)

                FreezeEntityPosition(door, true)

              end

            end

          end

      end

    end

  end

end)



function Draw3DText(x,y,z, text) 



  local onScreen,_x,_y=World3dToScreen2d(x,y,z)

  local px,py,pz=table.unpack(GetGameplayCamCoords())

  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)



  local scale = (1/dist)*0.5

  local fov = (1/GetGameplayCamFov())*100

  local scale = scale*fov

 

  if onScreen then

      SetTextScale(0.0*scale, 1.1*scale)

      SetTextFont(7)

      SetTextProportional(1)

      SetTextColour(255, 255, 255, 255)

      SetTextDropshadow(0, 0, 0, 0, 255)

      SetTextEdge(2, 0, 0, 0, 150)

      SetTextDropShadow()

      SetTextOutline()

      SetTextEntry("STRING")

      SetTextCentre(1)

      AddTextComponentString(text)

      DrawText(_x,_y)

  end

end