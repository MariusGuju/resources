
local cutiiDuse = 0
local cutiiMaxim = 11
local masinaPostasSpawn = false
local portbagajPostasDeschis = false
local cutieInMana = false
local chestiiJobPostas = true
local duCutii = false
local blipsPostas = {}
local startJobPostas = false

function vRPeskJobsC.puneChestiiPostas(chestii,jobInfo)
	cutiiDuse = 0
	cutiiMaxim = 11
	masinaPostasSpawn = false
	portbagajPostasDeschis = false
	cutieInMana = false
    chestiiJobPostas = true
    startJobPostas = jobInfo
    Citizen.CreateThread(function()
        while startJobPostas do
            Wait(200)
            for k,v in pairs (chestii) do
                while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[3],v[4],v[5], true) <= 5.0 and chestiiJobPostas do
                    DrawMarker(v.markerid, v[3],v[4],v[5] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001,  73, 31, 214, 100, 0, 0, 0, 1, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[3],v[4],v[5], true) <= 1.0 then
                        local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a ~b~"..v.mesaj
                        HelpText(text)
                        if IsControlJustReleased(0, 38) then
                            if k == 1 then 
                                if not masinaPostasSpawn then
                                    Fade(1200)
                                    Wait(100)
                                    --spawnMasinaPostas("boxville4",121.0060043335,90.114120483398,81.300354003906,250.38,"POSTAS")
                                    veh,x,y,z,h = "boxville4",132.16748046875,88.397407531738,82.302886962891,250.38
                                    vehiclehash = GetHashKey(veh)
                                    RequestModel(vehiclehash)
                                    while not HasModelLoaded(vehiclehash) do
                                        waiting = waiting + 100
                                        Citizen.Wait(100)
                                        if waiting > 5000 then
                                            break
                                        end
                                    end
                                    CreateVehicle(vehiclehash, x, y, z, h, 1, 0)
                                    masinaPostasSpawn = true
                                end
                            elseif k == 2 then
                                if masinaPostasSpawn and portbagajPostasDeschis then
                                    if not cutieInMana then
                                        spawncutieInMana()
                                    end
                                end
                            end
                        end
                    end
                    Wait(0)
                end
            end
        end
    end)
end

function spawnMasinaPostas(veh,x,y,z,h,job)
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

