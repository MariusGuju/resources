local items = {}

items["medkit"] = {"Medical Kit","Used to reanimate unconscious people.",nil,0.5}
items["dirty_money"] = {"Dirty money","Illegally earned money.",nil,0}
items["parcels"] = {"Parcels","Parcels to deliver",nil,0.10}
items["repairkit"] = {"Repair Kit","Used to repair vehicles.",nil,0.5}
items["bait"] = {"Momeala","Momeala pentru pescuit",nil,0.01}
items["salvage"] = {"Ramasite","Ramasite subacvatice",nil,0.01}
items["il_salvage"] = {"Ramasite Ilegale","Ramasite subacvatice ilegale",nil,0.01}

items["rod"] = {"Undita","Undita",function(args)
  local choices = {}
  local idname = args[1]

  choices["Foloseste"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- use diving gear
        TriggerClientEvent("james_fishing:tryToFish", player)
       end
    end
  end}

  return choices
end,0}

items["scubagear"] = {"Constum de scafandru","Imbracaminte de scafandru",function(args)
  local choices = {}
  local idname = args[1]

  choices["Foloseste"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- use diving gear
        TriggerClientEvent('uwsalvage:scubaGear', player)
       end
    end
  end}

  return choices
end,0}

items["uwtorch"] = {"Lampa de topit","Lampa de topit",function(args)
  local choices = {}
  local idname = args[1]

  choices["Foloseste"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- use diving gear
        TriggerClientEvent('uwsalvage:salvagestart', player)
       end
    end
  end}

  return choices
end,0}


-- money
items["money"] = {"Money","Packed money.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Unpack"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      vRP.prompt(player, "How much to unpack ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)
        if vRP.tryGetInventoryItem(user_id, idname, ramount, true) then -- unpack the money
          vRP.giveMoney(user_id, ramount)
          vRP.closeMenu(player)
        end
      end)
    end
  end}

  return choices
end,0}

-- money binder
items["money_binder"] = {"Money binder","Used to bind 1000$ of money.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Bind money"] = {function(player,choice,mod) -- bind the money
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local money = vRP.getMoney(user_id)
      if money >= 1000 then
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) and vRP.tryPayment(user_id,1000) then
          vRP.giveInventoryItem(user_id, "money", 1000, true)
          vRP.closeMenu(player)
        end
      else
        vRPclient.notify(player,{vRP.lang.money.not_enough()})
      end
    end
  end}

  return choices
end,0}

local supressor_choices = {}
supressor_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"supressor",1) then
      TriggerClientEvent('alex:supp', player)
    end
  end
end}

local flash_choices = {}
flash_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"flash",1) then
      TriggerClientEvent('alex:flashlight', player)
    end
  end
end}

local yusuf_choices = {}
yusuf_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"yusuf",1) then
      TriggerClientEvent('alex:yusuf', player)
    end
  end
end}

items["supressor"] = {"Suppressor Arma","",function(args) return supressor_choices end,0.1}
items["flash"] = {"Flashlight Arma","",function(args) return flash_choices end,0.1}
items["yusuf"] = {"Paint Arma","",function(args) return yusuf_choices end,0.1}


