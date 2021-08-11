fDeliverySpawnLoc = nil
fDelScooter = nil
fDelBlip = nil
fDelLocations = nil
fDelCurrentLoc = 0
fDelLocBlip = nil
fDelStarted = false
isDoingOrder = false

function vRPjobsC.fDeliveryPopulateData(fDelSpawnLoc, fDeliveryLocations)
	fDeliverySpawnLoc = fDelSpawnLoc
	fDelLocations = fDeliveryLocations
	SetNewWaypoint(fDeliverySpawnLoc[1], fDeliverySpawnLoc[2])
end


function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

function vRPjobsC.deleteDeliveryScooter()
	if(DoesEntityExist(fDelScooter))then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fDelScooter))
		fDelScooter = nil
	end
end

function vRPjobsC.cancelDeliveryJob()
	vRPjobsC.deleteDeliveryScooter()
	vRPSjobs.stopFoodDelivery({})
	fDelStarted = false
	vRP.notify({"[UBER EATZ] ~r~Cursa de ~y~Uber Eatz ~r~a fost anulata!"})
	if(DoesBlipExist(fDelLocBlip))then
		RemoveBlip(fDelLocBlip)
		fDelLocBlip = nil
	end
end

function vRPjobsC.spawnFoodDeliveryScooter()
	fDelLocations = shuffle(fDelLocations)
	if(fDelScooter == nil)then
		vRP.notify({"[UBER EATZ] ~g~Asteapta pana ce primesti o comanda!"})
		coords = GetEntityCoords(GetPlayerPed(-1), true)
		vehicle = GetHashKey("faggio")
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Citizen.Wait(0)
		end
		fDelScooter = CreateVehicle(vehicle, coords.x, coords.y, coords.z+0.5, 123.6125793457, true, false)
		SetVehicleOnGroundProperly(fDelScooter)
		SetEntityInvincible(fDelScooter, false)
		SetPedIntoVehicle(GetPlayerPed(-1), fDelScooter, -1)
		Citizen.InvokeNative(0xAD738C3085FE7E11, fDelScooter, true, true) -- set as mission entity
		SetVehicleHasBeenOwnedByPlayer(fDelScooter, true)
		SetModelAsNoLongerNeeded(vehicle)
		vRPjobsC.makeNewOrder()
	end
end

function vRPjobsC.makeNewOrder()
	newTimer = math.random(2000, 8000)
	if(DoesBlipExist(fDelBlip))then
		RemoveBlip(fDelBlip)
		fDelBlip = nil
	end
	isDoingOrder = false
	if(fDelCurrentLoc + 1 <= #fDelLocations)then
		fDelCurrentLoc = fDelCurrentLoc + 1
		SetTimeout(newTimer, function()
			vRPjobsC.takeDeliveryOrder()
		end)
	else
		vRP.notify({"[UBER EATZ] ~g~Ti-ai terminat tura pe astazi! Intoarce-te la restaurant!"})
	end
end

function vRPjobsC.executeFoodDelivery()
	newTimer = math.random(100, 600)
	vRP.notify({"[UBER EATZ] ~g~Asteapta pana cand cineva va raspunde la usa!"})
	SetTimeout(newTimer, function()
		if(isDoingOrder)then
			vRPSjobs.payFoodDeliveryDriver({})
			vRPjobsC.makeNewOrder()
		end
	end)
end

function vRPjobsC.takeDeliveryOrder()
	x, y, z = fDelLocations[fDelCurrentLoc][1], fDelLocations[fDelCurrentLoc][2], fDelLocations[fDelCurrentLoc][3]
	local var1, var2 = GetStreetNameAtCoord(x, y, z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local zone = tostring(GetNameOfZone(x, y, z))
	if tostring(GetStreetNameFromHashKey(var2)) == "" then
		streetName = tostring(GetStreetNameFromHashKey(var1))
	else
		streetName = tostring(GetStreetNameFromHashKey(var2))
	end
	fDelStarted = true
	vRP.notify({"[UBER EATZ] ~g~Ai o comanda pe ~b~"..streetName.." ~g~in zona ~y~"..zone})
	if(fDelLocBlip == nil)then
		fDelLocBlip = AddBlipForCoord(x, y, z)
		SetBlipRoute(fDelLocBlip, true)
		SetBlipSprite(fDelLocBlip, 270)
		SetBlipColour(fDelLocBlip, 2)
		SetBlipRouteColour(fDelLocBlip, 2)
	else
		if(DoesBlipExist(fDelLocBlip))then
			RemoveBlip(fDelLocBlip)
			fDelLocBlip = AddBlipForCoord(x, y, z)
			SetBlipRoute(fDelLocBlip, true)
			SetBlipSprite(fDelLocBlip, 270)
			SetBlipColour(fDelLocBlip, 2)
			SetBlipRouteColour(fDelLocBlip, 2)
		end
	end
end

Citizen.CreateThread(function()
	while true do 
		Wait(0)
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped, true)
		if((not DoesEntityExist(fDelScooter)) or (IsEntityDead(fDelScooter))) and (fDelStarted)then
			vRPjobsC.cancelDeliveryJob()
			fDelScooter = nil
		end
		if(fDeliverySpawnLoc ~= nil)then
			if(fDelScooter == nil)then
				x, y, z = fDeliverySpawnLoc[1], fDeliverySpawnLoc[2], fDeliverySpawnLoc[3]
				if(not DoesBlipExist(fDelBlip))then
					fDelBlip = AddBlipForCoord(x, y, z)
					SetBlipSprite(fDelBlip, 376)
					SetBlipColour(fDelBlip, 2)
				end
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) < 30.0)then
					DrawText3D(x, y, z+0.1, "~y~Scuter", 1.2)
					DrawMarker(37, x, y, z-0.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 0, 255, 0, 0, 0, 1)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) < 2.0)then
						job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a spawna un ~r~Scuter")
						if(IsControlJustReleased(1, 51))then
							vRPSjobs.spawnFoodDeliveryScooter({})
						end
					end
				end
			else
				x, y, z = fDelLocations[fDelCurrentLoc][1], fDelLocations[fDelCurrentLoc][2], fDelLocations[fDelCurrentLoc][3]
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) < 30.0)then
					DrawText3D(x, y, z+0.1, "~p~Livreaza Mancarea", 1.2)
					DrawMarker(40, x, y, z-0.5, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 92, 255, 0, 180, 0, 0, 0, 0.9)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) < 2.0)then
						job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a bate la usa")
						if(IsControlJustReleased(1, 51))then
							if(isDoingOrder == false)then
								isDoingOrder = true
								vRPjobsC.executeFoodDelivery()
							else
								vRP.notify({"[UBER EATZ] ~r~Ai batut deja la usa! Asteapta sa iti raspunda!"})
							end
						end
					end
				end
				sCoords = GetEntityCoords(fDelScooter, true)
				if(GetVehiclePedIsIn(ped, false) ~= fDelScooter) and (GetPedInVehicleSeat(fDelScooter, -1) ~= ped) then
					job_drawTxt("~y~[UBER EATZ] ~r~Nu te indeparta prea tare de scuter",1,1,0.5,0.8,0.8,255,255,255,255)
					if(GetDistanceBetweenCoords(sCoords.x, sCoords.y, sCoords.z, pos.x, pos.y, pos.z, true) > 50.0)then
						vRPjobsC.cancelDeliveryJob()
					end
				end
			end
		end
	end
end)