local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_chatroles")
vRPsp = Proxy.getInterface("vRP_sponsor")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:muitzaqmessageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

RegisterServerEvent('chat:kickSpammer')
AddEventHandler('chat:kickSpammer', function()
	TriggerClientEvent('chatMessage', -1, "^1[SPAM] ^2"..GetPlayerName(source).."^8 a primit kick pentru spam!")
	DropPlayer(source, 'Ai primit kick ptr spam!')
end)

local pornit = true
AddEventHandler('_chat:muitzaqmessageEntered', function(author, color, message)
    if not message or not author then
        return
	end

    TriggerEvent('chatMessage', source, author, message)
	if string.len(message) <= 65 then 
    	if not WasEventCanceled() then
			local user_id = vRP.getUserId({source})
			local player = vRP.getUserSource({user_id})
			local pName = GetPlayerName(player)
			local author = "^4[^0 "..user_id.." ^4]^7 "..author 			
				--- Staff ---
			if (user_id == 0) then -- 
				tag = "[Developer]"
				rgb = {13, 126, 255}
			elseif vRP.hasGroup({user_id, "fondator"}) then
				tag = "👑Fondator"
				rgb = {191, 0, 0}
			elseif vRP.hasGroup({user_id, "Community Manager"}) then
				tag = "👑Co-Fondator"
				rgb = {83, 0, 114}
			elseif vRP.hasGroup({user_id, "dev"}) then
				tag = "⚙️Dev"
				rgb = {13, 126, 255}
			elseif vRP.hasGroup({user_id, "supportdev"}) then
				tag = "⚜️Ajutor Scripter "
				rgb = {61, 59, 60}
			elseif vRP.hasGroup({user_id, "Head Of Staff"}) then
				tag = "⚜️HEAD OF STAFF "
				rgb = {255, 225, 0}
			elseif vRP.hasGroup({user_id, "admin"}) then
				tag = "🔧Administrator🔧"
				rgb = {191, 0, 0}
			elseif vRP.hasGroup({user_id, "helper"}) then
				tag = "🔨Helper🔨"
				rgb = {6, 143, 24}
			elseif vRP.hasGroup({user_id, "moderator"}) then
				tag = "⚙️Moderator⚙️"
				rgb = {0, 72, 120}		
			elseif vRP.hasGroup({user_id, "trialhelper"}) then
				tag = "🔩Helper în Teste🔩"
				rgb = {208, 255, 0}
			elseif vRP.hasPermission({user_id, "youtuber.chat"}) then
				tag = "YouTuber "
				rgb = {204, 51, 51}
			elseif vRP.hasPermission({user_id, "radio.police"}) then
				tag = "M.A.I "
				rgb = {13, 93, 214}
			elseif vRP.hasPermission({user_id, "medic.chat"}) then
				tag = "SMURD "
				rgb = {255, 23, 101}
			elseif vRP.hasGroup({user_id, "Traficant de Arme"}) then
				tag = "Traficant de Arme "
				rgb = {61, 59, 60}               
			elseif vRP.hasPermission({user_id, "mafiot.chat"}) then
				tag = "Mafiot "
				rgb = {242, 0, 0}
			elseif vRP.hasPermission({user_id, "gang.chat"}) then
				tag = "Gang "
				rgb = {242, 0, 0}
			elseif vRP.hasGroup({user_id, "Lider Hitman"}) then
				tag = "Civil~ "
				rgb = {0, 0, 0} 
			elseif vRP.hasGroup({user_id, "Hitman"}) then
				tag = "Civil "
				rgb = {0, 0, 0}
			elseif vRP.hasGroup({user_id, "vip1"}) then
				tag = "V.I.P"
				rgb = {153, 77, 0}    
			elseif vRP.hasGroup({user_id, "vip2"}) then
				tag = "V.I.P"
				rgb = {128, 128, 128}  
			elseif vRP.hasGroup({user_id, "vip3"}) then
				tag = "V.I.P"
				rgb = {230, 184, 0}  
			elseif vRP.hasGroup({user_id, "vip4"}) then
				tag = "V.I.P"
				rgb = {0, 255, 255}                                                                                                     --- Politie ---
			else
				tag = "Civil"
				rgb = {255, 217, 0}
			end
		
			if pornit == true then
				TriggerClientEvent('chatMessage', -1, tag..""..author, rgb, " " ..  message) 
				
				print(author .. ': ' .. message)
			else
				TriggerClientEvent("chatMessage", source, "^8[Liquid-SYSTEM]: Chat-ul este oprit!")
			end
		end	 
	else 
		TriggerClientEvent("chatMessage", source, "^8[Liquid-SYSTSEM]: Nu poti scrie mai mult de 150 de caractere!")
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)
    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local pName = GetPlayerName(player)
		local author = "["..user_id.."] "..name
		message = "/"..command
		if source ~= nil and not id == 1 then
          local embed = {
						{
							["color"] = 0xFF7400,
							["title"] = "**".. "Comenzi chat".."**",
							["description"] = "Player "..GetPlayerName(player).."("..id..") comanda folosita "..GetPlayerName(id).."("..command..")",
							["thumbnail"] = {
								["url"] = "https://logopond.com/logos/5547875bcbba9c76a60ff38dc3b6d236.png",
							},
							["footer"] = {
							["text"] = "",
							},
						}
          }
          PerformHttpRequest("https://discord.com/api/webhooks/889596509522366514/SEUKkTVFxV8kpqaGCgnZElzkfBYDTXqZp7OcInCUG2kVU3Pg-e5aO_ng7wTDHZmmItjB", function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
		end
    end

    CancelEvent()
end)

