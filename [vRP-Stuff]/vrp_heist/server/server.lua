

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_heist")
vRPCfishing = Tunnel.getInterface("vrp_heist","vrp_heist")
vRPgold = {}
Tunnel.bindInterface("vrp_heist",vRPgold)
Proxy.addInterface("vrp_heist",vRPgold)

vRPlevel = Proxy.getInterface("vrp_level")

local SmelteryTimer = {}
local ExchangeTimer = {}
local GoldJobTimer = {}

local NPC = 0

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		NPC = math.random(1,#Config.MissionNPC)
		TriggerClientEvent("esx_goldCurrency:spawnNPC",-1,Config.MissionNPC[NPC])
		Citizen.Wait(7200000*2)
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	TriggerClientEvent("esx_goldCurrency:spawnNPC",playerId,Config.MissionNPC[NPC])
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:MeltingCooldown")
AddEventHandler("esx_goldCurrency:MeltingCooldown",function(source)
	table.insert(SmelteryTimer,{MeltingTimer = GetPlayerIdentifier(source), time = ((Config.SmelteryTime * 1000))})
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:ExhangeCooldown")
AddEventHandler("esx_goldCurrency:ExhangeCooldown",function(source)
	table.insert(ExchangeTimer,{ExchangeTimer = GetPlayerIdentifier(source), timeExchange = ((Config.ExchangeCooldown * 60000))})
end)

RegisterServerEvent("Double:AreLevel")
AddEventHandler("Double:AreLevel",function()
	--player = source
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({user_id})
	if ore > 15 then
		TriggerClientEvent("Double:Npc",source)
	else
		vRPclient.notify(player,{"~r~Nu ai destule ore \n~w~Necesar: ~g~ 15 "})
	end
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:GoldJobCooldown")
AddEventHandler("esx_goldCurrency:GoldJobCooldown",function(source)
	table.insert(GoldJobTimer,{GoldJobTimer = GetPlayerIdentifier(source), timeGoldJob = (2 * 60000)}) -- cooldown timer for doing missions
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(SmelteryTimer) do
			if v.time <= 0 then
				RemoveSmelteryTimer(v.MeltingTimer)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(ExchangeTimer) do
			if v.timeExchange <= 0 then
				RemoveExchangeTimer(v.ExchangeTimer)
			else
				v.timeExchange = v.timeExchange - 1000
			end
		end
		for k,v in pairs(GoldJobTimer) do
			if v.timeGoldJob <= 0 then
				RemoveGoldJobTimer(v.GoldJobTimer)
			else
				v.timeGoldJob = v.timeGoldJob - 1000
			end
		end
	end
end)

-- server side function to get cooldown timer
vrpGold.RegisterServerCallback("esx_goldCurrency:getGoldJobCoolDown",function(source,cb)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	--if not CheckGoldJobTimer(GetPlayerIdentifier(player)) then
		cb(false)
	--else
	--	vRPclient.notify(player,{"Another ~y~job~s~ is ~g~available~s~ for you in: ~b~%s~s~ minutes",GetGoldJobTimer(GetPlayerIdentifier(source))})
	--	cb(true)
	--end
end)

-- server side function to get payment
RegisterServerEvent('esx_goldCurrency:missionAccepted')
AddEventHandler('esx_goldCurrency:missionAccepted', function()
	TriggerClientEvent("esx_goldCurrency:startMission",source,0)
end)

vrpGold.RegisterServerCallback("esx_goldCurrency:getPayment",function(source,cb)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local data = vRP.getUserDataTable({user_id})
	local moneyCash = vRP.getMoney({user_id})

	if vRP.tryPayment({user_id,Config.MissionCost}) then
		TriggerEvent("esx_goldCurrency:GoldJobCooldown",player)
		cb(true)
	else
		vRPclient.notify(player,{"NU ai  ~b~destui~s~ ~g~Bani~s~ pentru a platii ~r~taxele~s~ pentru acest ~y~Job~s~"})
		cb(false)
	end
end)

-- server side function to accept the mission
vrpGold.RegisterServerCallback("esx_goldCurrency:getMissionavailability",function(source,cb)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local data = vRP.getUserDataTable({user_id})
	local Players = vRP.getUsers()
	local policeOnline = 0
	for i = 1, #Players do
		local xPlayer = vRP.getUserId({Players[i]})
		if vRP.hasGroup({xPlayer,Config.PoliceDatabaseName}) then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPoliceOnline then
		cb(true)
	else
		cb(false)
		vRPclient.notify(player,{"NU sunt  ~r~not~s~ destui  ~b~Politisti~s~ in  ~y~Oras~s~"})
	end
end)

-- mission reward
RegisterServerEvent('esx_goldCurrency:reward')
AddEventHandler('esx_goldCurrency:reward', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local SecondItem = false
	
	-- item 1
	local itemAmount1 = ((math.random(Config.ItemMinAmount1,Config.ItemMaxAmount1)) * 100)
	local item1 = Config.ItemName1
	
	-- item 2
	local itemAmount2 = math.random(Config.ItemMinAmount2,Config.ItemMaxAmount2)
	local item2 = Config.ItemName2
	
	local chance = math.random(1,Config.RandomChance)
	if chance == 1 then
		SecondItem = true	
	end
	money = math.random(50000,100000)
	money1 = math.random(100000,400000)
	if Config.EnableSecondItemReward == true and SecondItem == true then
		--vRP.giveInventoryItem({user_id,Config.ItemName1,itemAmount1,true})
		--vRP.giveInventoryItem({user_id,Config.ItemName2,itemAmount2,true})
		-- */ To do: Sa iti dea bani in loc de gold
		if Config.EnableCustomNotification == true then
			TriggerClientEvent("esx_goldCurrency:missionComplete", player,money,money1)
		else
			vRPclient.notify(player,{"Mission Complete: Ai primit ~g~"..vRP.formatMoney({money}).."x~s~ ~y~"..vRP.formatMoney({money1})})
		end
	else
		--vRP.giveInventoryItem({user_id,Config.ItemName1,itemAmount1,true})
		if Config.EnableCustomNotification == true then
			TriggerClientEvent("esx_goldCurrency:missionComplete", player,money,money1)
		else
			vRPclient.notify(player,{"~g~Mission Complete:~s~ Ai primit ~g~"..vRP.formatMoney({money}).."x~s~ ~y~"..vRP.formatMoney({money1})})
		end
	end
	
end)

RegisterServerEvent('esx_goldCurrency:GoldJobInProgress')
AddEventHandler('esx_goldCurrency:GoldJobInProgress', function(targetCoords, streetName)
	TriggerClientEvent('esx_goldCurrency:outlawNotify', -1,string.format("^3 Gloante Trase ^0  ^5%s^0 ,este un jaf auto",streetName))
	TriggerClientEvent('esx_goldCurrency:GoldJobInProgress', -1, targetCoords)
end)

-- sync mission data
RegisterServerEvent("esx_goldCurrency:syncMissionData")
AddEventHandler("esx_goldCurrency:syncMissionData",function(data)
	TriggerClientEvent("esx_goldCurrency:syncMissionData",-1,data)
end)

-- server side function for converting part
RegisterServerEvent('esx_goldCurrency:goldMelting')
AddEventHandler('esx_goldCurrency:goldMelting', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local data = vRP.getUserDataTable({user_id})

	if data.inventory['goldwatch'] == nil then return vRPclient.notify(player,{"Nu ai goldwatch"}) end
	if data.inventory['goldbar'] == nil then return vRPclient.notify(player,{"Nu ai goldbar"}) end

	if data.inventory['goldwatch'].amount >= 100 then
		if data.inventory['goldbar'].amount <= 99 then
			if not CheckIfMelting(GetPlayerIdentifier(player)) then
				TriggerEvent("esx_goldCurrency:MeltingCooldown",player)
						
				vRP.tryGetInventoryItem({user_id,'goldwatch',100,true})
			
				TriggerClientEvent("GoldWatchToGoldBar",player)
				Citizen.Wait((Config.SmelteryTime * 1000))
			
				vRP.giveInventoryItem({user_id,"goldbar",1,true})
			else
				vRPclient.notify(player,{string.format("You are ~b~already engaged~s~ in a ~y~process~s~!",GetTimeForMelting(GetPlayerIdentifier(source)))})
			end
		else
			vRPclient.notify(player,{"You ~r~do not have~s~ enough ~b~empty space~s~ for more ~y~Gold Bars~s~"})
		end
	else
		vRPclient.notify(player,{"You need ~r~at least~s~ 100x ~y~Gold Watches~s~"})
	end
end)

-- server side function for exchange part
RegisterServerEvent('esx_goldCurrency:goldExchange')
AddEventHandler('esx_goldCurrency:goldExchange', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local data = vRP.getUserDataTable({user_id})

	if not CheckIfExchanging(GetPlayerIdentifier(source)) then
		if  data.inventory['goldbar']~= nil and data.inventory['goldbar'].amount >= 50 then
			TriggerEvent("esx_goldCurrency:ExhangeCooldown",player)
						
			vRP.tryGetInventoryItem({user_id,'goldbar',70,true})
			
			TriggerClientEvent("GoldBarToCash",player)
			Citizen.Wait((Config.ExchangeTime * 1000))
			
			vRP.giveMoney({user_id,150000})
		else
			vRPclient.notify(player,{"You need ~r~at least~s~ 70x ~y~Gold Bars~s~"})
		end
	else
		vRPclient.notify(player,{string.format("You can ~y~exchange gold~s~ again in: ~b~%s minutes~s~",GetTimeForExchange(GetPlayerIdentifier(source)))})
	end




end)

function RemoveSmelteryTimer(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			table.remove(SmelteryTimer,k)
		end
	end
end
function GetTimeForMelting(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return math.ceil(v.time/1000)
		end
	end
end
function CheckIfMelting(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return true
		end
	end
	return false
end
-- Functions for Exchange Timer:
function RemoveExchangeTimer(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			table.remove(ExchangeTimer,k)
		end
	end
end
function GetTimeForExchange(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return math.ceil(v.timeExchange/60000)
		end
	end
end
function CheckIfExchanging(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return true
		end
	end
	return false
end
-- Functions for Mission Timer:
function RemoveGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			table.remove(GoldJobTimer,k)
		end
	end
end
function GetGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return math.ceil(v.timeGoldJob/60000)
		end
	end
end
function CheckGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return true
		end
	end
	return false
end


