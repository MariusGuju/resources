
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","all_sla")

vRPfp = {}
Tunnel.bindInterface("all_sla",vRPfp)
Proxy.addInterface("all_sla",vRPfp)
vRPfpC = Tunnel.getInterface("all_sla","all_sla")

playersTracking = {}
playersToFind = {}

local function findThePlayer(player,choice)
	local user_id = vRP.getUserId({player})
	target = playersToFind[choice]
	if(user_id == target)then
		vRPclient.notify(player,{"~r~Nu te poti cauta pe tine!"})
	else
		theTarget = vRP.getUserSource({target})
		TriggerClientEvent("findPlayerOnMap", player, theTarget)
		playersTracking[user_id] = target
		local embed = {
			{
			  ["color"] = 1234521,
			  ["title"] = "__".. "Hitman".."__",
			  ["description"] = "[ "..GetPlayerName(player).." ] il urmareste pe [ "..GetPlayerName(theTarget).." ]",
			  ["thumbnail"] = {
				["url"] = "https://static.wikia.nocookie.net/hitman/images/6/6b/Agent47HITMAN2016.png/revision/latest/scale-to-width-down/2000?cb=20210121120030",
			  },
			  ["footer"] = {
			  ["text"] = "Hitman Log",
			  },
			}
		  }
		  PerformHttpRequest('https://discord.com/api/webhooks/894246857851699261/Fp4WwxWgk-Fr4l_cEeH0u4ypI-M5azIS1wrXtHUE-Ayj55TESqv0fgOhyZN2ZCB4uFKs', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
		vRP.closeMenu({player})
	end
end
	
local function cancelTracking(player,choice)
	local user_id = vRP.getUserId({player})
	TriggerClientEvent("cancelPlayerTracking", player)
	playersTracking[user_id] = nil
	vRP.closeMenu({player})
end

AddEventHandler('playerDropped', function()
	local trackedPlayer = source
	users = vRP.getUsers({})
	for i, v in pairs(users) do
		local user_id = vRP.getUserId({v})
		local trackedPlr = playersTracking[user_id]
		if(trackedPlr == trackedPlayer)then
			TriggerClientEvent("cancelPlayerTracking", v)
			vRP.notify(v, {"~w~[FIND] ~r~Jucatorul ~w~"..GetPlayerName(trackedPlr).." ~r~a parasit jocul!"})
		end
	end
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.hasPermission({user_id, "cautaprostu.hitman"}))then
			choices["Cauta Jucator"] = {function(player,choice)
				users = vRP.getUsers({})
				vRP.buildMenu({"Players to Find", {player = player}, function(menu)
					menu.name = "Players to Find"
					menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end	
					if(playersTracking[user_id] == nil)then
						myName = tostring(GetPlayerName(player))
						for k,v in pairs(users) do
							playerName = tostring(GetPlayerName(v))
							playersToFind[playerName] = tonumber(k)
							menu[playerName] = {findThePlayer, "Marcheaza jucatorul pe harta"}
						end
					else
						menu["Anuleaza Cautarea"] = {cancelTracking, "Anuleaza cautarea jucatorilui"}
					end
					vRP.openMenu({player, menu})
				end})
			end, "Cauta un jucator pe harta!"}
		end
		add(choices)
	end
end})