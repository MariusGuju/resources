--[[
    FiveM Scripts
    The Official HackerGeo Script 
	WEBISTE: www.HackerGeo.com
	GITHUB: GITHUB.com/HackerGeoTheBest
	STEAM: SteamCommunity.com/id/HackerGeo1

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Official Scripts by HackerGeo ------------------------------------------
--------------------------------------------------------------------------------------------------------------------



MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_Car_Registration")

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

--Car registration
MySQL.createCommand("vRP/registration_column", "ALTER TABLE vrp_users ADD CarRegistration varchar(55) NOT NULL default 'No'")
MySQL.createCommand("vRP/registration_success", "UPDATE vrp_users SET CarRegistration='Yes' WHERE id = @id")
MySQL.createCommand("vRP/registration_search", "SELECT * FROM vrp_users WHERE id = @id AND CarRegistration = 'Yes'")
-- init
-- MySQL.query("vRP/registration_column")


RegisterServerEvent("registration:success")
AddEventHandler("registration:success", function()
	local user_id = vRP.getUserId({source})
	MySQL.query("vRP/registration_success", {id = user_id})
end)

RegisterServerEvent("registration:cumdr3fs")
AddEventHandler("registration:cumdr3fs", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryPayment({user_id,250000}) then
        TriggerClientEvent('registration:EndBuyRegistration',player)
	 else
		vRPclient.notifyPicture(player,{"CHAR_BANK_FLEECA",1,"~g~Flecca Bank",false,"Nu ai ~r~Bani~w~ de inscriere a masinii."})
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	MySQL.query("vRP/registration_search", {id = user_id}, function(rows, affected)
      if #rows > 0 then
          TriggerClientEvent('registration:CheckInscStatus',source)
      end
    end)
end)

local choice_askregistration = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Certificatul De Inmatriculare..."})
      vRP.request({nplayer,"Vrei sa arati certificatul de inmatriculare?",15,function(nplayer,ok)
        if ok then
          MySQL.query("vRP/registration_search", {id = nuser_id}, function(rows, affected)
            if #rows > 0 then
			  vRPclient.notify(player,{"Certificatul De Inmatriculare: ~g~DA"})
			else
			  vRPclient.notify(player,{"Certificatul De Inmatriculare: ~r~NU"})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica Certificatul De Inmatriculare."}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission({user_id,"police.askreg"}) then
       choices["Certificatul De Inmatriculare"] = choice_askregistration
    end
	
    add(choices)
  end
end})