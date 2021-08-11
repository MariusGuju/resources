
local noclip = false
local noclip_speed = 5.0

function tvRP.toggleNoclip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- set
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false, false)
  else -- unset
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)
  end
end

function tvRP.isNoclip()
  return noclip
end

-- noclip/invisibility
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if noclip then
      local ped = GetPlayerPed(-1)
      local x,y,z = tvRP.getPosition()
      local dx,dy,dz = tvRP.getCamDirection()
      local speed = noclip_speed

      -- reset velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

      -- forward
      if IsControlPressed(0,32) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- backward
      if IsControlPressed(0,269) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end

      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
  end
end)

featureSpectate = false

function tvRP.spectatePlayer(target)
	local playerPed = GetPlayerPed(-1)
	
	for i = 0, 256 do
		if NetworkIsPlayerConnected(i) then
			local serverID = GetPlayerServerId(i)
			if(serverID == target)then
				targetPlayer = i
			end
		end
	end
	
	targetPed = GetPlayerPed(targetPlayer)
	targetName = GetPlayerName(targetPlayer)
	if not(featureSpectate)then
		if (not IsScreenFadedOut() and not IsScreenFadingOut()) then
			DoScreenFadeOut(1000)
			while (not IsScreenFadedOut()) do
				Wait(0)
			end

			local targetpos = GetEntityCoords(targetPed, false)

			RequestCollisionAtCoord(targetpos['x'],targetpos['y'],targetpos['z'])
			NetworkSetInSpectatorMode(true, targetPed)

			if(IsScreenFadedOut()) then
				DoScreenFadeIn(1000)
			end
		end
		featureSpectate = true

		tvRP.notify("Spectating ~b~<C>"..targetName.."</C>.")
	else
		if(not IsScreenFadedOut() and not IsScreenFadingOut()) then
			DoScreenFadeOut(1000)
			while (not IsScreenFadedOut()) do
				Wait(0)
			end
				
			featureSpectate = false
			
			local targetpos = GetEntityCoords(playerPed, false)

			RequestCollisionAtCoord(targetpos['x'],targetpos['y'],targetpos['z'])
			NetworkSetInSpectatorMode(false, targetPed)

			if(IsScreenFadedOut()) then
				DoScreenFadeIn(1000)
			end
		end

		tvRP.notify("Stopped Spectating ~b~<C>"..targetName.."</C>.")
	end
end