local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_drugs")

comandaDeal = {}

droga = {
	["erva"] = {
		gather = false,
		processing = false,
	},	
	["metanfetamina"] = {
		gather = false,
		processing = false,
	},	
	["coca"] = {
		gather_1 = false,
		gather_2 = false,
		gather_3 = false,
		gather_4 = false,
		gather_5 = false,
		gather_6 = false,
		processing = false,
	},
}
--Weed
RegisterServerEvent('vrp_drug:apanhar_erva')
AddEventHandler('vrp_drug:apanhar_erva', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
		TriggerClientEvent("vrp_drug:apanhar_erva_c",source)
		droga["erva"].gather = true
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	else
		vRPclient.notify(player,{"~r~Inventarul este plin"})
	end
end)
RegisterServerEvent('vrp_drug:apanhar_erva_finish')
AddEventHandler('vrp_drug:apanhar_erva_finish', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if vRP.tryFullPayment({user_id,30}) then -- aici platesti cand culegi iarba
		if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
			vRP.giveInventoryItem({user_id,"iarba",1,true})
			droga["erva"].gather = false
			TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
		else
			vRPclient.notify(player,{"~r~Inventarul este plin"})
		end
	else
		vRPclient.notify(player,{"Nu ai bani sa platesti pentru culesul ierbii"})
	end
end)
RegisterServerEvent('vrp_drug:processar_erva')
AddEventHandler('vrp_drug:processar_erva', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryGetInventoryItem({user_id,"iarba",5,true}) then
		TriggerClientEvent("vrp_drug:processar_erva_c",source)
		droga["erva"].processing = true
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	else
		vRPclient.notify(player,{"Nu ai destula iarba pentru a face un stash intreg"})
	end
end)
RegisterServerEvent('vrp_drug:processar_erva_finish')
AddEventHandler('vrp_drug:processar_erva_finish', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRP.giveInventoryItem({user_id,"stack_iarba",1,true})
	droga["erva"].processing = false
	TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
end)
--COCAINA
RegisterServerEvent('vrp_drug:apanhar_cocaina')
AddEventHandler('vrp_drug:apanhar_cocaina', function(x,y,z,heading,gather)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
		TriggerClientEvent("vrp_drug:apanhar_cocaina_c",source,x,y,z,heading,gather)
		if gather == 1 then
			droga["coca"].gather_1 = true
		elseif gather == 2 then
			droga["coca"].gather_2 = true
		elseif gather == 3 then
			droga["coca"].gather_3 = true
		elseif gather == 4 then
			droga["coca"].gather_4 = true
		elseif gather == 5 then
			droga["coca"].gather_5 = true
		elseif gather == 6 then
			droga["coca"].gather_6 = true
		end
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	else
		vRPclient.notify(player,{"~r~Inventarul este plin"})
	end
end)
RegisterServerEvent('vrp_drug:apanhar_cocaina_finish')
AddEventHandler('vrp_drug:apanhar_cocaina_finish', function(gather)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if vRP.tryFullPayment({user_id,100}) then -- aici platesti cand faci coca
		if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
			vRP.giveInventoryItem({user_id,"cocaina",1,true})
			if gather == 1 then
				droga["coca"].gather_1 = false
			elseif gather == 2 then
				droga["coca"].gather_2 = false
			elseif gather == 3 then
				droga["coca"].gather_3 = false
			elseif gather == 4 then
				droga["coca"].gather_4 = false
			elseif gather == 5 then
				droga["coca"].gather_5 = false
			elseif gather == 6 then
				droga["coca"].gather_6 = false
			end
			TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
		else
			vRPclient.notify(player,{"~r~Inventarul este plin"})
		end
	else
		vRPclient.notify(player,{"Nu ai destui bani sa faci cocaina"})
	end
end)
RegisterServerEvent('vrp_drug:processar_cocaina')
AddEventHandler('vrp_drug:processar_cocaina', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryGetInventoryItem({user_id,"cocaina",5,true}) then
		TriggerClientEvent("vrp_drug:processar_cocaina_c",source)
		droga["coca"].processing = true
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	end
end)
RegisterServerEvent('vrp_drug:processar_cocaina_finish')
AddEventHandler('vrp_drug:processar_cocaina_finish', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRP.giveInventoryItem({user_id,"stack_cocaina",1,true})
	droga["coca"].processing = false
	TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
end)
--Metanfetamina
RegisterServerEvent('vrp_drug:apanhar_metanfetamina')
AddEventHandler('vrp_drug:apanhar_metanfetamina', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
		TriggerClientEvent("vrp_drug:apanhar_metanfetamina_c",source)
		droga["metanfetamina"].gather = true
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	else
		vRPclient.notify(player,{"~r~Inventarul este plin"})
	end
end)
RegisterServerEvent('vrp_drug:apanhar_metanfetamina_finish')
AddEventHandler('vrp_drug:apanhar_metanfetamina_finish', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id}) + 5
	if vRP.tryFullPayment({user_id,75}) then -- aici platesti cand faci methj
		if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
			vRP.giveInventoryItem({user_id,"metanfetamina",1,true})
			droga["metanfetamina"].gather = false
			TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
		else
			vRPclient.notify(player,{"~r~Inventarul este plin"})
		end
	else
		vRPclient.notify(player,{"Nu ai destui bani pentru a face meth"})
	end
