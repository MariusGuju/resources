--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(1) 
--		
--        for ped in EnumeratePeds() do
--            if DoesEntityExist(ped) then
--				for i,model in pairs(cfg.peds) do
--					if (GetEntityModel(ped) == GetHashKey(model)) then
--						veh = GetVehiclePedIsIn(ped, false)
--						SetEntityAsNoLongerNeeded(ped)
--						SetEntityCoords(ped,10000,10000,10000,1,0,0,1)
--						if veh ~= nil then
--							SetEntityAsNoLongerNeeded(veh)
--							SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
--						end
--					end
--				end
--				for i,model in pairs(cfg.noguns) do
--					if (GetEntityModel(ped) == GetHashKey(model)) then
--						RemoveAllPedWeapons(ped, true)
--					end
--				end
--				for i,model in pairs(cfg.nodrops) do
--					if (GetEntityModel(ped) == GetHashKey(model)) then
--						SetPedDropsWeaponsWhenDead(ped,false) 
--					end
--				end
--			end
--		end
--		--[[ WORK IN PROGESS // DOES NOT WORK
--        for veh in EnumerateVehicles() do
--            if DoesEntityExist(veh) then
--				for i,model in pairs(cfg.vehs) do
--					if (GetEntityModel(veh) == GetHashKey(model)) then
--						SetEntityAsNoLongerNeeded(veh)
--						SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
--					end
--				end
--			end
--		end
--		]]
--    end
--end)
--
--Citizen.CreateThread(function()
--    while true 
--        do
--         -- These natives has to be called every frame.
--        SetPedDensityMultiplierThisFrame(cfg.density.peds)
--        SetScenarioPedDensityMultiplierThisFrame(cfg.density.peds, cfg.density.peds)
--        SetVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
--        SetRandomVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
--        SetParkedVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
--        Citizen.Wait(0)
--    end
--end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- prevent crashing

		-- These natives have to be called every frame.
		SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
		SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
		SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
		SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
		SetRandomBoats(false) -- Stop random boats from spawning in the water.
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
	end
end)

