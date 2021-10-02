local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_gym")
vRPCgym = Tunnel.getInterface("vRP_gym","vRP_gym")

vRPgym = {}
Tunnel.bindInterface("vRP_gym",vRPgym)
Proxy.addInterface("vRP_gym",vRPgym)

members = {}

gymTable = {
	["biceps1"] = {-1198.9050, -1564.1252, 4.1115, "Biceps Bara"},
	["abdo"] = {-1197.7672, -1571.3300, 4.1115, "Abdomene"},
	["biceps2"] = {-1210.0610, -1560.6418, 4.1115, "Biceps Bara"},
	["yoga"] = {-1204.2547, -1556.8259, 4.1115, "Yoga"},
	["tractiuni1"] = {-1200.1284, -1570.9903, 4.1115, "Tractiuni"},
	["tractiuni2"] = {-1204.7150, -1564.3831, 4.1115, "Tractiuni"},
	["flotari"] = {-1194.1945, -1570.1912, 4.1115, "Flotari"},
	["bench1"] = {-1197.1033, -1567.5870, 4.1115, "La Piept"},
	["bench2"] = {-1200.6325, -1575.8344, 4.1115, "La Piept"},
	["bench3"] = {-1206.4871, -1561.5948, 4.1115, "La Piept"},
	["bench4"] = {-1201.4362, -1562.7670, 4.1115, "La Piept"}
}

theGym = {-1195.4376, -1577.6749, 4.1115}

workouts = {
	["PROP_HUMAN_MUSCLE_CHIN_UPS"] = {"tractiuni1", "tractiuni2"},
	["WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"] = {"biceps1", "biceps2"},
	["WORLD_HUMAN_SIT_UPS"] = {"abdo"},
	["WORLD_HUMAN_YOGA"] = {"yoga"},
	["WORLD_HUMAN_PUSH_UPS"] = {"flotari"},
	["PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"] = {"bench1", "bench2", "bench3", "bench4"}
}

supplements = {
	["Creatina"] = {50, "creatina"},
	["Batoane Proteice"] = {60, "batoaneproteice"},
	["Multivitamine"] = {540, "multivitamine"},
	["Oxid Nitric"] = {140, "oxidnitric"},
	["BCAA"] = {10, "bcaa"},
	["Amino Acizi"] = {253, "aminoacizi"},
	["Pre-Workout"] = {243, "preworkout"},
	["ZMA"] = {125, "zma"},
	["Tablete Ulei Peste"] = {155, "uleipeste"}
}

supplements_menu = {name="Suplimente",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
gym_menu = {name="Magazin Sala",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		thePlayer = vRP.getUserSource({user_id})
		vRPCgym.populateGymTable(thePlayer, {gymTable, theGym})
	end
end)

function vRPgym.initWorkout(workout)
	thePlayer = source
	for i, v in pairs(workouts) do
		workTable = v
		for k, vl in pairs(workTable) do
			if(vl == workout)then
				vRPCgym.startWorkout(thePlayer, {i})
				break
			end
		end
	end
end

function vRPgym.gainStrenght(strenght)
	user_id = vRP.getUserId({source})
	
	local parts = splitString("physical.strength",".")
    if #parts == 2 then
        vRP.varyExp({user_id,parts[1],parts[2],tonumber(strenght)})
    end
end

function vRPgym.hasMembership()
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(user_id ~= nil)then
		if(members[user_id] == true)then
			return true
		else
			return false
		end
	end
end

function buyMembership(player, choice)
	user_id = vRP.getUserId({player})
	if(members[user_id] ~= true)then
		if(vRP.tryPayment({user_id, 1500}))then
			members[user_id] = true
			vRPclient.notify(player, {"~w~[GYM] ~g~Ai platit $1500 pentru abonament! Timp de o zi poti accesa facilitatile salii!"})
		else
			vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai destui bani pentru abonament"})
		end
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~Ai deja abonament"})
	end
	vRP.closeMenu({player})
end

function cancelMembership(player, choice)
	user_id = vRP.getUserId({player})
	if(members[user_id] == true)then
		members[user_id] = false
		vRPclient.notify(player, {"~w~[GYM] ~g~Ti-ai anulat abonamentul la sala!"})
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai abonament la sala!"})
	end
	vRP.closeMenu({player})
end

function buySupplements(player, choice)
	for i, v in pairs(supplements) do
		supplements_menu[i] = {function(player, choice) 
			user_id = vRP.getUserId({player})
			if(vRP.tryPayment({user_id, v[1]}))then
				vRPclient.notify(player, {"~w~[GYM] ~g~Ai cumparat ~y~"..i.."!"})
				vRP.giveInventoryItem({user_id,v[2],1,true})
				vRP.closeMenu({player})
			else
				vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai destui bani pentru a cumpara ~y~"..i.."!"})
			end
		end, "Pret: $"..v[1]}
	end
	vRP.openMenu({player, supplements_menu})
end

RegisterServerEvent("showGymMenu")
AddEventHandler("showGymMenu", function()
	thePlayer = source
	if(members[user_id] ~= true)then
		gym_menu["Fa-ti Abonament"] = {buyMembership, "Cumpara abonament pentru o zi<br>Pret: $1500"}
		gym_menu["Anuleaza Abonament"] = nil
	else
		gym_menu["Anuleaza Abonament"] = {cancelMembership, "Anuleaza-ti abonamentul"}
		gym_menu["Fa-ti Abonament"] = nil
	end
	gym_menu["Suplimente"] = {buySupplements, "Cumpara suplimenete"}
	vRP.openMenu({thePlayer,gym_menu})
end)