end)
RegisterServerEvent('vrp_drug:processar_metanfetamina')
AddEventHandler('vrp_drug:processar_metanfetamina', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryGetInventoryItem({user_id,"metanfetamina",5,true}) then
		TriggerClientEvent("vrp_drug:processar_metanfetamina_c",source)
		droga["metanfetamina"].processing = true
		TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
	end
end)
RegisterServerEvent('vrp_drug:processar_metanfetamina_finish')
AddEventHandler('vrp_drug:processar_metanfetamina_finish', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRP.giveInventoryItem({user_id,"stack_metanfetamina",1,true})
	droga["metanfetamina"].processing = false
	TriggerClientEvent("vrp_drug:updatelist",(-1),droga)
end)
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	TriggerClientEvent("vrp_drug:updatelist",source,droga)
end)


local LocatiiSellStash = {
    {1,1395.3154296875,3623.6953125,35.012157440186,status = true},
    {2,1436.1826171875,3639.0786132813,34.947284698486,status = false},
    {3,1514.7225341797,3784.7663574219,34.468097686768,status = false},
    {4,1693.9465332031,3785.0849609375,34.767608642578,status = false},
    {5,1871.0991210938,3750.1525878906,32.998683929443,status = false},
    {6,1963.5668945313,3749.640625,32.262294769287,status = false},
    {7,1897.4301757813,3731.6948242188,32.78475189209,status = false},
    {8,1667.9344482422,3744.3215332031,35.003837585449,status = false},
    {9,1838.6459960938,3907.56640625,33.461124420166,status = false},
    {10,1894.3627929688,3896.06640625,33.190536499023,status = false}
}
local LocatiiSellNormale = {
    {1,224.0428314209,513.67547607422,140.76696777344,status = true},
    {2,167.44122314453,473.69049072266,142.51327514648,status = false},
    {3,-119.88179779053,494.51669311523,147.34295654297,status = false},
    {4,-7.7511568069458,467.77310180664,145.84489440918,status = false},
    {5,-110.25408172607,501.96243286133,143.4787902832,status = false},
    {6,-348.86141967773,515.07165527344,120.64653015137,status = false},
    {7,-386.81686401367,504.16564941406,120.41269683838,status = false},
    {8,-406.67330932617,567.744140625,124.60092163086,status = false},
    {9,-459.07269287109,537.02203369141,121.46044921875,status = false},
    {10,-474.35549926758,585.93267822266,128.68385314941,status = false},
    {11,-495.84729003906,738.70599365234,163.03103637695,status = false},
    {12,-559.80853271484,662.88635253906,145.48287963867,status = false},
    {13,-544.8388671875,694.57141113281,146.07447814941,status = false},
    {14,-595.70947265625,667.08746337891,151.03672790527,status = false},
    {15,-700.88537597656,647.03204345703,155.37524414063,status = false},
    {16,-661.77575683594,678.94519042969,153.91053771973,status = false},
    {17,-765.6962890625,650.55334472656,145.69924926758,status = false},
    {18,-819.61224365234,696.51141357422,148.10981750488,status = false},
    {19,-951.21588134766,682.54064941406,153.57803344727,status = false},
    {20,-1032.7357177734,686.02520751953,161.30293273926,status = false}
}
local transport = false
local drogurivandute = 0
local totaldroguri = 5
local droguriramase = totaldroguri - drogurivandute

