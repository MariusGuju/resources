local menuOn = false

local keybindControls = {
	["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local keybindControl = keybindControls["F1"]
        if IsControlPressed(0, 288) then
            menuOn = true
            TransitionToBlurred(100)
            SendNUIMessage({
                type = 'init',
                resourceName = GetCurrentResourceName()
            })
            SetCursorLocation(0.5, 0.5)
            SetNuiFocus(true, true)
            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
            while menuOn == true do Citizen.Wait(100) end
            Citizen.Wait(1000)
            while IsControlPressed(0, keybindControl) do Citizen.Wait(100) end
        end
    end
end)

RegisterNUICallback('closemenu', function(data, cb)
    menuOn = false
    TransitionFromBlurred(100)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    cb('ok')
end)


RegisterNUICallback('openmenu', function(data)
    menuOn = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    if data.id == 'inventory' then
        TriggerEvent("kasperr_inventory:openGui")
    elseif data.id == 'billing' then
        TransitionFromBlurred(100)
        TriggerEvent("esx_billing:openBillings")
    elseif data.id == 'dance' then
        TransitionFromBlurred(100)
        TriggerEvent("openDanceMenu")
        --print('dance!')
    elseif data.id == 'id' then
        --TriggerEvent("idcard:openId")
        TransitionFromBlurred(100)
    elseif data.id == 'work' then

    elseif data.id == 'phone' then
        TransitionFromBlurred(100)
        TriggerServerEvent('gcPhone:doIhaveAphone')
    end
end)

-- Callback function for testing
RegisterNUICallback('testprint', function(data, cb)
    -- Print message
    TriggerEvent('mesajPeChat', "[test]", {255,0,0}, data.message)

    -- Send ACK to callback function
    cb('ok')
end)
