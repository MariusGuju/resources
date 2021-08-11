local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vehshop = module("vrp_showroom", "cfg/showroom")

--MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_showroom")
Gclient = Tunnel.getInterface("vRP_garages","vRP_showroom")

local cfg = module("vrp_showroom","cfg/showroom")
local vehgarage = cfg

vRPlogs = Proxy.getInterface("vRP_logs")

-- vehicle db / garage and lscustoms compatibility

--[[MySQL.createCommand("vRP/add_custom_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)")
MySQL.createCommand("vRP/get_cars_of_type","SELECT * FROM vrp_user_vehicles WHERE vehicle = @vehicle")
MySQL.createCommand("vRP/get_plr_vhz","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_vehicle_id","SELECT id FROM vrp_user_vehicles ORDER BY id DESC LIMIT 1")
MySQL.createCommand("vRP/get_vehicle_byPlate","SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @vehicle_plate")
MySQL.createCommand("vRP/update_license_plate","UPDATE vrp_user_vehicles SET vehicle_plate = @vehicle_plate WHERE user_id = @user_id AND vehicle = @vehicle")
]]

prefix = {
	["AB"] = "Alba",
	["AR"] = "Arad",
	["AG"] = "Arges",
	["BC"] = "Bacau",
	["BH"] = "Bihor",
	["BN"] = "Bistrita-Nasaud",
	["BT"] = "Botosani",
	["BR"] = "Braila",
	["BV"] = "Brasov",
	["BZ"] = "Buzau",
	["CL"] = "Calarasi",
	["CS"] = "Caras-Severin",
	["CJ"] = "Cluj",
	["CT"] = "Constanta",
	["CV"] = "Covasna",
	["DB"] = "Dambovita",
	["DJ"] = "Dolj",
	["GL"] = "Galati",
	["GR"] = "Giurgiu",
	["GJ"] = "Gorj",
	["HR"] = "Harghita",
	["HD"] = "Hunedoara",
	["IL"] = "Ialomita",
	["IS"] = "Iasi",
	["IF"] = "Ilfov",
	["MM"] = "Maramures",
	["MH"] = "Mehedinti",
	["MS"] = "Mures",
	["NT"] = "Neamt",
	["OT"] = "Olt",
	["PH"] = "Prahova",
	["SJ"] = "Salaj",
	["SM"] = "Satu Mare",
	["SB"] = "Sibiu",
	["SV"] = "Suceava",
	["TR"] = "Teleorman",
	["TM"] = "Timis",
	["TL"] = "Tulcea",
	["VL"] = "Valcea",
	["VS"] = "Vaslui",
	["VN"] = "Vrancea",
	["B"] = "Bucuresti"
}

