SecPentruKickDacaNuDoarme = 900

avertisment = true


RegisterNetEvent("sv_primire")
AddEventHandler("sv_primire",function(bool)
sleep = bool
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
	if not sleep then --
		playerPed = GetPlayerPed(-1)
		if playerPed then
			PozitieCurenta = GetEntityCoords(playerPed, true)
				if PozitieCurenta == PozitiePrecedenta then
					if timp > 0 then
						if avertisment and timp == math.ceil(SecPentruKickDacaNuDoarme / 4) then
							TriggerEvent("chatMessage", "ATENTIE!", {255, 0, 0}, "^1O sa primesti automat kick in " .. timp .. " secunde daca mai stai AFK!")
						end

						timp = timp - 1
					else
						TriggerServerEvent("KickDacaNuDoarme")
					end
				else
					timp = SecPentruKickDacaNuDoarme
				end
			else
				vRPclient.notify(source,{'print verificat'})
			end		

			PozitiePrecedenta = PozitieCurenta
		end
	end
end)