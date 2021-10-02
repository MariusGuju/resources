local smechercuvaloaremare = {
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