--[[
		 The script is releases for free
		 This is a Youtuber Menu with only Permission
		 Author:ZED#1337
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPyt = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","all_sla")
BMclient = Tunnel.getInterface("all_sla","all_sla")
Tunnel.bindInterface("all_sla",vRPyt)
Proxy.addInterface("all_sla",vRPyt)
vRPCyoutuber = Tunnel.getInterface("all_sla", "all_sla")

ytUtils = {}
ytCars = {}
ytTags = {}

local function yt_fixCar(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~y~[Meniu] ~g~Ti-ai reparat vehiculul!"})
	else
		vRPclient.notify(player, {"~y~[Meniu] ~r~Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
		return
	end
end

local function yt_rev(player, choice)
	user_id = vRP.getUserId({player})
		vRPclient.isInComa(player,{}, function(in_coma)
			if in_coma then
				vRPclient.varyHealth(player,{100}) 
				SetTimeout(1000, function()
					vRPclient.varyHealth(player,{100})
			end)
				vRPclient.notify(player,{"~r~[Meniu]~g~Ai primit revive!"})
		else
				vRPclient.notify(player,{"~r~[Meniu] ~r~Nu esti mort!"})
		end
	end)
end

local function yt_revive(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		vRP.varyThirst({user_id, -100})
		vRP.varyHunger({user_id, -100})
		SetTimeout(500, function()
			vRPclient.varyHealth(player,{200})
			vRP.varyThirst({user_id, -100})
			vRP.varyHunger({user_id, -100})
		end)
		TriggerClientEvent('chatMessage', -1, "^7 Jucatorul ^1"..GetPlayerName(player).."["..user_id.."]^7 si-a dat revive din Meniul Special!")
		vRPclient.notify(player, {"~y~[Meniu] ~g~Acum ai viata full!"})
	else
		vRPclient.notify(player, {"~y~[Meniu] ~r~Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
		return
	end
end

local function sp_skyfall(player, choice)
	local user_id = vRP.getUserId({player})
	local source = vRP.getUserSource({user_id})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		TriggerClientEvent('Skyfall:DoFall', source)
		vRPclient.notify(source, {"~y~[Meniu] ~g~Ai grija sa activezi parasuta!"})
	else
		vRPclient.notify(source, {"~y~[Meniu] ~r~Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
	end
end

local function yt_weapons(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_COMBATPISTOL"] = {ammo=100},
			["WEAPON_ASSAULTSMG"] = {ammo=200},
			["WEAPON_MACHETE"] = {ammo=1},
			["WEAPON_MG"] = {ammo=100}
		}})
		vRPclient.notify(player, {"~y~[Meniu] ~g~Ai primit un pachet cu arme!"})
	else
		vRPclient.notify(player, {"~y~[Meniu] ~r~Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
		return
	end
end
local function sponsor_weapons(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_COMBATPISTOL"] = {ammo=100},
			["WEAPON_ASSAULTSMG"] = {ammo=200},
			["WEAPON_MACHETE"] = {ammo=1},
			["WEAPON_SPECIALCARBINE"] = {ammo=200},
			["WEAPON_MG"] = {ammo=100}
		}})
		vRPclient.notify(player, {"~y~[Meniu] ~g~Ai primit un pachet cu arme!"})
	else
		vRPclient.notify(player, {"~y~[Meniu] ~r~Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
		return
	end
end

local function spGhost_weapons(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_ASSAULTRIFLE"] = {ammo=200},
			["WEAPON_PISTOL50"] = {ammo=200},
			["WEAPON_KNIFE"] = {ammo=1},
		}})
		vRPclient.notify(player, {"~r~[GHOST MENU] ~g~Ai primit pachetul de arme!"})
	else
		vRPclient.notify(player, {"~r~[GHOST MENU] ~r~ Asteapta 1 minut pentru a-ti reincarca abilitatea!"})
		return
	end
end

local function sp_VIPweaponsVaslui(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_BAT"] = {ammo=1},
			["WEAPON_KNIFE"] = {ammo=1},
		}})
		vRPclient.notify(player, {"~g~[Vaslui Edition] ~w~Pregateste sabia si calul!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
		return
	end
end

local function yt_ChildSkin(player, choice)
	BMclient.setYoutuberSkin(player,{4})
end

local function yt_blackracerSkin(player, choice)
	BMclient.setGimiSkin(player,{4})
end

local function yt_ytawnCar(player, choice)
	BMclient.spawnYoutuberCar(player, {})
end

local function sp_spawnheli(player, choice)
	BMclient.spawnHeli(player, {})
end


vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.hasGroup({user_id, "youtuber"}) then
			choices["🎥Youtuber Menu🎥"] = {function(player,choice)
				vRP.buildMenu({"🎥Youtuber Menu🎥", {player = player}, function(menu)
					menu.name = "🎥Youtuber Menu🎥"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["Fix ~ Masina"] = {yt_fixCar,"🔧 > Repara-ti masina"}
					menu["Primeste Mancare&Viata"] = {yt_revive,"🏥 > Da-ti apa&mancare full"}
					menu["YouTuber Revive"] =  {yt_rev,"🔮 > Da-ti revive"}
					menu["Pachet cu arme"] = {yt_weapons,"🔫 > Primeste un pachet cu Arme"}
					menu["YouTuber ~ Masina"] = {yt_ytawnCar,"🏎️ > Primeste masina de YouTuber"}
					--[[menu["Black Racer"] = {yt_blackracerSkin,"💥 > Change the text with your description</br>(Change the text with your description)"}
					menu["Child Skin"] = {yt_ChildSkin,"👶🏻 > Change the text with your description</br>(Change the text with your description)"}]]
					vRP.openMenu({player,menu})
				end})
			end, "🎥Facilitati YouTuber🎥"}
		elseif vRP.hasGroup({user_id, "sponsor"}) then
			choices["💎Sponsor Menu💎"] = {function(player,choice)
				vRP.buildMenu({"💎Sponsor Menu💎", {player = player}, function(menu)
					menu.name = "💎Sponsor Menu💎"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["Fix ~ Masina"] = {yt_fixCar,"🔧 > Repara-ti masina"}
					menu["Sky Fall"] = {sp_skyfall,"☁️ > Arunca-te cu parasuta"}
					menu["Primeste Mancare&Viata"] = {yt_revive,"🏥 > Da-ti apa&mancare full"}
					menu["Revive"] =  {yt_rev,"🔮 > Da-ti revive"}
					menu["Pachet cu arme"] = {sponsor_weapons,"🔫 > Primeste un pachet cu Arme"}
					menu["Masina Sponsor"] = {yt_ytawnCar,"🏎️ > Primeste masina de Sponsor"}
					menu["Elicopter Sponsor"] = {sp_spawnheli,"🏎️ > Spawneaza elicopter"}
					--[[menu["Black Racer"] = {yt_blackracerSkin,"💥 > Change the text with your description</br>(Change the text with your description)"}
					menu["Child Skin"] = {yt_ChildSkin,"👶🏻 > Change the text with your description</br>(Change the text with your description)"}]]
					vRP.openMenu({player,menu})
				end})
			end, "🎥Facilitati sponsor🎥"}
		elseif vRP.hasGroup({user_id, "pachetarme"}) then
			choices["Ghost Pack"] = {function(player,choice)
				vRP.buildMenu({"Ghost Pack", {player = player}, function(menu)
					menu.name = "Ghost Pack"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["🔫Poc Poc🔫"] = {spGhost_weapons,"🔫 > Avere la Ghost!"}
					vRP.openMenu({player,menu})
				end})
			end, "💸Ghost Premium💸"}
		elseif vRP.hasGroup({user_id, "nitrobooster"}) then
			choices["Booster Pack"] = {function(player,choice)
				vRP.buildMenu({"Booster Pack", {player = player}, function(menu)
					menu.name = "Booster Pack"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["💎Refa Mancare&Apa💎"] = {yt_revive,"🌊🍔 > Refati Mancarea + Apa Boost"}
					menu["💎Booster Car💎 "] = {yt_ytawnCar,"💎 > Spawneaza Masina pentru Nitro Boost"}
					vRP.openMenu({player,menu})
				end})
			end, "💎Booster Pack💎"}
		elseif vRP.hasPermission({user_id, "vip1.masini"}) then
			choices["VIP Menu"] = {function(player,choice)
				vRP.buildMenu({"VIP Menu", {player = player}, function(menu)
					menu.name = "VIP Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					if vRP.hasPermission({user_id,"vip3.masini"}) then
						menu["Fix ~ Masina"] = {yt_fixCar,"🔧 > Repara-ti masina"}
					end
					if vRP.hasPermission({user_id, "vip2.masini"}) then
						menu["🍔Refa Mancare&Apa🌊"] = {yt_revive,"🌊🍔 > Refati Mancarea + Apa VIP"}
						menu["Revive"] =  {yt_rev,"🔮 > Da-ti revive"}
					end
					if vRP.hasPermission({user_id, "vip1.masini"}) then
						menu["☁️Sky Fall☁️"] = {sp_skyfall,"☁️ > Arunca-te cu parasuta"}
						menu["🔧Vaslui Edition🔧"] = {sp_VIPweaponsVaslui,"🔧 >  Pregateste sabia si calul, mergem in Vaslui"}
					end
					vRP.openMenu({player,menu})
				end})
			end, "💸VIP Menu💸"}
		end
		add(choices)
	end
end})

function vRPyt.denyYoutuberCarDriving()
	user_id = vRP.getUserId({source})
	if not(vRP.hasGroup({user_id, "youtuber"}))then
		BMclient.denyYoutuberCarDriving(source, {})
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasGroup({i, "youtuber"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[YouTuber] ~b~Acum poti folosi facilitatile de YouTuber!"})
			elseif(vRP.hasGroup({i, "sponsor"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[Sponsor] ~b~Acum poti folosi facilitatile de Sponsor!"})
			elseif(vRP.hasGroup({i, "nitrobooster"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[Nitro] ~b~Acum poti folosi facilitatile de NitroBooster!"})
			elseif(vRP.hasGroup({i, "pachetarme"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[GhostPack] ~b~Acum poti folosi facilitatile pachetului cu Arme!"})
			elseif(vRP.hasGroup({i, "vip1"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[VIP] ~b~Acum poti folosi facilitatile de VIP1!"})
			elseif(vRP.hasGroup({i, "vip2"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[VIP] ~b~Acum poti folosi facilitatile de VIP2!"})
			elseif(vRP.hasGroup({i, "vip3"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[VIP] ~b~Acum poti folosi facilitatile de VIP3!"})
			elseif(vRP.hasGroup({i, "vip4"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[VIP] ~b~Acum poti folosi facilitatile de VIP4!"})
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if(ytCars[user_id] ~= nil)then
		BMclient.deleteYoutuberCar(-1, {ytCars[user_id]})
		ytCars[user_id] = nil
	end
	if(ytTags[user_id] ~= nil)then
		ytTags[user_id] = nil
	end
end)

RegisterNetEvent("baseevents:enteringVehicle")
AddEventHandler("baseevents:enteringVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "e63amg")then
		if not(vRP.hasGroup({user_id, "youtuber"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Youtuber] ~w~Nu conduci o masina de  ~r~Youtuber"})
		end
	elseif(theSeat == -1) and (vehicleName == "e63amg")then
		if not(vRP.hasGroup({user_id, "sponsor"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Sponsor] ~w~Nu conduci o masina de  ~r~Sponsor"})
		end
	end
end)

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "e63amg")then
		if not(vRP.hasGroup({user_id, "youtuber"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Youtuber] ~w~Nu conduci o masina de  ~r~Youtuber"})
		end
	elseif(theSeat == -1) and (vehicleName == "e63amg")then
		if not(vRP.hasGroup({user_id, "sponsor"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Sponsor] ~w~Nu conduci o masina de  ~r~Sponsor"})
		end
	end
end)

SetGameType("Hard RolePlay")