RegisterCommand('clear', function(source)
	local user_id = vRP.getUserId({source});
	if user_id ~= nil then
		if vRP.hasPermission({user_id, "admin.tickets"}) and vRP.hasPermission({user_id, "acces.duty"}) then
			TriggerClientEvent("chat:clear", -1);
			TriggerClientEvent("chatMessage", -1,"^1[Liquid-SYSTEM]^7: ^7"..GetPlayerName(source).."^9 a curățat tot Chat-ul !");
		else
			vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
		end
	end
end)

---AA2---
RegisterCommand("aa2", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		vRPclient.teleport(player, {-1923.8289794922,1389.478515625,219.94540405273})
	end
end, false)

RegisterCommand('stopchat', function(source)
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"stop.chat"}) and vRP.hasPermission({user_id, "acces.duty"}) then
        if pornit == true then
            TriggerClientEvent('chatMessage', -1, "^1[Liquid-SYSTEM] ^0Chat-ul a fost oprit de catre : ^1"..GetPlayerName(source).."^0")
            pornit = false
        else
            TriggerClientEvent('chatMessage', -1, "^1[Liquid-SYSTEM] ^0Chat-ul a fost pornit de catre : ^1"..GetPlayerName(source).."^0")
            pornit = true
        end
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end)

RegisterCommand('id', function(source, args)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    local banicash = vRP.getMoney({user_id})
    local nume = GetPlayerName(player)
    local banibanca = vRP.getBankMoney({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    local aur = 0
    local giftbox = vRP.getPuncte({user_id})
    local locdemunca = vRP.getUserGroupByType({user_id,"job"})
    local warnuri = vRP.getUserWarns({user_id})
    local VIP = "Nu"
    if vRP.hasPermission({user_id,"vip1.masini"}) then
    	VIP = "Da"
    else
    	VIP = "Nu"
    end
    CancelEvent()
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "=============== ^0NUME: ^2"..nume.."^0 ====== ^0ID: ^5"..user_id.."^0 ===============")
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "^0Ai bani cash: ^2" ..banicash.." $^0 , Bani Banca: ^2"..banibanca.."^0, Gifbotxuri: ^8"..aur.."^0, Warn : ^5"..warnuri)
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "^0Lucrezi ca si^6: "..locdemunca.."^0, VIP: ^3"..VIP.."^0, Ore jucate: ^5"..orejucate.."^0, Aur: ^3"..aur)
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "========================================================")
end)

