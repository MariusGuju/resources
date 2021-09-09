hasClothes = {}

sewMachine = {
	{716.32684326172,-960.09326171875,29.85},
	{718.97900390625,-960.02294921875,29.85},
	{713.84002685546,-960.00073242188,29.85}
}

sewMaterialsPickup = {715.41711425782,-974.30493164062,29.85}

sewSellClothes = {715.00891113282,-966.84100341796,29.9}

sewIron = {
	{711.65148925782,-970.84588623046,30.0},
	{711.74560546875,-968.2232055664,30.0}
}

sewMaterials = {
	["Ata"] = {price = 15000, item = "sewjob_ata"},
	["Nasturi"] = {price = 5000, item = "sewjob_nasturi"},
	["Material"] = {price =  20000, item = "sewjob_material"},
	["Imprimeu"] = {price = 5000, item = "sewjob_imprimeu"},
	["Fermoar"] = {price =  5000, item = "sewjob_fermoar"}
}

sewClothes = {
	["Camasa"] = {price = 580000, th = 10, bt = 5, mat = 1, imp = 2, ferm = 0, dur = 200},
	["Boxeri"] = {price = 130000, th = 5, bt = 0, mat = 1, imp = 0, ferm = 0, dur = 120},
	["Blugi"] = {price = 450000, th = 10, bt = 3, mat = 2, imp = 2, ferm = 1, dur = 240},
	["Tricou"] = {price = 300000, th = 8, bt = 0, mat = 1, imp = 2, ferm = 0, dur = 180},
	["Caciula"] = {price = 195000, th = 6, bt = 0, mat = 1, imp = 0, ferm = 0, dur = 120},
	["Geaca"] = {price = , th = 10, bt = 5, mat = 3, imp = 1, ferm = 2, dur = 240}
}

