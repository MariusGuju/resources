
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_polcmds")

--[[LANG]]--
local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})


RegisterServerEvent('meniuArme')
AddEventHandler('meniuArme',function()
	  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id,"radio.police"}) then
      vRP.buildMenu({"Arme PD", {user_id = user_id, player = player}, function(menu)
        menu.name="Arme PD"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
        

        menu["DOP"] = {function(player,choice) dop(player) end, "Directia de Ordine Publica"}
        menu["DR"] = {function(player,choice) dr(player) end, "Directia de Rutiera"}
        menu["SAS"] = {function(player,choice) sas(player) end, "Serviciul pentru Actiuni Speciale"}

        vRP.openMenu({player,menu})

        function dop(player)
          vRPclient.giveWeapons(player,{{
            ["weapon_pistol"] = {ammo=250},
            ["weapon_stungun"] = {ammo=250},
            ["weapon_nightstick"] = {ammo=200},
            ['weapon_flashlight'] = {ammo = 200}
          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat echipamentul"})

          vRP.closeMenu({player})
        end

        function dr(player)
          vRPclient.giveWeapons(player,{{
            ["weapon_pistol"] = {ammo=250},
            ["weapon_stungun"] = {ammo=50},
            ["weapon_nightstick"] = {ammo=250},
            ["weapon_flashlight"] = {ammo=250},
            ["weapon_vintagepistol"] = {ammo=200},
            ['weapon_flare'] = {ammo = 200}
          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat echipamentul"})

          vRP.closeMenu({player})
        end

        function sas(player)
          vRPclient.giveWeapons(player,{{
            ["weapon_assaultshotgun"] = {ammo=250},
            ["WEAPON_PISTOL50"] = {ammo=250},
            ["WEAPON_SPECIALCARABINE"] = {ammo=250},
            ["WEAPON_CARBINERIFLE_MK2"] = {ammo=250},
            ["weapon_combatpdw"] = {ammo=250},
            ["weapon_bzgas"] = {ammo=250},
            ["gadget_parachute"] = {ammo=250},
            ["weapon_stungun"] = {ammo=50},
            ["weapon_nightstick"] = {ammo=200},
            ["WEAPON_SNIPERRIFLE"] = {ammo=250}

          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat echipamentul"})

          vRP.closeMenu({player})
        end
      end})
    end
    if vRP.hasPermission({user_id,"mafiafull.arme"}) then
      vRP.buildMenu({"Arme", {user_id = user_id, player = player}, function(menu)
        menu.name="Arme"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
        

        menu["Pachet Arme-Siciliana"] = {function(player,choice) pachetarmefull(player) end, "Pachet de arme"}
        vRP.openMenu({player,menu})

        function pachetarmefull(player)
          vRPclient.giveWeapons(player,{{
            ["WEAPON_PISTOL"] = {ammo=250},
            ["WEAPON_PISTOL50"] = {ammo=250},
            ["WEAPON_ASSAULTRIFLE_MK2"] = {ammo=250},
            ["WEAPON_PUMPSHOTGUN_MK2"] = {ammo=250},
            ["WEAPON_SNSPISTOL_MK2"] = {ammo=250},
            ["WEAPON_HEAVYSNIPER"] = {ammo=250},
            ["WEAPON_PISTOL_MK2"] = {ammo=250},
            ["WEAPON_MICROSMG"] = {ammo=250},
            ["WEAPON_SPECIALCARABINE"] = {ammo=250},
            ["WEAPON_CARBINERIFLE_MK2"] = {ammo=250},
            ["WEAPON_KNIFE"] = {ammo=100},
            ["WEAPON_SWITCHBLADE"] = {ammo=100},
            ["WEAPON_PETROLCAN"] = {ammo=250},
            ["GADGET_PARACHUTE"] = {ammo=100}
          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat armele"})

          vRP.closeMenu({player})
        end
      end})
    end
    if vRP.hasPermission({user_id,"sniper.acces"}) then
      vRP.buildMenu({"Sniper", {user_id = user_id, player = player}, function(menu)
        menu.name="Sniper"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      

        menu["Sniper+Arme"] = {function(player,choice) sniper(player) end, "Sniper+Arme"}
        vRP.openMenu({player,menu})

      function sniper(player)
        vRPclient.giveWeapons(player,{{
          ["WEAPON_SNIPERRIFLE"] = {ammo=100},
          ["WEAPON_PISTOL"] = {ammo=250},
          ["WEAPON_ASSAULTRIFLE"] = {ammo=250},
          ["WEAPON_PUMPSHOTGUN_MK2"] = {ammo=250},
          ["WEAPON_MICROSMG"] = {ammo=250},
          ["WEAPON_KNIFE"] = {ammo=100},
          ["WEAPON_SWITCHBLADE"] = {ammo=100},
          ["WEAPON_PETROLCAN"] = {ammo=250},
          ["GADGET_PARACHUTE"] = {ammo = 100}
        }, true})
        TriggerClientEvent("colete", player)
        vRPclient.notify(player,{"~g~Ai luat Sniper-ul si armele"})

        vRP.closeMenu({player})
        end
      end})
    end
    if vRP.hasPermission({user_id,"gang.acces"}) then
      vRP.buildMenu({"gang", {user_id = user_id, player = player}, function(menu)
        menu.name="gang"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      

        menu["gang"] = {function(player,choice) gang(player) end, "gang"}
        vRP.openMenu({player,menu})

      function gang(player)
        vRPclient.giveWeapons(player,{{
          ["WEAPON_PISTOL"] = {ammo=250},
          ["WEAPON_MICROSMG"] = {ammo=250},
          ["WEAPON_KNIFE"] = {ammo=100}
        }, true})
        TriggerClientEvent("colete", player)
        vRPclient.notify(player,{"~g~Ai luat armele"})

        vRP.closeMenu({player})
        end
      end})
    end    
    if vRP.hasPermission({user_id,"mafia.arme"}) then
      vRP.buildMenu({"Arme", {user_id = user_id, player = player}, function(menu)
        menu.name="Arme"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
        

        menu["Pachet Arme"] = {function(player,choice) pachetarme(player) end, "Pachet de arme"}
        vRP.openMenu({player,menu})

        function pachetarme(player)
          vRPclient.giveWeapons(player,{{
            ["WEAPON_PISTOL"] = {ammo=250},
            ["WEAPON_ASSAULTRIFLE"] = {ammo=250},
            ["WEAPON_PUMPSHOTGUN_MK2"] = {ammo=250},
            ["WEAPON_MICROSMG"] = {ammo=250},
            ["WEAPON_KNIFE"] = {ammo=100},
            ["WEAPON_SWITCHBLADE"] = {ammo=100},
            ["WEAPON_PETROLCAN"] = {ammo=250},
            ["GADGET_PARACHUTE"] = {ammo = 100}
          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat armele"})

          vRP.closeMenu({player})
        end
    end})
  end
  if vRP.hasPermission({user_id,"armamenthitman.acces"}) then
    vRP.buildMenu({"Arme", {user_id = user_id, player = player}, function(menu)
      menu.name="Arme"
      menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      

      menu["Pachet Arme"] = {function(player,choice) pachetarme(player) end, "Pachet de arme"}
      vRP.openMenu({player,menu})

      function pachetarme(player)
        vRPclient.giveWeapons(player,{{
          ["WEAPON_PISTOL"] = {ammo=250},
          ["WEAPON_ASSAULTRIFLE"] = {ammo=250},
          ["WEAPON_MICROSMG"] = {ammo=250},
          ["WEAPON_KNIFE"] = {ammo=100},
          ["WEAPON_SWITCHBLADE"] = {ammo=100},
          ["WEAPON_PETROLCAN"] = {ammo=250},
          ["WEAPON_SNIPERRIFLE"] = {ammo=250},
          ["GADGET_PARACHUTE"] = {ammo = 100}
        }, true})
        TriggerClientEvent("colete", player)
        vRPclient.notify(player,{"~g~Ai luat armele"})

        vRP.closeMenu({player})
      end
      end})
  --[[elseif vRP.hasPermission({user_id,"mafiapula.arme"}) then
      vRP.buildMenu({"Arme", {user_id = user_id, player = player}, function(menu)
        menu.name="Arme"
        menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
        

        menu["Pachet Arme"] = {function(player,choice) pachetarme(player) end, "Pachet de arme"}
        vRP.openMenu({player,menu})

        function pachetarme(player)
          vRPclient.giveWeapons(player,{{
            ["WEAPON_PISTOL"] = {ammo=250},
            ["WEAPON_ASSAULTRIFLE"] = {ammo=250},
            ["WEAPON_MICROSMG"] = {ammo=250},
            ["WEAPON_KNIFE"] = {ammo=100},
            ["WEAPON_SWITCHBLADE"] = {ammo=100},
            ["WEAPON_PETROLCAN"] = {ammo=250},
            ["GADGET_PARACHUTE"] = {ammo = 100}
          }, true})
          TriggerClientEvent("colete", player)
          vRPclient.notify(player,{"~g~Ai luat armele"})

          vRP.closeMenu({player})
        end
    end})]] 
    else
        vRPclient.notify(player,{"Nu ai acces"})
    end
end)


RegisterServerEvent("cumparaAsigurare")
AddEventHandler("cumparaAsigurare", function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local areasigurare = 0
  exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id AND asigAuto = 'Luat'", {id = user_id}, function(rows)    
    if #rows > 0 then
      areasigurare = 1
    else
      areasigurare = 0
    end  
    if areasigurare == 0 then
      if vRP.tryFullPayment({user_id,250}) then
        exports.ghmattimysql:execute("UPDATE vrp_users SET asigAuto='Luat' WHERE id = @id", {
          ['@id']= user_id
        }, function (rows)
        end)
        vRPclient.notify(player,{"~g~Ai cumparat cu succes Asigurarea Auto"})
      else
        vRPclient.notify(player,{"~r~Nu ai bani"})
      end
    else
      vRPclient.notify(player,{"~g~Detii deja Asigurarea Auto"})
    end
  end)
end)

RegisterServerEvent("cumparaCertificat")
AddEventHandler("cumparaCertificat", function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local arecertificat = 0
  exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id AND certfAuto = 'Luat'", {id = user_id}, function(rowsz)    
    if #rowsz > 0 then
      arecertificat = 1
    else
      arecertificat = 0
    end  
    if arecertificat == 0 then
      if vRP.tryFullPayment({user_id,250}) then
        exports.ghmattimysql:execute("UPDATE vrp_users SET certfAuto='Luat' WHERE id = @id", {
          ['@id']= user_id
        }, function (rows)
        end)
        vRPclient.notify(player,{"~g~Ai cumparat cu succes Certificatul Auto"})
      else
        vRPclient.notify(player,{"~r~Nu ai bani"})
      end
    else
      vRPclient.notify(player,{"~g~Detii deja Certificatul Auto"})
    end
  end)
end)


--[[POLICE MENU]]--

local choice_setlc = {function(player,choice)
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
    local user_list = ""
    for k,v in pairs(nplayers) do
      user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
    if user_list ~= "" then
      vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
        if target_id ~= nil and target_id ~= "" then 
         exports.ghmattimysql:execute("UPDATE vrp_users SET carnet=@carnet WHERE id = @id", {
          ['@id']= target_id,
          ['@carnet'] = 1
        }, function (rows)
        end)
         vRPclient.notify(player,{"I-ai dat permisiunea de a conduce cazane jucatorului!"})
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end
      end})
    else
      vRPclient.notify(player,{"Nu ai jucator in preajma"})
    end
  end)
end,"Da-i unui jucator Licenta Auto"}

local choice_dapermisarma = {function(player,choice)
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
    local user_list = ""
    for k,v in pairs(nplayers) do
      user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
    if user_list ~= "" then
      vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
        if target_id ~= nil and target_id ~= "" then 
         exports.ghmattimysql:execute("UPDATE vrp_users SET PermisArma=@PermisArma WHERE id = @id", {
          ['@id']= target_id,
          ['@PermisArma'] = 1
        }, function (rows)
        end)
         vRPclient.notify(player,{"I-ai dat permisiunea de a avea arme!"})
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end
      end})
    else
      vRPclient.notify(player,{"Nu ai jucator in preajma"})
    end
  end)
end,"Da-i permisul de arme unui jucator."}

local choice_iapermisarma = {function(player,choice)
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
    local user_list = ""
    for k,v in pairs(nplayers) do
      user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
    if user_list ~= "" then
      vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
        if target_id ~= nil and target_id ~= "" then 
         exports.ghmattimysql:execute("UPDATE vrp_users SET PermisArma='Confiscat' WHERE id = @id", {
          ['@id']= target_id
        }, function (rows)
        end)
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end
      end})
    else
      vRPclient.notify(player,{"Nu ai jucator in preajma"})
    end
  end)
end,"Confisca permisul de arme unui jucator."}

local choice_iapermis = {function(player,choice)
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
    local user_list = ""
    for k,v in pairs(nplayers) do
      user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
    if user_list ~= "" then
      vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
        if target_id ~= nil and target_id ~= "" then 
         exports.ghmattimysql:execute("UPDATE vrp_users SET carnet='Confiscat' WHERE id = @id", {
          ['@id']= target_id
        }, function (rows)
        end)
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end
      end})
    else
      vRPclient.notify(player,{"Nu ai jucator in preajma"})
    end
  end)
end,"Confisca unui jucator Licenta Auto"}


