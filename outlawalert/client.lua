--Config
local timer = 10 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local gunshotAlert = true --Set if show alert when player use gun
local carJackingAlert = true --Set if show when player do carjacking
local meleeAlert = true --Set if show when player fight in melee
local blipGunTime = 120 --in second
local blipMeleeTime = 120 --in second
local blipJackingTime = 120 -- in second
--End config

local origin = false --Don't touche it
local timing = timer * 60000 --Don't touche it

local PedModels = {
        "s_m_y_cop_01",
        'mp_m_freemode_01',
        'mp_m_freemode_02',
        's_f_y_cop_01',
        's_m_y_sheriff_01',
        's_m_y_ranger_01',
        's_m_m_armoured_01',
        's_m_m_armoured_01',
        's_f_y_sheriff_01',
        's_f_y_ranger_01',
        --'s_m_m_ciasec_01',
        --'s_m_m_armoured_01',
        --'s_m_m_armoured_02',
        --'u_m_m_fibarchitect',
        --'s_m_y_swat_01',
    }
GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(alert)
    for i = 0, #PedModels do
        if not origin and IsPedModel(GetPlayerPed(-1),GetHashKey(PedModels[i])) then
            Notify(alert)
        end
    end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('thiefPlace')
AddEventHandler('thiefPlace', function(tx, ty, tz)
    for i = 0, #PedModels do
        if not origin and IsPedModel(GetPlayerPed(-1),GetHashKey(PedModels[i])) then
            if carJackingAlert1 then
                local transT = 250
                local thiefBlip = AddBlipForCoord(tx, ty, tz)
				SetBlipSprite(thiefBlip, 9)
	            SetBlipScale(thiefBlip, 1.0)
	            SetBlipRotation(thiefBlip, 0)
                SetBlipColour(thiefBlip, 1)
                SetBlipAlpha(thiefBlip,  75)
                SetBlipAsShortRange(thiefBlip,  100)
                while transT ~= 0 do
                    Wait(blipJackingTime * 6)
                    transT = transT - 1
                    SetBlipAlpha(thiefBlip,  transT)
                    if transT == 0 then
                        SetBlipSprite(thiefBlip,  9)
                        return end
                end
                
            end
        end
    end
end)

--Star color
--[[1- White
2- Black
3- Grey
4- Clear grey
5-
6-
7- Clear orange
8-
9-
10-
11-
12- Clear blue]]


Citizen.CreateThread( function()
    while true do
        Wait(1000)
        if DecorGetInt(GetPlayerPed(-1), "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
        end
    end
end)

