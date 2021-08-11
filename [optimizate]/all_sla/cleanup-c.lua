
checkTime = 30 --minute
deleteTime = 1800 --sec

local enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function getVehicles()
  return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

RegisterNetEvent("zedutz:delAllVehs")
AddEventHandler("zedutz:delAllVehs", function(sec) deleteAllVehs(sec) end)

function deleteAllVehs(theTime)
	TriggerEvent("chatMessage", "[SERVER]", {255, 255, 0}, "Toate masinile neocupate vor fi sterse in "..theTime.." secunde!")
	SetTimeout(theTime * 1000, function()
		theVehicles = getVehicles()
		TriggerEvent("chatMessage", "[SERVER]", {0, 255, 0}, "Toate masinile neocupate au fost sterse!")
		for entity in theVehicles do
			local veh = entity
			NetworkRequestControlOfEntity(veh)

			local timeout = 2000
			while timeout > 0 and not NetworkHasControlOfEntity(veh) do
    			Wait(100)
    			timeout = timeout - 100
			end

			SetEntityAsMissionEntity(veh, true, true)

			local timeout = 2000
			while timeout > 0 and not IsEntityAMissionEntity(veh) do
    			Wait(100)
    			timeout = timeout - 100
			end
			if DoesEntityExist(veh) then 
				if GetEntityModel(veh) ~= GetHashKey("rcbandito") then
					if not IsEntityAttached(veh) then
						if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
			    			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( veh ) )
			    
			    			if (DoesEntityExist(veh)) then 
			        			DeleteEntity(veh)
			    			end 
						end
					end
				end
			end
		end
	end)
end

--[[Citizen.CreateThread(function()
	while true do
		Wait(checkTime * 60000)
		deleteAllVehs(deleteTime)
	end
end)]]