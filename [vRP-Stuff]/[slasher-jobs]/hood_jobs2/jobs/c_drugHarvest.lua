local plantsPlanted = {}
local plantsGrowing = {}

local harvestField = {}

local plantsObject = "prop_bush_lrg_01c_cr"

function vRPjobsC.initSeedField(field)
	harvestField = field
end

function vRPjobsC.plantSeed()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, harvestField[1], harvestField[2], harvestField[3], true) < 30.0)then
		RequestModel(plantsObject)
		plantsGrowing[#plantsGrowing+1] = CreateObject(plantsObject, coords.x, coords.y, coords.z-3.6, false, false, true)
		plantsPlanted[#plantsPlanted+1] = {stage = 0, done = false}
		vRPSjobs.executePlanting({})
	else
		vRP.notify({"~r~Poti planta aceasta samanta doar pe un camp!"})
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(35000)
		for i, v in pairs(plantsPlanted) do
			if(v.stage < 15) and (v.done == false)then
				local model = plantsObject
				local coords = GetEntityCoords(plantsGrowing[i])
				DeleteObject(plantsGrowing[i])
				plantsGrowing[i] = CreateObject(plantsObject, coords.x, coords.y, coords.z-0.875, false, false, true)
				v.stage = v.stage + 1
			else
				v.done = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i, v in pairs(plantsPlanted) do
			local pCoords = GetEntityCoords(plantsGrowing[i])
			if(v.done)then
				if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pCoords.x, pCoords.y, pCoords.z, true) < 5.0)then
					DrawText3D(pCoords.x, pCoords.y, pCoords.z+1.0, "~g~Apasa ~r~'E' ~g~pentru a culege planta", 0.75)
					if(IsControlJustReleased(1, 51))then
						DeleteObject(plantsGrowing[i])
						plantsGrowing[i] = nil
						plantsPlanted[i] = nil
						vRPSjobs.harvestDrugPlant({})
					end
				end
			else
				if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pCoords.x, pCoords.y, pCoords.z, true) < 5.0)then
					DrawText3D(pCoords.x, pCoords.y, pCoords.z+1.0, "~r~Planta este in crestere...", 0.75)
				end
			end
		end
	end
end)