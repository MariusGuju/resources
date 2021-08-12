

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

RegisterServerEvent('vrp:hotdecase')
AddEventHandler('vrp:hotdecsae', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Gunoier"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de hot de case !"})
	else if ore >= 25  then
		vRP.addUserGroup({user_id,"Hot de case"})
		--vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Hot de Case!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~ORELE ~w~necesare"})
	   end
	end
end)

RegisterServerEvent('vrp:constructor')
AddEventHandler('vrp:constructor', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Tirist"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Constructor!"})
	else if ore >= 15 then
		vRP.addUserGroup({user_id,"Tirist"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Constructor!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~20 de ORE JUCATE ~w~de conducere"})
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
	else if ore >= 5  then
		vRP.addUserGroup({user_id,"Tirist"})
		--vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Tirist!"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~ORELE ~w~necesare"})
	   end
	end
end)
RegisterServerEvent('vrp:taxiNorbSiMaruServer')
AddEventHandler('vrp:taxiNorbSiMaruServer', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Taxi NorbSiMaruServer"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Taxi !"})
	else if ore >= 2 then
		vRP.addUserGroup({user_id,"Taxi NorbSiMaruServer"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum este Taxi!"})
	else
		vRPclient.notify(player, {"Nu ai ~r~2 ORE JUCATE~s~!"})
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
	else if ore >= 5 then
		vRP.addUserGroup({user_id,"Pescar"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum este Pescar !"})
	else
		vRPclient.notify(player, {"Nu ai ~r~5 de ORE JUCATE~s~!"})
	   end
	end
end)

RegisterServerEvent('vrp:postas')
AddEventHandler('vrp:postas', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Postas"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Postas!"})
	else if ore >= 10 then
		vRP.addUserGroup({user_id,"Postas"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum este Postas!"})
	else
		vRPclient.notify(player, {"Nu ai ~r~10 de ORE JUCATE~s~!"})
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
	else if ore >= 50  then
		vRP.addUserGroup({user_id,"Uber"})
		vRP.giveInventoryItem({user_id,"permis",1,false})
                vRP.giveInventoryItem({user_id,"autorizatie",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum Uber !"})
	else
		vRPclient.notify(player, {"Verifica ~r~INFO JOB~s~!"})
	   end
	end
end)

RegisterServerEvent('vrp:taxi')
AddEventHandler('vrp:taxi', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
	if vRP.hasGroup({user_id,"Taxi"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de Taxi !"})
	else if ore >= 0  then
		vRP.addUserGroup({user_id,"Taxi"})
		vRP.giveInventoryItem({user_id,"permis",1,false})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum esti Taximetrist !"})
	else
		vRPclient.notify(player, {"~w~Nu ai ~r~PERMIS ~w~de conducere"})
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
	else if ore >= 2  then
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
	if vRP.hasGroup({user_id,"Pizza"}) then
	vRPclient.notify(player, {"~r~Deja ai job-ul de sofer Pizza"})
	else if ore >= 3 then
		vRP.addUserGroup({user_id,"Pizza"})
		vRPclient.notify(player, {"~r~Felicitari. ~b~Acum livrezi la Pizza!"})
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
	else if ore >= 5 then
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
		^0[^9INFO-JOB^0]
		^0[^4Taxi^0] - 2 ore
		^0[^4Pescar^0] - 0 ore
		^0[^4Hot De Case^0] - 25 or
		^0[^9Tirist^0] - 5 ore 
		^0[^9Constructor^0] - 15 ore
		^0[^9Livrator Banca Bani^0] - 15 ore
		^0[^9Autobuz^0] - 15 ore
		^0[^4Pescar^0] - 5 ore
		^0[^9Postas ^0] - 10 ore
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





