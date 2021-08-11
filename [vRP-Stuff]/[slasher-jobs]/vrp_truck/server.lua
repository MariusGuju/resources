local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")


vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_trucker")
vRPCtruck = Tunnel.getInterface("vRP_trucker","vRP_trucker")

vRPtruck = {}
Tunnel.bindInterface("vRP_trucker",vRPtruck)
Proxy.addInterface("vRP_trucker",vRPtruck)

x, y, z = 20.78282737732,-2486.6345214844,6.0067796707154

trailerCoords = {
	[1] = {45.078811645508,-2475.0646972656,6.3240194320678, 1},
	[2] = {42.933082580566,-2476.9184570312,6.905936717987, 1},
	[3] = {41.984375,-2479.5810546875,6.9055109024048, 1},
	[4] = {40.802635192872,-2482.0200195312,5.9073495864868, 1},
	[5] = {38.894924163818,-2483.9655761718,5.9065561294556, 1}
}

trucks = {"kamaz", "k54115", "daf", "man", "haulmaster2", "nav9800", "phantom3", "ramvan","phantom", "hauler"}
trailers = {"TANKER", "TRAILERS", "TRAILERS2"}
activeDeliveries = {}

unloadLocations = {
	{"Rompetrol", 186.87092590332,6614.294921875,31.82873916626, "Combustibil", 220}, --Blaine
	{"Ferma Izvoreni", 2015.2478027344,4979.3334960938,41.288940429688, "Ingrasamant", 150}, --Ferma
	{"Pescarie Triton", 3806.3562011718,4457.3383789062,4.3696641921998, "Piese", 100}, --Iesirea inspre mare partea dreapta 
	{"Motor Wood", -577.99694824218,5325.5283203125,70.263298034668, "Unelte", 250}, -- Blaine cherestea
	{"Pestele Auriu", 1309.264038086,4328.076171875,38.1669921875, "Plase Pescuit", 130}, -- Pescarie lacul din mijloc
	{"Secret Army", -2069.2082519532,3386.5070800782,31.282091140748, "Uranium", 200}, -- Blaine cherestea
	{"Firma Constructii", 870.50927734375,2343.2783203125,51.687889099122, "Caramizi", 200}, -- Aproape de armata
	{"Los Santos Guvern", 2482.4860839844,-443.32431030274,92.992576599122, "Arme", 210}, -- facilitate secreta los santos dreapta
    {"Aeroport Trevor", 1744.2651367188,3289.7778320312,41.102840423584, "Componente Aeronautice", 180}, -- aeroport trevor 
	{"Pet Shop", 562.17309570312,2722.1853027344,42.060230255126, "Hrana Animale", 120}, -- petshop 
	{"Galerie Mall", -2318.4116210938,280.80227661132,169.467086792, "Mobila", 100}, -- mall Xtremezone 
	{"Fabrica Ciment", 1215.9357910156,1877.8912353516,78.845520019532, "Piatra", 120}, -- Fabrica de ciment la iesire din los santos
	{"Ferma Dimitri", -50.683254241944,1874.984008789,196.8624572754, "Ingrasamant", 120}, -- Langa Poacher 
	{"Penes Curcanul", -64.300018310546,6275.9194335938,31.35410118103, "Pasari Domestice", 120}, -- Langa Poacher
	{"You Tool", 2672.3757324218,3518.2490234375,52.712032318116, "Unelte", 200}, -- Paralel cu Human Labs
	{"Lance Industry", 849.52270507812,2201.7373046875,51.490081787116, "Pesticide", 160}, -- Langa constructia din mijloc
	{"Cimitir Avioane", 2333.0327148438,3137.6437988282,48.178939819336, "iese", 140}, -- 
	{"Podgoria DiPavia", -1921.7559814454,2045.240234375,140.73533630372, "Sticle", 150}, -- Podgorie 
	{"Benzinaria Seven", 2563.6311035156,419.98919677734,108.45681762696, "Combustibil", 150} --Benzinarie
}

deliveryDistances = {}

deliveryCompany = {"ACI SRL", "ACC", "EuroAcres", "EuroGoodies", "GlobeEUR", "Renar Logistik", "S.A.L S.R.L", "TE Logistica", "Tesoro Gustoso", "Tradeaux"}


AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPclient.addBlip(source,{x, y, z, 318, 3, "Logistica"})
end)

function vRPtruck.getTrucks()
	return trucks, trailers
end

function vRPtruck.finishTruckingDelivery(distance)
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	deliveryMoney = math.ceil(distance*1.2)
	vRPclient.notify(thePlayer, {"~w~[TRUCK] ~g~Ai livrat incarcatura si ai primit ~r~$"..deliveryMoney})
	vRP.giveMoney({user_id, deliveryMoney})
	updateGoalContributie = deliveryMoney / 2
	exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
	exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
end

function vRPtruck.payTrailerFine()
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(vRP.tryFullPayment({user_id, 200}))then
		vRPclient.notify(thePlayer, {"~w~[TRUCKER] ~r~Remorca a fost distrusa! Ai platit pagube de ~g~200$"})
	end
end

function vRPtruck.updateBayStats(theBay, stats)
	trailerCoords[theBay][4] = stats
end

local function takeDeliveryJob(thePlayer, theDelivery)
	lBay = 0
	for i, v in pairs(trailerCoords) do
		if(v[4] == 1)then
			lBay = i
			trailerCoords[lBay][4] = 0
			break
		end
	end
	if(lBay ~= 0)then
		vRPCtruck.spawnTrailer(thePlayer, {lBay, trailerCoords[lBay]})
		local user_id = vRP.getUserId({thePlayer})
		activeDeliveries[user_id] = unloadLocations[theDelivery]
		vRPCtruck.saveDeliveryDetails(thePlayer, {activeDeliveries[user_id]})
		vRP.closeMenu({thePlayer})
		vRPclient.notify(thePlayer, {"~w~[TRUCKER] ~g~Du-te la ~r~"..activeDeliveries[user_id][1].." ~g~pentru a livra ~r~"..activeDeliveries[user_id][5]})
	else	
		vRPclient.notify(thePlayer, {"~w~[TRUCKER] ~r~Nu sunt spatii libere pentru remorca! Asteapta putin!"})
		return
	end
end

trucker_menu = {name="Livrari Logistica",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

RegisterServerEvent("openTruckerJobs")
AddEventHandler("openTruckerJobs", function()
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	for i, v in ipairs(unloadLocations) do
		deliveryName = tostring(v[1])
		dX, dY, dZ = v[2], v[3], v[4]
		deliveryType = v[5]
		deliveryDistance = v[6]
		deliveryMoney = math.ceil(deliveryDistance*0.80)
		theCompany = deliveryCompany[math.random(1, #deliveryCompany)]
		trucker_menu[deliveryName] = {function() takeDeliveryJob(thePlayer, i) end, "Firma Logistica: <font color='yellow'>"..theCompany.."</font><br>Tip Incarcatura: <font color='red'>"..deliveryType.."</font><br>Distanta: <font color='red'>"..(deliveryDistance/1000).." KM</font><br>Plata: <font color='green'>$"..deliveryMoney.."</font>"}
	end
	vRP.openMenu({thePlayer,trucker_menu})
end)
