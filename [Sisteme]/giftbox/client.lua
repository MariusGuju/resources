local displayGiftBlips = true -- Toggles Bank Blips on the map (Default: true)
local enableGui = true -- Enables the banking GUI (Default: true) // MAY HAVE SOME ISSUES

-- giftpos
local giftpos = {
  ["giftpos"] = {
    position = { ['x'] =-1700.6760253906, ['y'] =-1091.7877197266, ['z'] =13.152297019958 },
  },
}

-- rainbow effect
local function curcubeu( frequency )
  local result = {}
  local curtime = GetGameTimer() / 4000

  result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
  result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
  result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
  
  return result
end

-- Display Map Blips
Citizen.CreateThread(function()
  if displayGiftBlips then
    for k,v in pairs(giftpos) do
      local vgiftbox = v.position

      local blip = AddBlipForCoord(vgiftbox.x, vgiftbox.y, vgiftbox.z)
      SetBlipSprite(blip, 181)
      SetBlipColour(blip, 1)
      SetBlipScale(blip, 0.8)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("GiftBox")
      EndTextCommandSetBlipName(blip)
    end
  end
end)

-- NUI Variables
local atPos = false
local giftOpen = false

-- Open Gui and Focus NUI
function openGui()
  SetNuiFocus(true, true)
  SendNUIMessage({openNUI = true})
end

-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openNUI = false})
  giftOpen = false
end

-- If GUI setting turned on, listen for INPUT_PICKUP keypress
if enableGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(2)
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
          local rainbow = curcubeu (1)
      for k,v in pairs(giftpos)do
        local pos2 = v.position
        if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
          giftbox1(v.position.x, v.position.y, v.position.z + taginaltime, "GIFTBOX")
          giftbox1(v.position.x, v.position.y, v.position.z + taginaltime2, "~w~Puteti sa castigati: ~y~ Masini~w~/~p~Pachete VIP~w~!")
          giftbox1(v.position.x, v.position.y, v.position.z + taginaltime3, "MULT NOROC")

            DrawMarker(22, v.position.x, v.position.y, v.position.z , 0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001,rainbow.r, rainbow.g, rainbow.b, 150, 1, 1, 0, 1, 0, 0, 0)
            DrawMarker(6, v.position.x, v.position.y, v.position.z , 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001,rainbow.r, rainbow.g, rainbow.b, 150, 1, 1, 0, 1, 0, 0, 0)

              if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
                callGift(51)
                giftbox_text("Apasa ~INPUT_CONTEXT~ Pentru a deschide cadourile")
             end
        end
      end
    end
  end)
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if giftOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- Check if player is near an atm
-- Check if player is in a vehicle
function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is near a bank
function IsNearGift()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(giftpos) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 3) then
      return true
    end
  end
end

function callGift(button)
	    if IsControlJustPressed(1, button) then
	        if (IsInVehicle()) then
	            TriggerEvent('inmasina')
	        else
	          if giftOpen then
	            closeGui()
	            giftOpen = false
	          else
	            openGui()
	            giftOpen = true
	          end
	        end
	    end
end

taginaltime = 1.0
taginaltime2 = 0.86
taginaltime3 = 0.72

function giftbox1(x,y,z, text) 
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
    local rainbow = curcubeu( 1 )
    SetTextColour( rainbow.r, rainbow.g, rainbow.b, 255 )
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


function giftbox_text(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('mesajgiftprimit')
AddEventHandler('mesajgiftprimit', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("test")
    SetNotificationMessage("CHAR_BUGSTARS", "CHAR_BUGSTARS", true, 1, "GIFTBOX")
    DrawNotification(false, true)
end)

RegisterNetEvent('nuaipuncte')
AddEventHandler('nuaipuncte', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Imi pare rau, nu ai destule puncte de gift, ai nevoie de 10!")
    SetNotificationMessage("CHAR_BUGSTARS", "CHAR_BUGSTARS", true, 1, "GIFTBOX")
    DrawNotification(false, true)
end)

RegisterNetEvent('inmasina')
AddEventHandler('inmasina', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Nu poti deschide giftbox-ul in masina!")
    SetNotificationMessage("CHAR_BUGSTARS", "CHAR_BUGSTARS", true, 1, "GIFTBOX")
    DrawNotification(false, true)
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('chance', function(data, cb)
  TriggerServerEvent('verificagift')
  closeGui()
  cb('ok')
end)