tailorDur = 0
tailorAction = ""
tailorBlip = nil
tailorCoords = {715.31286621094,-965.13702392578,30.395336151124}
myObject = nil

function vRPjobsC.startTailoring(tailorD, tailorA)
	tailorDur = tailorD
	tailorAction = tailorA
end

function vRPjobsC.sellTailoredClothing()
	if(myObject and DoesEntityExist(myObject))then
		DeleteEntity(myObject)
		myObject = nil
	end
end

function vRPjobsC.createTailorBlip()
	if(not DoesBlipExist(tailorBlip))then
		tailorBlip = AddBlipForCoord(tailorCoords[1], tailorCoords[2], tailorCoords[3])
		SetBlipSprite(tailorBlip, 71)
		SetBlipColour(tailorBlip, 15)
	end
	SetNewWaypoint(tailorCoords[1], tailorCoords[2])
end

function createClothInHand(myModel)
	if(myObject and DoesEntityExist(myObject))then
		DeleteEntity(myObject)
		myObject = nil
		objectModel = GetHashKey(myModel)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		bone = GetPedBoneIndex(GetPlayerPed(-1), 28422)
		vRP.playAnim({true, {{"anim@heists@box_carry@", "idle", 1}}, true})
		if(myObject == nil)then
			Citizen.CreateThread(function()
				RequestModel(objectModel)
				myObject = CreateObject(objectModel, pos.x, pos.y, pos.z, true, true, false)
				AttachEntityToEntity(myObject, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
			end)
		end
	else
		myObject = nil
		objectModel = GetHashKey(myModel)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		bone = GetPedBoneIndex(GetPlayerPed(-1), 28422)
		vRP.playAnim({true, {{"anim@heists@box_carry@", "idle", 1}}, true})
		if(myObject == nil)then
			Citizen.CreateThread(function()
				RequestModel(objectModel)
				myObject = CreateObject(objectModel, pos.x, pos.y, pos.z, true, true, false)
				AttachEntityToEntity(myObject, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
			end)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		if(tailorAction ~= "")then
			coords = GetEntityCoords(ped)
			if(tailorDur > 0)then
				if(tailorAction == "Cusut")then
					job_drawTxt("~g~Ai inceput sa cosi...",1,1,0.5,0.8,0.65,255,255,255,255)
					job_drawTxt("~y~Timp: ~g~"..tailorDur,1,1,0.5,0.84,0.7,255,255,255,255)
					if(not IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_COMPUTER"))then
						SetEntityHeading(ped, 174.17475891113)
						TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_COMPUTER", coords.x, coords.y, coords.z-0.35, GetEntityHeading(ped), 0, 0, false)	
						FreezeEntityPosition(ped, true)
					end
				elseif(tailorAction == "Calcat")then
					job_drawTxt("~g~Ai inceput sa calci...",1,1,0.5,0.8,0.65,255,255,255,255)
					job_drawTxt("~y~Timp: ~g~"..tailorDur,1,1,0.5,0.84,0.7,255,255,255,255)
					if(myObject and DoesEntityExist(myObject))then
						DeleteEntity(myObject)
						myObject = nil
					end
					if(not IsPedUsingScenario(ped, "WORLD_HUMAN_STAND_FIRE"))then
						SetEntityHeading(ped, 266.57623291016)
						TaskStartScenarioAtPosition(ped, "WORLD_HUMAN_STAND_FIRE", coords.x, coords.y, coords.z-0.3, GetEntityHeading(ped), 0, 0, false)	
						FreezeEntityPosition(ped, true)
					end
				end
			elseif(tailorDur == 0)then
				coordz = coords
				if(tailorAction == "Cusut")then
					vRPSjobs.finishTailoringClothes({})
					createClothInHand("prop_cs_tshirt_ball_01")
				elseif(tailorAction == "Calcat")then
					vRPSjobs.finishIroningClothes({})
					createClothInHand("p_t_shirt_pile_s")
				end
				tailorAction = ""
				tailorDur = 0
				ClearPedTasks(ped)
				FreezeEntityPosition(ped, false)
				SetTimeout(150, function()
					SetEntityCoords(ped, coordz.x, coordz.y, coordz.z-0.4)
				end)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1200)
		if(tailorDur > 0)then
			tailorDur = tailorDur - 1
		end
	end
end)