
local isRadarExtended = false
local showblip = false
local showsprite = false

vRP = Proxy.getInterface("vRP")

RegisterNetEvent('showBlips')
AddEventHandler('showBlips', function()
	showblip = not showblip
	if showblip then
		showsprite = true
		vRP.notify({"~g~Blips enabled"})
	else
		showsprite = false
		vRP.notify({"~r~Blips disabled"})
	end
end)

RegisterNetEvent('showSprites')
AddEventHandler('showSprites', function()
	showsprite = not showsprite
	if showsprite then
		vRP.notify({"~g~Sprites enabled"})
	else
		vRP.notify({"~r~Sprites disabled"})
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(350)
		while showblip or showsprite do
			Wait(0)
			for id = 0, 255 do
				if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped )

					headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, GetPlayerName( id ), false, false, "", false )

					if showsprite then
						Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 0, true ) -- Add player name sprite
						Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 7, false ) -- Remove wanted sprite
		
						if NetworkIsPlayerTalking( id ) then
							Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, true ) -- Add speaking sprite
						else
							Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false ) -- Remove speaking sprite
						end
					else
						Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 7, false ) -- Remove wanted sprite
						Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false ) -- Remove speaking sprite
						Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 0, false ) -- Remove player name sprite
					end
					if showblip then
						if not DoesBlipExist( blip ) then 
							blip = AddBlipForEntity( ped )
							SetBlipSprite( blip, 1 )
							Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
						else 
							veh = GetVehiclePedIsIn( ped, false )
							blipSprite = GetBlipSprite( blip )
							if not GetEntityHealth( ped ) then -- dead
								if blipSprite ~= 274 then
									SetBlipSprite( blip, 274 )
									Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) 
								end
							elseif veh then
								vehClass = GetVehicleClass( veh )
								vehModel = GetEntityModel( veh )
								if vehClass == 15 then
									if blipSprite ~= 422 then
										SetBlipSprite( blip, 422 )
										Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
									end
								elseif vehClass == 16 then -- plane
									if vehModel == GetHashKey( "besra" ) or vehModel == GetHashKey( "hydra" )
										or vehModel == GetHashKey( "lazer" ) then -- jet
										if blipSprite ~= 424 then
											SetBlipSprite( blip, 424 )
											Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
										end
									elseif blipSprite ~= 423 then
										SetBlipSprite( blip, 423 )
										Citizen.InvokeNative (0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
									end
								elseif vehClass == 14 then -- boat
									if blipSprite ~= 427 then
										SetBlipSprite( blip, 427 )
										Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
									end
								elseif vehModel == GetHashKey( "insurgent" ) or vehModel == GetHashKey( "insurgent2" ) or vehModel == GetHashKey( "limo2" ) then -- insurgent (+ turreted limo cuz limo blip wont work)
									if blipSprite ~= 426 then
										SetBlipSprite( blip, 426 )
										Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
									end
								elseif vehModel == GetHashKey( "rhino" ) then -- tank
									if blipSprite ~= 421 then
										SetBlipSprite( blip, 421 )
										Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false ) -- Player Blip indicator
									end
								elseif blipSprite ~= 1 then -- default blip
									SetBlipSprite( blip, 1 )
									Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true ) -- Player Blip indicator
								end

								passengers = GetVehicleNumberOfPassengers( veh )
								if passengers then
									if not IsVehicleSeatFree( veh, -1 ) then
										passengers = passengers + 1
									end
									ShowNumberOnBlip( blip, passengers )
								else
									HideNumberOnBlip( blip )
								end
							else
								HideNumberOnBlip( blip )
								if blipSprite ~= 1 then -- default blip
									SetBlipSprite( blip, 1 )
									Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true ) -- Player Blip indicator
								end
							end
		
							SetBlipRotation( blip, math.ceil( GetEntityHeading( veh ) ) ) 
							SetBlipNameToPlayerName( blip, id ) 
							SetBlipScale( blip,  0.85 ) 
		
							if IsPauseMenuActive() then
								SetBlipAlpha( blip, 255 )
							else
		
								x1, y1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
								x2, y2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
								distance = ( math.floor( math.abs( math.sqrt( ( x1 - x2 ) * ( x1 - x2 ) + ( y1 - y2 ) * ( y1 - y2 ) ) ) / -1 ) ) + 900
		
								if distance < 0 then
									distance = 0
								elseif distance > 255 then
									distance = 255
								end
								SetBlipAlpha( blip, distance )
							end
						end
					else
						RemoveBlip(blip)
					end
				end
			end
		end
	end
end)