RegisterCommand('addgroup', function(source, args, rawCommand)
    local target_id = parseInt(args[1])
    local group = args[2]
    local tplayer = vRP.getUserSource({tonumber(target_id)})
    if(source == 0)then

        if tplayer ~= nil then
            print ("ai oferit gradul de ".. group.." lui ID "..target_id)
            vRP.addUserGroup({target_id,group})
            vRPclient.notify(tplayer,{"~y~Ai primit Gradul de ~g~"..group})
        else
            print ("Playerul nu e pe server ")
        end
    else print("Ce incerci boss ?") end
end)

RegisterCommand('playeri',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    TriggerClientEvent('chatMessage',source,"[PLAYERI]",{255,70,50},"Jucatori Online: "..onlinePlayers)
end)


RegisterCommand("tpto", function(player, args)
	local user_id = vRP.getUserId({player})
		if vRP.hasPermission({user_id, "admin.tickets"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(target_src, {}, function(x, y, z)
					vRPclient.teleport(player, {x, y, z})
					vRPclient.notify(player, {"Te-ai teleportat la "..vRP.getPlayerName({target_src}).." ["..target_id.."]"})
					vRPclient.notify(target_src, {"Adminul "..vRP.getPlayerName({player}).." ["..user_id.."] s-a teleportat la tine"})
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1[Eroare]^7: Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1[Syntax]^7: /tpto <user_id>")
		end
	else
        vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
    end
end, false)

RegisterCommand("ore", function(player, args)
	local user_id = vRP.getUserId({player})
	if args[1] and args[1] ~= "" then
		local target_id = parseInt(args[1])
		local target_src = vRP.getUserSource({target_id})
		if target_src then
			local name = vRP.getPlayerName({target_src})
			local ore = vRP.getUserHoursPlayed({target_id})
			TriggerClientEvent("chatMessage", player, "^0[^9Liquid^0] ID: ^1"..target_id.."^0 Nume: ^1"..name.."^0 Are: ^1"..ore.."^0 ore jucate!")
		else
			TriggerClientEvent("chatMessage", player, "^0[^9Liquid^0] ^1Jucatorul nu este conectat !")
		end
	else
		TriggerClientEvent("chatMessage", player, "^0[^9Liquid^0] ^1/ore <id>")
	end
end, false)

RegisterCommand("full", function(source)
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "mancar.apa"}) then
        vRP.varyHunger({user_id, -100})
        vRP.varyThirst({user_id, -100})
        vRPclient.varyHealth(source, {100})
        vRPclient.notify(source,{"~y~[~w~Liquid~y~]\n~g~Te-ai facut full boss!"})
   else
    vRPclient.notify(source,{"~y~[~w~Liquid~y~]\n~r~Nu ai acces la aceasta comanda !"})
        end
	end)

RegisterCommand('rev', function(source, args, msg)
	local user_id = vRP.getUserId({source})
	msg = msg:sub(4)
	if msg:len() >= 1 then
	  msg = tonumber(msg)
	  local target = vRP.getUserSource({msg})
	  if target ~= nil then
		if vRP.hasPermission({user_id, "admin.tickets"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		  vRPclient.varyHealth(target,{300})
		  vRP.varyHunger({msg,-100})
		  vRP.varyThirst({msg,-100})
		  TriggerClientEvent('chatMessage', source, "^8Server^7 : I-ai dat Revive lui : "..GetPlayerName(target).."!")
		  TriggerClientEvent('chatMessage', target, "^8Server^7 : Adminul "..GetPlayerName(source).." ti-a dat revive !")
		 vRPclient.notify(source,{"[~g~Server~w~] : I-ai dat Revive lui : "..GetPlayerName(target).."!"})
		 vRPclient.notify(target,{"[~g~Server~w~] : Adminul "..GetPlayerName(source).." ti-a dat revive !"})
		else
			vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
		end
	  else
		TriggerClientEvent('chatMessage', source, "^8Eroare^7 : Player-ul nu este conectat.")
	  end
	else
	  TriggerClientEvent('chatMessage', source, "^8Syntax^7 : /rv <user-id>")
	end
  end)
--------------------------------------------------------------------------------------------------

  local function giveallitem(amount)
	local users = vRP.getUsers({})
	for user_id, source in pairs(users) do
		vRP.giveInventoryItem({user_id, "cufargur.", amount, true})

	end
end

RegisterCommand("givecufargur", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "cufar.gur"}) then
		local theMoney = parseInt(args[1]) or 0
		if theMoney >= 1 then
			giveallitem(theMoney)
			TriggerClientEvent("chatMessage", -1, "^2[Liquid-SYSTEM]^7: ^9"..vRP.getPlayerName({player}).."^7 a oferit tuturor jucatorilor un ^2Cufar Liquid-SYSTEM")
		else
			TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: /givecufargur <amount>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: Nu ai acces la aceasta comanda")
	end
end, false)
--[[
--------------------------------------------------------------------------------------------------
local function giveallitem(amount)
	local users = vRP.getUsers({})
	for user_id, source in pairs(users) do
		vRP.giveInventoryItem({user_id, "cufarboost.", amount, true})

	end
end

RegisterCommand("givecufarboost", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "cufar.boost"}) then
		local theMoney = parseInt(args[1]) or 0
		if theMoney >= 1 then
			giveallitem(theMoney)
			TriggerClientEvent("chatMessage", -1, "^2[Liquid-SYSTEM]^7: ^9"..vRP.getPlayerName({player}).."^7 a oferit tuturor jucatorilor un Cufar Boost")
		else
			TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: /givecufarboost <amount>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: Nu ai acces la aceasta comanda")
	end
end, false)
--------------------------------------------------------------------------------------------------
local function giveallitem(amount)
	local users = vRP.getUsers({})
	for user_id, source in pairs(users) do
		vRP.giveInventoryItem({user_id, "cufarpremiu.", amount, true})

	end
end

RegisterServerEvent("beny:recivePoliceChat")
AddEventHandler("beny:recivePoliceChat", function(name, msg)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, "radio.police"}) then
    TriggerClientEvent("chatMessage", source, "^7[^4Departament Politie^7]^0 - ^7(^1".. name .."^7) ^0:^7 ".. msg)
  end
