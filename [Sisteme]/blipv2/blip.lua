local smechercuvaloaremare = {
    {2307.3779296875,4889.0991210938,41.808265686036,615,46,"Abator",false,true},
	{-619.77685546875,-233.99067687988,38.05701828003,617,46,"Amanet",true,true},
    {163.95574951172,-3092.3972167969,5.9235429763794,501,10,"~b~Job Sofer Stivuitor",true,true},
    {160.12158203125,-3200.3601074219,5.9933085441589,501,10,"~b~Job Sofer Stivuitor",true,true},
    {22.588144302368,-2490.236328125,6.006778717041,477,81,"~y~Job Tirist",true,true},
    --{410.39584350586,-1633.0988769531,29.291944503784,566,50,"[#4]~p~Job Mecanic",true,true},
    {463.65551757813,-647.83392333984,28.241102218628,513,84,"~r~Job Sofer Autobuz",true,true},
    {718.31701660156,-979.25634765625,24.118183135986,71,2,"~g~Job Croitor",true,true},
    --{718.31701660156,-979.25634765625,24.118183135986,198,5,"[#7]~y~Job Taximetrist",true,true},
    {1710.7093505859,-1575.8352050781,112.58786010742,318,2,"[#7]~g~Job Gunoier",true,true},
    --{-1165.6215820313,-888.17742919922,14.125538825989,512,6,"[#6]~b~Job Uber Eatz",true,true},
    --{970.75903320313,-122.18836975098,74.353164672852,630,1,"Sons Of Anarchy",true,true},
    {-1082.3308105469,-259.71783447266,37.788005828857,409,1,"~r~Departament de Job-uri",true,true}
}
--718.31701660156,-979.25634765625,24.118183135986
Citizen.CreateThread(function()
    for _,v in pairs(smechercuvaloaremare) do	
        local blip = AddBlipForCoord(v[1],v[2],v[3])
        SetBlipSprite(blip, v[4])
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, v[5])
        SetBlipAsShortRange(blip, true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v[6])
        EndTextCommandSetBlipName(blip)
    end
end) 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        for _,v in pairs(smechercuvaloaremare) do
            if Vdist(GetEntityCoords(GetPlayerPed(-1)),v[1],v[2],v[3]) < 10.0 then
                if v[7] then
                 
                end
                if v[8] then
                    
                end
            end
        end
    end
end)

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.5*scale, 0.75*scale)
        SetTextFont(1)
        SetTextProportional(1)
    SetTextColour( 100, 200, 200, 255 )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
      World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end