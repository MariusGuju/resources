saciDusi = 0
saciMaxim = 15
masinaSpawn = false
portbagajDeschis = false
sacInMana = false
duSacii = false
chestiiJob = true
startJob = false
blips = {}

function vRPeskJobsC.puneChestiiGruppe6(chestii,startJobInfo)
    saciDusi = 0
    saciMaxim = 15
    masinaSpawn = false
    portbagajDeschis = false
    sacInMana = false
    chestiiJob = true
    startJob = startJobInfo
        Citizen.CreateThread(function()
            while startJob do
                Wait(200)
                for k,v in pairs (chestii) do
                    while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[3],v[4],v[5], true) <= 3.0 and chestiiJob do
                        DrawMarker(v.markerid, v[3],v[4],v[5] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[3],v[4],v[5], true) <= 1.0 then
                            local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a ~b~"..v.mesaj
                            HelpText(text)
                            if IsControlJustReleased(0, 38) then
                                if k == 1 then 
                                    if masinaSpawn == false then
                                        masinaSpawn = true
                                        Fade(1200)
                                        local waiting = 0
                                        --spawnMasinaJob("stockade",-6.1428499221802,-669.97711181641,31.942794799805,184.20,"GRUPPE6")
                                        veh,x,y,z,h = "stockade",-6.1428499221802,-669.97711181641,31.942794799805,184.20
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
                                    end
                                elseif k == 2 then
                                    if masinaSpawn and portbagajDeschis then
                                        if not sacInMana then
                                            spawnSacInMana()
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

RegisterCommand("pulentiu", function()
    if(dickObject ~= nil)then
        SetEntityAsMissionEntity(dickObject, true, true)
        DeleteEntity(dickObject)
        dickObject = nil
    else
        local hash = GetHashKey('prop_cs_dildo_01')
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        local coords = GetEntityCoords(GetPlayerPed(-1))
        dickObject = CreateObject(hash, coords.x, coords.y, coords.z, true, false, false)
        AttachEntityToEntity(dickObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 11816), 0.1, 0.12, 0.0, -90.0, -10.0, 0.0, false, false, false, false, 0, true)
    end
end) 

function vRPeskJobsC.bagaBancomatele(bancomate)
    if duSacii and not chestiiJob then
        for k,v in pairs (bancomate) do
            local blip = AddBlipForCoord(v[2],v[3],v[4])
            SetBlipSprite(blip, 207)
            SetBlipColour(blip, 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Livrator Bancar] BANCOMATE')
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)

            Citizen.CreateThread(function()
                while true do
                    Wait(200)
                   -- for k,v in pairs (bancomate) do
                        while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 3.0 and duSacii and v.status do
                            DrawMarker(26, v[2],v[3],v[4] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 1.0 then
                                local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a ~b~ alimenta bancomatele"
                                HelpText(text)
                                if IsControlJustReleased(0, 38) then
                                    if sacInMana then
                                        puneAnimatie("missfbi4prepp1","_bag_throw_garbage_man")
                                        vRPSeskJobs.reward({})
                                        sacInMana = false
                                        v.status = false
                                        deleteSac() -- de pe player
                                        if saciDusi == 0 then
                                            duSacii = false
                                            chestiiJob = true
                                            for j,p in pairs (blips) do
                                                RemoveBlip(p)
                                            end
                                            table.remove(blips)
                                        end
                                    end
                                end
                            end
                            Wait(0)
                        end
                    --end
                end
            end)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(200)
        if masinaSpawn then
            local veh = GetStockPosition(10)
            local ped = PlayerPedId()
            local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
            local model = GetEntityModel(veh)
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),coordsStock.x,coordsStock.y,coordsStock.z,true) <= 2.0 and not IsPedInAnyVehicle(PlayerPedId()) do
                if model == 1747439474 then
                    if not portbagajDeschis then
                        mesaj = "~b~[E] ~w~Deschide"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorOpen(veh, 3, false, false)
                            SetVehicleDoorOpen(veh, 2, false, false)
                            portbagajDeschis = true
                        end
                    elseif portbagajDeschis and not sacInMana then
                        mesaj = "~b~[E] ~w~Inchide | ~b~[G] ~w~Ridica sacul de bani"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorShut(veh, 3, false)
                            SetVehicleDoorShut(veh, 2, false)
                            portbagajDeschis = false
                        elseif IsControlJustPressed(0,58) then
                            if saciDusi > 0  then
                                saciDusi = saciDusi -2
                                sacInMana = true
                                spawnSacInMana()
                                deleteSacRajnita()
                            end
                            if saciDusi == 0 then
                                chestiiJob = true
                            end
                        end
                    elseif portbagajDeschis and sacInMana then
                        mesaj = "~b~[E] ~w~Inchide | ~b~[G] ~w~Pune sacul de bani"
                        if IsControlJustPressed(0,38) then
                            SetVehicleDoorShut(veh, 3, true)
                            SetVehicleDoorShut(veh, 2, true)
                            portbagajDeschis = false
                        elseif IsControlJustPressed(0,58) then
    
                                saciDusi = saciDusi + 1
                                puneAnimatie("missfbi4prepp1","_bag_throw_garbage_man")
                                deleteSac() -- de pe player
                                sacInMasina(veh,model)
                                sacInMana = false

                            if saciDusi == saciMaxim then
                                chestiiJob = false
                                duSacii = true
                                vRPSeskJobs.spawnBancomate({true})
                            end
                        end
                    end
                    DrawText3Ds(coordsStock.x,coordsStock.y,coordsStock.z+0.95,mesaj)
                    if portbagajDeschis then
                        DrawText3Ds(coordsStock.x,coordsStock.y,coordsStock.z+0.7,"  ~b~"..saciDusi.."~w~  /  ~b~" ..saciMaxim)
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

