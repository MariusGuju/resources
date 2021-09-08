--[[
		 The script is releases for free
		 This is a Youtuber Menu with only Permission
		 Author:ZED#1337
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]

vRPCyoutuber = {}
Tunnel.bindInterface("all_sla",vRPCyoutuber)
Proxy.addInterface("all_sla",vRPCyoutuber)
vRP = Proxy.getInterface("vRP")
vRPyt = Tunnel.getInterface("all_sla","all_sla")

local lastVehicle

function vRPCyoutuber.setYoutuberSkin(skinID)
	if(skinsID == 2)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 3)then
		model = "leona"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "Child"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setXDSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
	elseif(skinID == 4)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setGimiSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
	elseif(skinsID == 3)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "blackracer"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setDXSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
	elseif(skinID == 4)then
		model = "JackSparrow"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1000)
		end
		SetPlayerModel(PlayerId(), model)
	end
end


function vRPCyoutuber.teleportOutOfCar(theVehicle)
	thePed = GetPlayerPed(-1)
	local pos = GetEntityCoords(theVehicle, true)
	SetEntityCoords(thePed, pos.x, pos.y, pos.z+1.0)
end

function vRPCyoutuber.spawnYoutuberCar()
	model = GetHashKey("675lt")--Youtuber Car
	ped = GetPlayerPed(-1)
	
	if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end
	
	x, y, z = table.unpack(GetEntityCoords(ped, true))
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Citizen.Wait(1000)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh
		UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

		SetModelAsNoLongerNeeded( veh )
	end
end

-- 
function vRPCyoutuber.spawnHeli()
	model = GetHashKey("Volatus")
	ped = GetPlayerPed(-1)
	
	if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end
	
	x, y, z = table.unpack(GetEntityCoords(ped, true))
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Citizen.Wait(1000)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh
		UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

		SetModelAsNoLongerNeeded( veh )
	end
end

---SkyFAll for Youtuber ---

local isSkyfall = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

config = {
	["vehicleColor"] = {
		vRainbowStats = false,
		vRainbowSpeed = 5.00
	},
	["neonsColor"] = {
		nRainbowStats = false,
		nRainbowSpeed = 2.00
	}
}

function vRPCyoutuber.rainbowVehicleEffect()
	config["vehicleColor"].vRainbowStats = not config["vehicleColor"].vRainbowStats
	if(config["vehicleColor"].vRainbowStats)then
		TriggerEvent("chatMessage", "", {255,255,255}, "Vehicul RGB: ^2^*ACTIVAT")
	else
		TriggerEvent("chatMessage", "", {255,255,255}, "Vehicul RGB: ^8^*DEZACTIVAT")
	end
end

function vRPCyoutuber.rainbowNeonsEffect()
	config["neonsColor"].nRainbowStats = not config["neonsColor"].nRainbowStats
	if(config["neonsColor"].nRainbowStats)then
		TriggerEvent("chatMessage", "", {255,255,255}, "Neoane RGB: ^2^*ACTIVATE")
	else
		TriggerEvent("chatMessage", "", {255,255,255}, "Neaone RGB: ^8^*DEZACTIVATE")
	end
end

Citizen.CreateThread(function()
	local function RGBRainbow( frequency )
		local result = {}
		local curtime = GetGameTimer() / 1000

		result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
		result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
		result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )

		return result
	end
    while true do
    	Citizen.Wait(1000)
    	if(config["vehicleColor"].vRainbowStats)then
    		if IsPedInAnyVehicle(PlayerPedId(), true) then
				local vRainbow = RGBRainbow(config["vehicleColor"].vRainbowSpeed)
    			local theVehicle = GetVehiclePedIsUsing(PlayerPedId())
    			SetVehicleCustomPrimaryColour(theVehicle, vRainbow.r, vRainbow.g, vRainbow.b)
    			SetVehicleCustomSecondaryColour(theVehicle, vRainbow.r, vRainbow.g, vRainbow.b)
    		else
    			config["vehicleColor"].vRainbowStats = false
    		end
    	end
		if(config["neonsColor"].nRainbowStats)then
    		if IsPedInAnyVehicle(PlayerPedId(), true) then
				local nRainbow = RGBRainbow(config["neonsColor"].nRainbowSpeed)
    			local theVehicle = GetVehiclePedIsUsing(PlayerPedId())
    			SetVehicleNeonLightsColour(theVehicle, nRainbow.r, nRainbow.g, nRainbow.b)
    		else
    			config["neonsColor"].nRainbowStats = false
    		end
    	end
    end
end)
-----------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and antiShuffleEnabled then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					vRPyt.denySponsorCarDriving({})
				end
			end
		end
	end
end)

function vRPCyoutuber.denySponsorCarDriving()
	SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
end
