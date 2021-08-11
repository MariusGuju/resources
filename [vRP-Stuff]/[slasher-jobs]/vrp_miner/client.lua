  
vRPcasinoC = {}
Tunnel.bindInterface("vRP_casino",vRPcasinoC)
Proxy.addInterface("vRP_casino",vRPcasinoC)
vRP = Proxy.getInterface("vRP")


local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local washingActive = false
local remeltingActive = false
local firstspawn = false
local impacts = 0
local timer = 0
local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
						DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a mina.")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                mineActive = true
                            end
                        end
            end
        end
    end
end)


RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function()
    Washing()
end)


RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function()
    Remelting()
end)


RegisterNetEvent('esx_miner:timer')
AddEventHandler('esx_miner:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                Draw3DText( Config.WashingX, Config.WashingY, Config.WashingZ+0.5 -1.400, ('Spalarea Minereului Necunoscut: ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 5 then
                Draw3DText( Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ+0.5 -1.400, ('Topirea Minereului: ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 25 and washingActive == false then
            DrawMarker(20, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 2, 1, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 1 then
                    -- DisplayHelpText("Apasa ~INPUT_CONTEXT~ to wash the stones.")
                    DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a spala Minereul Necunoscut")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:washing")
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 25 and remeltingActive == false then
            DrawMarker(20, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 1 then
                    -- DisplayHelpText("Press ~INPUT_CONTEXT~ to remelting stones.")
                    DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a topii Minereul")
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_miner:remelting")  
                    end
                end
            end
        end
    end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
        DrawMarker(2, -158.87260437012,6141.7543945312,32.335144042968-0.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.00, 1.00, 1.00, 0, 250, 0, 200, false, true, 2, true, false, false, false)
        DrawMarker(29, -619.75634765625,-233.99868774414,38.057052612304-0.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.00, 1.00, 1.00, 0, 250, 0, 200, false, true, 2, true, false, false, false)
    end
end)


-- Citizen.CreateThread(function()
--     local hash = GetHashKey("ig_natalia")

--     if not HasModelLoaded(hash) then
--         RequestModel(hash)
--         Citizen.Wait(100)
--     end

--     while not HasModelLoaded(hash) do
--         Citizen.Wait(0)
--     end

--     if firstspawn == false then
--         local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 129.0, false, false)
--         SetEntityInvincible(npc, true)
--         FreezeEntityPosition(npc, true)
--         SetPedDiesWhenInjured(npc, false)
--         SetPedCanRagdollFromPlayerImpact(npc, false)
--         SetPedCanRagdoll(npc, false)
--         SetEntityAsMissionEntity(npc, true, true)
--         SetEntityDynamic(npc, true)
--     end
-- end)


-- RegisterNetEvent('esx_miner:createblips')
-- AddEventHandler('esx_miner:createblips', function()
--     Citizen.CreateThread(function()
--         while true do 
--             Citizen.Wait(1)
--                 if blips == true and blipActive == false then
--                     blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
--                     blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)
--                     blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
--                     blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
--                     SetBlipSprite(blip1, 365)
--                     SetBlipColour(blip1, 5)
--                     SetBlipAsShortRange(blip1, true)
--                     BeginTextCommandSetBlipName("STRING")
--                     AddTextComponentString("Mine")
--                     EndTextCommandSetBlipName(blip1)   
--                     SetBlipSprite(blip2, 365)
--                     SetBlipColour(blip2, 5)
--                     SetBlipAsShortRange(blip2, true)
--                     BeginTextCommandSetBlipName("STRING")
--                     AddTextComponentString("Washing stones")
--                     EndTextCommandSetBlipName(blip2)   
--                     SetBlipSprite(blip3, 365)
--                     SetBlipColour(blip3, 5)
--                     SetBlipAsShortRange(blip3, true)
--                     BeginTextCommandSetBlipName("STRING")
--                     AddTextComponentString("Remelting stones")
--                     EndTextCommandSetBlipName(blip3)
--                     SetBlipSprite(blip4, 272)
--                     SetBlipColour(blip4, 5)
--                     SetBlipAsShortRange(blip4, true)
--                     BeginTextCommandSetBlipName("STRING")
--                     AddTextComponentString("Selling items")
--                     EndTextCommandSetBlipName(blip4)    
--                     blipActive = true
--                 elseif blips == false and blipActive == false then
--                     RemoveBlip(blip1)
--                     RemoveBlip(blip2)
--                     RemoveBlip(blip3)
--                 end
--         end
--     end)
-- end)


function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1000)
		local ped = PlayerPedId()	
                RequestAnimDict("melee@large_wpn@streamed_core")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("esx_miner:givestone")
                    break
                end        
        end
    end)
end


function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_miner:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
end

function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_miner:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

  
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end



function filtern1(t, cb) 
	local j = 1 
	for i, v in ipairs(t) do 
	   if cb(v) then 
		  t[j] = v 
		  j = j + 1 
	   end 
	end 
	while t[j] ~= nil do 
	   t[j] = nil 
	   j = j + 1 
	end 
	return t 
 end
 
 -- RP gain thing
 
 local onScreenEffects = {}
 
 Citizen.CreateThread(function() 
	 while not isTerminating do
		 RequestStreamedTextureDict("MPHud")
		 for i, e in pairs(onScreenEffects) do
			 local sw, sh = GetScreenResolution()
			 local w = 18.0
			 local h = 18.0
			 local sY = e.yFade
 
			 SetDrawOrigin(e.x, e.y, e.z, 0)
			 SetTextFont(0)
			 SetTextColour(255, 255, 255, 255)
			 SetTextScale(0.32, 0.32)
			 SetTextDropShadow(2, 2, 0, 0, 0)
			 SetTextOutline()
			 SetTextEntry("STRING")
			 AddTextComponentString(e.text)
			 DrawText(8 / sw, (-10.0 - sY) / sh)
			 DrawSprite("MPHud", e.sprite, 0.0, -sY / sh, w / sw, h / sh, 0.0, 255, 255, 255, 255)
			 ClearDrawOrigin()
 
			 if e.fadeAfter <= 0 then 
				 e.yFade = e.yFade * 1.4
			 end
			 e.ticks = e.ticks - 1
			 e.fadeAfter = e.fadeAfter - 1
		 end
		 onScreenEffects = filtern1(onScreenEffects, function(e) return e.ticks > 0 end)
		 Wait(0)
	 end
 end)
 
 function AddFloatingRpGained(x, y, z, text) 
	 onScreenEffects[#onScreenEffects + 1] = {
		 x = x ,
		 y = y ,
		 z = z ,
		 sprite = "mp_anim_cash",
		 text = text,
		 yFade = 1.0,
		 fadeAfter = 15,
		 ticks = 60
	 }
 end
 
 RegisterNetEvent("LingouAur")
 AddEventHandler("LingouAur", function(PretLingouAur)

    pos = GetEntityCoords(GetPlayerPed(-1))
    AddFloatingRpGained(pos.x-5.5,pos.y-1.4,pos.z+1, "~g~+ " ..PretLingouAur)

 end)


--  Citizen.CreateThread(function() 
--     while not isTerminating do
--         RequestStreamedTextureDict("MPHud")
--         local hit, pos = GetPedLastWeaponImpactCoord(PlayerPedId())
--         if hit then
--             local x, y, z = table.unpack(pos)
--             AddFloatingRpGained(x-5.5, y-1, z+1, "~g~+ 100")
--         end
--         Wait(0)
--     end
-- end)
 