end)

RegisterCommand("givecufarpremiu", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "cufar.event"}) then
		local theMoney = parseInt(args[1]) or 0
		if theMoney >= 1 then
			giveallitem(theMoney)
			TriggerClientEvent("chatMessage", -1, "^2[Liquid-SYSTEM]^7: ^9"..vRP.getPlayerName({player}).."^7 a oferit tuturor jucatorilor un ^2Cufar Event")
		else
			TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: /cufarpremiu <amount>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^7: Nu ai acces la aceasta comanda")
	end
end, false)
--]]
--------------------------------------------------------------------------------------------------
RegisterCommand("event", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		if not eventOn then
			vRPclient.getPosition(player, {}, function(x, y, z)
				evCoords = {x, y, z + 0.5}
			end)
			eventOn = true
			TriggerClientEvent("chatMessage", -1, "^1[Event]^7: Adminul "..vRP.getPlayerName({player}).." a pornit un eveniment ! Foloseste </goevent> pentru a da tp acolo")

		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Eroare]^7: Nu ai acces la aceasta comanda")
	end
end, false)

RegisterCommand("goevent", function(player)
	if eventOn then
		vRPclient.teleport(player, {evCoords[1], evCoords[2], evCoords[3]})
		TriggerClientEvent("zedutz:setFreeze", player, true)
	else
		TriggerClientEvent("chatMessage", player, "^1[Eroare]^7: Nu exista nici un eveniment activ")
	end
end, false)

RegisterCommand("startevent", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		if eventOn then
			evCoords = {}
			eventOn = false

			TriggerClientEvent("zedutz:setFreeze", -1, false)
			TriggerClientEvent("chatMessage", -1, "^1Event^7: Toti jucatorii au primit unfreeze si eventul a inceput !")
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nu exista nici un eveniment activ !")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nu ai acces la aceasta comanda")
	end
end, false)

