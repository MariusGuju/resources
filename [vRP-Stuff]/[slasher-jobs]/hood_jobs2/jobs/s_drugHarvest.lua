local harvestField = {2534.0642089844,4817.8110351562,34.034660339356}
local seedSellerPed = {2439.1042480468,4974.2548828125,50.5648727417,224.52505493164}

local sellDrugs = {84.215789794922,-1966.7648925782,20.93917274475}

local drugsToGive = {"drug_cansativa", "drug_cocaalka", "drug_unprocpcp", "drug_lyseracid"}

local drugsToSell = {
	["Cocaina"] = {
		itemName = "cocaine", 
		price = 750,
		materials = {
			["drug_cansativa"] = 3,
			["drug_cocaalka"] = 4,
			["water"] = 1
		}
	},
	["PCP"] = {
		itemName = "pcp", 
		price = 420,
		materials = {
			["drug_lyseracid"] = 2,
			["drug_unprocpcp"] = 3,
			["water"] = 1
		} 
	},
	["LSD"] = {
		itemName = "lsd", 
		price = 300, 
		materials = {
			["drug_lyseracid"] = 2,
			["drug_cocaalka"] = 1,
			["water"] = 1
		} 
	},
	["Amphetamina"] = {
		itemName = "amphetamine", 
		price = 200,
		materials = {
			["drug_lyseracid"] = 1,
			["drug_cansativa"] = 1,
			["water"] = 1
		} 
	},
	["Subutex"] = {
		itemName = "subutex", 
		price = 250,
		materials = {
			["amphetamine"] = 2,
			["drug_unprocpcp"] = 1,
			["water"] = 2
		} 
	},
	["Marijuana"] = {
		itemName = "weed", 
		price = 150,
		materials = {
			["drug_cansativa"] = 1
		} 
	}
	--[[
	["Heroina"] = {
		itemName = "heroine", 
		price = 23000,
		materials = {
			["cocaine"] = 1,
			["drug_unprocpcp"] = 2,
			["drug_lyseracid"] = 1,
			["amphetamine"] = 1,
			["water"] = 2
		} 
	},
	["GHB"] = {
		itemName = "ghb", 
		price = 14000,
		materials = {
			["subutex"] = 1,
			["drug_cansativa"] = 1,
			["drug_lyseracid"] = 1,
			["water"] = 1
		} 
	},
	["Morphina"] = {
		itemName = "morphine", 
		price = 9200,
		materials = {
			["amphetamine"] = 3,
			["drug_cansativa"] = 1,
			["water"] = 2
		} 
	},
	["DMT"] = {
		itemName = "dmt", 
		price = 25000,
		materials = {
			["heroine"] = 1,
			["amphetamine"] = 2,
			["water"] = 1
		} 
	},
	["Ulei THC"] = {
		itemName = "thc", 
		price = 6700,
		materials = {
			["drug_cansativa"] = 3,
			["drug_cocaalka"] = 2,
			["water"] = 1
		} 
	}
	--]]
}

