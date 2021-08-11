
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_heist")
vRPgold = Tunnel.getInterface("vrp_heist","vrp_heist")
vRPgoldC = {}
Tunnel.bindInterface("vrp_heist",vRPgoldC)
vRPserver = Tunnel.getInterface("vrp_heist","vrp_heist")

local PlayerData = nil
local converting = false
local meltingGold = false
local exchangingGold = false


-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end


--[[local locatii = {x=3311.26,y=5176.45,z=19.61}
-- Blip on Map for Gold Smeltery Location
Citizen.CreateThread(function()
	--if Config.EnableSmelteryBlip == true then
	  --for k,v in ipairs(Config.MissionNPC)do
		local blip = AddBlipForCoord(locatii[1],locatii[2],locatii[3])
		SetBlipSprite(blip, 616)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Car Thief")
		EndTextCommandSetBlipName(blip)
	--  end
	--end
end)]]




-- GOLD WATCH >> GOLD BAR
RegisterNetEvent("GoldWatchToGoldBar")
AddEventHandler("GoldWatchToGoldBar", function()
	FreezeEntityPosition(GetPlayerPed(-1), true)
    if converting then
      return
    end
	
    converting = true
	
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	--exports['progressBars']:startUI((Config.SmelteryTime * 1000), "GOLD WATCH > GOLD BAR")
	Citizen.Wait((Config.SmelteryTime * 1000))
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(GetPlayerPed(-1), false)
    meltingGold = false
	converting = false
end)

-- GOLD BAR >> DIRTY CASH
RegisterNetEvent("GoldBarToCash")
AddEventHandler("GoldBarToCash", function()
	FreezeEntityPosition(GetPlayerPed(-1), true)
    if converting then
      return
    end
	
    converting = true
	
	--TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	--exports['progressBars']:startUI((Config.ExchangeTime * 1000), "EXCHANGING GOLD BARS")
	Citizen.Wait((Config.ExchangeTime * 1000))
	--ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(GetPlayerPed(-1), false)
    
	exchangingGold = false
	converting = false
	vRP.notify({"You received ~r~$35.000~s~ Dirty Cash"})
end)