--[[RegisterCommand("vehs", function(source, args, cmd)
	if(args[1] ~= nil)then
		--MySQL.query("vRP/get_cars_of_type", {vehicle = args[1]}, function(pvehicle, affected)
		exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE vehicle = @vehicle", {['@vehicle'] = args[1]}, function(pvehicle)
			vRPclient.notify(source,{"Sunt ~r~"..#pvehicle.." ~g~de ~g~"..args[1]})
		end)
	end
end)]]

function findVehsIds()
	theLastID = 0
	--MySQL.query("vRP/get_vehicle_id", {}, function(pvehicles, affected)
	exports.ghmattimysql:execute("SELECT id FROM vrp_user_vehicles ORDER BY id DESC LIMIT 1", {}, function(pvehicles)
		if #pvehicles > 0 then
			theLastID = tonumber(pvehicles[1].id)
		else
			theLastID = 0
		end
	end)
	Citizen.Wait(100)
	return theLastID
end
 
function getPrice( category, model )
    for i,v in ipairs(vehshop.menu[category].buttons) do
      if v.model == model then
          return v.costs
      end
    end
    return nil 
end

-- SHOWROOM
RegisterServerEvent('veh_SR:CumparaRabla')
AddEventHandler('veh_SR:CumparaRabla', function(category, vehicle, price, veh_type)
	local user_id = tonumber(vRP.getUserId({source}))
	local player = vRP.getUserSource({user_id})
	--vehName, vehPrice = vRP.checkVehicleName({vehicle})
	
	--vehID = findVehsIds()+1
	--[[if vehID < 10 then
		vehID = "0000"..vehID
	elseif vehID <= 99 and vehID > 9 then
		vehID = "000"..vehID
	elseif vehID <= 999 and vehID > 99 then
		vehID = "00"..vehID
	elseif vehID <= 9999 and vehID > 999 then
		vehID = "0"..vehID
	elseif vehID <= 99999 and vehID > 9999 then
		vehID = vehID
	end
]]	thePlate = "Fara Numere"
  
	--[[ SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle ]]
	--MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
	exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = vehicle}, function(pvehicle)
		if #pvehicle > 0 then
			vRPclient.notify(player,{"~r~Vehicle already owned."})
			TriggerClientEvent("meniu", player)
		else
			local actual_price = getPrice( category, vehicle)
			if actual_price == nil then
				print( "Masina "..vehicle.." din categoria "..category.." nu are pret setat" )
				vRPclient.notify(player,{"~r~This car is out of stock"})
				TriggerClientEvent("meniu", player)
				return 
			end
			if  actual_price ~= price then
				print( "Player with ID "..user_id.. " is suspected of Cheat Engine.")
			end	
			if vRP.tryFullPayment({user_id,actual_price}) then
				vRP.getUserIdentity({user_id, function(identity)
					--MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_plate = thePlate, veh_type = veh_type})
					exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)", {['@user_id'] = user_id, ['@vehicle'] = vehicle, ['@vehicle_plate'] = thePlate, ['@veh_type'] = veh_type})
                end})
				TriggerClientEvent('veh_SR:CloseMenu', player)
				TriggerClientEvent('amPulaMare', player)
					vRPclient.notify(player,{"Ai platit ~r~$"..actual_price})
					vRPclient.notify(player,{"Pentru a inmatricula masina, trebuie sa mergi la ~g~RAR."})
					vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj.\nPlacuta: ~g~"..thePlate})
					--logText = GetPlayerName(player).."("..user_id..") a cumparat "..vehName.." pentru $"..actual_price
					vRPlogs.createLog({user_id,logText,"Masina Showroom"})	
			else
				vRPclient.notify(player,{"~r~Not enough money."})
				TriggerClientEvent("meniu", player)
			end
		end
	end)
end)

RegisterServerEvent('veh_SR:CumparaRabla1')
AddEventHandler('veh_SR:CumparaRabla1', function(user_id, vehicle, price ,veh_type)
  local player = vRP.getUserSource({user_id})
  --[[ SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle ]]
  --MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
  exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = vehicle}, function(pvehicle)
	if #pvehicle > 0 then
		vRPclient.notify(player,{"~r~Vehicle already owned."})
		vRP.giveMoney({user_id,price})
		TriggerClientEvent("meniu", player)
	else
        vRPclient.notify(player,{"Paid ~r~"..price.."$."})				
		vRP.getUserIdentity({user_id, function(identity)
			--MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
			exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)", {['@user_id'] = user_id, ['@vehicle'] = vehicle, ['@vehicle_plate'] = "P "..identity.registration, ['@veh_type'] = veh_type})
		vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
		end})
	end
  end)
end)

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

playerRegVeh = {}
isUsingRAR = false

