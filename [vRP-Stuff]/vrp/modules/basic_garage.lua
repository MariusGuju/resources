local data = [[
  CREATE TABLE IF NOT EXISTS vrp_user_vehicles(
      user_id INTEGER,
      vehicle VARCHAR(255),
      upgrades TEXT,
      CONSTRAINT pk_user_vehicles PRIMARY KEY(user_id,vehicle),
      CONSTRAINT fk_user_vehicles_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
  );
]]

local function generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
  
	local number = ""
	for i=1,#format do
	  local char = string.sub(format, i,i)
	  if char == "D" then number = number..string.char(zbyte+math.random(0,9))
	  elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
	  else number = number..char end
	end
  
	return number
end  

-- load config

local cfg = module("cfg/garages")
local cfg_inventory = module("cfg/inventory")
local vehicle_groups = cfg.garage_types
local lang = vRP.lang

local garages = cfg.garages

-- -- garage menus
damage = {}
function tvRP.getDamage(damageC)
    damage = damageC
end

function tvRP.damageInsert(vname, type)
  local user_id = vRP.getUserId(source)
  if type == 1 then
    exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET damage = @damage WHERE user_id = @user_id AND vehicle = @vname",{
      ["@user_id"] = user_id,
      ["@vname"] = vname,
      ["@damage"] = "Da"
    })
    vRPclient.notify(source, {"Ti ai bagat masina in garaj cu viata de: "..math.floor(damage),2500,1})
  elseif type == 2 then
    exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET damage = @damage WHERE user_id = @user_id AND vehicle = @vname",{
      ["@user_id"] = user_id,
      ["@vname"] = vname,
      ["@damage"] = "Nu"
    })
    vRPclient.notify(source, {"Ti ai bagat masina in garaj cu viata de: "..math.floor(damage),2500,1})
  end
end

function tvRP.askDamage(vname)
  local user_id = vRP.getUserId(source)
    if user_id ~= nil then
      vRP.prompt(source,"Masina este stricata cu viata de: "..math.floor(damage).." Ai vrea sa platesti pentru ea?","",function(player,raspuns)
      if raspuns == "Da" or raspuns == "da" or raspuns == "dA" then 
          vRP.tryFullPayment(user_id,250)
        vRPclient.notify(player, {"Ai platit 250$ pentru masina cu viata de: "..math.floor(damage),2500,1})
          exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET damage = @damage WHERE user_id = @user_id AND vehicle = @vname",{
            ["@user_id"] = user_id,
            ["@vname"] = vname,
            ["@damage"] = "Nu"
          })
      elseif raspuns == "Nu" or raspuns == "nu" or raspuns == "nU" then
          exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET damage = @damage WHERE user_id = @user_id AND vehicle = @vname",{
            ["@user_id"] = user_id,
            ["@vname"] = vname,
            ["@damage"] = "Da"
          })
        vRPclient.notify(source, {"Ti ai bagat masina in garaj cu viata de: "..math.floor(damage),2500,1})
      end
    end)
  end
end

local garage_menus = {}

