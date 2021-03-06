local pos = {x=-1616.0565185547,y=181.23881530762,z=59.957065582275}

------------------------------------------------
----------------------------------

----------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    DrawMarker(6, pos.x,pos.y,pos.z+0.25, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 0,0,0, 200, 1, 1, 0, 1, 0, 0, 0)
    DrawMarker(36, pos.x,pos.y,pos.z+0.25, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 158,13,163, 200, 1, 1, 0, 1, 0, 0, 0)
    text_overflow(pos.x,pos.y, pos.z + 1, "~g~Pret: ~r~5000 $ ~w~| ~r~10 Minute")
    text_overflow(pos.x,pos.y, pos.z + 1.25, "~g~Inchiriaza ~y~un Sandero")
      if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then -- here u can set up ur position, this is a test position
        license_text("Apasa ~INPUT_CONTEXT~ pentru a inchiria masina")
        if IsControlJustPressed(1, 51) then
          if IsInVehicle() then
            TriggerEvent('vRP_Rent: pedincar')
          else
            TriggerServerEvent('vRP_rent: payment')
          end
        end
      end
  end
end)
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
RegisterNetEvent('vRP_Rent: spawncar')
AddEventHandler('vRP_Rent: spawncar', function()
  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey('sandero21')
  RequestModel(vehicle)
  while not HasModelLoaded(vehicle) do
    Wait(1)
  end
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
  local spawned_car = CreateVehicle(vehicle, coords, GetEntityHeading(myPed), true, false)
  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleNumberPlateText(spawned_car, "RENT")
  SetModelAsNoLongerNeeded(vehicle)
  SetPedIntoVehicle(myPed,spawned_car,-1)
  Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(spawned_car))
end)

RegisterNetEvent('vRP_Rent: message')
AddEventHandler('vRP_Rent: message', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Ai inchiriat un Sandero pentru 10 minute")
    SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Sediu De Inchirieri |Liquid ShoowRoom!")
    DrawNotification(false, true)
end)

  RegisterNetEvent('vRP_Rent: pedincar')
  AddEventHandler('vRP_Rent: pedincar', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Te afli deja intr-o masina sau pe bicicleta")
      SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Sediu De Inchirieri |Liquid ShoowRoom!")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('vRP_Rent: notenough')
  AddEventHandler('vRP_Rent: notenough', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Nu ai destui bani")
      SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Sediu De Inchirieri |Liquid ShoowRoom!")
      DrawNotification(false, true)
  end)

RegisterNetEvent( 'vRP_Rent: deleteveh' )
AddEventHandler( 'vRP_Rent: deleteveh', function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )        
            local licenseplate = GetVehicleNumberPlateText(vehicle)

                  if licenseplate == "  RENT  " then
                    SetEntityAsMissionEntity( vehicle, true, true )
                    deleteCar( vehicle )
                  end

                if ( DoesEntityExist( vehicle ) ) then 
                  ShowNotification( "~r~Nu am gasit masina inchiriata" )
                else 
                  ShowNotification( "Timpul s-a terminat" )
                end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, 5.0, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )
            local licenseplate = GetVehicleNumberPlateText(vehicle)

            if ( DoesEntityExist( vehicle ) ) then 

                  if licenseplate == "  RENT  " then
                    SetEntityAsMissionEntity( vehicle, true, true )
                    deleteCar( vehicle )
                  end

                if ( DoesEntityExist( vehicle ) ) then 
                  ShowNotification( "~r~Nu am gasit masina inchiriata" )
                else 
                  ShowNotification( "Timpul s-a terminat" )
                end 
            else 
                ShowNotification( "Trebuie sa fii aproape de vehicul" )
            end 
        end 
    end 
end ) 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
function text_overflow(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.2*scale, 0.5*scale)
        SetTextFont(6)
        SetTextProportional(1)
    SetTextColour( 255, 255, 255, 255 )
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

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

function timp(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
  SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
  SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function license_text(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end