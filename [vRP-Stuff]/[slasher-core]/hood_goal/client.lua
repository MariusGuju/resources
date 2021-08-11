vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","esk_jobgl")
vRPjobgoal = Tunnel.getInterface("esk_jobgl","esk_jobgl")
vRPjobgoalC = {}
Tunnel.bindInterface("esk_jobgl",vRPjobgoalC)
vRPserver = Tunnel.getInterface("esk_jobgl","esk_jobgl")

infoGoal = {}
infobani = nil
local maxGoal = 75000

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(120000) -- 2 miunt
    TriggerServerEvent("getGoal",maxGoal)
  end
end)


function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function vRPjobgoalC.spawnJobGoal(goal,contributie)
  valoare = comma_value(goal)
  contributiamea = comma_value(contributie)
  SendNUIMessage({pmoney = "$"..valoare.." / $"..comma_value(maxGoal)})
  SendNUIMessage({contributiamea = "$"..contributiamea})
end

