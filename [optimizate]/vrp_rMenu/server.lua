local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_rainbowMenu")
vRPrainbowMenuClient = Tunnel.getInterface("vRP_rainbowMenu", "vRP_rainbowMenu")

local thePermission = "sponsor.menu"

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.hasPermission({user_id, "sponsor.menu"}) then
			choices["Meniu Curcubeu"] = {function(player,choice)
				local menu = {}
				menu.name = "Meniu RGB"
				menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
				menu.onclose = function(player) vRP.openMainMenu({player}) end
				
				menu["Vehicul RGB"] = {function(player, choice)
					vRPrainbowMenuClient.rainbowVehicleEffect(player, {})
				end, "Activeaza modul Curcubeu pe Vehicul. (Iti face Masina RGB)"}
				
				menu["Neoane RGB"] = {function(player, choice)
					vRPrainbowMenuClient.rainbowNeonsEffect(player, {})
				end, "Activeaza modul Curcubeu pe Neoane. (Iti face Neoanele RGB)"}
			
				vRP.openMenu({player, menu})
			end, "Meniu Curcubeu (RGB)"}
		end
		add(choices)
	end
end})