
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_marfa")
local hangar1ID = nil
local hangar2ID = nil
local gotowka = {a = 100000, b = 150000} -- zakres od ile do ile wynosi gotowka za wykonanie misji
-----------------------------------
local MisjaAktywna = 0
AddEventHandler('playerDropped', function(DropReason)

	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
	
end)

RegisterServerEvent('tostdostawa:przejmijHangar')
AddEventHandler('tostdostawa:przejmijHangar', function(ktory)

if ktory == '1' then
	if hangar1ID == nil then
		hangar1ID = source
		vRPclient.notify(source,{"~g~Ai preluat hangarul"})
		vRPclient.notify(source,{"~g~Acum doar tu poti efectua comenzi aici."})
		TriggerClientEvent("tostdostawa:maszHangar", source)
	else
		vRPclient.notify(source,{'~y~Acest hangar este deja luat de ID ~r~'..hangar1ID})
	end
elseif ktory == '2' then
	if hangar2ID == nil then
		hangar2ID = source
				vRPclient.notify(source,{"~g~Ai preluat hangarul"})
		vRPclient.notify(source,{"~g~Acum doar tu poti efectua comenzi aici."})
		TriggerClientEvent("tostdostawa:maszHangar", source)
	else
		vRPclient.notify(source,{'~y~Acest hangar este deja luat de ID ~r~'..hangar2ID})
	end
end

end)



RegisterServerEvent('tostdostawa:wykonanieMisji')
AddEventHandler('tostdostawa:wykonanieMisji', function(premia)
local xPlayer = vRP.getUserId({source})
local player = vRP.getUserSource({xPlayer})
local LosujSiano = math.random(gotowka.a,gotowka.b)

if premia == 'nie' then
	vRP.giveMoney({xPlayer,LosujSiano})
	vRPclient.notify(player,{'~g~Ai primit +1 EXP Point pentru livrare'})
	vRPclient.notify(player,{'~g~Ai primit $'..LosujSiano..' pentru livrare'})
	updateGoalContributie = LosujSiano / 2
	exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal where id = @user_id", {['user_id'] = xPlayer,['@updategoal'] = updateGoalContributie }, function (rows) end)
	exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = LosujSiano}, function (rows) end)
	exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
		['@id'] = xPlayer
	}, function (rows)
	end)
Wait(2500)
else
	vRP.giveMoney({xPlayer,premia})
	Wait(150000)
end

end)

RegisterServerEvent('tostdostawa:OdszedlDalekoo')
AddEventHandler('tostdostawa:OdszedlDalekoo', function()

	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
	
end)


