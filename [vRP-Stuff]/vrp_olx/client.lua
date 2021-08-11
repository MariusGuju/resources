vRP = Proxy.getInterface("vrp")
vRPserver = Tunnel.getInterface("vrp","olx")
vRPolx = Tunnel.getInterface("olx","olx")
vRPolxC = {}
Tunnel.bindInterface("olx",vRPolxC)
vRPserver = Tunnel.getInterface("olx","olx")

print(GetEntityHeading(GetPlayerPed(-1)))

masiniSpawnate = {}
tablemasini = {}
inMenu = false
blipexist = false
inMenuVehicle = 0

function vRPolxC.spawnOLX(table)
    tablemasini = table
    if not blipexist then
        for k,v in pairs (tablemasini) do
            local blip = AddBlipForCoord(v.locatieAdaugareMasina[1],v.locatieAdaugareMasina[2],v.locatieAdaugareMasina[3])
            SetBlipSprite(blip, v.locatieAdaugareMasina.blipid)
            SetBlipColour(blip, v.locatieAdaugareMasina.blipcolor)
            SetBlipScale(blip, 1.0)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[OLX - Parcare #'..k..']')
            EndTextCommandSetBlipName(blip)
            blipexist = true
        end
    end

    count = 0
    for k,v in pairs (table) do 
        for i,p in pairs (v.parcari) do
            if p.status == 0 then
                count = count + 1
            end
        end
    end
end

function vRPolxC.spawnOLXMasini(masini,mods)
    if #masiniSpawnate == 0 then
        for k,v in pairs(masini) do
            for l,m in pairs(tablemasini) do
                for j,i in pairs(m.parcari) do
                    if v.parkid == i.id and v.parcare == l then
                        timp = 0
                        mhash = v.vehicul
                        while not HasModelLoaded(mhash) and timp < 10000 do
                            RequestModel(mhash)
                            Citizen.Wait(10)
                            timp = timp+1
                        end
                        if HasModelLoaded(mhash) then
                            local nveh = CreateVehicle(mhash, i[1],i[2],i[3]+0.5, i.heading, false, false)
                            NetworkFadeInEntity(nveh,0)
                            SetVehicleOnGroundProperly(nveh)
                            SetEntityInvincible(nveh,false)
                            SetVehicleNumberPlateText(nveh, v.plate)
                            SetVehicleHasBeenOwnedByPlayer(nveh,true)
                            SetModelAsNoLongerNeeded(mhash)
                            FreezeEntityPosition(nveh, true)
                            SetVehicleEngineOn(nveh,true,true,true)
                            tuning = json.decode(v.tuning)
                            SetTuning(nveh,tuning)

                            engine,brakes,turbo,transmisii = 0,0,0,0
                            for i,m in pairs(tuning.mods) do
                                i = tonumber(i)
                                if i == 11 then
                                    engine = m.mod
                                elseif i == 12 then
                                    brakes = m.mod
                                elseif i == 13 then
                                    turbo = m.mod
                                elseif i == 15 then
                                    transmisii = m.mod
                                end
                            end
                            table.insert(masiniSpawnate,{
                                vehicle = mhash, 
                                id = nveh,
                                x = i[1],
                                y = i[2],
                                z = i[3],
                                plate = v.plate,
                                proprietar = v.ownername..' ( ID '..v.owner..' )',
                                pret = v.pret,
                                -- TUNING
                                engine = engine,
                                brakes = brakes,
                                turbo = turbo,
                                transmisii = transmisii,
                                idtable = v.id,
                                spawned = true
                            })
                        end
                    end
                end
            end
        end
    else
        for k,v in pairs(masiniSpawnate) do
            DeleteEntity(v.id)
            table.remove(masiniSpawnate,k)
        end
        for k,v in pairs(masini) do
            for l,m in pairs(tablemasini) do
                for j,i in pairs(m.parcari) do
                    if v.parkid == i.id and v.parcare == l then
                        timp = 0
                        mhash = v.vehicul
                        while not HasModelLoaded(mhash) and timp < 10000 do
                            RequestModel(mhash)
                            Citizen.Wait(10)
                            timp = timp+1
                        end
                        if HasModelLoaded(mhash) then
                            local nveh = CreateVehicle(mhash, i[1],i[2],i[3]+0.5, i.heading, false, false)
                            NetworkFadeInEntity(nveh,0)
                            SetVehicleOnGroundProperly(nveh)
                            SetEntityInvincible(nveh,false)
                            SetVehicleNumberPlateText(nveh, v.plate)
                            SetVehicleHasBeenOwnedByPlayer(nveh,true)
                            SetModelAsNoLongerNeeded(mhash)
                            FreezeEntityPosition(nveh, true)
                            SetVehicleEngineOn(nveh,true,true,true)
                            tuning = json.decode(v.tuning)
                            SetTuning(nveh,tuning)

                            engine,brakes,turbo,transmisii = 0,0,0,0
                            for i,m in pairs(tuning.mods) do
                                i = tonumber(i)
                                if i == 11 then
                                    engine = m.mod
                                elseif i == 12 then
                                    brakes = m.mod
                                elseif i == 13 then
                                    turbo = m.mod
                                elseif i == 15 then
                                    transmisii = m.mod
                                end
                            end
                            table.insert(masiniSpawnate,{
                                vehicle = mhash, 
                                id = nveh,
                                x = i[1],
                                y = i[2],
                                z = i[3],
                                plate = v.plate,
                                proprietar = v.ownername..' ( ID '..v.owner..' )',
                                pret = v.pret,
                                -- TUNING
                                engine = engine,
                                brakes = brakes,
                                turbo = turbo,
                                transmisii = transmisii,
                                idtable = v.id,
                                spawned = true
                            })
                        end
                    end
                end
            end
        end
    end
end



function vRPolxC.schimbaPret(idmasina,pret)
    for k,v in pairs (masiniSpawnate) do
        if v.idtable == idmasina then
            v.pret = pret 
        end
    end
end

function vRPolxC.removeVehicle(idMasina)
    for k,v in pairs (masiniSpawnate) do
        if v.idtable == idMasina then
            DeleteEntity(v.id)
            table.remove(masiniSpawnate,k)
        end
    end
end

function SetTuning(masina,tuning)
    veh = masina
    SetVehicleModKit(veh,0)
    SetVehicleWheelType(veh, 0)
    for i,m in pairs(tuning.mods) do
        i = tonumber(i)
        if i == 22 or i == 18 then
            ToggleVehicleMod(veh,i,m.mod)
        elseif i == 23 or i == 24 then
            SetVehicleMod(veh,i,m.mod,m.variation)
        elseif i == 20 then
            ToggleVehicleMod(veh,20,true)
        else
            SetVehicleMod(veh,i,m.mod)
        end
    end
    
    for k,v in pairs (tuning.neon) do
        if k == 'front' then
            SetVehicleNeonLightEnabled(veh, 2,v)
        elseif k== 'back' then
            SetVehicleNeonLightEnabled(veh, 3,v)
        elseif k == 'left' then
            SetVehicleNeonLightEnabled(veh, 0,v)
        elseif k == 'right' then  
            SetVehicleNeonLightEnabled(veh, 1,v)
        end
    end
    SetVehicleXenonLightsColour(veh, tuning.headlightscolor)
    SetVehicleTyreSmokeColor(veh, tuning.smokecolor[1],tuning.smokecolor[2],tuning.smokecolor[3])
    SetVehicleCustomPrimaryColour( veh, tuning.color[1], tuning.color[2], tuning.color[3] )
    SetVehicleCustomSecondaryColour( veh, tuning.color[4], tuning.color[5], tuning.color[6] )
    SetVehicleExtraColours(veh,tuning.extracolor[1], tuning.extracolor[2])
    SetVehicleNeonLightsColour(veh,tuning.neoncolor[1],tuning.neoncolor[2],tuning.neoncolor[3])
    SetVehicleNumberPlateTextIndex(veh, tuning.plateindex)
    SetVehicleWindowTint(veh, tuning.windowtint)
end

CreateThread(function()
    while tablemasini ~= nil do
        Wait(350)
        for k,v in pairs (tablemasini) do
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.locatieAdaugareMasina[1],v.locatieAdaugareMasina[2],v.locatieAdaugareMasina[3], true) <= 8 do
                Wait(0)
                DrawMarker(2,v.locatieAdaugareMasina[1],v.locatieAdaugareMasina[2],v.locatieAdaugareMasina[3],0,0,0,0,0,0, 0.5001,0.5001,-0.5001 , 200,200,200,100 ,0,1,0,0)
                 if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.locatieAdaugareMasina[1],v.locatieAdaugareMasina[2],v.locatieAdaugareMasina[3], true) <= 1 then
                    text = "Apasa ~INPUT_CONTEXT~ pentru meniu \nLocuri Disponibile ~y~"..count.."/"..#v.parcari
                    Text(text)
                    if IsControlJustPressed(0,51) then
                        vRPserver.puneVehicululLaVanzare({k})
                    end
                 end
            end
        end
    end
