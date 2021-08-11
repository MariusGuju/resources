
local items = {}

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

local pills_choices = {}
pills_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.isInComa(player,{}, function(in_coma)    
        if not in_coma then
          if vRP.tryGetInventoryItem(user_id,"pills",1) then
            vRPclient.varyHealth(player,{25})
            vRPclient.notify(player,{"~g~ Taking pills."})
            play_drink(player)
            vRP.closeMenu(player)
          end
        end    
    end)
  end
end}

local function play_smoke(player)
  local seq2 = {
    {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
  }

  vRPclient.playAnim(player,{true,seq2,false})
end

local smoke_choices = {}
smoke_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"weed",1) then
	  vRP.varyHunger(user_id,(20))
      vRPclient.notify(player,{"~g~ smoking weed."})
      play_smoke(player)
      vRP.closeMenu(player)
    end
  end
end}

local function play_smell(player)
  local seq3 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq3,false})
end

local smell_choices = {}
smell_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"cocaine",1) then
	  vRP.varyThirst(user_id,(20))
      vRPclient.notify(player,{"~g~ smell cocaine."})
      play_smell(player)
      vRP.closeMenu(player)
    end
  end
end}

local function play_lsd(player)
  local seq4 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq4,false})
end

local lsd_choices = {}
lsd_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"lsd",1) then
	  vRP.varyThirst(user_id,(20))
      vRPclient.notify(player,{"~g~ Taking lsd."})
      play_lsd(player)
      vRP.closeMenu(player)
    end
  end
end}

local applyBandage = {}
applyBandage["Apply"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.isInComa(player,{}, function(in_coma)
			if (in_coma == false) then
				if vRP.tryGetInventoryItem(user_id,"bandage",1) then
					local randomHealth = math.random(5, 50)
					vRPclient.varyHealth(player,{randomHealth}) 
					vRPclient.notify(player,{"~g~ Ti-ai aplicat un bandaj pe rani"})
					vRP.closeMenu(player)
					Citizen.Wait(100)
					vRP.closeMenu(player)
				end
			end
		end)
	end
end}

local takeParacetamol = {}
takeParacetamol["Take"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.isInComa(player,{}, function(in_coma)
			if (in_coma == false) then
				if (vRP.tryGetInventoryItem(user_id,"paracetamol",1)) then
					local randomHealth = math.random(5, 25)
					vRPclient.varyHealth(player,{randomHealth}) 
					vRPclient.notify(player,{"~g~ Ai luat o pastila paracetamol"})
					vRP.closeMenu(player)
					Citizen.Wait(100)
					vRP.closeMenu(player)
				end
			end
		end)
	end
end}

local takeAdrenaline = {}
takeAdrenaline["Take"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.isInComa(player,{}, function(in_coma)
			if (in_coma == false) then
				if vRP.tryGetInventoryItem(user_id,"adrenaline",1) then
					local randomHealth = math.random(50, 100)
					vRPclient.varyHealth(player,{randomHealth}) 
					vRPclient.notify(player,{"~g~ Ti-ai administrat o injectie cu adrenalina"})
					vRP.closeMenu(player)
					Citizen.Wait(100)
					vRP.closeMenu(player)
				end
			end
        end)
	end
end}

--
items["bandage"] = {"Bandaj","Un bandaj pentru a oprii sangerarile.",function(args) return applyBandage end,1,"pocket"}
items["paracetamol"] = {"Paracetamol","Un paracetamol pentru raceala si gripa.",function(args) return takeParacetamol end,0.50,"pocket"}
items["adrenaline"] = {"Injectie Adrenalina","O injectie cu adrenalina.",function(args) return takeAdrenaline end,2,"pocket"}

items["pills"] = {"Pills","A simple medication.",function(args) return pills_choices end,0.1}
items["iarba"] = {"Iarba","A some weed.",function(args) return smoke_choices end,0.10}
items["weed"] = {"Weed","A some weed.",function(args) return smoke_choices end,0.10}
items["cocaine"] = {"Cocaine","Some cocaine.",function(args) return smell_choices end,0.5}
items["heroine"] = {"Heroina","O seriga de 0.5mm de heroina",function(args) return smell_choices end,0.7}
items["pcp"] = {"PCP","O tableta alba cu initialele PCP",function(args) return smell_choices end,0.65}
items["amphetamine"] = {"Amphetamina","O fiola de amphetamina",function(args) return smell_choices end,0.65}
items["subutex"] = {"Subutex","O substanta maro combinata cu apa",function(args) return lsd_choices end,0.7}
items["thc"] = {"Ulei THC","Un borcan de ulei THC",function(args) return lsd_choices end,0.9}
items["lsd"] = {"LSD","Tablete de hartie cu desene animate",function(args) return lsd_choices end,0.5}
items["dmt"] = {"DMT","Tablete colorate DMT",function(args) return lsd_choices end,0.5}
items["Medical Weed"] = {"Medical Weed","Used by Doctors.",function() end,0.1}
items["mushroom"] = {"Mushroom Red","Given to Science..",function(args) return lsd_choices end,0.3}
items["filter"] = {"Filter","Filter for cigarette mushroom.",function(args) return lsd_choices end,0.2}
items["preservative"] = {"Preservative","No kids ,easy life.",function() end,0.1}
items["speish"] = {"Speish","Halucination.",function(args) return green_choices end,0.2}
items["antidrog"] = {"Anti-Drog","O injectie anti-drog puternica pentru eliminarea efectelor!",function(args) return anti_drog end,0.1}
items["ginseng"] = {"Ginseng","Good for tea and life.",function(args) return lsd_choices end,0.2}
items["glicina"] = {"glicina","licina india flower.",function(args) return lsd_choices end,0.2}
items["Presents"] = {"Presents","Given to Children."}

return items
