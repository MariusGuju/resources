local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "doors")
local cfg = module("SLASHERCore", "config")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    TriggerClientEvent('vrpdoorsystem:load', source, cfg.list)
  end
end)

Citizen.CreateThread(function()
  Citizen.Wait(500)
  TriggerClientEvent('vrpdoorsystem:load', -1, cfg.list)
end)

RegisterServerEvent('vrpdoorsystem:open')
AddEventHandler('vrpdoorsystem:open', function(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.hasPermission({user_id,cfg.list[id].permission}) or vRP.hasGroup({user_id,"dev"}) then
    vRPclient.playAnim(player, {false,{{"misscommon@locked_door", "lockeddoor_tryopen", 1}},false})
    SetTimeout(4000, function()
      cfg.list[id].locked = not cfg.list[id].locked
      TriggerClientEvent('vrpdoorsystem:statusSend', (-1), id,cfg.list[id].locked)
      if cfg.list[id].pair ~= nil then
        local idsecond = cfg.list[id].pair
        cfg.list[idsecond].locked = cfg.list[id].locked
        TriggerClientEvent('vrpdoorsystem:statusSend', (-1), idsecond,cfg.list[id].locked)
      end
      if cfg.list[id].locked then
        vRPclient.notify(player, {"[~b~Sistem Usi~w~] Ai inchis usa! Locatie:"..cfg.list[id].name})
      else
        vRPclient.notify(player, {"[~b~Sistem Usi~w~] Ai deschis usa! Locatie:"..cfg.list[id].name})
      end
    end)
  else
    vRPclient.notify(player, {"[~b~Sistem Usi~w~] Nu ai cheie pentru aceasta usa! Ai nevoie de:"..cfg.list[id].name})
  end
end)