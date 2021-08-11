local testMode = true -- enables/disables car spawn command

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","taxihud")
isTransfer = false

local taxiMeter = {}

-- HELPER FUNCTIONS
function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function splitString(str, sep)
  if sep == nil then sep = "%s" end

  local t={}
  local i=1

  for str in string.gmatch(str, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end

--if testMode then
  AddEventHandler('chatMessage', function(source, n, message)
    local args = stringsplit(message, " ")
    if (args[1] == "/spawn") then
      CancelEvent()
      if (args[2] ~= nil) then
        local user_id = vRP.getUserId({source})
        if vRP.hasGroup({user_id,"dev"}) then
            local playerID = tonumber(source)
            local vehicleName = tostring(args[2])
            TriggerClientEvent('VehicleSpawn', playerID, vehicleName)
        end
      end
    end
  end)
--end
AddEventHandler('chatMessage', function(from,name,message)
  if(string.sub(message,1,1) == "/") then

    local args = splitString(message)
    local cmd = args[1]

    if(cmd == "/taxi")then
      CancelEvent()

      local subCmd = string.lower(tostring(args[2]))
      if(subCmd == nil)then
        TriggerClientEvent('chatMessage', from, "Taximetru -- Setari", {200,0,0} , "Foloseste: /taxi ajutor")
        return
      end
      if subCmd == "ajutor" then
        TriggerClientEvent('chatMessage', from, "Taximetru -- Ajutor", {200,0,0} , "Actiuni posibile: initial, km, minute, arata. Pretul initial este (default: 10lei). Pretul pe KM stationat (default: 20lei). Pretul km pe ora (default: 100). Arata setarile actuale.")
        return
      end
      if subCmd == "arata" then
        TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, nil)
        return
      end
      if args[3] ~= nil then
        value = parseDouble(args[3])
        if subCmd == "initial" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
        if subCmd == "km" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
        if subCmd == "minute" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
      else
        TriggerClientEvent('chatMessage', from, "Taximetru -- Setari", {200,0,0} , "Foloseste: /taxi ajutor")
        return
      end
    elseif cmd == "/angajattaxi" then
      TriggerClientEvent('taxi:toggleHire',from)
    elseif cmd == "/taximetrureset" then
      TriggerClientEvent('taxi:resetMeter',from)
    elseif cmd == "/aratataximetru" then
      TriggerClientEvent('taxi:toggleDisplay',from)
    end
  end
end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str i = i + 1
  end
  return t
end
