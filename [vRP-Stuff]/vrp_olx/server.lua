local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPColx = Tunnel.getInterface("olx","olx")
vRPolx = {}
Tunnel.bindInterface("olx",vRPolx)
Proxy.addInterface("olx",vRPolx)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_rob")
RBclient = Tunnel.getInterface("vrp_rob","vrp_rob")
vRPrbC = Tunnel.getInterface("vrp_rob","vrp_rob")


--[[
CREATE TABLE IF NOT EXISTS olx(
  id INTEGER AUTO_INCREMENT,
  vehicul VARCHAR(255),
  plate VARCHAR(255),
  pret INTEGER,
  owner INTEGER,
  ownername VARCHAR(255),
  tuning LONGTEXT,
  parcare INTEGER,
  parkid INTEGER,
  PRIMARY KEY(id,vehicul)
);
ALTER TABLE vrp_user_vehicles ADD olx INTEGER default 0;
]]

count = 0
local infoforclient = {
	[1] = {
		locatieAdaugareMasina = {-1599.4398193359,-873.05078125,9.8266353607178,blipid = 147, blipcolor = 24},
		parcari = {
			--{x,y,z, id = 13, heading = 140.0, status = 0}, -- fata in jos
			--{x,y,z, id = 13, heading = 320.0, status = 0}, -- fata in sus
			{-1619.3566894531,-853.89703369141,9.4069061279297,id = 1,heading = 140.0, status = 0},
			{-1623.9536132813,-849.71185302734,9.4037322998047,id = 2,heading = 140.0,status = 0},
			{-1628.6413574219,-845.69982910156,9.407829284668,id = 3,heading = 140.0,status = 0},
			{-1633.3800048828,-841.84478759766,9.3777809143066,id = 4,heading = 140.0,status = 0},
			{-1638.1156005859,-838.01281738281,9.3822326660156,id = 5,heading = 140.0 ,status = 0},
			{-1642.8543701172,-834.02661132813,9.3863258361816, id = 6,heading = 140.0 ,status = 0 },
			{-1662.6320800781,-835.58215332031,8.9372806549072, id = 7,heading = 320.0 ,status = 0 },
			{-1657.8100585938,-839.271484375,8.9503078460693, id = 8,heading = 320.0 ,status = 0 },
			{-1653.1453857422,-843.31677246094,8.918586730957, id = 9,heading = 320.0 ,status = 0 },
			{-1648.4343261719,-847.44378662109,8.8577547073364, id = 10,heading = 320.0 ,status = 0 },
			{-1643.6680908203,-851.40447998047,8.910325050354, id = 11,heading = 320.0 ,status = 0 },
			{-1638.8947753906,-855.01037597656,9.1820468902588,id = 12, heading = 320.0, status = 0},
		}
	}
}

tablemasini = {}
function vRPolx.puneVehicululLaVanzare(idparcare)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRPclient.getNearestOwnedVehicle(player,{5},function(ok,vtype,name)
		if ok then
			parkingId = GetParkingSlot()
			if parkingId ~= 0 then
				exports.ghmattimysql:execute("SELECT vehicul FROM olx WHERE owner = @owner AND vehicul = @vehicul", {['@owner'] = user_id, ['@vehicul'] = name}, function (exist)
					if #exist == 0 then
						exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = name}, function (haveCar)
							vRP.getUserIdentity({user_id, function(identity)
								vRP.prompt({player,"Pret","",function(player,pret)
									pret = parseInt(pret)
									if pret > 0 then
										exports.ghmattimysql:execute("INSERT IGNORE INTO olx(vehicul,plate,owner,ownername,tuning,parcare,parkid,pret) VALUES(@vehicul,@plate,@owner,@ownername,@tuning,@parcare,@parkid,@pret)", {
											['@vehicul'] = name,
											['@plate'] = haveCar[1].vehicle_plate,
											['@owner'] = user_id,
											['@ownername'] = identity.firstname,
											['@tuning'] = haveCar[1].upgrades,
											['@parcare'] = idparcare,
											['@parkid'] = parkingId,
											['@pret'] = pret
										})
										exports.ghmattimysql:execute("UPDATE vrp_user_vehicles set olx = 1 WHERE user_id = @user_id and vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = name})
										vRPclient.despawnGarageVehicle(player,{vtype,15}) 
										Wait(10)
										local users = vRP.getUsers({})
										for k,sourceJucator in pairs (users) do
											spawnOLX(sourceJucator)
										end
									else
										vRPclient.notify(player,{"[OLX] Trebuie sa pui un PRET mai mare decat 0!"})
									end
								end})
							end})
						end)
					else
						vRPclient.notify(player,{"[OLX] Ai deja aceasta masina adagata in OLX"})
					end

				end)
			else
				vRPclient.notify(player,{"[OLX] Nu mai sunt locuri disponibile!"})
			end
		else
			vRPclient.notify(player,{"[OLX] Trebuie sa vii cu masina personala!"})
		end
	end)
