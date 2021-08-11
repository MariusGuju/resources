local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPtow = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_tow")
BMclient = Tunnel.getInterface("vRP_tow","vRP_tow")
Tunnel.bindInterface("vrp_tow",vRPtow)
Proxy.addInterface("vrp_tow",vRPtow)

impoundFee = 100
isTowing = {}

local allowedTowModels = { "flatbed", "flatbed2", "flatbed3"}

function isPlayerTowTrucker(user_id)
	if(vRP.isUserInFaction({user_id, "Mecanic"}))then
		return true
	else
		return false
	end
	return false
end

function setPlayerAsNotTowing(thePlayer)
	local user_id = vRP.getUserId({thePlayer})
	isTowing[user_id] = nil
end

RegisterServerEvent("setPlayerAsNotTowing")
AddEventHandler("setPlayerAsNotTowing", function(theVehicle)
	local user_id = vRP.getUserId({source})
	isTowing[user_id] = nil
end)

RegisterServerEvent("setPlayerAsTowing")
AddEventHandler("setPlayerAsTowing", function(theVehicle)
	local user_id = vRP.getUserId({source})
	isTowing[user_id] = theVehicle
end)

local function ch_towVehicle(player, choice)
	TriggerClientEvent('towVehicle', player)
	vRP.closeMenu({player})
end

local function ch_unimpoundVehicle(player, choice)
	setPlayerAsNotTowing(player)
	TriggerClientEvent('towVehicle', player)
	vRP.closeMenu({player})
end

local function ch_impoundVehicle(player, choice)
	TriggerClientEvent('deleteTowedVehicle', player)
	local user_id = vRP.getUserId({player})
	vRP.closeMenu({player})
	setPlayerAsNotTowing(player)
	vRP.giveMoney({user_id, impoundFee})
	vRPclient.notify(player, {"~w~[T.A] ~g~Ai tractat vehiculul pentru ~r~$"..impoundFee})
end

local function ch_repair(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestVehicle(player, {7}, function(veh)
			if(veh)then
				vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
				SetTimeout(15000, function()
					vRPclient.fixeNearestVehicle(player,{7})
					vRPclient.stopAnim(player,{false})
				end)
			else
				vRPclient.notify(player, {"~w~[T.A] ~r~Nici un vehicul in apropiere"})
			end
		end)
	end
end

local function ch_towMenu(player, choice)
	vRP.buildMenu({"Tractari Auto", {player = player}, function(menu)
		menu.name = "Tractari Auto"
		menu.css={top="75px",header_color="rgba(0,255,213,0.75)"}
		menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
		local user_id = vRP.getUserId({player})
		if(isTowing[user_id] == nil)then
			menu["Tracteaza Vehicul"] = {ch_towVehicle,"Tracteaza vehiculul de langa tine"}
		else
			menu["Elibereaza Vehicul"] = {ch_unimpoundVehicle,"Elibereaza vehiculul de pe platforma"}
		end
		menu["Repara Vehicul"] = {ch_repair,"Repara vehiculul de langa tine"}
		vRP.openMenu({player,menu})
	end})
end

function isVehicleATowTruck(player)
    isValid = false
    for i, v in pairs(allowedTowModels) do
        vRPclient.isPlayerInSpecificVehicle(player, {v}, function(isTow)
			isTow = isTow
		end)
		if (isTow == true) then
			isValid = true
			break
		end
    end
	print("IS VALID: "..tostring(isValid))
	return isValid
end

local function impoundVehicle(player)
	local user_id = vRP.getUserId({player})
	local isTowTruck = isVehicleATowTruck(player)
	--if(isTowTruck == true)then
		if(isTowing[user_id] ~= nil)then
			vRP.buildMenu({"Tracteaza Vehicul", {player = player}, function(menu2)
				menu2.name = "Tracteaza Vehicul?"
				menu2.css={top="75px",header_color="rgba(0,255,213,0.75)"}
				menu2.onclose = function(player) vRP.closeMenu({player}) end -- nest menu
							
				menu2["Da"] = {ch_impoundVehicle,"Baga vehiculul in garaj"}
				menu2["Nu"] = {function(player) vRP.closeMenu({player}) end}
				vRP.openMenu({player,menu2})
			end})
		else
			vRPclient.notify(player,{"~w~[T.A] ~r~Nu ai nici un vehicul pe rampa!"})
		end
	--else
	--	vRPclient.notify(player,{"~w~[T.A] ~r~Nu conduci nici o platforma!"})
	--end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	isTowing[user_id] = nil
  
	local function impound_enter()
        local user_id = vRP.getUserId({source})
        if (user_id ~= nil and isPlayerTowTrucker(user_id)) then
			impoundVehicle(source) 
        end
    end

    local function impound_leave()
		vRP.closeMenu({source})
    end
	
	local x, y, z = -453.5848083496,-799.92303466796,30.544145584106
	vRPclient.addMarker(source,{x,y,z-1,2.2,2.2,0.65,0,0,255,213,150})
	vRPclient.addBlip(source,{x,y,z,68,26,"Tractari Auto"})
    vRP.setArea({source,"vRP:towImpound",x,y,z,3.8,1.5,impound_enter,impound_leave})
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		choices = {}
		if (isPlayerTowTrucker(user_id) == true) then
			choices["Meniu Tractari"] = {ch_towMenu, "Meniu Tractari Auto"}
		end
		add(choices)
	end
end})