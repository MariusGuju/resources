--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 09/05/2017
-- Time: 09:55
-- To change this template use File | Settings | File Templates.
--




local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Meniu masina",
    menu_subtitle = "Categorii",
    color_r = 100,
    color_g = 0,
    color_b = 255,
}


------------------------------------------------------------------------------------------------------------------------

-- Base du menu
function PersonnalMenu()
    options.menu_subtitle = "Categorii"  
    ClearMenu()
    Menu.addButton("Motor", "moteur", nil)
    Menu.addButton("Usi", "portieres", nil)
    Menu.addButton("Limitator de viteza", "speedo", nil)    
    Menu.addButton("Geamuri", "geamuri", nil)   
    Menu.addButton("Neoane", "neoane", nil)   
	 Menu.addButton("Inchide", "CloseMenu", nil)
end

function geamuri()
   options.menu_subtitle = "Geamuri"  
   ClearMenu()
   Menu.addButton("Fata stanga", "fstanga", nil)
   Menu.addButton("Fata dreapta", "fdreapta", nil)
    Menu.addButton("Inapoi", "PersonnalMenu", nil)
end

function neoane()
   options.menu_subtitle = "Neoane"  
   ClearMenu()
   Menu.addButton("Opreste neoanele", "neoaneoff", nil)
   Menu.addButton("Porneste neoanele", "neoaneon", nil)
    Menu.addButton("Inapoi", "PersonnalMenu", nil)
end

function moteur()
    options.menu_subtitle = "Categorii"  
    ClearMenu()
    Menu.addButton("Porneste", "moteurOn", nil)
    Menu.addButton("Opreste", "moteurOff", nil)
	  Menu.addButton("Inapoi", "PersonnalMenu", nil)
end

function portieres()
    options.menu_subtitle = "Categorii"  
    ClearMenu()
    Menu.addButton("Toate usile", "all", nil)
    Menu.addButton("Capota", "capot", nil)
    Menu.addButton("Portbagaj", "coffre", nil)
    Menu.addButton("Usile din fata", "avant", nil)    
    Menu.addButton("Usile din spate", "arriere", nil)
	  Menu.addButton("Inapoi", "PersonnalMenu", nil)
end

function avant()
    options.menu_subtitle = "Usi"  
    ClearMenu()
    Menu.addButton("Usa stanga", "avantgauche", nil)
    Menu.addButton("Usa dreapta", "avantdroite", nil)
	  Menu.addButton("Inapoi", "portieres", nil)
end

function arriere()
    options.menu_subtitle = "Usi"  
    ClearMenu()
    Menu.addButton("Spate stanga", "arrieregauche", nil)
    Menu.addButton("Spate dreapta", "arrieredroite", nil)
	  Menu.addButton("Back", "portieres", nil)
end

function speedo()
    options.menu_subtitle = "Limitator"
    ClearMenu()
    Menu.addButton("Dezactiveaza", "limiter", 0)
    Menu.addButton("30 ~g~Kp/h", "limiter", "30.0")
    Menu.addButton("50 ~g~Kp/h", "limiter", "50.0")
    Menu.addButton("70 ~g~Kp/h", "limiter", "70.0")
    Menu.addButton("90 ~g~Kp/h", "limiter", "90.0")
    Menu.addButton("110 ~g~Kp/h", "limiter", "110.0")
    Menu.addButton("130 ~g~Kp/h", "limiter", "130.0")
    Menu.addButton("Inapoi", "PersonnalMenu", nil)
end

function CloseMenu()
    Menu.hidden = not Menu.hidden
end

