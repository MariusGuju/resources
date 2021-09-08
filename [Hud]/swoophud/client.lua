

local toghud = true
local thirst = 0
local hunger = 0

RegisterNetEvent("hudd")
AddEventHandler("hudd", function()
    if toghud then 
        toghud = false
    else
        toghud = true
    end
end)

 
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(100)
        TriggerServerEvent("vRP_HealthUI:getData")
        local player = PlayerPedId()       
        SendNUIMessage({
            action = "updateStatusHud",
            show = toghud,
            hunger = math.ceil(100 - hunger),
            thirst = math.ceil(100 - thirst),
            stress = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
        })
    end
end)

RegisterNetEvent("vRP_HealthUI:returnBasics")
AddEventHandler("vRP_HealthUI:returnBasics", function (rHunger, rThirst)
    hunger = rHunger
    thirst = rThirst
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
            oxygen = oxy,
        })
        Citizen.Wait(200)
    end
end)