for group,vehicles in pairs(vehicle_groups) do
  local veh_type = vehicles._config.vtype or "default"

  local menu = {
    name=lang.garage.title({group}),
    css={top = "75px", header_color="rgba(255,125,0,0.75)"}
  }
  garage_menus[group] = menu

  menu[lang.garage.owned.title()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local tmpdata = vRP.getUserTmpTable(user_id)
      if tmpdata.rent_vehicles == nil then
        tmpdata.rent_vehicles = {}
      end

      -- build nested menu
      local kitems = {}
      local submenu = {name=lang.garage.title({lang.garage.owned.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
        submenu.onclose = function()
      end

        exports.ghmattimysql:execute('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id', {["user_id"] = user_id}, function(pvehicles)
        for k,v in pairs(pvehicles) do
          local vehicle = vehicles[v.vehicle]
          if vehicle then
            if v.veh_type == "heli" then
              submenu["<p style='font-size:15px'>"..vehicle[1].."</p>"] = {function(player,choice) vRPclient.spawnGarageVehicle(player,{v.veh_type,v.vehicle,v.damage,v.vehicle_plate}) vRP.closeMenu(player) end,"Helicopter: <span style = 'color: rgb(0, 255, 80);font-weight:bold;'>"..vehicle[1].."</span> <br/> Apasa <font color='red'>ENTER</font> pentru a scoate din Garaj </span> "}
              kitems[vehicle[1]] = v.vehicle
            else
              submenu["<p style='font-size:13px'>"..vehicle[1].."</p>"] = {function(player,choice) vRPclient.spawnGarageVehicle(player,{v.veh_type,v.vehicle,v.damage,v.vehicle_plate}) vRP.closeMenu(player) end,"Vehicul: <span style = 'color: rgb(0, 255, 80);font-weight:bold;'>"..vehicle[1].."</span><br/>Apasa <font color='red'>ENTER</font> pentru a scoate din Garaj"}
              kitems[vehicle[1]] = v.vehicle  
            end
          end
        end

        vRP.openMenu(player,submenu)
      end)
    end
  end,lang.garage.owned.description()}

  local isbuy = vehicles._config.hasbuy or false
  if isbuy then
    menu[lang.garage.buy.title()] = {function(player,choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then

        -- build nested menu
        local kitems = {}
        local submenu = {name=lang.garage.title({lang.garage.buy.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
        submenu.onclose = function()
          -- vRP.openMenu(player,menu)
        end

        local choose = function(player, choice)
          local vname = kitems[choice]
          if vname then
            -- buy vehicle
            local vehicle = vehicles[vname]
            if vehicle and vRP.tryPayment(user_id,vehicle[2]) then

            -- thePlate = "B " ..math.random(1,99).. " " ..cfg.prefixs[math.random(1,#cfg.prefixs)]
            local plate = generateStringNumber("DDDLLL")
            exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,veh_type,vehicle_plate) VALUES(@user_id,@vehicle,@veh_type,@vehicle_plate)",{["user_id"] = user_id,["vehicle"] = vname, ['@veh_type'] = veh_type, ['@vehicle_plate'] = "BC "..plate}, function(data)end)

              vRPclient.notify(player,{lang.money.paid({vehicle[2]}),4000,3})
              vRP.closeMenu(player)
            else
              vRPclient.notify(player,{lang.money.not_enough(),4000,2})
            end
          end
        end
        
        -- get player owned vehicles (indexed by vehicle type name in lower case)
          exports.ghmattimysql:execute('SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id', {["user_id"] = user_id}, function(_pvehicles)
          local pvehicles = {}
          for k,v in pairs(_pvehicles) do
            pvehicles[string.lower(v.vehicle)] = true
          end

          -- for each existing vehicle in the garage group
          for k,v in pairs(vehicles) do
            if k ~= "_config" and pvehicles[string.lower(k)] == nil then -- not already owned
              submenu[v[1]] = {choose,lang.garage.buy.info({v[2],v[3]})}
              kitems[v[1]] = k
            end
          end

          vRP.openMenu(player,submenu)
        end)
      end
    end,lang.garage.buy.description()}
  end

  menu[lang.garage.store.title()] = {function(player,choice)
    vRPclient.despawnGarageVehicle(player,{veh_type,15}) 
  end, lang.garage.store.description()}
end


local function build_client_garages(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(garages) do
      local gtype,x,y,z = table.unpack(v)

      local group = vehicle_groups[gtype]
      if group then
        local gcfg = group._config

        -- enter
        local garage_enter = function(player,area)
          local user_id = vRP.getUserId(source)
          if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) and gcfg.faction == nil and gcfg.vip == nil and gcfg.fType == nil then
            local menu = garage_menus[gtype]
            if menu then
              vRP.openMenu(player,menu)
            end
          elseif(gcfg.fType ~= nil and gcfg.fType ~= "")then
            theFaction = vRP.getUserFaction(user_id)
            if(tostring(vRP.getFactionType(theFaction)) == tostring(gcfg.fType))then
							local menu = garage_menus[gtype]
							if menu then
								vRP.openMenu(player,menu)
							end
            end  
          elseif (gcfg.faction ~= nil or gcfg.faction ~= "") and gcfg.vip == nil then
						if(vRP.isUserInFaction(user_id,gcfg.faction))then
							local menu = garage_menus[gtype]
							if menu then
								vRP.openMenu(player,menu)
							end
            end
          elseif (gcfg.vip ~= nil or gcfg.vip ~= 0) then
            if(vRP.getUserVipRank(user_id) == gcfg.vip)then
              local menu = garage_menus[gtype]
              if menu then
                vRP.openMenu(player,menu)
              end
            end
          end
        end

        -- leave
        local garage_leave = function(player,area)
          vRP.closeMenu(player)
        end

        vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.garage.title({gtype})})
        vRPclient.addMarker2(source,{x,y,z-1,2.0,2.0,0.3,255,255,255,125,150})
        vRP.setArea(source,"vRP:garage"..k,x,y,z,1,1.5,garage_enter,garage_leave)
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_client_garages(source)
  end
end)

local veh_actions = {}

veh_actions[lang.vehicle.trunk.title()] = {function(user_id,player,vtype,name)
  local chestname = "u"..user_id.."veh_"..string.lower(name)
  local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

  vRPclient.vc_openDoor(player, {vtype,5})
  vRPclient.StopBug(player, {"true"})
  vRP.openChest(player, chestname, max_weight, function()
    vRPclient.StopBug(player, {"false"})
    vRPclient.vc_closeDoor(player, {vtype,5})
  end)
end, lang.vehicle.trunk.description()}


veh_actions[lang.vehicle.lock.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleLock(player, {vtype})
end, lang.vehicle.lock.description()}

veh_actions[lang.vehicle.engine.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleEngine(player, {vtype})
end, lang.vehicle.engine.description()}


veh_actions["Vinde masina"] = {function(playerID,player,vtype,name)
	if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Jucatori : " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Pret $: ","",function(player,amount)
                if(tonumber(amount) and tonumber(amount) > 0) then
									exports.ghmattimysql:execute('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle', {["user_id"] = user_id,["vehicle"] = name}, function(pvehicle)
										if #pvehicle > 0 then
											vRPclient.notify(player,{"Acest jucator detine deja acest vehicul",2000,2})
										else
											local tmpdata = vRP.getUserTmpTable(playerID)
											if tmpdata.rent_vehicles[name] == true then
												vRPclient.notify(player,{"Nu poti vinde o masina inchiriata",2000,2})
												return
											else
												vRP.request(target,GetPlayerName(player).." vrea sa iti vanda : " ..name.. " Pret: $"..amount, 10, function(target,ok)
													if ok then
														local pID = vRP.getUserId(target)
														local money = vRP.getMoney(pID)
														if (tonumber(money) >= tonumber(amount)) then
															vRPclient.despawnGarageVehicle(player,{vtype,15}) 
                                exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET user_id = @user_id WHERE user_id = @oldUser AND vehicle = @vehicle",{["user_id"] = user_id,["oldUser"] = playerID,["vehicle"] = name}, function(data)end)															vRP.giveMoney(playerID, amount)
															vRP.setMoney(pID,money-amount)
															vRPclient.notify(player,{"Ai vandut cu succes vehiculul lui ".. GetPlayerName(target).." pentru "..amount.."$",2000,1})
														else
															vRPclient.notify(player,{GetPlayerName(target).." nu are suficienti bani",2000,2})
															vRPclient.notify(target,{"Nu ai suficienti bani",2000,2})
														end
													else
														vRPclient.notify(player,{GetPlayerName(target).." a refuzat sa iti cumpere vehiculul",2000,2})
														vRPclient.notify(target,{"Ai refuzat sa ii cumperi lui "..GetPlayerName(player).." vehiculul",2000,2})
													end
												end)
											end
											vRP.closeMenu(player)
										end
									end) 
								else
									vRPclient.notify(player,{"Pretul masini este invalid",2000,2})
								end
							end)
						else
							vRPclient.notify(player,{"Acest ID este invalid",2000,2})
						end
					else
						vRPclient.notify(player,{"Nu ai ales un jucator",2000,2})
					end
				end)
			else
				vRPclient.notify(player,{"Niciun jucator in preajma",2000,2})
			end
		end)
	end
end, lang.vehicle.sellTP.description()}

local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          vRP.openMenu(player,menu)
        end)
      else
        vRPclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end

local function ch_asktrunk(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.notify(player,{lang.vehicle.asktrunk.asked(),4000,3})
      vRP.request(nplayer,lang.vehicle.asktrunk.request(),15,function(nplayer,ok)
        if ok then
          vRPclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
            if ok then
              local chestname = "u"..nuser_id.."veh_"..string.lower(name)
              local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

              local cb_out = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.given({vRP.getItemName(idname),amount}),4000,2})
              end

              local cb_in = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.received({vRP.getItemName(idname),amount}),4000,1})
              end

              vRPclient.vc_openDoor(nplayer, {vtype,5})
              vRP.openChest(player, chestname, max_weight, function()
                vRPclient.vc_closeDoor(nplayer, {vtype,5})
              end,cb_in,cb_out)
            else
              vRPclient.notify(player,{lang.vehicle.no_owned_near(),4000,2})
              vRPclient.notify(nplayer,{lang.vehicle.no_owned_near(),4000,2})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused(),4000,2})
        end
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near(),4000,2})
    end
  end)