function vRPeskJobsC.bagaCheckpointcase(case)
    if duCutii and not chestiiJobPostas then
        for k,v in pairs (case) do
            local blips = AddBlipForCoord(v[2],v[3],v[4])
            SetBlipSprite(blips, 615)
            SetBlipColour(blips, 3)
            SetBlipAsShortRange(blips, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[POSTAS] Case')
            EndTextCommandSetBlipName(blips)
            table.insert(blipsPostas, blips)

            Citizen.CreateThread(function()
                while true do
                    Wait(200)

                        while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 3.0 and duCutii and v.status do
                            DrawMarker(26, v[2],v[3],v[4] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 1.0 then
                                local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a ~b~ lasa cutiile"
                                HelpText(text)
                                if IsControlJustReleased(0, 38) then
                                    if cutieInMana then
										puneAnimatie("anim@heists@money_grab@briefcase","put_down_case")
                                        vRPSeskJobs.rewardPostas({})
                                        cutieInMana = false
                                        v.status = false
                                        deleteCutie() -- de pe player
                                        if cutiiDuse == 0 then
                                            duCutii = false
                                            chestiiJobPostas = true
                                            for j,p in pairs (blipsPostas) do
                                                RemoveBlip(p)
                                            end
                                            table.remove(blipsPostas)
                                        end
                                    end
                                end
                            end
                            Wait(0)
                        end

                end
            end)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(200)
        if masinaPostasSpawn then
			local veh = GetVanPosition(10)
			local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),coordsVan.x,coordsVan.y,coordsVan.z,true)
			local model = GetEntityModel(veh)
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),coordsVan.x,coordsVan.y,coordsVan.z,true) <= 2.0 and not IsPedInAnyVehicle(PlayerPedId()) do
                if model == 444171386 then
                    if not portbagajPostasDeschis then
                        mesaj = "~b~[E] ~w~Deschide"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorOpen(veh, 3, false, false)
                            SetVehicleDoorOpen(veh, 2, false, false)
                            portbagajPostasDeschis = true
                        end
                    elseif portbagajPostasDeschis and not cutieInMana then
                        mesaj = "~b~[E] ~w~Inchide | ~b~[G] ~w~Ridica cutia"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorShut(veh, 3, false)
                            SetVehicleDoorShut(veh, 2, false)
                            portbagajPostasDeschis = false
                        elseif IsControlJustPressed(0,58) then
                            if cutiiDuse > 0 then
                                cutiiDuse = cutiiDuse -2
                                cutieInMana = true
                                spawncutieInMana()
                                deleteCutiiRajnita()
                            end
                            if cutiiDuse == 0 then
                                chestiiJobPostas = true
                            end
                        end
                    elseif portbagajPostasDeschis and cutieInMana then
                        mesaj = "~b~[E] ~w~Inchide | ~b~[G] ~w~Pune cutia"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorShut(veh, 3, true)
                            SetVehicleDoorShut(veh, 2, true)
                            portbagajPostasDeschis = false
                        elseif IsControlJustPressed(0,58) then
    
                                cutiiDuse = cutiiDuse + 1
                                puneAnimatie("anim@heists@money_grab@briefcase","put_down_case")
                                deleteCutie() -- de pe player
                                cutiutaInMasina(veh,model)
                                cutieInMana = false

                            if cutiiDuse == cutiiMaxim then
                                chestiiJobPostas = false
                                duCutii = true
                                vRPSeskJobs.spawnCasele({true})
                            end
                        end
                    end
                    DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.95,mesaj)
                    if portbagajPostasDeschis then
                        DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.7,"  ~b~"..cutiiDuse.."~w~  /  ~b~" ..cutiiMaxim)
                    end
                end
                Wait(0)
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTII JOB
-----------------------------------------------------------------------------------------------------------------------------------------


function spawncutieInMana()
    local Player = PlayerPedId()
    if cutiiDuse <= cutiiMaxim then
        local cutie = "hei_prop_heist_box"
        cutieInMana = true
        local x,y,z = table.unpack(GetEntityCoords(Player))

        if not HasModelLoaded(cutie) then
            while not HasModelLoaded(GetHashKey(cutie)) do
                RequestModel(GetHashKey(cutie))
                Wait(10)
            end
        end

        prop = CreateObject(GetHashKey(cutie), x, y, z+0.2,  true,  true, true)
        AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 28422), 0.49,-0.18,0.00,25.0,270.0,180.0, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(cutie)
    end
end


function GetVanPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetVanDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetVanDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end

function deleteCutiiRajnita()
	if cutiiDuse == 0 then
        if DoesEntityExist(cutiuta) then
			DetachEntity(cutiuta,false,false)
			FreezeEntityPosition(cutiuta,false)
			DeleteEntity(cutiuta1)
        end
	elseif cutiiDuse == 1 then
		if DoesEntityExist(cutiuta2) then
			DetachEntity(cutiuta2,false,false)
			FreezeEntityPosition(cutiuta2,false)
			DeleteEntity(cutiuta2)
        end
	elseif cutiiDuse == 2 then
		if DoesEntityExist(cutiuta3) then
			DetachEntity(cutiuta3,false,false)
			FreezeEntityPosition(cutiuta3,false)
			DeleteEntity(cutiuta3)
        end
	elseif cutiiDuse == 3 then
		if DoesEntityExist(cutiuta4) then
			DetachEntity(cutiuta4,false,false)
			FreezeEntityPosition(cutiuta4,false)
			DeleteEntity(cutiuta4)
        end
	elseif cutiiDuse == 4 then
		if DoesEntityExist(cutiuta5) then
			DetachEntity(cutiuta5,false,false)
			FreezeEntityPosition(cutiuta5,false)
			DeleteEntity(cutiuta5)
        end
	elseif cutiiDuse == 5 then
		if DoesEntityExist(cutiuta6) then
			DetachEntity(cutiuta6,false,false)
			FreezeEntityPosition(cutiuta6,false)
			DeleteEntity(cutiuta6)
        end
    elseif cutiiDuse == 6 then
		if DoesEntityExist(cutiuta7) then
			DetachEntity(cutiuta7,false,false)
			FreezeEntityPosition(cutiuta7,false)
			DeleteEntity(cutiuta7)
        end
    elseif cutiiDuse == 7 then
		if DoesEntityExist(cutiuta8) then
			DetachEntity(cutiuta8,false,false)
			FreezeEntityPosition(cutiuta8,false)
			DeleteEntity(cutiuta8)
        end
    elseif cutiiDuse == 8 then
		if DoesEntityExist(cutiuta9) then
			DetachEntity(cutiuta9,false,false)
			FreezeEntityPosition(cutiuta9,false)
			DeleteEntity(cutiuta9)
        end
    elseif cutiiDuse == 9 then
		if DoesEntityExist(cutiuta10) then
			DetachEntity(cutiuta10,false,false)
			FreezeEntityPosition(cutiuta10,false)
			DeleteEntity(cutiuta10)
        end
	end