------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
function drawTxt(options)
    SetTextFont(options.font)
    SetTextProportional(0)
    SetTextScale(options.scale, options.scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(0)
    SetTextEntry('STRING')
    AddTextComponentString(options.text)
    DrawRect(options.xBox,options.y,options.width,options.height,0,0,0,150)
    DrawText(options.x - options.width/2 + 0.005, options.y - options.height/2 + 0.0028)
end
function DisplayHelpText(str)
    SetTextComponentFormat('STRING')
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

--------------------------------------------------- NUI CALLBACKS ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function limiter(vit)
    speed = vit/3.6
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
   
    local vehicleModel = GetEntityModel(vehicle)
    local float Max = GetVehicleMaxSpeed(vehicleModel)
   
    if (vit == 0) then
    SetEntityMaxSpeed(vehicle, Max)
    exports.pNotify:SendNotification({text = "Limitator dezactivat", type = "error", layout = "bottomRight", timeout = math.random(4000, 8000)})
    else
    SetEntityMaxSpeed(vehicle, speed)
    exports.pNotify:SendNotification({text = "Limitator activat", type = "success", layout = "bottomRight", timeout = math.random(4000, 8000)})
    PersonnalMenu()
    end
end

function all()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)        
         SetVehicleDoorShut(playerVeh, 4, false)
         SetVehicleDoorShut(playerVeh, 3, false)
         SetVehicleDoorShut(playerVeh, 2, false)
         SetVehicleDoorShut(playerVeh, 1, false)
         SetVehicleDoorShut(playerVeh, 0, false)         
       else
         SetVehicleDoorOpen(playerVeh, 5, false)        
         SetVehicleDoorOpen(playerVeh, 4, false)
         SetVehicleDoorOpen(playerVeh, 3, false)
         SetVehicleDoorOpen(playerVeh, 2, false)
         SetVehicleDoorOpen(playerVeh, 1, false)
         SetVehicleDoorOpen(playerVeh, 0, false)  
         frontleft = true        
      end
   end
end

function capot()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 4, false)
       else
         SetVehicleDoorOpen(playerVeh, 4, false)
         frontleft = true        
      end
   end
end

function coffre()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)
       else
         SetVehicleDoorOpen(playerVeh, 5, false)
         frontleft = true        
      end
   end
end

function avantgauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 0, false)
       else
         SetVehicleDoorOpen(playerVeh, 0, false)
         frontleft = true        
      end
   end
end

function avantdroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 1, false)
       else
         SetVehicleDoorOpen(playerVeh, 1, false)
         frontleft = true        
      end
   end
end

function arrieredroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 3, false)
       else
         SetVehicleDoorOpen(playerVeh, 3, false)
         frontleft = true        
      end
   end
end

function arrieregauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 2, false)
       else
         SetVehicleDoorOpen(playerVeh, 2, false)
         frontleft = true        
      end
   end
end

function moteurOn()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
   SendNotification("~s~~h~Motor ~g~pornit")
end

function moteurOff()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
   SendNotification("~s~~h~Motor ~r~oprit")
end

local sgeam = false
local dgeam = false

function fstanga()
   local playerPed = GetPlayerPed(-1)
   sgeam = not sgeam
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if sgeam then
      RollDownWindow(playerVeh,0)
      SendNotification("~s~~h~Geam ~g~stanga ~w~deschis")
   else
      RollUpWindow(playerVeh,0)
      SendNotification("~s~~h~Geam ~g~stanga ~w~inchis")
   end
end

function neoaneoff()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleNeonLightEnabled(playerVeh,0,false)
   SetVehicleNeonLightEnabled(playerVeh,1,false)
   SetVehicleNeonLightEnabled(playerVeh,2,false)
   SetVehicleNeonLightEnabled(playerVeh,3,false)
end

function neoaneon()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleNeonLightEnabled(playerVeh,0,true)
   SetVehicleNeonLightEnabled(playerVeh,1,true)
   SetVehicleNeonLightEnabled(playerVeh,2,true)
   SetVehicleNeonLightEnabled(playerVeh,3,true)
end

function fdreapta()
   local playerPed = GetPlayerPed(-1)
   dgeam = not dgeam
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if dgeam then
      RollDownWindow(playerVeh,1)
      SendNotification("~s~~h~Geam ~g~stanga ~w~deschis")
   else
      RollUpWindow(playerVeh,1)
      SendNotification("~s~~h~Geam ~g~stanga ~w~inchis")
   end
end

function SendNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

------------------------------------------------------------------------------------------------------------------------
function drawMenuRight(txt,x,y,selected)
  local menu = personnelmenu.menu
  SetTextFont(menu.font)
  SetTextProportional(0)
  SetTextScale(menu.scale, menu.scale)
  SetTextRightJustify(1)
  if selected then
    SetTextColour(0, 0, 0, 255)
  else
    SetTextColour(255, 255, 255, 255)
  end
  SetTextCentre(0)
  SetTextEntry("STRING")
  AddTextComponentString(txt)
  DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028) 
end

--------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        tick = 500
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
         tick = 0
        if IsControlJustPressed(1, 244) then
            PersonnalMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
        if IsEntityDead(PlayerPedId()) then
            PlayerIsDead()
            -- prevent the death check from overloading the server
            playerdead = true
			else
			end
        end
        Wait(tick)
    end
end)

local working
------------------------------------------------------------------------------------------------------------------------
