vRPCarme = {}
Tunnel.bindInterface("vrp_traficantarme",vRPCarme)
Proxy.addInterface("vrp_traficantarme",vRPCarme)
vRPSarme = Tunnel.getInterfata("vrp_traficantarme","vrp_traficantarme")
vRP = Proxy.getInterface("vRP")

local job_arme = {-583.83782958984,5363.787109375,70.391693115234}
local ia_armele = {-519.47039794922,5307.8979492188,80.239868164062}

local activare_job = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if(Vdist(GetEntityCoords(GetPlayerPed(-1)),-588.42266845703,5348.4555664062,70.287170410156)<2.0) then
            DrawText3D(-588.42266845703,5348.4555664062,70.287170410156+1, "~w~[~c~TRAFICANT~w~] Apasa ~c~'E' ~w~sa te angajezi!", 1.0, 1)
            if IsControlJustPressed(0, 38) then
                vRPSarme.arme_job()
                vRPCarme.activare_job()
            end
        elseif (activare_job == true) then
            if(Vdist(GetEntityCoords(GetPlayerPed(-1)),ia_armele[1],ia_armele[2],ia_armele[3])<2.0) then
                DrawText3D(ia_armele[1],ia_armele[2],ia_armele[3]+1, "~w~[~c~TRAFICANT~w~] Apasa ~c~'E' ~w~sa iei armele!", 1.0, 1)
                if IsControlJustPressed(0, 38) then
                    vRPCarme.incepe_animatia()
                    vRPSarme.ia_armele()
                end
            end
        end
    end
end)

function vRPCarme.incepe_animatia()
    local ped = GetPlayerPed(-1)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_PARKING_METER", 0, true)
    Wait(10000)
    ClearPedTasks(ped)
    activare_job = false
end

function vRPCarme.activare_job()
    activare_job = true
end

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end