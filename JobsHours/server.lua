

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","iajoburi")

RegisterServerEvent('vrp:stivuitor')
AddEventHandler('vrp:stivuitor', function()
	local user_id = vRP.getUserId({source}) 
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Curier Amazon"}) then
	vRPclient.notify(player, {"~r~Esti angajat pe stivuitor !"})
	else if ore >= 0  then
		vRP.addUserGroup({user_id,"Sofer Stivuitor"})
		--vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti angajat pe stivuitor!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~ORELE ~w~necesare"})
	   end
	end
end)

RegisterServerEvent('vrp:tirist')
AddEventHandler('vrp:tirist', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Tirist"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Tirist !"}) 
	else if ore >= 0  then
		vRP.addUserGroup({user_id,"Tirist"})
		--vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Tirist!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~ORELE ~w~necesare"})
	   end
	end
end)

RegisterServerEvent('vrp:pescar')
AddEventHandler('vrp:pescar', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Pescar"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Pescar!"})
	else if ore >= 0 then
		vRP.addUserGroup({user_id,"Pescar"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum este Pescar !"})
	else
		vRPclient.notify(player, {"Nu ai ~r~5 de ORE JUCATE~s~!"})
	   end
	end
end)



RegisterServerEvent('vrp:uber')
AddEventHandler('vrp:uber', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Uber"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Uber !"})
	else if ore >= 0  then
		vRP.addUserGroup({user_id,"Uber"})
		vRP.giveInventoryItem({user_id,"permis",1,false})
                vRP.giveInventoryItem({user_id,"autorizatie",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Uber !"})
	else
		vRPclient.notify(player, {"Verifica ~r~INFO JOB~s~!"})
	   end
	end
end)


RegisterServerEvent('vrp:mecanic')
AddEventHandler('vrp:mecanic', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Mecanic"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Mecanic !"})
	else if ore >= 0  then
		vRP.addUserGroup({user_id,"Mecanic"})
		vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Mecanic!"})
	else
		vRPclient.notify(player, {"Verifica ~r~INFO JOB ~s~!"})
	   end
	end
end)

RegisterServerEvent('vrp:pizza')
AddEventHandler('vrp:pizza', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Uber Eatz"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul Uber Eatz"})
	else if ore >= 0 then
		vRP.addUserGroup({user_id,"Uber Eatz"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti angajat la Uber Eatz!"})
	else
		vRPclient.notify(player, {"Verifica ~r~INFO JOB ~s~!"})
	   end
	end
end)

RegisterServerEvent('vrp:soferautobuz')
AddEventHandler('vrp:soferautobuz', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Sofer Autobuz"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Sofer Bancar !"})
	else if ore >= 0 then
		vRP.addUserGroup({user_id,"Sofer Autobuz"})
		 vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Sofer Autobuz!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~PERMIS ~w~de conducere"})
	   end
	end
end)

RegisterServerEvent('vrp:info')
AddEventHandler('vrp:info', function()
	local src = source
	local mesaj = [[
	]]
	TriggerClientEvent('chatMessage', src, ""..mesaj)
end)

RegisterServerEvent('vrp:demisioneaza')
AddEventHandler('vrp:demisioneaza', function()
	local user_id = vRP.getUserId({source}) 
	local player = vRP.getUserSource({user_id})
		vRP.addUserGroup({user_id,"Somer"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti un ~h~~r~Somer"})
end)





