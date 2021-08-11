local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_rcCar")


local Bet = Config.AllowedBets[1]
local Fighters = {
	[1] = false,
	[2] = false,
}

RegisterServerEvent("esx_fighting:SendResult")
AddEventHandler("esx_fighting:SendResult", function (pos)
	TriggerClientEvent("esx_fighting:EditPos", -1, 1, false)
	TriggerClientEvent("esx_fighting:EditPos", -1, 2, false)

	if Fighters[1] == source then
		local user_id = vRP.getUserId({Fighters[2]})
		vRP.giveMoney({user_id,Bet*2})
		--local xPlayer = ESX.GetPlayerFromId(Fighters[2])
		--xPlayer.addMoney(Bet*2)
		TriggerClientEvent("esx_fighting:Result", Fighters[1], false)
		TriggerClientEvent("esx_fighting:Result", Fighters[2], true)
	else
		local user_id = vRP.getUserId({Fighters[1]})
		vRP.giveMoney({user_id,Bet*2})
		--local xPlayer = ESX.GetPlayerFromId(Fighters[1])
		--xPlayer.addMoney(Bet*2)
		TriggerClientEvent("esx_fighting:Result", Fighters[2], false)
		TriggerClientEvent("esx_fighting:Result", Fighters[1], true)
	end
	Fighters[1] = false
	Fighters[2] = false
end)

vrpPV.RegisterServerCallback('esx_fighting:EditBet', function(source, cb, prize)
	if Fighter1 or Fighter2 then
		cb(false)
	else
		Bet = prize
		TriggerClientEvent("esx_fighting:BetEdited", -1, Bet)
		cb(true)
	end
end)


vrpPV.RegisterServerCallback('esx_fighting:JoinFight', function(source, cb, pos)
	local user_id = vRP.getUserId({source})

	if vRP.getMoney({user_id}) > Bet and not Fighters[pos] then
		vRP.tryPayment({user_id,Bet})
		Fighters[pos] = source
		TriggerClientEvent("esx_fighting:EditPos", -1, pos, true)
		if Fighters[1] and Fighters[2] ~= false then
			TriggerClientEvent("esx_fighting:StartFight", Fighters[1])
			TriggerClientEvent("esx_fighting:StartFight", Fighters[2])
			cb(true)
		end
	--	cb(true)
	else
		cb(false)
	end
end)

vrpPV.RegisterServerCallback('esx_fighting:LeaveFight', function(source, cb, pos)
--	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = vRP.getUserId({source})

	if Fighters[pos] == source then
		vRP.giveMoney({user_id,Bet})
		--xPlayer.addMoney(Bet)
		Fighters[pos] = false
		-- aB3YbXE
		TriggerClientEvent("esx_fighting:EditPos", -1, pos, false)
		cb(true)
	else
		cb(false)
	end
end)