--[[
Los Santos Customs V1.1 
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vrp")
vRPclient = Tunnel.getInterface("vrp","lscustom")

local tbl = {
[1] = {locked = false, player = nil},
[2] = {locked = false, player = nil},
[3] = {locked = false, player = nil},
[4] = {locked = false, player = nil},
[5] = {locked = false, player = nil},
[6] = {locked = false, player = nil},
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)


-- RegisterCommand("fixtunning", function(player)
-- 	local user_id = vRP.getUserId({player})
-- 	if user_id ~= nil then
-- 		TriggerClientEvent('lockGarage',-1,tbl)
-- 		print("[LSC] Tunning-ul a fost debuguit")
-- 	end
-- end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local mymoney = 999999 --Just so you can buy everything while there is no money system implemented
	if button.price then -- check if button have price
		if button.price <= mymoney then
			TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
			mymoney  = mymoney - button.price
		else
			TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
		end
	end
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)
	local model = veh.model --Display name from vehicle model(comet2, entityxf)
	local mods = veh.mods
	local color = veh.color
	local extracolor = veh.extracolor
	local neoncolor = veh.neoncolor
	local smokecolor = veh.smokecolor
	local plateindex = veh.plateindex
	local windowtint = veh.windowtint
	local wheeltype = veh.wheeltype
	local bulletProofTyres = veh.bulletProofTyres
	--Do w/e u need with all this stuff when vehicle drives out of lsc
end)

RegisterServerEvent("lscustom:doPayment")
AddEventHandler("lscustom:doPayment", function(price)
	local user_id = vRP.getUserId({source})
	if vRP.tryFullPayment({user_id, price}) then
		TriggerClientEvent("lscustom:sayPayment",source,2)
	else
		TriggerClientEvent("lscustom:sayPayment",source,3)
	end	
end)


RegisterServerEvent("lscustom:sendDB")
AddEventHandler("lscustom:sendDB", function(tt, model,farcolorat)
	webhook = GetConvar("vehtunning", "none")
	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
	SendWebhookMessage(webhook,"**TUNNING VEHICLE**\n```lua\n[1] Jucator: "..GetPlayerName(source).." ["..vRP.getUserId({source}).."]\n[2] Vehicul: "..model.."\n[3] Salvat```")
	exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET farcolorat = @farcolorat WHERE user_id = @src AND vehicle = @vehicle",{["@farcolorat"] = farcolorat, ["@src"] = vRP.getUserId({source}), ["@vehicle"] = model}, function(data)end)
	exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET `upgrades`=@ups WHERE user_id = @src AND vehicle = @mdl",{['@ups'] = tt, ['@src'] = vRP.getUserId({source}), ['@mdl'] = model}, function(data)end)
end)