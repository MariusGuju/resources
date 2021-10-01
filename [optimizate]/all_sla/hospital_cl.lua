---------- VARIABLES ----------


local treatment = false


local timer = false


local blips = { 
  --{name="Spital", id=80, x= 340.77764892578, y= -1396.0338134766, z= 32.509231567382, color= 1},
  --{name="Spital", id=80, x= 357.51815795898, y= -593.72448730468, z= 28.788692474366, color= 1},
--{name="Spital", id=80, x= -449.04428100586, y= -340.75106811524, z= 34.501781463624, color= 1},
  --{name="Spital", id=80, x= 248.50749206542, y= 6331.3349609375, z= 32.426189422608},
}


---------- FONCTIONS ----------


function Notify(text)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(text)
  DrawNotification(false, false)
end


function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


function ConfigLang(lang)
  local lang = lang
  if lang == "FR" then
    lang_string = {
      text1 = "Apasati ~INPUT_VEH_HORN~ pentru a va vindeca ~r~(~h~~g~500$~r~)",
      text2 = "Le ~h~~g~docteur ~s~va te ~h~~r~soigner~s~, ~h~~b~soit patient~s~.",
      text3 = "Tu n'as pas besoin d'être ~h~~r~soigner~s~.",
      text4 = "Tu as été ~h~~r~soigné~s~.",
      text5 = "Tu as ~h~~r~bougé~s~, le ~h~~g~docteur~s~ n'as pas pu te ~h~~r~soigner~s~ !",
  }

  elseif lang == "EN" then
    lang_string = {
      text1 = "Apasati Tasta ~INPUT_VEH_HORN~ pentru a fi tratat ~r~(~h~~g~10000$~r~)!",
      text2 = "~h~~g~Doctorul ~s~te va trata imediat! ~h~~r~Va rugam sa aveti rabdare~s~!",
      text3 = "Nu aveti nevoie de ~h~~r~tratament~s~.",
      text4 = "Docturul ~h~~g~a avut grija de ranile dumneavoastra.",
      text5 = "~h~V-ati indepartat prea mult de Doctor!",
  }
  end
end


---------- CITIZEN ----------

Citizen.CreateThread(function()
  for _, item in pairs(blips) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipColour(item.blip, item.color)
    SetBlipAsShortRange(item.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
  end
end)


Citizen.CreateThread(function()
  while true do
    tick = 500
    for _, item in pairs(blips) do
	  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 20 then
        DrawMarker(0, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x,item.y,item.z, true) <= 2 then
          ShowInfo(lang_string.text1, 0)
          tick = 0
          if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) < 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
            Notify(lang_string.text2)
            treatment = true
          end
        end
      end
      if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
        tick = 0
        if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) == 200) then
          Notify(lang_string.text3)
        end
      end
      if treatment == true then
	    Citizen.Wait(15000)
        timer = true
	  end
      if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
        tick = 0
        TriggerServerEvent('hospital:price')
        SetEntityHealth(GetPlayerPed(-1), 200)
        Notify(lang_string.text4)
        treatment = false
        timer = false
      end
      if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) > 2) then
        tick = 0
        Notify(lang_string.text5)
        treatment = false
        timer = false            
      end
    end 
    Wait(tick)
  end       
end)

Citizen.CreateThread(function()
    
    RequestModel(GetHashKey("s_m_m_doctor_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
      Wait(1)
    end

      local hospitalped =  CreatePed(4, 0xd47303ac, 338.85, -1394.56, 31.51, 49.404, false, true)
      SetEntityHeading(hospitalped, 49.404)
      FreezeEntityPosition(hospitalped, true)
      SetEntityInvincible(hospitalped, true)
      SetBlockingOfNonTemporaryEvents(hospitalped, true)
end)


AddEventHandler("playerSpawned", function()
    local lang = "EN"
    ConfigLang(lang)
end)

---------- CREATED BY BOARO ----------


---------- RUINER ISLAND ----------
