local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPhk = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_keys")
HKclient = Tunnel.getInterface("vrp_keys","vrp_keys")
Tunnel.bindInterface("vrp_keys",vRPhk)

emsServices = {"emergency"}

function vRPhk.test(msg)
  print("msg "..msg.." received from "..source)
  return 42
end

function vRPhk.docsOnline()
  local docs = vRP.getUsersByPermission({"emscheck.revive"})
  return #docs
end


--edit by fenton
function vRPhk.canSkipComa()
  local user_id = vRP.getUserId({source})
  return vRP.hasPermission({user_id,"player.skip_coma"})
end

function vRPhk.helpComa(x,y,z)
  for k,v in pairs(emsServices) do
  vRP.sendServiceAlert({source,v,x,y,z,"Ajutor, am nevoie de ajutor"}) -- people will change this message anyway haha
  end
end

