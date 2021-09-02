local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPSsb = {}
Tunnel.bindInterface("vRP_scoreboard",vRPSsb)
Proxy.addInterface("vRP_scoreboard",vRPSsb)

vRPCsb = Tunnel.getInterface("vRP_scoreboard","vRP_scoreboard")

onlinePlayers = {}

ems = 0
police = 0
fbi = 0
hitman = 0
uber = 0
curve = 0
mechanic = 0

function initPlayer(thePlayer, user_id)
	faction = "Civil"
	isAdmin = 0
	local isVip = 0
	playerName = "Nume"

	local thePlayer = vRP.getUserSource({user_id})
	
	if(vRP.hasGroup({user_id,"fondator"}) or vRP.hasGroup({user_id,"dev"}) or vRP.hasGroup({user_id,"helper"}) or vRP.hasGroup({user_id,"Co-Fondator"}) or vRP.hasGroup({user_id,"moderator"}) or vRP.hasGroup({user_id,"moderator"}) or vRP.hasGroup({user_id,"trialhelper"}) or vRP.hasGroup({user_id,"Head Of Staff"}) or vRP.hasGroup({user_id,"admin"}) or vRP.hasGroup({user_id,"admin"}))then
		isAdmin = 1
	end

	if(vRP.hasGroup({user_id,"vip1"}))then
		isVip = 1
	elseif(vRP.hasGroup({user_id,"vip2"}))  then
		isVip = 2
	elseif(vRP.hasGroup({user_id,"vip3"}))  then
		isVip = 3
	elseif(vRP.hasGroup({user_id,"vip4"})) then
		isVip = 4
	end
	if vRP.hasGroup({user_id,"ems"}) then
		faction = "Medici"
		ems = ems + 1
	elseif vRP.hasGroup({user_id,"cop"}) then
		faction = "Politie"
		police = police + 1
	end
	
	playerName = vRP.getPlayerName({thePlayer})
	
	if(playerName)then
		if(string.len(playerName)>14)then
			newPlayerName = ""
			for i = 1, string.len(playerName) do
				if(i <= 14)then
					newPlayerName = newPlayerName..string.sub(playerName, i, i)
				end
			end
			playerName = newPlayerName.."..."
		end
	end

	
	job = vRP.getUserGroupByType({user_id, "job"})
	if job == nil or job == "" then
		job = "Somer"
	end
	ore = vRP.getUserHoursPlayed({user_id})
	onlinePlayers[user_id] = {tostring(faction), tonumber(isAdmin), tonumber(isVip), tostring(playerName),tonumber(ore), tostring(job)}
	
	vRPCsb.initJobs(-1, {ems, police})
	vRPCsb.initOnlinePlayers(-1, {onlinePlayers})
end


function uninitPlayer(user_id, thePlayer)
	if vRP.hasGroup({user_id,"ems"}) then
		ems = ems - 1
	elseif vRP.hasGroup({user_id,"cop"}) then
		police = police - 1
	end
	
	vRPCsb.initJobs(-1, {ems, police})
	
	onlinePlayers[user_id] = nil
	vRPCsb.initOnlinePlayers(-1, {onlinePlayers})
end

local function fixScoreBoard()
	onlinePlayers = {}
	ems = 0
	police = 0
	users = vRP.getUsers({})
	for i, v in pairs(users) do
		thePlayer = v
		user_id = tonumber(i)

		if vRP.getPlayerName({thePlayer}) ~= "unknown" and vRP.getPlayerName({thePlayer}) ~= "Username" and vRP.getPlayerName({thePlayer}) then
			initPlayer(thePlayer, user_id)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		fixScoreBoard()
		Citizen.Wait(5 * 60 * 1000)
	end
end)

RegisterCommand("fixscoreboard", function() fixScoreBoard() end)


AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	initPlayer(source, user_id)
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if onlinePlayers[user_id] ~= nil then
		uninitPlayer(user_id, source)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		fixScoreBoard()
	end
end)