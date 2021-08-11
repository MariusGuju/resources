local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","afk-sleep")

RegisterServerEvent("KickDacaNuDoarme")
AddEventHandler("KickDacaNuDoarme", function()
    DropPlayer(source, "Ai stat AFK prea mult timp fara sa dormi.")
    --print('AI LUAT KICK MA')
end)

RegisterCommand("sleep",function(source)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		if not sleep then
			sleep = true
			--print("esti pe sleep")
			TriggerClientEvent('sv_primire',player,true)
			TriggerClientEvent('chatMessage',source,"Tocmai ai intrat in modul sleep")
		elseif sleep then
			sleep = false
			--print("nu mai esti pe sleep")
			TriggerClientEvent('sv_primire',player,false)
			TriggerClientEvent('chatMessage',source,"Nu mai esti pe sleep si vei lua kick in cateva secunde !")
		end
	elseif vRP.hasPermission({user_id, "acces.sleep"}) then
		if not sleep then
			sleep = true
			--print("esti pe sleep")
			TriggerClientEvent('sv_primire',player,true)
			TriggerClientEvent('chatMessage',source,"Tocmai ai intrat in modul sleep")
		elseif sleep then
			sleep = false
			--print("nu mai esti pe sleep")
			TriggerClientEvent('sv_primire',player,false)
			TriggerClientEvent('chatMessage',source,"Nu mai esti pe sleep si vei lua kick in cateva secunde !")
		end
	else
		vRPclient.notify(player,{"Nu ai acces la aceasta comanda!"})
		print('Jucatorul cu ID:'..user_id..' a actionat comanda /sleep si nu are acces.')
	end
end)