local choice_asklc = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking license..."})
      vRP.request({nplayer,"Iti arati licenta auto?",15,function(nplayer,ok)
        if ok then
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
              carnetinfo = rows[1].carnet
              vRPclient.notify(player,{"Carnetul De Conducere:"..carnetinfo})
            end)

        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica licenta auto celui mai apropiat jucator"}

local choice_askasig = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking license..."})
      vRP.request({nplayer,"Iti arati Certificatul auto?",15,function(nplayer,ok)
        if ok then
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
              asiginfo = rows[1].asigAuto
              vRPclient.notify(player,{"Asigurare:"..asiginfo})
            end)

        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica asigurarea auto celui mai apropiat jucator"}

local choice_askaporm = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking Port Arma..."})
      vRP.request({nplayer,"Iti arati licenta port arma?",15,function(nplayer,ok)
        if ok then
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
              portinfo = rows[1].PermisArma
              vRPclient.notify(player,{"Permis Arma:"..portinfo})
            end)

        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica licenta arma celui mai apropiat jucator"}

local choice_askcertf = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking license..."})
      vRP.request({nplayer,"Iti arati licenta auto?",15,function(nplayer,ok)
        if ok then

            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
              certf = rows[1].certfAuto
              vRPclient.notify(player,{"Certificat:"..certf})
            end)

        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica Certificatul auto celui mai apropiat jucator"}

local choice_verificaPermis = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Asking license..."})
      vRP.request({nplayer,"Iti arati licenta auto?",15,function(nplayer,ok)
        if ok then
          exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
            exports.ghmattimysql:execute("SELECT * FROM vrp_user_identities WHERE user_id = @user_id", {['@user_id'] = nuser_id}, function (rows2)
              if rows[1].carnet == 1 then
                TriggerClientEvent("ples-id:showPermis", player, {
                  nume = rows2[1].firstname, 
                  prenume = rows2[1].name, 
                  target = nplayer
                })
            else
                vRPclient.notify(player,{"Nu are permis"})
            end
            end)
          end)

        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica Certificatul auto celui mai apropiat jucator"}


local choice_askBuletin = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Ai cerut buletinul.."})
      vRP.request({nplayer,"Iti arati buletinul?",15,function(nplayer,ok)
        if ok then
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = nuser_id}, function (rows)
              exports.ghmattimysql:execute("SELECT * FROM vrp_user_identities WHERE user_id = @user_id", {['@user_id'] = nuser_id}, function (rows2)
                TriggerClientEvent("ples-id:showBuletin", player, {
                  nume = rows2[1].firstname, 
                  prenume = rows2[1].name, 
                  age = rows2[1].age, 
                  adresa = "Necunoscut", 
                  usr_id = nuser_id, 
                  target = nplayer
                })
              end)
            end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, "Verifica buletinul celui mai apropiat jucator"}

tdCords = {473.77716064453,-1005.7958374023,26.273305892944}

local menu_thePc = {
  name = "Baza de date a Politiei",
	css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
}

menu_thePc["Adauga Dosar Penal"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id then
    vRP.closeMenu({player})
    vRP.prompt({player, "Numarul de identificare: ", "", function(player, target_id)
      target_id = parseInt(target_id)
      if target_id then
        vRP.prompt({player, "Motiv ( fapta comisa )", "Ex: Furt Auto, Crima, Jaf armat", function(player, reason)
          reason = tostring(reason)
          if reason ~= nil and reason ~= "" then
            vRP.prompt({player, "Gravitatea faptei (1, 2, 3, 4 sau 5): ", "", function(player, points)
              points = parseInt(points)
              if points >= 1 and points <= 5 then
                vRPclient.notify(player, {"Dosar Adaugat !~n~~w~"..reason})
                exports.ghmattimysql:execute("INSERT IGNORE INTO `vrp_penalitati` (`user_id`, `motiv`, `points`) VALUES(@target_id, @reason, @points)", {['@target_id'] = target_id, ['@reason'] = reason, ['@points'] = points})
              else
                vRPclient.notify(player, {"Gravitatea faptei invalida (1-5)"})
              end
            end})
          else
            vRPclient.notify(player, {"Motiv invalid"})
          end
        end})
      else
        vRPclient.notify(player, {"User Id Invalid"})
      end
    end})
  end
end, "Adauga un dosar penal pentru un jucator"}

menu_thePc["Verifica Dosare Penale"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id then
    vRP.prompt({player, "Numar de indentficare: ", "", function(player, target_id)
      target_id = parseInt(target_id)
      if target_id then
        local sub_menu = {
          name = "Dosare - "..target_id,
          css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
        }

        exports.ghmattimysql:execute("SELECT * FROM `vrp_penalitati` WHERE `user_id` = @target_id", {['@target_id'] = target_id}, function(rows)
          for k, v in pairs(rows) do
            sub_menu["Dosar #"..v.id] = {function(player, choice)
              vRP.request({player, "Esti sigur ca doresti sa-i anulezi dosarul penal ?", 15, function(player, ok)
                if ok then
                  vRP.closeMenu({player})
                  exports.ghmattimysql:execute("DELETE FROM `vrp_penalitati` WHERE `user_id` = @target_id AND `motiv` = @reason", {['@target_id'] = target_id, ['@reason'] = v.motiv})
                end
              end})
            end, [[
              <span style='font-size: 10px;'>Gravitatea Faptei: <span style='color: red;'>]]..v.points..[[</span></span>
              <hr/>]] .. v.motiv .. [[<br/><br/>
              <span style='font-size: 10px; color: orange;'>Selecteaza dosarul penal pentru a-l anula</span>
              ]]}
          end
          vRP.openMenu({player, sub_menu})
        end)

      else
        vRPclient.notify(player, {"Identificare invalida"})
      end
    end})
  end
end, "Verifica dosarele penale ale unui jucator"}


local function build_thePc(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local x, y, z = table.unpack(tdCords)

		local thePc_enter = function(player, area)
			local user_id = vRP.getUserId({player})
      if user_id ~= nil then
        if vRP.hasPermission({user_id,"police.pc"}) then
          if menu_thePc then vRP.openMenu({player, menu_thePc}) end
        end
			end
		end

		local thePc_leave = function(player, area)
			vRP.closeMenu({player})
		end

		vRPclient.addMarker(source,{x,y,z-0.95,0.7,0.7,0.4,0, 221, 140, 33, 150})

		vRP.setArea({source, "vRP:dosarealex", x, y, z, 1, 1, thePc_enter, thePc_leave})
	end
end



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

local platePrice = 500



function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

playerRegVeh = {}
isUsingRAR = false

local function build_rar_menu(source)
	local x, y, z = 451.82543945313,-990.51391601563,30.689493179321
	local function rarmenu_enter(source,area)
		user_id = vRP.getUserId({source})
		if user_id ~= nil then
			rar_menu = {name="Registrul Auto Roman",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
			exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {['@user_id'] = user_id}, function (theVehicles)
				if #theVehicles > 0 then
					for i, v in pairs(theVehicles) do
						vehName = v.vehicle
						currentNrPlate = tostring(v.vehicle_plate)
						
						if(string.sub(currentNrPlate, 1, 2) == "P ")then
							isReg = "<font color='red'>NU</font><br>Taxa: $<font color='blue' size=3.6>"..platePrice.."</font><br><br>Apasa <font color='green'>'ENTER'</font> pentru a inmatricula vehiculul!"
							isPlate = "<font color='red'>"..currentNrPlate.."</font>"
						else
							isReg = "<font color='green'>DA</font><br>Taxa: $<font color='blue' size=3.6>"..platePrice.."</font><br><br>Apasa <font color='green'>'ENTER'</font> pentru a iti schimba numarul de inmatriculare!"
							isPlate = "<font color='green'>"..currentNrPlate.."</font>"
						end
						rar_menu[vehName] = {function(player, choice)
							if(isUsingRAR == false)then
								isUsingRAR = true
								user_id = vRP.getUserId({player})
								playerRegVeh[user_id] = tostring(v.vehicle)
								rar2_menu = {name="Registrul Auto Roman",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
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
																	
																	exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @vehicle_plate", {['@vehicle_plate'] = thePlate}, function (pvehicle)
																		if #pvehicle > 0 then
																			vRPclient.notify(player, {"~r~O masina cu acest numar de inmatriculare exista deja!"})
																		else
																			if(vRP.tryFullPayment({user_id, platePrice}))then
																				theVeh = playerRegVeh[user_id]
		
																				exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET vehicle_plate = @vehicle_plate WHERE user_id = @user_id AND vehicle = @vehicle", {
																					['@user_id'] = user_id, 
																					['@vehicle'] = theVeh,
																					['@vehicle_plate'] = thePlate
																				}, function (rows)
																				
																				  end)

																				vehName, vehPrice = theVeh
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
						end, "Placuta: "..isPlate.."<br>Inamtriculat: "..isReg}
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
		
	vRPclient.addBlip(source,{x,y,z,198,67,"Registrul Auto Roman"})
	vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
	vRP.setArea({source,"vRP:RAR",x,y,z,1,1.5,rarmenu_enter,rarmenu_leave})
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_rar_menu(source)
    build_thePc(source)
    playerRegVeh[user_id] = nil
  end
  if user_id then
    exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id AND carnet = 1", {['@id']= user_id}, function(rows)
      if #rows > 0 then
          TriggerClientEvent('dmv:CheckLicStatus',source)
      end
    end)
  end
end)

RegisterCommand("rar", function(source)
	user_id = vRP.getUserId({source})
	build_rar_menu(source)
		playerRegVeh[user_id] = nil
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	isUsingRAR = false
end)


vRP.registerMenuBuilder({"police", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		choices = {}

   
    if vRP.hasPermission({user_id,"politie.acces"}) then
      choices["Da-i carnetul unui jucator"] = choice_setlc
    end

    if vRP.hasPermission({user_id,"politie.acces"}) then
    choices["Verifica Asigurare Masina"] = choice_askasig
    end
  
    if vRP.hasPermission({user_id,"politie.acces"}) then
    choices["Verifica Certificat Auto"] = choice_askcertf
    end

    if vRP.hasPermission({user_id,"sias.acces"}) then
      choices["Ofera Permisul Port-Arma"] = choice_dapermisarma
    end
    if vRP.hasPermission({user_id,"sias.acces"}) then
      choices["Confisca Permisul Port-Arma"] = choice_iapermisarma
    end
     if vRP.hasPermission({user_id,"sias.acces"}) then
      choices["Verifica Licenta Port-Arma"] = choice_askaporm
    end

    if vRP.hasPermission({user_id,"politie.acces"}) then
    choices["Confisca Permisul unui jucator"] = choice_iapermis
   end
   if vRP.hasPermission({user_id,"politie.acces"}) then
    choices["Verifica Permis"] = choice_verificaPermis
   end
   if vRP.hasPermission({user_id,"verifica.buletin"}) then
    choices["Verifica Buletin"] = choice_askBuletin
   end

		add(choices)
	end
end})