local seedSeller_menu = {name="Seminte",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local drugSell_menu = {name="Vinde Droguri",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local drugCreate_menu = {name="Creaza Droguri",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

function vRPjobs.plantDrugSeed(thePlayer)
	vRPCjobs.plantSeed(thePlayer, {})
end

function vRPjobs.executePlanting()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if vRP.tryGetInventoryItem({user_id,"drug_seeds",1,false}) then
		vRPclient.notify(thePlayer, {"~g~Ai plantat o samanta! Asteapta sa creasca pentru a vedea ce este!"})
	end
end

function vRPjobs.openChemSet(thePlayer)
	vRP.closeMenu({thePlayer})
	SetTimeout(250, function()
		vRP.openMenu({thePlayer, drugCreate_menu})
	end)
end

function vRPjobs.harvestDrugPlant()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local drug = drugsToGive[math.random(#drugsToGive)]
	local drugNum = math.random(1, 3)
	vRP.giveInventoryItem({user_id,drug,drugNum,false})
	vRPclient.notify(thePlayer, {"~g~Ai cules planta si ai primit ~y~"..drugNum.." "..vRP.getItemName({drug})})
end

function vRPjobs.hasMaterialsForDrug(thePlayer, drug)
	local hasAllMaterials = 0
	local user_id = vRP.getUserId({thePlayer})	
	
	local theI = 0
	for i, v in pairs(drugsToSell[drug].materials) do
		amount = tonumber(v)
		idname = tostring(i)
		theI = theI + 1
		if(vRP.getInventoryItemAmount({user_id,idname}) >= amount)then
			hasAllMaterials = hasAllMaterials + 1
		end
	end	
	if(hasAllMaterials == theI)then
		return true
	else
		return false
	end
	return false
end

for i, v in pairs(drugsToSell) do
	drugSell_menu["Vinde "..i] = {function(player, choice)
		local user_id = vRP.getUserId({player})
		vRP.prompt({player, "Cata vrei sa vinzi?", "", function(player,drugs)
			drugs = parseInt(drugs)
			if drugs > 0 then
				local totalCost = drugs * v.price
				if vRP.tryGetInventoryItem({user_id,v.itemName,drugs,false}) then
					vRP.giveMoney({user_id, totalCost})
					vRPclient.notify(player, {"~g~Ai vandut ~y~"..drugs.." "..i.." ~g~pentru ~r~$"..totalCost})
				else
					vRPclient.notify(player, {"~r~Nu ai destul/a ~y~"..i})
				end
			end
		end})
	end, "<img src='nui://vrp/gui/items/"..v.itemName..".png' height='70' width='70'><br><u>"..i.."</u><br><br>Pret: <font color='green'>$"..v.price.."</font>"}
end

for i, v in pairs(drugsToSell) do
	local drugDesc = "<img src='nui://vrp/gui/items/"..v.itemName..".png' height='70' width='70'><br><u>"..i.."</u><br><br>"
	for index, value in pairs(v.materials) do
		drugDesc = drugDesc..""..vRP.getItemName({index})..": <font color='red'>"..value.."</font><br>"
	end
	drugCreate_menu[i] = {function(player, choice)
		local user_id = vRP.getUserId({player})
		local drugRand = math.random(1,5)
		if(vRPjobs.hasMaterialsForDrug(player, i))then
			local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({v.itemName})
			if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
				for ie, ve in pairs(v.materials) do
					vRP.tryGetInventoryItem({user_id,ie,ve,true})
				end
				if(drugRand == 1)then
					vRP.tryGetInventoryItem({user_id,"chem_set",1,true})
					vRPclient.notify(player, {"~r~Ai amestecat ceva gresit iar setul de chimie a explodat!"})
				else
					vRP.giveInventoryItem({user_id,v.itemName,1,false})
					vRPclient.notify(player, {"~g~Ai reusit sa faci ~y~"..i})
				end
			end
		else
			vRPclient.notify(player, {"~r~Nu ai destule materiale pentru a face ~y~"..i})
		end
		vRP.closeMenu({player})
	end, drugDesc}
end

seedSeller_menu["Cumpara Seminte"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	vRP.prompt({player, "Cate seminte vrei sa cumperi?", "", function(player,seeds)
		seeds = parseInt(seeds)
		if seeds > 0 then
			local totalCost = seeds * 65
			local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"drug_seeds"})*seeds
			if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
				if(vRP.tryFullPayment({user_id, totalCost}))then
					vRP.giveInventoryItem({user_id,"drug_seeds",seeds,false})
					vRPclient.notify(player, {"~g~Ai cumparat ~y~"..seeds.." Seminte! ~g~Du-te la campul din fata casei pentru a le planta!"})
				else
					vRPclient.notify(player, {"~r~Nu ai destui bani pentru a cumpara ~y~"..seeds.."~r~ seminte!"})
				end
			else
				vRPclient.notify(player, {"~r~Nu ia destul spatiu in inventar!"})
			end
		end
	end})
end, "<img src='nui://vrp/gui/items/drug_seeds.png' height='70' width='70'><br><u>Seminte</u><br><br>Pret: <font color='green'>$65</font><br>Seminte misterioase de plante exotice!"}

function vRPjobs.spawnSeedSeller(thePlayer)
	local seedSeller_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, seedSeller_menu})
		end
	end
	
	local drugSell_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, drugSell_menu})
		end
	end
	
	local seedSeller_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	vRPclient.addMarkerNames(thePlayer,{seedSellerPed[1], seedSellerPed[2], seedSellerPed[3]+1.98, "Ciprian_Gogoi", 4, 1.2})
	vRP.createNPC({thePlayer,"vRP:seedSeller","A_M_O_Acult_02", seedSellerPed[1], seedSellerPed[2], seedSellerPed[3], seedSellerPed[4], 2.0, 1.5, seedSeller_enter, seedSeller_leave})
	vRPclient.setNamedBlip(thePlayer, {"vRP:seedSeller:blip", seedSellerPed[1], seedSellerPed[2], seedSellerPed[3], 162, 85, "Vanzator Seminte"})
	
	vRPclient.setNamedBlip(thePlayer, {"vRP:seedField:blip", harvestField[1], harvestField[2], harvestField[3], 140, 85, "Camp Plantatie"})
	
	vRPclient.addMarkerNames(thePlayer,{sellDrugs[1], sellDrugs[2], sellDrugs[3]+0.1, "~g~Vinde Droguri", 0, 0.85})
	vRP.setPickup({thePlayer,"vRP:drugSell:obj","prop_drug_package",sellDrugs[1], sellDrugs[2], sellDrugs[3]-0.4,2.3,1.5,drugSell_enter,seedSeller_leave})
	
	vRPclient.setNamedBlip(thePlayer, {"vRP:drugSell:blip", sellDrugs[1], sellDrugs[2], sellDrugs[3], 140, 71, "Vinde Droguri"})
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPjobs.spawnSeedSeller(source)
	vRPCjobs.initSeedField(source, {harvestField})
end)