--------------------------------------------------------------------------------------------------
RegisterCommand("kick", function(player, args)
	if player == 0 then
		local usr = parseInt(args[1])
		if usr ~= nil and usr then
			local src = vRP.getUserSource({usr})
			if src ~= nil and usr then
				vRP.kick1337(src, "Kicked by Console")
			else
				print("Jucator offline")
			end
		else
			print("/kick <user_id>")
		end
	else
		local user_id = vRP.getUserId({player})
		if vRP.hasPermission({user_id, "admin.tickets"}) then
			if args and args[1] and args[2] then
				local target_id = parseInt(args[1])
				local reason = args[2]
				for i=3,#args do
					reason = reason .. " " .. args[i]
				end
				if target_id and reason then
					local target_src = vRP.getUserSource({target_id})
					if target_src then
						TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Adminul ^3"..GetPlayerName(player).." ^2i-a dat kick lui ^3"..GetPlayerName(target_src))
						TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Motiv: ^3"..reason)
						vRP.request({player, "", 1, function(player, ok)
							vRP.kick1337({target_src, reason})
						end})
					else
						TriggerClientEvent("chatMessage", player, "^1Eroare^7: Jucatorul nu este online")
					end
				end
			else
				TriggerClientEvent('chatMessage', player, "^1Syntax^7: /kick <user-id> <motiv>")
			end
		else
			TriggerClientEvent('chatMessage', player, "^1Eroare^7: Nu ai acces la aceasta comanda!")
		end
	end
end)

RegisterCommand("ban", function(player, args)
	if player == 0 then
		local usr = parseInt(args[1])
		if usr ~= nil and usr then
			local src = vRP.getUserSource({usr})
			if src ~= nil and usr then
				vRP.ban1337(src, "Mnezai tai de prost")
			else
				print("Jucator offline")
			end
		else
			print("/ban <user_id>")
		end
	else
		local user_id = vRP.getUserId({player})
		if vRP.hasPermission({user_id, "ban.comanda"}) then
			if args and args[1] and args[2] then
				local target_id = parseInt(args[1])
				local reason = args[2]
				for i=3,#args do
					reason = reason .. " " .. args[i]
				end
				if target_id and reason then
					local target_src = vRP.getUserSource({target_id})
					if target_src then
						TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Adminul ^3"..GetPlayerName(player).." ^2i-a dat ban lui ^3"..GetPlayerName(target_src))
						TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Motiv: ^3"..reason)
						vRP.request({player, "", 1, function(player, ok)
							--exports["GHMattiMySQL"]:QueryResultAsync("UPDATE vrp_users SET banned = '1', bannedReason = '3 Warn-uri acumulate', bannedBy = 'SLASHER-INFO' WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = banBy})

							vRP.ban({target_src, reason, player})
						end})
					else
						TriggerClientEvent("chatMessage", player, "^1Eroare^7: Jucatorul nu este online")
					end
				end
			else
				TriggerClientEvent('chatMessage', player, "^1Syntax^7: /ban <user-id> <motiv>")
			end
		else
			TriggerClientEvent('chatMessage', player, "^1Eroare^7: Nu ai acces la aceasta comanda!")
		end
	end
end)

RegisterCommand("dvall", function(player, args)
	if player == 0 then
		local theSecs = parseInt(args[1]) or 10
		TriggerClientEvent("zedutz:delAllVehs", -1, theSecs)
	else
		local user_id = vRP.getUserId({player})
		if vRP.hasPermission({user_id, "player.blips"}) then
			local sec = parseInt(args[1]) or 10
			if sec >= 0 then
				TriggerClientEvent("chatMessage", -1, "^1[Info]^7: Adminul ^1"..vRP.getPlayerName({player}).."^7 a sters toate masinile")
				TriggerClientEvent("zedutz:delAllVehs", -1, sec)
			end
		else
			TriggerClientEvent("chatMessage", player, "^1[Eroare]^7: Nu ai acces la aceasta comanda")
		end
	end
end, false)

RegisterCommand('d', function(source, args, msg)
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "radio.police"}) then
	  TriggerClientEvent("beny:sendPoliceChat", -1, GetPlayerName(source), msg:sub(3))
	else
	  TriggerClientEvent("chatMessage", source, "^1Eroare^0: Nu ai acces la aceasta comanda.")
	end
  end)

