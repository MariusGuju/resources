vRPCsb = {}
Tunnel.bindInterface("vRP_scoreboard",vRPCsb)
Proxy.addInterface("vRP_scoreboard",vRPCsb)
vRPSsb = Tunnel.getInterface("vRP_scoreboard","vRP_scoreboard")

-- config 
local playersOnPage = 50
local maxPlayers = 256
----

local listOn = false
local Faketimer = 0

onlinePlayers = {}

ems = 0
police = 0

function vRPCsb.initJobs(theEms, thePolice)
	ems = theEms
	police = thePolice
end

function vRPCsb.initOnlinePlayers(thePlayers)
	onlinePlayers = thePlayers
end

Citizen.CreateThread(function()
	if Faketimer >= 3 then
		Faketimer = 0
	end
	local listPage = 0
	local playersOn = GetOnlinePlayers()

	SendNUIMessage({meta = 'close', maximus = maxPlayers})

	while true do
		Citizen.Wait(1)

		if IsControlJustPressed(0, 213) then -- old button (M): 244, (HOME): 213
			local players = {}

			local theCntr = 0
			local contor = 1
			local limit = playersOnPage
			SendNUIMessage({meta = 'close'})
			if listPage >= 1 and playersOn >= playersOnPage then
				contor = playersOnPage
				limit = maxPlayers
			end

			for i, v in pairs(onlinePlayers) do
				theCntr = theCntr + 1
				local goodForNow = true
				if theCntr < contor then
					goodForNow = false
				end
				if theCntr >= limit then
					goodForNow = false
				end

				if v[4] ~= nil and goodForNow then
					faction = tostring(v[1])
					isAdmin = tonumber(v[2])
					isVip = tonumber(v[3])
					playerName = tostring(v[4])
					theID = tonumber(i)
					theJob = v[6]
					if(faction == "Medici")then
						theJob = "Medic"
						r, g, b = 214, 69, 65
					elseif(faction == "Politie")then
						theJob = "Politist"
						r, g, b = 38, 103, 255
					else
						r, g, b = 255,255,255
					end
					if isVip ~= 0 then
						r, g, b = 200, 247, 197
						vipStatus = "V.I.P "..isVip
					else
						vipStatus = "Nu"
					end
					if(isAdmin ~= 0)then
						faction = "STAFF"
						r, g, b = 250, 216, 89
					end
					ore = v[5]
					level = v[7]
					table.insert(players,
					'<tr style=\"color: rgb(' .. r .. ', ' .. g .. ', ' .. b .. ')\"><td>' .. theID .. '</td><td>' .. playerName .. '</td><td>' .. faction .. '</td><td>' .. theJob .. '</td><td>' .. vipStatus .. '</td><td>' .. ore .. '</td></tr>')
				end
			end

			if playersOn >= 50 then
				listPage = listPage + 1
			else
				listPage = listPage + 3
			end	

			if Faketimer >= 2 then
				playersOn = GetOnlinePlayers()
				SendNUIMessage({ text = table.concat(players),
					ems = ems, 
					police = police,
					mechanic = mechanic,
					uber = uber,
					spelare = playersOn,
					thePage = listPage
				})
				Faketimer = 0
			else
				SendNUIMessage({ text = table.concat(players), thePage = listPage})
				Faketimer = 0
			end
			Citizen.Wait(300)
			while listPage >= 2 do
				Citizen.Wait(1)
				if(IsControlJustPressed(0, 213)) then
					listPage = 0
					SendNUIMessage({
						meta = 'close'
					})
					break
				end
			end
			Citizen.Wait(300)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		Faketimer = Faketimer + 1
	end
end)

function GetOnlinePlayers()
	local players = 0

	for i = 0, 128 do
		if NetworkIsPlayerActive(i) then
			players = players + 1
		end
	end

	return tonumber(players)
end
