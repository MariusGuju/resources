local smechercuvaloaremare = {
    {-596.30950927734,2089.62890625,131.4128112793,-595.45538330078,2086.5178222656,131.38150024414},
}

function teleport(x,y,z)
    local ped = GetPlayerPed(-1)
    NetworkFadeOutEntity(ped, true, false)
    Citizen.Wait(500)
    
    SetEntityCoords(ped, x, y, z, 1, 0, 0, 1)
    NetworkFadeInEntity(ped, 0)

    Citizen.Wait(500)
end

function help_text_notify(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)
        for _,v in pairs(smechercuvaloaremare) do	
            if (Vdist(playerPos.x, playerPos.y, playerPos.z,v[1],v[2],v[3]) < 11) or (Vdist(playerPos.x, playerPos.y, playerPos.z,v[4],v[5],v[6]) < 11) then
                DrawMarker(23, v[1],v[2],v[3]-0.85, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.9, 245,255,255, 50, true, true, 1, true, 0, 0, 0)
                DrawMarker(23, v[4],v[5],v[6]-0.85, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.9, 245,255,255, 50, true, true, 1, true, 0, 0, 0)
                Draw3DText(v[1],v[2],v[3]+0.2, "~g~[~w~Apasa ~r~[E] ~w~Pentru a folosi usa~g~]", 0.9)
                Draw3DText(v[4],v[5],v[6]+0.2, "~g~[~w~Apasa ~r~[E] ~w~Pentru a folosi usa~g~]", 0.9)
                if (Vdist(playerPos.x, playerPos.y, playerPos.z,v[1],v[2],v[3]) < 2.5) then
                    if IsControlJustPressed(1, 51) then
                        teleport(v[4],v[5],v[6])
                    end
                elseif (Vdist(playerPos.x, playerPos.y, playerPos.z,v[4],v[5],v[6]) < 2.5) then
                    if IsControlJustPressed(1, 51) then
                        teleport(v[1],v[2],v[3])
                    end
                end
            end
        end
    end
end)

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("~h~"..text)
        DrawText(_x,_y)
    end
end
