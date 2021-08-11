--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_drugfarms")

RegisterServerEvent('probar:permisos')
AddEventHandler('probar:permisos', function(loadWeed)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
		if vRP.hasGroup({user_id,"Drug Dealer"}) then
		  TriggerClientEvent('tiene:permisos', player)
		else
		  TriggerClientEvent('notiene:permisos', player)
	end
end)

RegisterServerEvent('blanqueo:permisos')
AddEventHandler('blanqueo:permisos', function(loadWeed)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
		if vRP.hasGroup({user_id,"spalatordebani"}) then
		  TriggerClientEvent('blanqueo:permisos', player)
		else
			vRPclient.notify(player,{"~r~Nu esti spalator de bani ca sa intrii aici!"})
	end
end)

RegisterServerEvent('meta:permisos')
AddEventHandler('meta:permisos', function(loadWeed)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
		if vRP.hasGroup({user_id,"Dealer de LSD"}) then
		  TriggerClientEvent('meta:permisos', player)
		else
			vRPclient.notify(player,{"~r~Nu esti Dealer de LSD ca sa intrii aici!"})
	end
end)

RegisterServerEvent('coke:permisos')
AddEventHandler('coke:permisos', function(loadWeed)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
		if vRP.hasGroup({user_id,"Dealer de Cocaina"}) then
		  TriggerClientEvent('coke:permisos', player)
		else
			vRPclient.notify(player,{"~r~Nu esti Dealer de Cocaina ca sa intrii aici!"})
	end
end)

RegisterServerEvent('motero:permisos')
AddEventHandler('motero:permisos', function(loadWeed)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
		if vRP.hasGroup({user_id,"Drug Dealer"}) then
		  TriggerClientEvent('motero:permisos', player)
		else
			vRPclient.notify(player,{"~r~Nu esti Drug Dealer ca sa intrii aici!"})
	end
end)