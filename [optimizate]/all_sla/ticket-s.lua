
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","all_sla")

local function sendMsgToStaff(msg, user_id, staffOnline)
	local task = Task(staffOnline)
	local staffs = 0

	local users = vRP.getUsers({})
	for uID, ply in pairs(users) do
		if vRP.hasPermission({user_id, "admin.tickets"}) then
			TriggerClientEvent("chatMessage", ply, "^2Question^7[^2"..user_id.."^7]: "..msg)
			vRPclient.playSound(ply, {"HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING"})
			staffs = staffs + 1
		end
	end

	task({staffs})
end

local function getNrCifre(n) -- stiu asta din C++ dreq =]] don't judge me 
	local cifs = 0
	while n ~= 0 do
		cifs = cifs + 1
		n = math.floor(n / 10)
	end
	
	return cifs
end

local questions = {}
local function autoDecremet(user_id)
	if questions[user_id] > 0 then
		questions[user_id] = questions[user_id] - 1
		Wait(1000)
		autoDecremet(user_id)
	else
		if questions[user_id] ~= -29 then
			TriggerClientEvent("chatMessage", vRP.getUserSource({user_id}), "^2[NorbSiMaruServer]^7: Din pacate nimeni nu ti-a raspuns la intrebare")
		end
		questions[user_id] = nil
	end
end

RegisterCommand("n", function(player, args, msg)
	local user_id = vRP.getUserId({player})
	if user_id then
		if not questions[user_id] then
		    local question = msg:sub(3)
		    if msg:len() > 5 then
		    	sendMsgToStaff(question, user_id, function(staffOnline)
		    		if staffOnline then
		    			TriggerClientEvent("chatMessage", player, "^2Intrebarea ta va fi revizuita de catre membrii staff-ului !")
		    			questions[user_id] = 60
		    			autoDecremet(user_id)
		    		else
		    			TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nici un membru din staff nu este online")
		    		end
		    	end)
		    else
		    	TriggerClientEvent("chatMessage", player, "^1Syntax^7: /n <intrebare>")
		    end
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^7: Ai pus deja o intrebare, asteapta ^1"..questions[user_id].." ^7secunde")
		end
	end
end)

RegisterCommand("nr", function(player, args, msg)
	local user_id = vRP.getUserId({player})
	local target_id = parseInt(args[1])
	local response = msg:sub(4 + getNrCifre(target_id))
	if user_id then
		if vRP.hasPermission({user_id, "admin.tickets"}) then
		    if target_id and response:len() > 0 then
		    	local target_source = vRP.getUserSource({target_id})
		    	if target_source then
		    		if questions[target_id] then
			    		TriggerClientEvent("chatMessage", target_source, "^3Raspuns^7: "..response)
			    		vRPclient.playSound(target_source, {"HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING"})

			    		local users = vRP.getUsers({})
						for uID, ply in pairs(users) do
							if vRP.hasPermission({user_id, "admin.tickets"}) then
								TriggerClientEvent("chatMessage", ply, "^2[NorbSiMaruServer]^7: Adminul ^2"..user_id.." ^7i-a raspuns lui ^2"..target_id)
								TriggerClientEvent("chatMessage", ply, "^2"..response)
							end
						end

						questions[target_id] = -29
			    	else
			    		TriggerClientEvent("chatMessage", player, "^1Eroare^7: Acel jucator nu are o intrebare")
			    	end
		    	else
		    		TriggerClientEvent("chatMessage", player, "^1Eroare^7: Acel jucator nu mai este conectat")
		    	end
		    else
		    	TriggerClientEvent("chatMessage", player, "^1Syntax^7: /nr <User ID> <raspuns>")
		    end
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nu ai acces la aceasta comanda")
		end
	end
end)