end
function deleteCutie()
    local player = PlayerPedId()
    DeleteEntity(prop)
end

function cutiutaInMasina(veh,model)
    if cutiiDuse <= cutiiMaxim then
        RequestModel(GetHashKey("hei_prop_heist_box"))
        while not HasModelLoaded(GetHashKey("hei_prop_heist_box")) do
            Citizen.Wait(10)
        end
        local coords = GetOffsetFromEntityInWorldCoords(veh,0.0,0.0,-5.0)
        if cutiiDuse == 1 and model == 444171386 then
			cutiuta = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta,veh,0.0,-0.45,-3.0,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta,true)
		elseif cutiiDuse == 2 and model == 444171386 then
			cutiuta2 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta2,veh,0.0,0.0,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta2,true)
		elseif cutiiDuse == 3 and model == 444171386 then
			cutiuta3 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta3,veh,0.0,0.45,-3.0,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta3,true)
		elseif cutiiDuse == 4 and model == 444171386 then
			cutiuta4 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta4,veh,0.0,-0.45,-2.6,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta4,true)
		elseif cutiiDuse == 5 and model == 444171386 then
			cutiuta5 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta5,veh,0.0,0.0,-2.6,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta5,true)
		elseif cutiiDuse == 6 and model == 444171386 then
			cutiuta6 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta6,veh,0.0,0.45,-2.6,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta6,true)
		elseif cutiiDuse == 7 and model == 444171386 then
			cutiuta7 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta7,veh,0.0,-0.45,-2.2,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta7,true)
		elseif cutiiDuse == 8 and model == 444171386 then
			cutiuta8 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta8,veh,0.0,0.0,-2.2,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta8,true)
		elseif cutiiDuse == 9 and model == 444171386 then
			cutiuta9 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta9,veh,0.0,0.45,-2.2,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta9,true)
		elseif cutiiDuse == 10 and model == 444171386 then
			cutiuta10 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta10,veh,0.0,-0.45,-1.8,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta10,true)
		elseif cutiiDuse == 11 and model == 444171386 then
			cutiuta11 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta11,veh,0.0,0.0,-1.8,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta11,true)
		elseif cutiiDuse == 12 and model == 444171386 then
			cutiuta12 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta12,veh,0.0,0.45,-1.8,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta12,true)
		elseif cutiiDuse == 13 and model == 444171386 then
			cutiuta13 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta13,veh,0.0,-0.45,-1.4,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta13,true)
		elseif cutiiDuse == 14 and model == 444171386 then
			cutiuta14 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(cutiuta14,veh,0.0,0.0,-1.4,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(cutiuta14,true)
		elseif cutiiDuse == 15 and model == 444171386 then
			cutiuta15 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(cutiuta15,veh,0.0,0.45,-1.4,-0.10,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(cutiuta15,true)
		end
    end
end