local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vRP_GUI:getHunger&Thirst")
AddEventHandler("vRP_GUI:getHunger&Thirst",function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		--TriggerClientEvent("vRP_GUI:getHunger&Thirst",player,vRP.getHunger({user_id}),vRP.getThirst({user_id}))
		TriggerClientEvent("vRP_GUI:SetPMoney",player,vRP.getMoney({user_id}))
		TriggerClientEvent("vRP_GUI:SetBMoney",player,vRP.getBankMoney({user_id}))
		TriggerClientEvent("vRP_GUI:SetAur",player,vRP.getAur({user_id}))
		TriggerClientEvent("vRP_GUI:SetGifts",player,vRP.getPuncte({user_id}))
		TriggerClientEvent("vRP_GUI:setJobInfo",player,vRP.getUserGroupByType({user_id,"job"}))
	end
end)