end

-- repair nearest vehicle
local function ch_repair(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- anim and repair
    if vRP.tryGetInventoryItem(user_id,"repairkit",1,true) then
      vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
      SetTimeout(15000, function()
        vRPclient.fixeNearestVehicle(player,{7})
        vRPclient.stopAnim(player,{false})
      end)
    end
  end
end


vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    -- add vehicle entry
    local choices = {}
    choices[lang.vehicle.title()] = {ch_vehicle}

    choices[lang.vehicle.asktrunk.title()] = {ch_asktrunk}

    if vRP.isUserInFaction(user_id,"Mecanici") then
      choices[lang.vehicle.repair.title()] = {ch_repair, lang.vehicle.repair.description()}
    end

    add(choices)
  end
end)

RegisterNetEvent("openTrunk")
 AddEventHandler("openTrunk",function()
   local user_id = vRP.getUserId(source)
   local _src = vRP.getUserSource(user_id)
   vRPclient.getNearestOwnedVehicle(_src,{7},function(ok,vtype,name)
         if ok then 
            local chestname = "u"..user_id.."veh"..string.lower(name)
            vRPin.openChest({_src, name, chestname,30.0, function() 
               vRPclient.vc_closeDoor(_src, {vtype,5})
             end})
         end
   end)
 end)

veh_actions[lang.vehicle.trunk.title()] = {function(user_id,player,vtype,name)
  local chestname = "u"..user_id.."veh_"..string.lower(name)
  local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
  vRPclient.vc_openDoor(player, {vtype,5})
  vRPin.openChest({player, name, chestname, max_weight, function() 
    vRPclient.vc_closeDoor(player, {vtype,5})
  end})
end, lang.vehicle.trunk.description()}



RegisterServerEvent("garage:requestMods")
AddEventHandler("garage:requestMods", function(vname)
  local user_id = vRP.getUserId(source)
  local src = vRP.getUserSource(user_id)
  exports.ghmattimysql:execute('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND upgrades IS NOT NULL', {["user_id"] = user_id,["vehicle"] = vname}, function(rows)
    if #rows > 0 then -- has vehicle
      vRPclient.garage_setmods(src, {rows[1].upgrades, rows[1].farcolorat})
    end
  end)
end)