local function build_rar_menu(source)
	local x, y, z = 100.68803405762,6618.650390625,32.4739112854
	local function rarmenu_enter(source,area)
		user_id = vRP.getUserId({source})
		if user_id ~= nil then
			rar_menu = {name="Test",css={top="75px",header_color="rgba(0,0,0,0)"}}
			--MySQL.query("vRP/get_plr_vhz", {user_id = user_id}, function(theVehicles, affected)
			eexports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {['@user_id'] = user_id}, function(theVehicles, affected)
				if #theVehicles > 0 then
					for i, v in pairs(theVehicles) do
						vehName, vehPrice = vRP.checkVehicleName({v.vehicle})
						currentNrPlate = tostring(v.vehicle_plate)
						
						nrs = 0
						for ix = 1, string.len(currentNrPlate) do
							if(tonumber(string.sub(currentNrPlate,ix,ix)))then
								nrs = nrs + 1
							end
						end
						
						local platePrice = 2500
						--if(vehPrice <= 0)then
							--platePrice = 100000
						--else
							--platePrice = round(tonumber(vehPrice*0.1))
						--end
						
						if(nrs == 5)then
							isReg = "<font color='red'>NU</font><br>Apasa <font color='green'>'ENTER'</font> pentru a inmatricula vehiculul!"
							isPlate = "<font color='red'>"..currentNrPlate.."</font>"
						else
							isReg = "<font color='green'>DA</font><br>Apasa <font color='green'>'ENTER'</font> pentru a iti schimba numarul de inmatriculare!"
							isPlate = "<font color='green'>"..currentNrPlate.."</font>"
							platePrice = round(tonumber(platePrice / 2))
						end
						rar_menu[vehName] = {function(player, choice)
							if(isUsingRAR == false)then
								isUsingRAR = true
								user_id = vRP.getUserId({player})
								playerRegVeh[user_id] = tostring(v.vehicle)
								rar2_menu = {name="Registrul Auto Roman 2",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
								for i, v in pairs(prefix) do
									rar2_menu["Judetul "..v] = {function(player, choice) 
										user_id = vRP.getUserId({player})
										if(playerRegVeh[user_id] ~= nil)then
											vRP.prompt({player, "Numere: ", "", function(player, numbers)
												numbers = numbers
												if(string.len(tostring(numbers)) >= 2 and string.len(tostring(numbers)) <= 3)then
													if(tonumber(numbers))then
														vRP.prompt({player, "Litere: ", "", function(player, letters)
															letters = tostring(letters)
															if(letters:match("%a"))then
																if(string.len(letters) == 3)then
																	thePlate = i..""..numbers..""..letters:upper()
																	--MySQL.query("vRP/get_vehicle_byPlate", {vehicle_plate = thePlate}, function(pvehicle, affected)
																	exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @vehicle_plate", {['@vehicle_plate'] = thePlate}, function(pvehicle)
																		if #pvehicle > 0 then
																			vRPclient.notify(player, {"~r~O masina cu acest numar de inmatriculare exista deja!"})
																		else
																			if(vRP.tryPayment({user_id, platePrice}))then
																				theVeh = playerRegVeh[user_id]
																				--MySQL.execute("vRP/update_license_plate", {user_id = user_id, vehicle = theVeh, vehicle_plate = thePlate})
																				exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET vehicle_plate = @vehicle_plate WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = theVeh, ['@vehicle_plate'] = thePlate})
																				vehName, vehPrice = vRP.checkVehicleName({theVeh})
																				vRPclient.notify(player, {"~g~Ai inmatriculat vehiculul ~y~"..vehName.." ~g~pe ~p~Judetul "..v.."\n~g~Placuta: ~b~"..thePlate})
																				playerRegVeh[user_id] = nil
																				isUsingRAR = false
																				vRP.closeMenu({player})
																			else
																				vRPclient.notify(player, {"~r~Nu ai destui bani pentru inmatriculare!"})
																			end
																		end
																	end)
																else
																	vRPclient.notify(player, {"~r~Trebuie sa pui 3 litere!"})
																end
															else
																vRPclient.notify(player, {"~r~Trebuie sa pui 3 litere!"})
															end
														end})
													else
														vRPclient.notify(player, {"~r~Trebuie sa pui 2 sau 3 numere!"})
													end
												else
													vRPclient.notify(player, {"~r~Trebuie sa pui 2 sau 3 numere!"})
												end
											end})
										end
									end, "Prefix: <font color='green'>"..i.."</font>"}
								end
								Citizen.Wait(100)
								vRP.openMenu({player, rar2_menu})
							else
								vRPclient.notify(source, {"~r~Cineva foloseste deja biroul R.A.R! Asteapta pana cand aceasta persoana termina!"})
							end
						end, "Placuta: "..isPlate.."<br>Inamtriculat: "..isReg.."<br><br>Taxa de inmatriculare este de <font color='red'>$"..vRP.formatMoney({platePrice}).."</font>"}
					end
					Citizen.Wait(100)
					vRP.openMenu({source,rar_menu})
				end
			end)
		end
	end
	local function rarmenu_leave(source,area)
		user_id = vRP.getUserId({source})
		vRP.closeMenu({source})
		playerRegVeh[user_id] = nil
		isUsingRAR = false
	end
		
	vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
	vRPclient.addMarkerSign(source,{32,x,y,z-1.5,0.5,0.3,0.5,183, 67, 0,150,150,true,0,0})
	vRP.setArea({source,"vRP:RAR",x,y,z,1,1.5,rarmenu_enter,rarmenu_leave})
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_rar_menu(source)
		playerRegVeh[user_id] = nil
	end
end)

RegisterCommand("machiamasuntunzeu", function(source)
	user_id = vRP.getUserId({source})
	build_rar_menu(source)
	playerRegVeh[user_id] = nil
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	isUsingRAR = false
end)