RegisterCommand("reviveall", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "player.blips"}) then
		local users = vRP.getUsers({})
		for k, v in pairs(users) do 
			Citizen.Wait(10)
			if v then
				vRPclient.varyHealth(v, {100})
				SetTimeout(500, function()
					vRPclient.varyHealth(v, {100})
				end)
			end
		end
		TriggerClientEvent("chatMessage", -1, "^1[Liquid-SYSTEM]^7: "..GetPlayerName(player).." a dat revive la tot server-ul")
	else
		vRPclient.noAccess(player, {})
	end
end)

RegisterCommand("respawnall", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "player.blips"}) then
		local users = vRP.getUsers({})
		for k, v in pairs(users) do 
			Citizen.Wait(10)
			if v then
				vRPclient.teleport(v, {-540.51916503906,-212.1442565918,37.64979171753})
			end
		end
		TriggerClientEvent("chatMessage", -1, "^1RespawnAll^7: "..GetPlayerName(player).." a dat respawn la tot server-ul")
	else
		vRPclient.noAccess(player, {})
	end
end)

RegisterCommand("tptome", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "admin.tptom"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(player, {}, function(x, y, z)
					vRPclient.teleport(target_src, {x, y, z})
					vRPclient.notify(player, {"L-ai teleportat la tine pe "..vRP.getPlayerName({target_src}).." ["..target_id.."]"})
					vRPclient.notify(target_src, {"Adminul "..vRP.getPlayerName({player}).." ["..user_id.."] te-a teleportat la el"})
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1[Eroare]^7: Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1Syntax^7: /tptome <user_id>")
		end
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end, false)

RegisterCommand("tptow", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "player.spectate"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		TriggerClientEvent("TpToWaypoint", player)
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end, false)

RegisterCommand("respawn", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		local target_id = parseInt(args[1])
		local target_src = vRP.getUserSource({target_id})
		if target_src then
			vRPclient.teleport(target_src, {-540.51916503906,-212.1442565918,37.64979171753})
			TriggerClientEvent("chatMessage", -1, "^1[Info]^7: Admin-ul "..GetPlayerName(player).." i-a dat respawn lui "..GetPlayerName(target_src))
		else
			TriggerClientEvent("chatMessage", player, "^1Syntax^7: /respawn <user_id>")
		end
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu ai acces"})
	end
end, false)

RegisterCommand("nc", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id, "player.spectate"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		vRPclient.toggleNoclip(player, {})
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end, false)

RegisterCommand("delinv", function(player, source)
    local user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id, "dev"}) then
    vRP.clearInventory({source})
    vRPclient.notify(source,{"~g~Ai sters inventarul"})
    end
end)

RegisterCommand('spawnveh',function(source)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id,"player.banoffline"}) and vRP.hasPermission({user_id, "acces.duty"}) then
		vRP.prompt({player,"Vehicle Model:","",function(player,model)
			if model ~= nil and model ~= "" then 
				  BMclient.spawnVehicle(player,{model})
			end
		end})
	else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end)
 
 RegisterCommand('asay', function(source, args, rawCommand)
   if (source == 0) then
	 TriggerClientEvent('chatMessage', -1,'^1Liquid ^3Roleplay ^4România', { 255, 255, 255 }, rawCommand:sub(5))
   else
	 local user_id = vRP.getUserId({source})
	 if vRP.hasPermission({user_id, "say.chat"}) then
	   TriggerClientEvent('chatMessage', -1,'^1Liquid ^3Roleplay ^4România', { 255, 255, 255 }, rawCommand:sub(5))
	 else
	   TriggerClientEvent('chatMessage', source, "^8Eroare^7: Nu deti acces-ul necesar pentru a folosi aceasta comandă!")
	 end
   end
 end)

 RegisterCommand('aasay', function(source, args, rawCommand)
	if (source == 0) then
	  TriggerClientEvent('chatMessage', -1, { 255, 255, 255 }, rawCommand:sub(5))
	else
	  local user_id = vRP.getUserId({source})
	  if vRP.hasPermission({user_id, "say.smeker"}) then
		TriggerClientEvent('chatMessage', -1, { 255, 255, 255 }, rawCommand:sub(5))
	  else
		TriggerClientEvent('chatMessage', source, "^8Eroare^7: Nu deti acces-ul necesar pentru a folosi aceasta comandă!")
	  end
	end
  end)



