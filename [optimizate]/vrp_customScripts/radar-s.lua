local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_radare")

RegisterServerEvent('VeziDacaAreUrgenta')
AddEventHandler('VeziDacaAreUrgenta', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local multa = 300
	if vRP.hasPermission({user_id,"bypass.radar"}) then
        vRPclient._notify(player,{"Faci parte din Serviciul de Urgente! Condu cu grija"})    		
	else
	vRP.tryFullPayment({user_id,multa})
end
end)