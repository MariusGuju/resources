-- define some basic inventory items

local items = {}

local function play_eat(player)
  local seq = {
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

-- gen food choices as genfunc
-- idname
-- ftype: eat or drink
-- vary_hunger
-- vary_thirst
local function gen(ftype, vary_hunger, vary_thirst)
  local fgen = function(args)
    local idname = args[1]
    local choices = {}
    local act = "Unknown"
    if ftype == "eat" then act = "Mananca" elseif ftype == "drink" then act = "Bea" end
    local name = vRP.getItemName(idname)

    choices[act] = {function(player,choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,idname,1,false) then
          if vary_hunger ~= 0 then vRP.varyHunger(user_id,vary_hunger) end
          if vary_thirst ~= 0 then vRP.varyThirst(user_id,vary_thirst) end

          if ftype == "drink" then
            vRPclient.notify(player,{"~b~ Bei "..name.."."})
            play_drink(player)
          elseif ftype == "eat" then
            vRPclient.notify(player,{"~o~ Mananci "..name.."."})
            play_eat(player)
          end

          vRP.closeMenu(player)
        end
      end
    end}

    return choices
  end

  return fgen
end

-- DRINKS --

items["apa"] = {"Apa","", gen("drink",0,-25),0.5}
items["coffee"] = {"Coffee","", gen("drink",0,-10),0.2}
items["ceai"] = {"Ceai","", gen("drink",0,-15),0.2}
items["icetea"] = {"Ice-Tea","", gen("drink",0,-20), 0.5}
items["sucportocale"] = {"Suc De Portocale","", gen("drink",0,-25),0.5}
items["cocacola"] = {"Coca Cola","", gen("drink",0,-35),0.3}
items["redbull"] = {"Red Bull","", gen("drink",0,-40),0.3}
items["limonada"] = {"Limonada","", gen("drink",0,-45),0.3}
items["vodka"] = {"Vodka","", gen("drink",15,-65),0.5}
items["lapte"] = {"Lapte","", gen("drink",0,-45),0.3}
items["Borsec"] = {"Borsec","", gen("drink",0,-45),0.3}
items["Vin"] = {"Vin","", gen("drink",0,-45),0.3}
items["Teddy"] = {"Teddy","", gen("drink",0,-45),0.3}
items["Limonada"] = {"Limonada","", gen("drink",0,-45),0.3}

--FOOD

-- create Breed item
items["gogoasa"] = {"Gogoasa","", gen("eat",-15,0),0.2}
items["tacos"] = {"Tacos","", gen("eat",-20,0),0.2}
items["sandwich"] = {"Sandwich","A tasty snack.", gen("eat",-25,0),0.5}
items["kebab"] = {"Kebab","", gen("eat",-45,0),0.85}
items["gogoasasmek"] = {"Gogoasa Cu Glazura","", gen("eat",-25,0),0.5}
items["catfish"] = {"Catfish","", gen("eat",-20,0),0.2}
items["paine"] = {"Paine","", gen("eat",-20,0),0.2}
items["Popcorn"] = {"Popcorn","", gen("eat",-20,0),0.2}
items["Spaghete"] = {"Spaghete","", gen("eat",-20,0),0.2}
items["Margherita"] = {"Pizza Margherita","", gen("eat",-20,0),0.2}
items["Capricciosa"] = {"Pizza Capricciosa","", gen("eat",-20,0),0.2}
items["Diavola"] = {"Pizza Diavola","", gen("eat",-20,0),0.2}
items["Formaggi"] = {"Pizza Quattro Formaggi","", gen("eat",-20,0),0.2}
items["Stagioni"] = {"Pizza Quattro Stagioni","", gen("eat",-20,0),0.2}
items["Vegetariana"] = {"Pizza Vegetariana","", gen("eat",-20,0),0.2}
items["McChicken"] = {"McChicken","", gen("eat",-20,0),0.2}
items["McPuisor"] = {"McPuisor","", gen("eat",-20,0),0.2}
items["McNuggets"] = {"Chicken McNuggets","", gen("eat",-20,0),0.2}
items["BigMac"] = {"Big Mac","", gen("eat",-20,0),0.2}
items["Cheeseburger"] = {"Cheeseburger","", gen("eat",-20,0),0.2}
items["cartofimici"] = {"Portie Cartofi Mica","", gen("eat",-20,0),0.2}
items["cartofimedi"] = {"Portie Cartofi Medie","", gen("eat",-20,0),0.2}
items["cartofimari"] = {"Portie Cartofi Mare","", gen("eat",-20,0),0.2}
items["salata"] = {"Salata Greek","", gen("eat",-20,0),0.2}

return items
