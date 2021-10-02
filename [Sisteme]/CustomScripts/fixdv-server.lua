local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fixcar")

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/dv" or msg == "/de" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
		CancelEvent();
		TriggerClientEvent('wk:deleteVehicle', source);
	end
end)

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/fix" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
	  if vRP.hasPermission({user_id,"player.spectate"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	  end
	end
end)