--[[
items["drug_seeds"] = {"Seminte Plante","Seminte de plante exotice",function(args)
	local choices = {}
	local idname = args[1]
		
	choices["Planteaza"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			vRPjobs.plantDrugSeed({player})
			vRP.closeMenu(player)
		end
	end}
	return choices
end,0.5,"pocket"}

items["chem_set"] = {"Set de Chimie","Un mic set de chimie",function(args)
	local choices = {}
	local idname = args[1]
		
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			vRP.closeMenu(player)
			vRPjobs.openChemSet({player})
		end
	end}
	return choices
end,1.0,"pocket"}
--]]
items["cufargur"] = {"Cufar Liquid","Liquid|Romania Community", function(args)
	local choices = {}
	local idname = args[1]

	choices["Deschide"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			if vRP.tryGetInventoryItem(user_id, "cufargur", 1, true) then
				chance = math.random(1, 5)
				if(chance == 1)then
					local lingoudiamantAmount = math.random(0, 1)
					vRP.giveInventoryItem(user_id, "lingoudiamant", lingouargintAmount, true)
					vRPclient.notify(player, {"~g~Ai deschis pachetul si ai gasit ~r~"..lingoudiamantAmount.." Lingou de Diamant"})
				elseif(chance == 2)then
					lingouaurAmount = math.random(0, 1)
					vRPclient.notify(player, {"~g~Ai deschis pachetul si ai gasit ~r~"..lingouaurAmount.." Lingou de Aur"})
					vRP.giveInventoryItem(user_id, "lingouaur", lingouaurAmount, true)
				elseif(chance == 3)then
					local vehLucky = math.random(5, 100)
					local vehName = "volvo850r"
					local vName = "Volvo"
					if(vehLucky <= 3)then
						vehName = "c10"
						vName = "Chevrolet"
					elseif(vehLucky > 3) and (vehLucky <= 10)then
						vehName = "camry18"
						vName = "Toyota Camay"
					elseif(vehLucky > 4) and (vehLucky <= 70)then
						vehName = "v250"
						vName = "Mercedes"
					end

					exports.ghmattimysql:execute("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = vehName}, function (pvehicle)
						Citizen.Wait(30)
						if #pvehicle > 0 then
							vRPclient.notify(player, {"~r~In acest pachet nu se afla nimic"})
							vRP.closeMenu(player)
							return
						else
							vRP.givePlayerSpecialVeh(user_id, vehName)
							vRPclient.notify(player, {"~g~Ai castigat : ~r~"..vName})
							TriggerClientEvent('chatMessage', -1, "[Liquid|Romania] ^5"..GetPlayerName(player).." ^2a castigat ^1"..vName.." ^2din pachetul de Liquid special")
						end
					end)

				elseif(chance == 4)then
					moneyReward = math.random(250, 2500)
					vRPclient.notify(player, {"~g~Ai deschis pachetul si ai gasit ~r~$"..moneyReward})
					TriggerClientEvent('chatMessage', -1, "[Liquid|Romania] ^5"..GetPlayerName(player).." ^2a gasit ^1$"..moneyReward.." ^2intr-un pachet!")
					vRP.giveMoney(user_id, moneyReward)
				else
					vRPclient.notify(player, {"~r~In acest pachet nu se afla nimic"})
					vRP.closeMenu(player)
					return
				end
				vRP.closeMenu(player)
			end
		end
	end}

	return choices
end, 0.2,"pocket"}



-- parametric weapon items
-- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id,"WEAPON_","")
  name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
  return name
end

--- weapon body
local wbody_name = function(args)
  return get_wname(args[2]).." body"
end

local wbody_desc = function(args)
  return ""
end

function string:split( inSplitPattern, outResults )
  if not outResults then
    outResults = { }
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( self, theStart ) )
  return outResults
end


local wbody_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Equip"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, fullidname, 1, true) then -- give weapon body
        local weapons = {}
        weapons[args[2]] = {ammo = 0}
        vRPclient.giveWeapons(player, {weapons})
        local infoarme = fullidname:split("wbody|")
        for i = 1, #infoarme do
         -- print(infoarme[i])
          --MySQL.query("vRP/scoateArmaDinInventar", {user_id = user_id, hash = infoarme[i]})--
		exports.ghmattimysql:execute("UPDATE vrp_arme SET inventar = 0 WHERE user_id = @user_id AND hash = @hash", {
            ['@user_id'] = user_id,
            ['@hash'] = infoarme[i]
		}, function (rows)
		end)
        end
        --MySQL.query("vRP/scoateArmaDinInventar", {user_id = user_id, hash = fullidname})

        vRP.closeMenu(player)
      end
    end
  end}

  return choices
end

local wbody_weight = function(args)
  return 0.75
end

items["wbody"] = {wbody_name,wbody_desc,wbody_choices,wbody_weight}

--- weapon ammo
local wammo_name = function(args)
  return get_wname(args[2]).." ammo"
end

local wammo_desc = function(args)
  return ""
end

local wammo_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Load"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, fullidname)
      vRP.prompt(player, "Amount to load ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)

        vRPclient.getWeapons(player, {}, function(uweapons)
          if uweapons[args[2]] ~= nil then -- check if the weapon is equiped
            if vRP.tryGetInventoryItem(user_id, fullidname, ramount, true) then -- give weapon ammo
              local weapons = {}
              weapons[args[2]] = {ammo = ramount}
              vRPclient.giveWeapons(player, {weapons,false})
              vRP.closeMenu(player)
            end
          end
        end)
      end)
    end
  end}

  return choices
end

local wammo_weight = function(args)
  return 0.01
end

items["wammo"] = {wammo_name,wammo_desc,wammo_choices,wammo_weight}

return items