end)

CreateThread(function()
    while masiniSpawnate ~= nil do
        Wait(350)
        for k,v in pairs(masiniSpawnate) do
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 1 and DoesEntityExist(v.id) do
                Wait(0)
                if not inMenu then
                    text = "Apasa ~INPUT_CONTEXT~ pentru meniul acestui vehicul"
                    Text(text)
                    if IsControlJustPressed(0,51) then
                        inMenu = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            action = "olxMenu",
                            masina = v.vehicle,
                            plate = v.plate,
                            proprietar = v.proprietar,
                            pret = v.pret,
                            engine = v.engine,
                            brakes = v.brakes,
                            turbo = v.turbo,
                            transmisii = v.transmisii,
                        })

                        inMenuVehicle = v.idtable
                    end
                end
            end
        end
    end
end)


RegisterNUICallback('cumparamasina', function(data,cb)
    vRPserver.cumparaMasina({inMenuVehicle})
    SendNUIMessage({
        action = "inchideOLX"
    })
end)

RegisterNUICallback('inchideOLX', function(data,cb)
    TaskLeaveVehicle(GetPlayerPed(-1),GetVehiclePedIsUsing(GetPlayerPed(-1)),16  )
    SetNuiFocus(false, false)
    inMenu = false
    inMenuVehicle = 0
end)

function Text(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end