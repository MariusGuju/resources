
positions = {
    {309.65637207031,-592.26971435547,43.283988952637, 38},
}

PlayerProps = {}
PlayerHasProp = false

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1000)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do

            x = location[1]
            y = location[2]
            z = location[3]
            presskey = location[4]

            DrawMarker(27, x, y, z-1.0, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 0, 127, 255, 200, 0, 0, 0, 1)

            if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, x, y, z, 2) then
                help_message("Apasa ~INPUT_CONTEXT~ pentru a semna fisa medicala")
                if IsControlJustReleased(1, presskey) then
                    TriggerServerEvent('medichealt:checkmoney')
                end
            end
        end
    end
end)


RegisterNetEvent('medichealt:function')
AddEventHandler('medichealt:function', function()
    local ped = GetPlayerPed(-1)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    notify_message("~g~Ai semnat fisa medicala")
    loadAnimDict( "amb@medic@standing@timeofdeath@enter" )
    loadAnimDict( "amb@medic@standing@timeofdeath@base" )
    loadAnimDict( "amb@medic@standing@timeofdeath@exit" )
    TaskPlayAnim(GetPlayerPed(-1),"amb@medic@standing@timeofdeath@enter", "enter",1.0, -1.0, 7000, 0, 7, false, false, false)
    TaskPlayAnim(GetPlayerPed(-1),"amb@medic@standing@timeofdeath@base", "base",1.0, -1.0, 7000, 0, 7, false, false, false)
    TaskPlayAnim(GetPlayerPed(-1),"amb@medic@standing@timeofdeath@exit", "exit",1.0, -1.0, 7000, 0, 7, false, false, false)
    AddPropToPlayer2("prop_pencil_01", 58866, 0.11, -0.02, 0.001, -100.0, 0.0, 0.0)
    AddPropToPlayer("prop_notepad_01", 18905, 0.1, 0.02, 0.05, 10.0, 0.0, 0.0)
    SetTimeout(7000, function()
        DoScreenFadeOut(500)
        DestroyAllProps()
        SetTimeout(500, function()
            SetEntityCoords(GetPlayerPed(-1), 354.1682434082,-592.81365966797,43.104415893555, 1,0,0,1)
            SetEntityHeading(GetPlayerPed(-1), -295.63)
            SetEntityVisible(ped, true, false)
            TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
            SetTimeout(1500, function()
                DoScreenFadeIn(500)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 120000,
        label = "Starea ta medicala se reface",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
                SetTimeout(120000, function()
                    notify_message("~g~Medici te-au ajutat cu toate curele necesare, acum puteti pleca")
                    SetEntityVisible(ped, true, false)
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    setHealth(200)
                    DoScreenFadeOut(500)
                    SetTimeout(500, function()
                        SetEntityCoords(GetPlayerPed(-1), 353.46752929688,-592.33630371094,43.315010070801, 1,0,0,1)
                        SetEntityHeading(GetPlayerPed(-1), 19.78)
                        SetTimeout(1000, function()
                            DoScreenFadeIn(1000)
                            DestroyAllProps()
                        end)
                    end)
                end)
            end)
        end)
    end)
end)

function position_verf(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify_message(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function notifyPicture(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end

function setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(GetPlayerPed(-1),n)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 1000 )
    end
end 

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
      RequestModel(GetHashKey(model))
      Wait(10)
    end
end
  
function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
      DeleteEntity(v)
    end
    PlayerHasProp = false
end
  
function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
      LoadPropDict(prop1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function AddPropToPlayer2(prop2, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop2) then
      LoadPropDict(prop2)
    end
  
    prop21 = CreateObject(GetHashKey(prop2), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop21, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop21)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop2)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
      DestroyAllProps()
      DoScreenFadeIn(5)
      DrawSpecialText("Restart resource", 5)
      FreezeEntityPosition(GetPlayerPed(-1), false)
    end
end)

AddEventHandler('playerDropped', function (reason)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DestroyAllProps()
end)

AddEventHandler("playerConnecting", function (connecting)
    SetTimeout(15000, function()
        FreezeEntityPosition(GetPlayerPed(-1), false)
        DestroyAllProps()
    end)
end)