RegisterCommand('a', function(source, args, rawCommand)
	if(args[1] == nil)then
		TriggerClientEvent('chatMessage', source, "^3SYNTAXA: /"..rawCommand.." [Mesaj]") 
	else
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id,"admin.tickets"}) then
		    local fMembers = vRP.getUsersByPermission({"admin.tickets"})
		    for i, v in ipairs(fMembers) do
			    local player = vRP.getUserSource({tonumber(v)})
			    TriggerClientEvent('chatMessage', player, "^5[CHAT STAFF] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
			end
		else 
			TriggerClientEvent('chatMessage', player, "Nu ai acces la aceasta comanda!")
		end
	end
end)

RegisterCommand('p', function(source, args, rawCommand)
	if(args[1] == nil)then
		TriggerClientEvent('chatMessage', source, "^3SYNTAXA: /"..rawCommand.." [Mesaj]") 
	else
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id,"police.service"}) then
		    local fMembers = vRP.getUsersByPermission({"police.service"})
		    for i, v in ipairs(fMembers) do
			    local player = vRP.getUserSource({tonumber(v)})
			    TriggerClientEvent('chatMessage', player, "^5[STATIE POLITIE] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
			end
		else 
			TriggerClientEvent('chatMessage', player, "Nu esti in politie!")
		end
	end
end)

RegisterCommand('m', function(source, args, rawCommand)
	if(args[1] == nil)then
		TriggerClientEvent('chatMessage', source, "^3SYNTAXA: /"..rawCommand.." [Mesaj]") 
	else
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id,"ems.whitelisted"}) then
		    local fMembers = vRP.getUsersByPermission({"ems.whitelisted"})
		    for i, v in ipairs(fMembers) do
			    local player = vRP.getUserSource({tonumber(v)})
			    TriggerClientEvent('chatMessage', player, "^5[STATIE MEDICI] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
			end
		else 
			TriggerClientEvent('chatMessage', player, "Nu esti medic!")
		end
	end
end)

RegisterCommand('anunt', function(source, args, msg)
	local anunt = table.concat(args, " ")
	local nume = GetPlayerName(source)
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "admin.tickets"}) then
		TriggerClientEvent('chatMessage', -1, "^5[Liquid] ^0Adminul ^5"..nume.." ^0 Anunta : ^5"..anunt.." ^0!")
	else
		TriggerClientEvent('chatMessage', source, "^8Nu ai acces la aceasta comanda")
	end
end)

local function giveAllBankMoney(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
            vRP.giveMoney({user_id, tonumber(amount)})
        end
    end
end

RegisterCommand("giveallmoney", function(player, args)
    if player == 0 then
        local theMoney = parseInt(args[1]) or 0
        if theMoney >= 1 then
            giveAllBankMoney(theMoney, false)
            TriggerClientEvent("chatMessage", -1, "^1[Liquid-SYSTEM]^0: Server-ul a oferit tuturor jucatorilor ^2Bani")
        else
            print("/giveallmoney <suma>")
        end
    else
        local user_id = vRP.getUserId({player})
        if vRP.hasGroup({user_id, "dev"}) then --Asta este un cod ptr mine .. Voi puneti grad vostru de Fondator!
            local theMoney = parseInt(args[1]) or 0
            if theMoney >= 1 then
                giveAllBankMoney(theMoney, false)
                TriggerClientEvent("chatMessage", -1, "^1[Liquid-SYSTEM]^0: Fondatorul ^7"..vRP.getPlayerName({player}).."^7 a oferit tuturor jucatorilor ^2Bani")
            else
                TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^0: /giveallmoney <suma>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1[Liquid-SYSTEM]^0: Nu ai acces la aceasta comanda")
        end
    end
end, false)
