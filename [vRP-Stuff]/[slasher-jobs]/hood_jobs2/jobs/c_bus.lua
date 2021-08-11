busSpawnLocs = nil
busStopsLocs = nil
theBlips = {}
busStopsBlip = nil
theBus = nil
hasBusRouteStarted = false
busCheckpoint = 0
atBusStop = false
finishBusRoute = {}
finishBlip = nil
busBlip = nil
busStopsBlip2 = nil

function vRPjobsC.busPopulateData(busSpawns, busLocs, finishTrash)
	busSpawnLocs = busSpawns
	busStopsLocs = busLocs
	finishBusRoute = finishTrash
	SetNewWaypoint(busSpawnLocs[1][1], busSpawnLocs[1][2])
end

function vRPjobsC.deleteTheBus()
	if(DoesEntityExist(theBus))then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(theBus))
		theBus = nil
	end
end

function vRPjobsC.spawnTheBus()
	if(theBus == nil)then
		coords = GetEntityCoords(GetPlayerPed(-1), true)
		vehicle = GetHashKey("bus")
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Citizen.Wait(0)
		end
		theBus = CreateVehicle(vehicle, coords.x, coords.y, coords.z+0.5, 213.70028686523, true, false)
		SetVehicleOnGroundProperly(theBus)
		SetEntityInvincible(theBus, false)
		SetPedIntoVehicle(GetPlayerPed(-1), theBus, -1)
		Citizen.InvokeNative(0xAD738C3085FE7E11, theBus, true, true) -- set as mission entity
		SetVehicleHasBeenOwnedByPlayer(theBus, true)
		SetModelAsNoLongerNeeded(vehicle)
	end
end

function vRPjobsC.startBusRoute()
	hasBusRouteStarted = true
	for i, v in pairs(theBlips) do
		if(DoesBlipExist(v))then
			RemoveBlip(v)
			theBlips[i] = nil
		end
	end
	vRPjobsC.nextBusStop()
	vRP.notify({"[BUS] ~g~Urmeaza ruta si asteapta la fiecare statie pentru a primii bani!"})
end