sewMachine_menu = {name="Masina Cusut",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
sewMaterials_menu = {name="Materiale Croitorie",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
sewIron_menu = {name="Masina Calcat Croitorie",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
sewSellClothes_menu = {name="Vinde Croitorie",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

function vRPjobs.hasMaterialsForClothes(thePlayer, clothing)
	local hasAllMaterials = 0
	
	local materials = {}
	
	materials[1] = {sewClothes[clothing].th, "sewjob_ata"}
	materials[2] = {sewClothes[clothing].bt, "sewjob_nasturi"}
	materials[3] = {sewClothes[clothing].mat, "sewjob_material"}
	materials[4] = {sewClothes[clothing].imp, "sewjob_imprimeu"}
	materials[5] = {sewClothes[clothing].ferm, "sewjob_fermoar"}	
	
	local user_id = vRP.getUserId({thePlayer})
	for i, v in pairs(materials) do
		amount = tonumber(v[1])
		idname = tostring(v[2])
		
		if(vRP.getInventoryItemAmount({user_id,idname}) >= amount)then
			hasAllMaterials = hasAllMaterials + 1
		end
	end
	if(hasAllMaterials == 5)then
		return true
	else
		return false
	end
	return false
end

sewSellClothes_menu["Pune pe Umeras"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Croitor")then
		if(hasClothes[user_id] ~= nil)then
			if(hasClothes[user_id].stage == 1)then
				vRPclient.notify(player, {"[CROITOR] ~r~Haina nu este calcata! Du-te la masina de calcat si calca haina!"})
			elseif(hasClothes[user_id].stage == 2)then
				local clothName = hasClothes[user_id].cloth
				local clothPrice = sewClothes[clothName].price
				vRP.giveMoney({user_id, clothPrice})
				hasClothes[user_id] = nil
				vRPCjobs.sellTailoredClothing(player, {})
				updateGoalContributie = clothPrice / 2
				exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
				exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = clothPrice}, function (rows) end)
				vRPclient.notify(player, {"[CROITOR] ~g~Ai pus haina pe umeras si ai primit ~y~$"..clothPrice})
				vRP.closeMenu({player})
			end
		else
			vRPclient.notify(player, {"[CROITOR] ~r~Nu ai nici o haina in mana!"})
		end
	else
		vRPclient.notify(player, {"[CROITOR] ~r~Nu ai job-ul de ~y~Croitor!"})
	end
end, "Pune haina din mana pe umeras pentru a iti lua banii!"}

sewIron_menu["Calca Haina"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Croitor")then
		if(hasClothes[user_id] ~= nil)then
			if(hasClothes[user_id].stage == 1)then
				vRPCjobs.startTailoring(player, {120, "Calcat"})
			elseif(hasClothes[user_id].stage == 2)then
				vRPclient.notify(player, {"[CROITOR] ~r~Haina este deja calcata! O poti pune pe umeras pentru a iti lua banii!"})
			end
			vRP.closeMenu({player})
		else
			vRPclient.notify(player, {"[CROITOR] ~r~Nu ai nici o haina in mana!"})
		end
	end
end, "Calca haina pe care o ai in mana!"}

for i, v in pairs(sewMaterials) do	
	local matName = tostring(i)
	local price = tonumber(v.price)
	local itemName = tostring(v.item)
	sewMaterials_menu[matName] = {function(player, choice)
		price = price
		itemName = itemName
		local user_id = vRP.getUserId({player})
		vRP.prompt({player, "Numar Materiale: ", "", function(player, materials)
			materials = tonumber(materials)
			if(materials)then
				if(materials > 0)then
					matPrice = tonumber(price * materials)
					if(vRP.tryPayment({user_id, matPrice}))then
						vRP.giveInventoryItem({user_id, itemName, materials, false})
						vRPclient.notify(player, {"[CROITOR] ~g~Ai cumparat ~y~"..materials.." ~b~"..matName.." ~g~pentru ~r~$"..matPrice})
					else
						vRPclient.notify(player, {"[CROITOR] ~r~Nu ai destui bani pentru aceste materiale!"})
					end
				end
			end
		end})
	end, "<img src='nui://vrp/gui/items/"..itemName..".png' height='70' width='70'><br>Material: <font color='red'>"..matName.."</font><br>Pret: <font color='green'>$"..price.."</font>"}
end

function vRPjobs.getAllClothMaterials(user_id, thread, buttons, material, imprimeu, fermoar)
	local mats = {{"sewjob_ata",thread}, {"sewjob_nasturi",buttons}, {"sewjob_material",material}, {"sewjob_imprimeu",imprimeu}, {"sewjob_fermoar",fermoar}}
	for i, v in pairs(mats) do
		vRP.tryGetInventoryItem({user_id,v[1],v[2],true})
	end
end

for i, v in pairs(sewClothes) do
	local clothName = tostring(i)
	local price = tonumber(v.price)
	local thread = tonumber(v.th)
	local buttons = tonumber(v.bt)
	local material = tonumber(v.mat)
	local imprimeu = tonumber(v.imp)
	local fermoar = tonumber(v.ferm)
	local dur = tonumber(v.dur)
	
	sewMachine_menu[clothName] = {function(player, choice)
		local clothName = tostring(clothName)
		local user_id = vRP.getUserId({player})
		if(hasClothes[user_id] == nil)then
			if(vRPjobs.hasMaterialsForClothes(player, clothName))then
				local price = tonumber(price)
				local thread = tonumber(thread)
				local buttons = tonumber(buttons)
				local material = tonumber(material)
				local imprimeu = tonumber(imprimeu)
				local fermoar = tonumber(fermoar)
				local dur = tonumber(dur)
				
				vRPjobs.getAllClothMaterials(user_id, thread, buttons, material, imprimeu, fermoar)
				vRPCjobs.startTailoring(player, {dur, "Cusut"})
				hasClothes[user_id] = {stage = 0, cloth = clothName}
				vRP.closeMenu({player})
			else
				vRPclient.notify(player, {"[CROITOR] ~r~Nu ai destule materiale pentru a face ~y~"..clothName})
			end
		else
			vRPclient.notify(player, {"[CROITOR] ~r~Ai deja o haina facuta in mana!"})
		end
	end, "<img src='nui://vrp_jobs/imgs/"..clothName..".png' height='70' width='70'><br>Pret Vanzare: <font color='green'>$"..price.."</font><br>Ata: <font color='red'>"..thread.."</font><br>Nasturi: <font color='red'>"..buttons.."</font><br>Material: <font color='red'>"..material.."</font><br>Imprimeuri: <font color='red'>"..imprimeu.."</font><br>Fermoar: <font color='red'>"..fermoar.."</font>"}
end

function vRPjobs.finishTailoringClothes()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	hasClothes[user_id].stage = 1
	local clothName = hasClothes[user_id].cloth
	vRPclient.notify(thePlayer, {"[CROITOR] ~g~Ai croit cu succes ~y~"..clothName.."! ~g~Du-te la masina de calcat!"})
end

function vRPjobs.finishIroningClothes()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	hasClothes[user_id].stage = 2
	local clothName = hasClothes[user_id].cloth
	vRPclient.notify(thePlayer, {"[CROITOR] ~g~Ai calcat cu succes ~y~"..clothName.."! ~g~Acum poti pune haina pe umeras pentru a iti lua banii!"})
end

function vRPjobs.spawnTailorJob(thePlayer)
	local sewMaterials_enter = function(player,sewMaterials)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Croitor")then
				vRP.openMenu({player,sewMaterials_menu})
			else
				vRPclient.notify(player, {"[CROITOR] ~r~Nu ai job-ul de ~y~Croitor!"})
			end
		end
	end
	
	local sewMachine_enter = function(player,sewMachine)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Croitor")then
				vRP.openMenu({player,sewMachine_menu})
			else
				vRPclient.notify(player, {"[CROITOR] ~r~Nu ai job-ul de ~y~Croitor!"})
			end
		end
	end
	
	local sewIron_enter = function(player,sewMachine)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Croitor")then
				vRP.openMenu({player,sewIron_menu})
			else
				vRPclient.notify(player, {"[CROITOR] ~r~Nu ai job-ul de ~y~Croitor!"})
			end
		end
	end
	
	local sewSellClothes_enter = function(player,sewMaterials)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Croitor")then
				vRP.openMenu({player,sewSellClothes_menu})
			else
				vRPclient.notify(player, {"[CROITOR] ~r~Nu ai job-ul de ~y~Croitor!"})
			end
		end
	end
	
	local sewMaterials_leave = function(player,sewMaterials)
		vRP.closeMenu({player})
	end
	
	for i, v in pairs(sewMachine) do
		vRPclient.addMarkerNames(thePlayer,{v[1], v[2],v[3]+0.7, "~b~Masina Cusut", 0, 0.7})
		vRP.setPickup({thePlayer,"vRP:croitor_machines:"..i,"prop_sewing_machine",v[1], v[2],v[3],1,1.5,sewMachine_enter,sewMaterials_leave})
	end
	
	for i, v in pairs(sewIron) do
		vRPclient.addMarkerNames(thePlayer,{v[1], v[2],v[3]+0.45, "~y~Masina Calcat", 0, 0.7})
		vRP.setPickup({thePlayer,"vRP:iron_machine:"..i,"prop_iron_01",v[1], v[2],v[3],1,1.5,sewIron_enter,sewMaterials_leave})
	end
	
	vRPclient.addMarkerNames(thePlayer,{sewMaterialsPickup[1], sewMaterialsPickup[2],sewMaterialsPickup[3]+0.7, "~p~Materiale Croitorie", 0, 0.7})
	vRP.setPickup({thePlayer,"vRP:croitor_materials","ng_proc_box_01a",sewMaterialsPickup[1], sewMaterialsPickup[2],sewMaterialsPickup[3],1,1.5,sewMaterials_enter,sewMaterials_leave})

	vRPclient.addMarkerNames(thePlayer,{sewSellClothes[1], sewSellClothes[2],sewSellClothes[3]+0.7, "~g~Vinde Hainele", 0, 0.7})
	vRP.setPickup({thePlayer,"vRP:croitor_sell","prop_cs_shirt_01",sewSellClothes[1], sewSellClothes[2],sewSellClothes[3]-0.35,1,1.5,sewSellClothes_enter,sewMaterials_leave})
	
	vRPCjobs.createTailorBlip(thePlayer, {})
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		SetTimeout(2000, function()
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Croitor")then
				vRPjobs.spawnTailorJob(source)
			end
		end)
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Croitor")then
		hasClothes[user_id] = nil
	end
end)