RegisterCommand("deal", function(source)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({user_id})
	local oreramase = 40 
	--print('test: '..ore)
	if(comandaDeal[user_id] ~= true) then
		comandaDeal[user_id] = true
		--if transport == false then
			vRPclient.eskNotify(player,{"~w~Vinde droguri! Ai grija la politisti!",8000})
			if ore <= 20 then
				vRPclient.notify(player,{"~w~Pentru a vinde Stack-uri trebuie sa ai ~g~"..oreramase.." de ore!"})				
			end
			vRP.buildMenu({"Vinde Droguri", {user_id = user_id, player = player}, function(menu)
				menu.name="Vinde Droguri"
				menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

				menu1 = "Vinde Iarba"
				menu2 = "Vinde Cocaina"
				menu3 = "Vinde metanfetamina"
				menu4 = "Vinde Stash de iarba"
				menu5 = "Vinde Stash de cocaina"
				menu6 = "Vinde Stash de metanfetamina"

				menu[menu1] = {function(player,choice) vindeGrame(player,"iarba") end, "Vinde cateva grame de iarba"}
				menu[menu2] = {function(player,choice) vindeGrame(player,"cocaina") end, "Vinde cateva grame de cocaina"}
				menu[menu3] = {function(player,choice) vindeGrame(player,"metanfetamina") end, "Vinde cateva grame de metanfetamina"}

				if (ore >= 40) then
					menu[menu4] = {function(player,choice) vindeStash(player,"stack_iarba") end, "Vinde stash de iarba"}
					menu[menu5] = {function(player,choice) vindeStash(player,"stack_cocaina") end, "Vinde stash de cocaina"}
					menu[menu6] = {function(player,choice) vindeStash(player,"stack_metanfetamina") end, "Vinde stash de metanfetamina"}
				end

				
				
				vRP.openMenu({player,menu})
				
				function vindeGrame(player,item)
					vRP.closeMenu({player})
					ceTrbSaVand = item
					transport = true
					vRPCeskJobs.duDroguri(source,{LocatiiSellNormale,ceTrbSaVand})
					vRPclient.eskNotify(player,{"~w~[ ~b~?~w~ ] ASA ARATA ~b~[ ~w~LS~b~ ]~w~ ",7000})
					vRPclient.eskNotify(player,{"Du-te la markerele marcate pe harta pentru a livra "..item.."!",7000})

				end
				function vindeStash(player,item)
					vRP.closeMenu({player})
					transport = true
					ceTrbSaVand = item
					vRPCeskJobs.duDroguriStash(source,{LocatiiSellStash,ceTrbSaVand})
					vRPclient.eskNotify(player,{"~w~[ ~b~?~w~ ] ASA ARATA ~b~[ ~w~SANDY~b~ ]~w~",7000})
					vRPclient.eskNotify(player,{"Du-te la markerele marcate pe harta pentru a livra "..item.."!",7000})
					--if vRP.tryGetInventoryItem({user_id,item,1}) then
					--end
				end

			end})
		--else
		--	vRPclient.notify(player,{"Du transportul prima data!"})
		--end
	else 
		vRPclient.notify(player, {"~y~[DrugDeal] ~r~Asteapta un minute pentru a folosi comanda din nou!"})
	end	
end)



local preturi = {
	{"iarba",75000},
	{"stack_iarba",400000},
	{"cocaina",85000},
	{"stack_cocaina",420000},
	{"metanfetamina",80000},
	{"stack_metanfetamina",410000}
}

function vRPeskJobs.checkDrugs(item)
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id}) 
	for k, v in pairs (preturi) do
		if v[1] == item then
			if vRP.tryGetInventoryItem({user_id,item,1,true}) then
				vRP.giveMoney({user_id,v[2]})
				vRPclient.eskNotify(player,{"Ai vandut cu succes ~p~".. item.. "~w~ pe ~g~$"..v[2],8000})
				vRPclient.eskNotify(player,{"~b~[~w~INFO~b~]~w~ Trebuie sa te duci la alta locatie",8000})
			else
				vRPclient.eskNotify(player,{"Vanzarea s-a oprit din cauza ca nu mai ai item necesar!",8000})
				vRPCeskJobs.stopSelling(player,{})
				transport = false
			end
		end
	end
end

RegisterCommand("stopdeal", function(source)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if(comandaDeal[user_id] ~= true) then
		comandaDeal[user_id] = true
		vRPclient.eskNotify(player,{"Ai oprit vanzarea",8000})
		vRPCeskJobs.stopSelling(source,{})
		transport = false
	else
		vRPclient.notify(player, {"~y~[DrugDeal] ~r~Asteapta un minute pentru a folosi comanda din nou!"})
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(comandaDeal[i] == true)then
				comandaDeal[i] = nil
				vRPclient.notify(v, {"~y~[DrugDeal] ~b~Acum poti folosi comanda!"})
			end
		end
	end
end)