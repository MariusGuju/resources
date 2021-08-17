
vRPfpc = {}
Tunnel.bindInterface("all_sla",vRPfpc)
vRPserver = Tunnel.getInterface("vRP","all_sla")
BMserver = Tunnel.getInterface("all_sla","all_sla")
vRP = Proxy.getInterface("vRP")

isBlipDrawn = false
waypointBlip = nil
targetPlayer = nil

function drawRouteToPlayer()
	if (isBlipDrawn == false) then
		isBlipDrawn = true
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(targetPlayer), false))
		if(waypointBlip)then
			RemoveBlip(waypointBlip)
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		else
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		end
	else
		vRP.notify({"~w~[FIND] ~r~Markerul jucatorului ~w~"..GetPlayerName(targetPlayer).." ~r~a fost scos de pe harta"})
		isBlipDrawn = false
		SetWaypointOff()
		RemoveBlip(waypointBlip)
		waypointBlip = nil
		targetPlayer = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if(targetPlayer)then
			isBlipDrawn = false
			drawRouteToPlayer()
		end
	end
end)

RegisterNetEvent('findPlayerOnMap')
AddEventHandler('findPlayerOnMap', function(target)
	for i = 0,256 do
		if NetworkIsPlayerConnected(i) then
			local serverID = GetPlayerServerId(i)
			if(serverID == target)then
				targetPlayer = i
			end
		end
	end
	drawRouteToPlayer()
	vRP.notify({"~w~[FIND] ~g~Jucatorul ~r~"..GetPlayerName(targetPlayer).." ~g~a fost marcat pe harta"})
end)

RegisterNetEvent('cancelPlayerTracking')
AddEventHandler('cancelPlayerTracking', function()
	isBlipDrawn = true
	drawRouteToPlayer()
end)