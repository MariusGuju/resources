trashSpawnLocs = nil
trashLoadLocs = nil
theBlips = {}
trashLoadBlip = nil
trashTruck = nil
hasTrashStarted = false
trashCheckpoint = 0
startedLoading = false
finishTrashPoint = {}
finishBlip = nil
truckBlip = nil

function vRPjobsC.trashPopulateData(trashSpawn, trashLocs, finishTrash)
	trashSpawnLocs = trashSpawn
	trashLoadLocs = trashLocs
	finishTrashPoint = finishTrash
	SetNewWaypoint(trashSpawnLocs[1][1], trashSpawnLocs[1][2])
end

function vRPjobsC.deleteTrashTruck()
	if(DoesEntityExist(trashTruck))then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(trashTruck))
		trashTruck = nil
	end
end

function shuffle(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

function vRPjobsC.spawnTrashTruck()
	if(trashTruck == nil)then
		coords = GetEntityCoords(GetPlayerPed(-1), true)
		vehicle = GetHashKey("trash2")
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Citizen.Wait(0)
		end
		trashTruck = CreateVehicle(vehicle, coords.x, coords.y, coords.z+0.5, 228.98454284668, true, false)
		SetVehicleOnGroundProperly(trashTruck)
		SetEntityInvincible(trashTruck, false)
		SetPedIntoVehicle(GetPlayerPed(-1), trashTruck, -1)
		Citizen.InvokeNative(0xAD738C3085FE7E11, trashTruck, true, true) -- set as mission entity
		SetVehicleHasBeenOwnedByPlayer(trashTruck, true)
		SetModelAsNoLongerNeeded(vehicle)
	end
end

function vRPjobsC.startTrashJob()
	trashLoadLocs = shuffle(trashLoadLocs)
	hasTrashStarted = true
	for i, v in pairs(theBlips) do
		if(DoesBlipExist(v))then
			RemoveBlip(v)
			theBlips[i] = nil
		end
	end
	vRPjobsC.nextCheckTrashCheckpoint()
	vRP.notify({"[GUNOIER] ~g~Du-te la locatia de pe harta pentru a incarca gunoiul!"})
end

function vRPjobsC.nextCheckTrashCheckpoint()
	trashCheckpoint = trashCheckpoint + 1
	if(trashLoadBlip == nil) or (DoesBlipExist(trashLoadBlip))then
		if(DoesBlipExist(trashLoadBlip))then
			RemoveBlip(trashLoadBlip)
		end
		trashLoadBlip = AddBlipForCoord(trashLoadLocs[trashCheckpoint][1], trashLoadLocs[trashCheckpoint][2], trashLoadLocs[trashCheckpoint][3])
		SetBlipRoute(trashLoadBlip, true)
		SetBlipSprite(trashLoadBlip, 318)
		SetBlipColour(trashLoadBlip, 2)
		SetBlipRouteColour(trashLoadBlip, 5)
	end
	if(trashCheckpoint > 1)then
		local rewardMoney = math.random(10, 15)
		vRPSjobs.addToTrashPay({rewardMoney})
	end	
end

function vRPjobsC.stopTrashJob()
	hasTrashStarted = false
	vRP.notify({"[GUNOIER] ~r~Ai anulat tura de gunoier!"})
	trashCheckpoint = 0
	if(DoesBlipExist(trashLoadBlip))then
		RemoveBlip(trashLoadBlip)
		trashLoadBlip = nil
	end
	if(DoesBlipExist(truckBlip))then
		RemoveBlip(truckBlip)
		truckBlip = nil
	end
	if(DoesBlipExist(finishBlip))then
		RemoveBlip(finishBlip)
		finishBlip = nil
	end
	vRPSjobs.stopTrashJob({})
	startedLoading = false
end

function vRPjobsC.finishTrashJob()
	hasTrashStarted = false
	trashCheckpoint = 0
	if(DoesBlipExist(trashLoadBlip))then
		RemoveBlip(trashLoadBlip)
		trashLoadBlip = nil
	end
	if(DoesBlipExist(truckBlip))then
		RemoveBlip(truckBlip)
		truckBlip = nil
	end
	if(DoesBlipExist(finishBlip))then
		RemoveBlip(finishBlip)
		finishBlip = nil
	end
	startedLoading = false
	vRPjobsC.deleteTrashTruck()
	vRPSjobs.payTrashDriver({})
end

function vRPjobsC.startLoadingTrash()
	if(startedLoading)then
		vRP.notify({"[GUNOIER] ~r~Deja incarci un tomberon de gunoi"})
	else
		startedLoading = true
		vRP.notify({"[GUNOIER] ~g~Ai inceput sa incarci gunoiul! Asteapta pana ce gunoiul este incarcat!"})
		SetTimeout(15000, function()
			if(startedLoading)then
				startedLoading = false
				if(#trashLoadLocs > trashCheckpoint)then
					vRPjobsC.nextCheckTrashCheckpoint()
					vRP.notify({"[GUNOIER] ~g~Ai incarcat gunoiul! Du-te la ~y~urmatoarea locatie ~g~sau ~b~intoarcete la groapa ~g~pentru a descarca!"})
					if(finishBlip == nil)then
						finishBlip = AddBlipForCoord(finishTrashPoint[1], finishTrashPoint[2], finishTrashPoint[3])
						SetBlipSprite(finishBlip, 318)
						SetBlipColour(finishBlip, 15)
						SetBlipAsShortRange(finishBlip, false)
					end
				else
					if(DoesBlipExist(trashLoadBlip))then
						RemoveBlip(trashLoadBlip)
						trashLoadBlip = nil
					end
					vRP.notify({"[GUNOIER] ~g~Camionul este plin! Du-te inapoi la groapa de gunoi pentru a iti incheia tura!"})
				end
			else
				vRP.notify({"[GUNOIER] ~r~Trebuie sa astepti in checkpoint pentru a incarca gunoiul!"})
			end
		end)
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)	
		local pos = GetEntityCoords(ped, true)	
		if(not DoesEntityExist(trashTruck)) and (hasTrashStarted)then
			vRPjobsC.stopTrashJob()
			trashTruck = nil
		end
		if(startedLoading)then
			job_drawTxt("~y~[GUNOIER] ~g~Se incarca gunoiul...",1,1,0.5,0.8,0.8,255,255,255,255)
		end
		if(trashTruck ~= nil)then
			if(GetVehiclePedIsIn(ped, false) == trashTruck) and (GetPedInVehicleSeat(trashTruck, -1) == ped) then
				if(hasTrashStarted == false)then
					vRPjobsC.startTrashJob()
				end
				if(#trashLoadLocs >= trashCheckpoint)then
					DrawMarker(1, trashLoadLocs[trashCheckpoint][1], trashLoadLocs[trashCheckpoint][2], trashLoadLocs[trashCheckpoint][3]-1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 200.0, 255, 255, 0, 180, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, trashLoadLocs[trashCheckpoint][1], trashLoadLocs[trashCheckpoint][2], trashLoadLocs[trashCheckpoint][3], true) < 5.0)then
						if(startedLoading == false)then
							vRPjobsC.startLoadingTrash()
						end
					else
						startedLoading = false
					end
				end
				if(trashCheckpoint >= 2)then
					DrawMarker(1, finishTrashPoint[1], finishTrashPoint[2], finishTrashPoint[3]-1.0, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 200.0, 0, 255, 0, 180, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, finishTrashPoint[1], finishTrashPoint[2], finishTrashPoint[3], true) < 5.0)then
						job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a termina cursa de ~r~Gunoier")
						if(IsControlJustReleased(1, 51))then
							vRPjobsC.finishTrashJob()
						end
					end
				end
				if(DoesBlipExist(truckBlip))then
					RemoveBlip(truckBlip)
					truckBlip = nil
				end
			else
				job_drawTxt("~y~[GUNOIER] ~r~Intoarce-te la camion pentru a continua",1,1,0.5,0.8,0.8,255,255,255,255)
				if(truckBlip == nil)then
					truckBlip = AddBlipForEntity(trashTruck)
					SetBlipSprite(truckBlip, 318)
					SetBlipColour(truckBlip, 1)
					SetBlipAsShortRange(truckBlip, false)
				end
			end
		else
			if(hasTrashStarted)then
				vRPjobsC.stopTrashJob()
			end
			if(trashSpawnLocs ~= nil)then
				for i, v in pairs(trashSpawnLocs) do
					if(theBlips[i] == nil)then
						theBlips[i] = AddBlipForCoord(v[1], v[2], v[3])
						SetBlipSprite(theBlips[i], 318)
						SetBlipColour(theBlips[i], 2)
						SetBlipAsShortRange(theBlips[i], true)
					end
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3], true) < 30.0)then
						DrawText3D(v[1], v[2], v[3]+0.1, "~y~Gunoier", 1.2)
						DrawMarker(39, v[1], v[2], v[3]-0.5, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 255, 0, 255, 0, 0, 0, 1)
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[1], v[2], v[3], true) < 2.0)then
							job_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a spawna o ~r~Masina")
							if(IsControlJustReleased(1, 51))then
								vRPSjobs.spawnTrashTruck({})
							end
						end
					end
				end
			end
		end
	end
end)