end


function vRPolx.cumparaMasina(idtable)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	exports.ghmattimysql:execute("SELECT * FROM olx WHERE id = @id", {['@id'] = idtable}, function (rows)
		if rows[1].id ~= nil then
			if rows[1].owner ~= user_id then
				exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = rows[1].vehicul}, function (haveCar)
					if #haveCar > 0 then
						vRPclient.notify(player,{"[OLX] Ai deja aceasta masina!"})
					else
						if vRP.tryFullPayment({user_id,rows[1].pret}) then
							exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                ['@user_id'] = user_id,
                                ['@vehicle'] = rows[1].vehicul,
                                ['@upgrades'] = rows[1].tuning,
                                ['@vehicle_plate'] = rows[1].plate
							})
							exports.ghmattimysql:execute("DELETE FROM olx WHERE id = @id", {['@id'] = idtable})
							exports.ghmattimysql:execute("DELETE FROM vrp_user_vehicles WHERE user_id = @user_id and vehicle = @vehicle", {['@user_id'] = rows[1].owner, ['vehicle'] = rows[1].vehicul})

							local users = vRP.getUsers({})
							for k,sourceJucator in pairs (users) do

								if rows[1].owner == k then
									vRP.giveMoney({rows[1].owner,rows[1].pret})
								else
									exports.ghmattimysql:execute("SELECT wallet FROM vrp_user_moneys WHERE user_id = @user_id", {['@user_id'] =  rows[1].owner}, function (bani)
										baniUpdate = bani[1].wallet + rows[1].pret
										exports.ghmattimysql:execute("UPDATE vrp_user_moneys SET wallet = @wallet where user_id = @user_id", {['@user_id'] = rows[1].owner, ['@wallet'] = baniUpdate })
									end)
								end

								vRPColx.removeVehicle(sourceJucator,{rows[1].id})
								scoateMasinica(sourceJucator,rows[1].parcare,rows[1].parkid)
							end

							vRPclient.notify(player,{"[OLX] Ai cumparat masina cu SUCCES!\nDu-te la un garaj sa o scoti"})
						else
							vRPclient.notify(player,{"[OLX] Nu ai destui bani pentru a cumpara aceasta masina!"})
						end
					end
				end)
			else
				vRPclient.notify(player,{"[OLX] Nu poti sa iti cumperi propria masina! Sterge-o din meniu!"})
			end
		end
	end)
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		spawnOLX(player)
	end
end)


function spawnOLX(source)
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		exports.ghmattimysql:execute("SELECT * FROM olx", {}, function (rows)
			if #rows == 0 then
				vRPColx.spawnOLX(player,{infoforclient})
			else
				for k,v in pairs (rows) do
					for i,j in pairs (infoforclient) do
						for l,m in pairs (j.parcari) do
							if m.id == v.parkid then
								m.status = 1
							end
						end
					end
				end
				vRPColx.spawnOLX(player,{infoforclient})
				vRPColx.spawnOLXMasini(player,{rows})
			end
		end)
	end
