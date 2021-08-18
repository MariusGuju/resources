vRPeskJobsC = {}
Tunnel.bindInterface("esk_jobs",vRPeskJobsC)
Proxy.addInterface("esk_jobs",vRPeskJobsC)
vRP = Proxy.getInterface("vRP")
vRPSeskJobs = Tunnel.getInterface("esk_jobs","esk_jobs")

local joburi = {
    {"Postas",133.06480407715,96.315269470215,83.507583618164, marker = 20, blip = 318, blipcolor = 9},
    {"Livrator Bancar",-1.9383909702301,-660.24426269531,33.480281829834, marker = 20, blip = 175, blipcolor = 2},
    {"Taximetrist",-302.52777099609,-616.77026367188,33.557689666748, marker = 23, blip = 56, blipcolor = 46},
    {"Hacker",980.87463378906,-1705.8547363281,31.117679595947, marker = 20, blip = 0, blipcolor = 0}
}


Citizen.CreateThread(function()
    for k,v in pairs (joburi) do
        local blip = AddBlipForCoord(v[2],v[3],v[4])
        SetBlipSprite(blip, v.blip)
        SetBlipColour(blip, v.blipcolor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('[#]Job ~b~'..v[1])
        EndTextCommandSetBlipName(blip)
    end
    while true do
        Wait(2)
        for k,v in pairs (joburi) do
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 6.0 do
                DrawMarker(v.marker, v[2],v[3],v[4] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 1.0 then
                    local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a lua jobul de ~b~"..v[1]
                    HelpText(text)
                    if IsControlJustReleased(0, 38) then
                        vRPSeskJobs.puneJob({k})
                    end
                end
                Wait(0)
            end
        end
    end
end)


HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
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
        SetTextColour(255, 255, 255, 180)
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

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end

function teleport(x,y,z)
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityCoords(GetPlayerPed(-1), x, y,z)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end

function spawnMasinaJob(veh,x,y,z,h,job)
    print(veh,x,y,z,h,job)
    if not nveh then
        while not HasModelLoaded(veh) do
            RequestModel(veh)
           Citizen.Wait(10)
        end

        local ped = PlayerPedId()
        nveh = CreateVehicle(veh,x,y,z,h,true,false)
        SetVehicleIsStolen(nveh,false)
        SetVehicleOnGroundProperly(nveh)
        SetEntityInvincible(nveh,false)
        SetVehicleNumberPlateText(nveh,job)
        Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetVehicleDirtLevel(nveh,0.0)
        SetVehRadioStation(nveh,"OFF")
        SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
        SetModelAsNoLongerNeeded(mhash)
    end
end

function puneAnimatie(dict,animatie)
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0) 
    end
    TaskPlayAnim(ped,dict,animatie,100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    FreezeEntityPosition(ped,true)
    Wait(1100)
    FreezeEntityPosition(ped,false)
    ClearPedTasksImmediately(ped)
end