function deleteSacRajnita()
	if saciDusi == 0 then
        if DoesEntityExist(saculet) then
			DetachEntity(saculet,false,false)
			DetachEntity(saculet2,false,false)
			FreezeEntityPosition(saculet,false)
            DeleteEntity(saculet)
        end
	elseif saciDusi == 1 then
		if DoesEntityExist(saculet2) then
			DetachEntity(saculet2,false,false)
			FreezeEntityPosition(saculet2,false)
            DeleteEntity(saculet2)
        end
	elseif saciDusi == 2 then
		if DoesEntityExist(saculet3) then
			DetachEntity(saculet3,false,false)
			FreezeEntityPosition(saculet3,false)
            DeleteEntity(saculet3)
        end
	elseif saciDusi == 3 then
		if DoesEntityExist(saculet4) then
			DetachEntity(saculet4,false,false)
			FreezeEntityPosition(saculet4,false)
            DeleteEntity(saculet4)
        end
	elseif saciDusi == 4 then
		if DoesEntityExist(saculet5) then
			DetachEntity(saculet5,false,false)
			FreezeEntityPosition(saculet5,false)
            DeleteEntity(saculet5)
        end
	elseif saciDusi == 5 then
		if DoesEntityExist(saculet6) then
			DetachEntity(saculet6,false,false)
			FreezeEntityPosition(saculet6,false)
            DeleteEntity(saculet6)
        end
    elseif saciDusi == 6 then
		if DoesEntityExist(saculet7) then
			DetachEntity(saculet7,false,false)
			FreezeEntityPosition(saculet7,false)
            DeleteEntity(saculet7)
        end
    elseif saciDusi == 7 then
		if DoesEntityExist(saculet8) then
			DetachEntity(saculet8,false,false)
			FreezeEntityPosition(saculet8,false)
            DeleteEntity(saculet8)
        end
    elseif saciDusi == 8 then
		if DoesEntityExist(saculet9) then
			DetachEntity(saculet9,false,false)
			FreezeEntityPosition(saculet9,false)
            DeleteEntity(saculet9)
        end
    elseif saciDusi == 9 then
		if DoesEntityExist(saculet10) then
			DetachEntity(saculet10,false,false)
			FreezeEntityPosition(saculet10,false)
            DeleteEntity(saculet10)
        end
    elseif saciDusi == 10 then
		if DoesEntityExist(saculet11) then
			DetachEntity(saculet11,false,false)
			FreezeEntityPosition(saculet11,false)
            DeleteEntity(saculet11)
        end
    elseif saciDusi == 11 then
		if DoesEntityExist(saculet12) then
			DetachEntity(saculet12,false,false)
			FreezeEntityPosition(saculet12,false)
            DeleteEntity(saculet12)
        end
    elseif saciDusi == 12 then
		if DoesEntityExist(saculet13) then
			DetachEntity(saculet13,false,false)
			FreezeEntityPosition(saculet13,false)
            DeleteEntity(saculet13)
        end
    elseif saciDusi == 13 then
		if DoesEntityExist(saculet14) then
			DetachEntity(saculet14,false,false)
			FreezeEntityPosition(saculet14,false)
            DeleteEntity(saculet14)
        end
    elseif saciDusi == 14 then
		if DoesEntityExist(saculet15) then
			DetachEntity(saculet15,false,false)
			FreezeEntityPosition(saculet15,false)
            DeleteEntity(saculet15)
        end
	end
