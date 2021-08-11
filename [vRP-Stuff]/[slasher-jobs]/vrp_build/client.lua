vRPciupercarC = {}
Tunnel.bindInterface("vRP_santierist",vRPsantieristC)
Proxy.addInterface("vRP_santierist",vRPsantieristC)
vRP = Proxy.getInterface("vRP")
vRPSsantierist = Tunnel.getInterface("vRP_santierist","vRP_santierist")

local hasjob = false
local cosSC = false
local santierist = 0
local vinde = false
local cosul = true

Citizen.CreateThread(function()
    local blip3 = AddBlipForCoord(36.075267791748,6549.1459960938,31.425592422485)
    SetBlipSprite(blip3, 653)
    SetBlipDisplay(blip3, 4)
    SetBlipScale(blip3, 0.9)
    SetBlipColour(blip3, 46)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("[~o~CR~w~] Job ~g~Santierist")
    EndTextCommandSetBlipName(blip3)
end)




function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
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

local coordonate = {
    {80.251571655273,6538.5,31.676446914673},
    {93.564575195313,6550.1381835938,31.676446914673},
    {100.71002960205,6540.2573242188,31.03611946106},
    {72.813697814941,6528.4697265625,31.5703125},
    {66.992835998535,6523.818359375,31.570306777954},
    {91.945983886719,6558.6875,31.676464080811},
    {774.31677246094,4204.9287109375,8.3551778793335},
}
local tabel = {}

Citizen.CreateThread(function()
    for i,v in pairs(coordonate) do
        local locatie = AddBlipForCoord(v[1],v[2],v[3])
        SetBlipSprite(locatie, 0)
      
        end
	while true do
        Citizen.Wait(1000)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local metrii = math.floor(GetDistanceBetweenCoords(36.075267791748,6549.1459960938,31.425592422485, GetEntityCoords(GetPlayerPed(-1))))
        if metrii < 20 then
            DrawMarker(20, -36.075267791748,6549.1459960938,31.425592422485, 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
            DrawText3D(36.075267791748,6549.1459960938,31.425592422485+1, "~y~JOB Santierist", 1.2)

        end
        if hasjob == true then
            for i,v in pairs(coordonate) do
                local metrii2 = math.floor(GetDistanceBetweenCoords(v[1],v[2],v[3], GetEntityCoords(GetPlayerPed(-1))))
                if santierist == 1 or santierist == 2 or santierist == 3 or santierist == 4 or santierist == 5 then
                    DrawText3D(pos.x,pos.y,pos.z, "Lucru: ~r~"..santierist.."~w~/~g~6", 1.2)
                    
                elseif santierist == 6 then
                    DrawText3D(pos.x,pos.y,pos.z, "Du-te sa-ti primesti recompensa", 1.2)
                    vinde = true
                end
                if coordonate[i] ~= nil then
                    if metrii2 <=30 then
                        DrawMarker(20, v[1],v[2],v[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
                        DrawText3D(v[1],v[2],v[3]+0.7, "Apasa ~y~[E]~w~ pentru a lucra", 1.2)
                    end
                end
                if coordonate[i] ~= nil then
                    if metrii2 <=3 then
                        if IsControlJustPressed(1,51) then
                            table.remove(coordonate,i)
                            vRP.playAnim({false, {task="WORLD_HUMAN_CONST_DRILL"}, false})
                            SetTimeout(10000, function()
                            vRP.stopAnim( {false})
                            vRP.notify({"[NorbSiMaruServer]Ai inceput sa lucrezi","success"})
                            santierist = santierist + 1

                            end)
                        end
                    end
                else
                    DrawText3D(v[1],v[2],v[3]+0.7, "~r~Ai lucrat deja aici", 1.2)
                end
            end
        end
		if metrii <= 3 then
            DrawText3D(pos.x,pos.y,pos.z+0.6, "Apasa ~y~[E]~w~ pentru a incepe jobul de Santierist\n Apasa ~y~[Y]~w~ pentru a primi recompensa", 1.2)
            if IsControlJustPressed(1,51) then
                
                
                if hasjob == false then
                
                vRP.notify({"[NorbSiMaruServer] Felicitari ai fost angajat ca Santierist","success"})


                hasjob = true
       

                for i,v in pairs(coordonate) do
                    DrawMarker(20, v[1],v[2],v[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
                end
                elseif hasjob == true then
                    vRP.notify({"[NorbSiMaruServer] Esti deja angajat ca Santierist","success"})
                end
                
            elseif IsControlJustPressed(1,246) then
                if vinde == true then
                    if santierist == 6 then
                        TriggerServerEvent("vRP_job_santierist:pay")
                        santierist = 0
                        hasjob = false
                        cosSC = false
                        vinde = false

                        table.insert(coordonate,{80.251571655273,6538.5,31.676446914673})
                        table.insert(coordonate,{100.71002960205,6540.2573242188,31.03611946106})
                        table.insert(coordonate,{72.813697814941,6528.4697265625,31.5703125})
                        table.insert(coordonate,{93.564575195313,6550.1381835938,31.676446914673})
                        table.insert(coordonate,{66.992835998535,6523.818359375,31.570306777954})
                        table.insert(coordonate,{91.945983886719,6558.6875,31.676464080811})
                        table.insert(coordonate,{774.31677246094,4204.9287109375,8.3551778793335})
                    end
                else
                    vRP.notify({"[NorbSiMaruServer] N-ai lucrat inca.","success"})
                end
            end
        end 
    end
end)