end

function GetParkingSlot()
	insertInParcare = 0
	for i,j in pairs (infoforclient) do
		for l,m in pairs (j.parcari) do
			if m.status == 0 then
				insertInParcare = m.id
				break
			end
		end
	end
	return insertInParcare
end

RegisterCommand("olx", function(source)
	spawnOLX(source)
end)


function modificapret(player,model,id)
	local user_id = vRP.getUserId({player})
	vRP.prompt({player,"Pret","",function(player,masPrice)
		masPrice = parseInt(masPrice)
		if masPrice > 0 then
			vRPclient.notify(player,{"~w~Ai modificat ~g~PRETUL~w~ masinii ~o~"..model.."~w~ cu succes! "})
			exports.ghmattimysql:execute("UPDATE olx SET pret = @pret WHERE id = @id", {['@pret'] = masPrice, ['@id']=id})
			Wait(10)
			local users = vRP.getUsers({})
			for k,sourceJucator in pairs (users) do
				vRPColx.schimbaPret(sourceJucator,{id,masPrice})
				spawnOLX(sourceJucator)
			end
		else
			vRPclient.notify(player,{"~w~ Trebuie sa pui un numar mai mare decat 1 la pretul masinii."})
		end
	end})
	vRP.closeMenu({player})
end

function scoateMasinica(jucatori,parcaremare,parcareid)
	local user_id = vRP.getUserId({jucatori})
	for i,j in pairs (infoforclient) do
		if i == parcaremare then
			for k,p in pairs (j.parcari) do
				if p.id == parcareid then
					p.status = 0
				end
			end
		end
	end
	vRPColx.spawnOLX(jucatori,{infoforclient})
end

function scoateMasina(player,model,id,parcareid,parkid)
	local user_id = vRP.getUserId({player})
	vRPclient.notify(player,{"~w~Ai scos masina ~o~"..model.."~w~ de la vanzare cu succes!"})
	exports.ghmattimysql:execute("DELETE FROM olx WHERE id = @id", {['@id'] = id})
	exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET olx = 0 WHERE vehicle = @vehicle", {['@vehicle'] = model})
	Wait(10)
	local users = vRP.getUsers({})
	for k,sourceJucator in pairs (users) do
		vRPColx.removeVehicle(sourceJucator,{id})
		scoateMasinica(sourceJucator,parcareid,parkid)
	end
	vRP.closeMenu({player})
end

function info(player, model,id,pret,parcareid,parkid)
	local user_id = vRP.getUserId({source})
	local olx_masinii = {name=model,css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	olx_masinii["Scoate Masina de la vanzare"] = {function() scoateMasina(player, model,id,parcareid,parkid) end, "Scoate masina de la vanzare"}
	olx_masinii["Modifica pretul masinii"] = {function() modificapret(player, model,id) end, "Modifica pretul masinii <br> PRET ACTUAL: <font color='green'>$"..pret.."</font><br> CAR-ID:<font color='orange'>"..id.."</font>"}
	vRP.openMenu({player,olx_masinii})
end


RegisterCommand('olxmenu', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	
	vRP.buildMenu({"olx", {user_id = user_id, player = player}, function(menu)
	  menu.name="OLX"
	  menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
	  exports.ghmattimysql:execute("SELECT * FROM olx where owner = @owner", {['@owner'] = user_id}, function (prable)
		  if #prable > 0 then
			  for k,p in pairs (prable) do
				  local model = prable[k].vehicul
				  local pret = prable[k].pret
				  local plate = prable[k].plate
				  local id = prable[k].id
				  local parcareid =prable[k].parcare
				  local parkid =prable[k].parkid
				  menu[model] = {function(player,choice) info(player, model,id,pret,parcareid,parkid) end, "Pret: <font color='green'>$"..pret.."</font><br> CAR-ID:<font color='orange'>"..id.."</font>"}
			  end
			  vRP.openMenu({player,menu})
		  end
	  end)
	end})
end)