function vRPjobsC.nextBusStop()
	busCheckpoint = busCheckpoint + 1
	if(busStopsLocs[busCheckpoint][4] == true)then
		blipColor = 1
	else
		blipColor = 2
	end
	if(busStopsBlip == nil) or (DoesBlipExist(busStopsBlip))then
		if(DoesBlipExist(busStopsBlip))then
			RemoveBlip(busStopsBlip)
		end
		busStopsBlip = AddBlipForCoord(busStopsLocs[busCheckpoint][1], busStopsLocs[busCheckpoint][2], busStopsLocs[busCheckpoint][3])
		SetBlipRoute(busStopsBlip, true)
		SetBlipSprite(busStopsBlip, 270)
		SetBlipColour(busStopsBlip, blipColor)
		SetBlipRouteColour(busStopsBlip, 2)
	end
	if(busCheckpoint+1 <= #busStopsLocs)then
		if(busStopsBlip2 == nil) or (DoesBlipExist(busStopsBlip2))then
			if(DoesBlipExist(busStopsBlip2))then
				RemoveBlip(busStopsBlip2)
			end
			busStopsBlip2 = AddBlipForCoord(busStopsLocs[busCheckpoint+1][1], busStopsLocs[busCheckpoint+1][2], busStopsLocs[busCheckpoint+1][3])
			SetBlipSprite(busStopsBlip2, 270)
			SetBlipColour(busStopsBlip2, 16)
		end
	end
end

function vRPjobsC.stopBusRoute()
	hasBusRouteStarted = false
	vRP.notify({"[BUS] ~r~Ai anulat tura de Sofer Autobuz!"})
	busCheckpoint = 0
	if(DoesBlipExist(busStopsBlip))then
		RemoveBlip(busStopsBlip)
		busStopsBlip = nil
	end
	if(DoesBlipExist(busStopsBlip2))then
		RemoveBlip(busStopsBlip2)
		busStopsBlip2 = nil
	end
	if(DoesBlipExist(busBlip))then
		RemoveBlip(busBlip)
		busBlip = nil
	end
	if(DoesBlipExist(finishBlip))then
		RemoveBlip(finishBlip)
		finishBlip = nil
	end
	vRPSjobs.stopBusRoute({})
	atBusStop = false
end

function vRPjobsC.finishBusRoute(route)
	hasBusRouteStarted = false
	busCheckpoint = 0
	if(DoesBlipExist(busStopsBlip))then
		RemoveBlip(busStopsBlip)
		busStopsBlip = nil
	end
	if(DoesBlipExist(busStopsBlip2))then
		RemoveBlip(busStopsBlip2)
		busStopsBlip2 = nil
	end
	if(DoesBlipExist(busBlip))then
		RemoveBlip(busBlip)
		busBlip = nil
	end
	if(DoesBlipExist(finishBlip))then
		RemoveBlip(finishBlip)
		finishBlip = nil
	end
	atBusStop = false
	vRPjobsC.deleteTheBus()
	vRPSjobs.payBusDriver({route})
end

function vRPjobsC.stopAtBusStop(isBusStop)
	if(isBusStop == false)then
		vRPjobsC.nextBusStop()
	else
		if(atBusStop == false)then
			atBusStop = true
			vRP.notify({"[BUS] ~g~Asteapta la statie pana ce pasagerii au urcat!"})
			SetTimeout(8000, function()
				if(atBusStop)then
					atBusStop = false
					if(#busStopsLocs > busCheckpoint)then
						vRPjobsC.nextBusStop()
						vRP.notify({"[BUS] ~g~Pasagerii au urcat! Te poti duce la urmatoarea statie"})
						vRPSjobs.payBusDriverAtStop({})
					else
						if(DoesBlipExist(busStopsBlip))then
							RemoveBlip(busStopsBlip)
							busStopsBlip = nil
						end
						vRP.notify({"[BUS] ~g~Ti-ai terminat tura! Intoarce-te inapoi la depou pentru a lasa autobuzul!"})
					end
				else
					vRP.notify({"[BUS] ~r~Trebuie sa astepti in checkpoint pentru a lasa pasagerii sa urce!"})
				end
			end)
		end
	end
end

RegisterCommand("cc", function(source)
	print("CC: "..busCheckpoint)
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)	
		local pos = GetEntityCoords(ped, true)	
		if((not DoesEntityExist(theBus)) or (IsEntityDead(theBus))) and (hasBusRouteStarted)then
			vRPjobsC.stopBusRoute()
			theBus = nil
		end
		if(atBusStop)then
			job_drawTxt("~y~[BUS] ~g~Asteapta la statie...",1,1,0.5,0.8,0.8,255,255,255,255)
		end
		if(theBus ~= nil)then
			if(GetVehiclePedIsIn(ped, false) == theBus) and (GetPedInVehicleSeat(theBus, -1) == ped) then
				if(hasBusRouteStarted == false)then
					vRPjobsC.startBusRoute()
				end
				if(tonumber(#busStopsLocs) > tonumber(busCheckpoint))then
					if(#busStopsLocs >= busCheckpoint+1)then
						if(busStopsLocs[busCheckpoint+1][4] == true)then
							DrawMarker(1, busStopsLocs[busCheckpoint+1][1], busStopsLocs[busCheckpoint+1][2], busStopsLocs[busCheckpoint+1][3]-1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 200.0, 0, 255, 0, 180, 0, 0, 0, 0)
						else
							DrawMarker(1, busStopsLocs[busCheckpoint+1][1], busStopsLocs[busCheckpoint+1][2], busStopsLocs[busCheckpoint+1][3]-1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 200.0, 255, 255, 0, 180, 0, 0, 0, 0)
						end
					end
					if(busStopsLocs[busCheckpoint][4] == true)then
						DrawMarker(1, busStopsLocs[busCheckpoint][1], busStopsLocs[busCheckpoint][2], busStopsLocs[busCheckpoint][3]-1.0, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 180, 0, 0, 0, 0)
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, busStopsLocs[busCheckpoint][1], busStopsLocs[busCheckpoint][2], busStopsLocs[busCheckpoint][3], true) < 8.0)then
							if(atBusStop == false)then
								vRPjobsC.stopAtBusStop(true)
							end
						else
							atBusStop = false
						end
					else
						DrawMarker(1, busStopsLocs[busCheckpoint][1], busStopsLocs[busCheckpoint][2], busStopsLocs[busCheckpoint][3]-1.0, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 255, 255, 0, 180, 0, 0, 0, 0)
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, busStopsLocs[busCheckpoint][1], busStopsLocs[busCheckpoint][2], busStopsLocs[busCheckpoint][3], true) < 8.0)then
							vRPjobsC.stopAtBusStop(false)
						end
					end
				end
				if(busCheckpoint == #busStopsLocs)then
					if(finishBlip == nil)then
						finishBlip = AddBlipForCoord(finishBusRoute[1], finishBusRoute[2], finishBusRoute[3])
						SetBlipSprite(finishBlip, 270)
						SetBlipColour(finishBlip, 15)
						SetBlipAsShortRange(finishBlip, false)
					end
					DrawMarker(1, finishBusRoute[1], finishBusRoute[2], finishBusRoute[3]-1.0, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 180, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, finishBusRoute[1], finishBusRoute[2], finishBusRoute[3], true) < 5.0)then
						job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a termina cursa de ~r~Sofer Autobuz")
						if(IsControlJustReleased(1, 51))then
							vRPjobsC.finishBusRoute(busCheckpoint)
						end
					end
				end
				if(DoesBlipExist(busBlip))then
					RemoveBlip(busBlip)
					busBlip = nil
				end
			else
				job_drawTxt("~y~[BUS] ~r~Intoarce-te la autobuz pentru a continua",1,1,0.5,0.8,0.8,255,255,255,255)
				if(busBlip == nil)then
					busBlip = AddBlipForEntity(theBus)
					SetBlipSprite(busBlip, 67)
					SetBlipColour(busBlip, 1)
					SetBlipAsShortRange(busBlip, false)
				end
			end
		else
			if(hasBusRouteStarted)then
				vRPjobsC.stopBusRoute()
			end
			if(busSpawnLocs ~= nil)then
				for i, v in pairs(busSpawnLocs) do
					if(theBlips[i] == nil)then
						theBlips[i] = AddBlipForCoord(v[1], v[2], v[3])
						SetBlipSprite(theBlips[i], 67)
						SetBlipColour(theBlips[i], 2)
						SetBlipAsShortRange(theBlips[i], true)
					end
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3], true) < 30.0)then
						DrawText3D(v[1], v[2], v[3]+0.1, "~y~Autobuz", 1.2)
						DrawMarker(39, v[1], v[2], v[3]-0.5, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 94, 94, 94, 255, 0, 0, 0, 1)
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3], true) < 2.0)then
							job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a spawna un ~r~Autobuz")
							if(IsControlJustReleased(1, 51))then
								vRPSjobs.spawnTheBus({})
							end
						end
					end
				end
			end
		end
	end
end)