end
function deleteSac()
    local player = PlayerPedId()
    DeleteEntity(prop)
end

function sacInMasina(veh,model)
    if saciDusi <= saciMaxim then
        RequestModel(GetHashKey("prop_money_bag_01"))
        while not HasModelLoaded(GetHashKey("prop_money_bag_01")) do
            Citizen.Wait(10)
        end
        local coords = GetOffsetFromEntityInWorldCoords(veh,0.0,0.0,-5.0)
        if saciDusi == 1 and model == 1747439474 then
			saculet = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet,veh,0.0,-0.45,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet,true)
		elseif saciDusi == 2 and model == 1747439474 then
			saculet2 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet2,veh,0.0,0.0,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet2,true)
		elseif saciDusi == 3 and model == 1747439474 then
			saculet3 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet3,veh,0.0,0.45,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet3,true)
		elseif saciDusi == 4 and model == 1747439474 then
			saculet4 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet4,veh,0.0,-0.45,-2.6,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet4,true)
		elseif saciDusi == 5 and model == 1747439474 then
			saculet5 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet5,veh,0.0,0.0,-2.6,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet5,true)
		elseif saciDusi == 6 and model == 1747439474 then
			saculet6 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet6,veh,0.0,0.45,-2.6,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet6,true)
		elseif saciDusi == 7 and model == 1747439474 then
			saculet7 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet7,veh,0.0,-0.45,-2.2,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet7,true)
		elseif saciDusi == 8 and model == 1747439474 then
			saculet8 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet8,veh,0.0,0.0,-2.2,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet8,true)
		elseif saciDusi == 9 and model == 1747439474 then
			saculet9 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet9,veh,0.0,0.45,-2.2,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet9,true)
		elseif saciDusi == 10 and model == 1747439474 then
			saculet10 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet10,veh,0.0,-0.45,-1.8,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet10,true)
		elseif saciDusi == 11 and model == 1747439474 then
			saculet11 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet11,veh,0.0,0.0,-1.8,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet11,true)
		elseif saciDusi == 12 and model == 1747439474 then
			saculet12 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet12,veh,0.0,0.45,-1.8,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet12,true)
		elseif saciDusi == 13 and model == 1747439474 then
			saculet13 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet13,veh,0.0,-0.45,-1.4,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet13,true)
		elseif saciDusi == 14 and model == 1747439474 then
			saculet14 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			--AttachEntityToEntity(saculet14,veh,0.0,0.0,-1.4,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			--FreezeEntityPosition(saculet14,true)
		elseif saciDusi == 15 and model == 1747439474 then
			saculet15 = CreateObject(GetHashKey("prop_money_bag_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(saculet15,veh,0.0,0.45,-1.4,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(saculet15,true)
		end
    end
end

function spawnSacInMana(dict,animatie)
    local Player = PlayerPedId()
    if saciDusi <= saciMaxim then
        local sacBani = "prop_money_bag_01"
        sacInMana = true
        local x,y,z = table.unpack(GetEntityCoords(Player))

        if not HasModelLoaded(sacBani) then
            while not HasModelLoaded(GetHashKey(sacBani)) do
                RequestModel(GetHashKey(sacBani))
                Wait(10)
            end
        end

        prop = CreateObject(GetHashKey(sacBani), x, y, z+0.2,  true,  true, true)
        -- aici
        TaskPlayAnim(ped,dict,animatie,100.0, 200.0, stil, 120, 0.2, 0, 0, 0)
        AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 57005), 0.49,-0.18,0.00,25.0,270.0,180.0, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(sacBani)
    end
end


function GetStockPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetStockDirection(coordsx, coordsy)
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

function GetStockDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end