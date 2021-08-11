vRP = Proxy.getInterface("vRP")
-- Admin Menu Hot Key (WIP)
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(1000)
	  if IsControlPressed(1, 56) then -- F9
		vRPserver.openAdminMenu({})
		end
	end
end)

-- Police Menu Hot Key
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(1000)
	  if IsControlPressed(1, 57) then -- F10
		vRPserver.openPoliceMenu({})
		end
	end
end)
