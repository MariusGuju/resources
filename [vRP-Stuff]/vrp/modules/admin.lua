local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")


local webhookAdmin = 'https://discord.com/api/webhooks/843422702496776212/WQb9ip9QiNk9NTuT4-c_gCU9I8_Htfi90CCKljsYcfzFqx-tfHtMR78k__ivUz-mG3q4'

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.hasPermission(k, "admin.tickets") and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

------------------------------------------------------
local onduty = { 1 }
local function ch_adminduty(player,choice)
    local user_id = vRP.getUserId(player)
    local nume_player = GetPlayerName(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"staff.duty") then
    if onduty[user_id] == 1 then
      onduty[user_id] = 0
      vRP.addUserGroup(user_id,'acces.duty')
      TriggerClientEvent('chatMessage', -1, "ATENTIE!", { 255, 0, 0 }, "^2Adminul " .. nume_player .. " a intrat ON-DUTY")
      vRPclient.notify(source,{"[STAFF-Info] - Este on DUTY vei primi [Tickete] si [ACCES] la comenzii"})
    else
      onduty[user_id] = 1
      vRP.removeUserGroup(user_id,'acces.duty')
      TriggerClientEvent('chatMessage', -1, "ATENTIE!", { 255, 0, 0 }, "^2Adminul " .. nume_player .. " a intrat OFF-DUTY")
      vRPclient.notify(source,{"[STAFF-Info] - Este off DUTY nu vei primi [Tickete] si [ACCES] la comenzii"})
    end
  end
end
--------------------------------------------------------
local function ch_addgroup(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.add") and onduty[user_id] == 0 then
    vRP.prompt(player,"User id: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Group to add: ","",function(player,group)
      if group == superadmin and not vRP.hasPermission(user_id,"player.group.add.superadmin") then
        do return end
      end
      if group == admin and not vRP.hasPermission(user_id,"player.group.add.admin") then
        do return end
      end  		 
      vRP.addUserGroup(id,group)
      vRPclient.notify(player,{group.." added to user "..id})

      local embed = {
        {
          ["color"] = 1234521,
          ["title"] = "**".. "ADAUGARE GRUPA".."**",
          ["description"] = "Administratorul "..GetPlayerName(player).."["..user_id.."] a folosit **add group** ["..group.."] pe jucatorul ("..id..")",
          ["thumbnail"] = {
            ["url"] = "https://www.pngitem.com/pimgs/m/144-1447190_add-user-group-woman-man-icon-transfer-png.png",
          },
          ["footer"] = {
          ["text"] = "",
          },
        }
      }
      PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 

      end)
    end)
  else
		vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
	end
end


local function ch_removegroup(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.remove") and onduty[user_id] == 0 then
    vRP.prompt(player,"User id: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Group to remove: ","",function(player,group) 
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})

        local embed = {
          {
            ["color"] = 0xFF0000,
            ["title"] = "**".. "ELIMINARE GRUPA".."**",
            ["description"] = "Administratorul "..GetPlayerName(player).." a folosit **remove group** ("..group..") pe jucatorul ["..id.."]",
            ["thumbnail"] = {
            ["url"] = "https://cdn1.iconfinder.com/data/icons/mix-color-3/502/Untitled-25-512.png",
            },
            ["footer"] = {
            ["text"] = "",
            },
          }
        }
        PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 

      end)
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end
RegisterCommand('bagaban', function(source, args, rawCommand)
	if(source == 0)then
		id = tonumber(args[1])
		reason = tostring(args[2])
		local theTarget = vRP.getUserSource(id)
		if(theTarget)then
			TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^3"..GetPlayerName(theTarget).." ^2a fost banat de Consola")
			vRP.ban(theTarget,"Banat de consola", "Consola")
		end
	end
end)
RegisterCommand('bagakick', function(source, args, rawCommand)
	if(source == 0)then
		id = tonumber(args[1])
		reason = tostring(args[2])
		local theTarget = vRP.getUserSource(id)
		if(theTarget)then
			TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^3"..GetPlayerName(theTarget).." ^2a primit kick de la Consola")
			vRP.kick1337(theTarget,"Ai primit Kick de la Consola")
		end
	end
end)
local function ch_kick(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") and onduty[user_id] == 0 then
    vRP.prompt(player,"ID: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Cauza: ","",function(player,reason)
        local source = vRP.getUserSource(id)
        if source ~= nil and not id == 1 then
          local embed = {
						{
							["color"] = 0xFF7400,
							["title"] = "**".. "KICK".."**",
							["description"] = "Administratorul "..GetPlayerName(player).."("..id..") i-a dat kick lui "..GetPlayerName(id).."("..id..")\nCauza:"..reason,
							["thumbnail"] = {
								["url"] = "https://logopond.com/logos/5547875bcbba9c76a60ff38dc3b6d236.png",
							},
							["footer"] = {
							["text"] = "",
							},
						}
          }
          PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
         
          vRP.kick1337(source,reason)
          vRPclient.notify(player,{"kicked user "..id})
        end
      end)
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

--[[
	ALTER TABLE vrp_users ADD banatDe VARCHAR(255) NOT NULL default "NU E BANAT";
	ALTER TABLE vrp_users ADD zileBan INTEGER NOT NULL default 0;
	ALTER TABLE vrp_users ADD cauzaBan VARCHAR(255) NOT NULL default "NU E BANAT";
	ALTER TABLE vrp_users ADD banPanaPe VARCHAR(255) NOT NULL default "NU E BANAT";
]]


local function ch_ban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") and onduty[user_id] == 0 then
    vRP.prompt(player,"User id to ban: ","",function(player,idJucator)
      idJucator = parseInt(idJucator)
      if idJucator == 1 or idJucator == 2 or idJucator == 3 then
        vRPclient.notify(player,{"[Liquid|Romania]COAIE NU-MI POTI DA BAN"})
      else
        vRP.isBanned(idJucator, function(banned)
          if not banned then
            vRP.prompt(player,"Zile ","",function(player,zileBan)
              zileBan = parseInt(zileBan)
              vRP.prompt(player,"Reason: ","",function(player,cauzaBan)
                local source = vRP.getUserSource(idJucator)
                if source ~= nil then 
                  vRP.getLastLogin(idJucator, function(last_login)

                    local creation_date = os.date("%d/%m/%Y")
              
                    local dayValue, monthValue, yearValue = string.match(creation_date, '(%d+)/(%d+)/(%d+)')
                    
                    dayValue, monthValue, yearValue = tonumber(dayValue), tonumber(monthValue), tonumber(yearValue)
                    
                    expiry_date = os.date("%d/%m/%Y",os.time{year = yearValue, month = monthValue, day = dayValue }+zileBan*24*60*60)

                    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned , banatDe = @banatDe ,zileBan = @zileBan, cauzaBan = @cauzaBan, banPanaPe = @banPanaPe WHERE id = @user_id", {
                      ['@user_id'] = idJucator, 
                      ['@banned'] = 1, 
                      ['@banatDe'] = GetPlayerName(player), 
                      ['@zileBan'] = zileBan, 
                      ['@cauzaBan'] = cauzaBan,
                      ['@banPanaPe'] = expiry_date
                    }, function (rows)
                  
                  end)
                  
                  end)
                  TriggerClientEvent('chatMessage', -1, "[ADMIN]", { 255, 0, 0 }, '^4 '..GetPlayerName(player)..'^2['..user_id..' ^0] l-a banat pe ^3 ID '..idJucator..'^7 cauza: ^2 '..cauzaBan.."^7 Pentru: ^2"..zileBan.." zile")
                      
                  local embed = {
                    {
                      ["color"] = 0xFF0000,
                      ["title"] = "**".. "BAN".."**",
                      ["description"] = "Administrator "..GetPlayerName(player).."("..user_id..")\n Id banat: ("..idJucator..")\nCauza:"..cauzaBan.."\nZile: "..zileBan,
                      ["thumbnail"] = {
                        ["url"] = "https://www.psdstamps.com/wp-content/uploads/2019/11/grunge-banned-label-png.png",
                      },
                      ["footer"] = {
                      ["text"] = "",
                      },
                    }
                  }
                  PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
                  vRP.kick1337(source,cauzaBan)
                  vRP.ban1337(source,cauzaBan)
                  vRPclient.notify(player,{"banned user "..idJucator})
                end
              end)
            end)
          else
            TriggerClientEvent('chatMessage', source, "Jucatorul e deja banat.")
          end
        end)
      end
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

local function ch_serverban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") and onduty[usrID] == 0 then
    vRP.prompt(player,"User id to ban: ","",function(player,idJucator)
      idJucator = parseInt(idJucator)
      if idJucator == 1 or idJucator == 2 or idJucator == 3 then
        vRPclient.notify(player,{"[Liquid|Romania]COAIE NU-MI POTI DA BAN"})
      else
        vRP.isBanned(idJucator, function(banned)
          if not banned then
            vRP.prompt(player,"Zile ","",function(player,zileBan)
              zileBan = parseInt(zileBan)
              vRP.prompt(player,"Reason: ","",function(player,cauzaBan)
                local source = vRP.getUserSource(idJucator)
                if source ~= nil then 
                  vRP.getLastLogin(idJucator, function(last_login)

                    local creation_date = os.date("%d/%m/%Y")
              
                    local dayValue, monthValue, yearValue = string.match(creation_date, '(%d+)/(%d+)/(%d+)')
                    
                    dayValue, monthValue, yearValue = tonumber(dayValue), tonumber(monthValue), tonumber(yearValue)
                    
                    expiry_date = os.date("%d/%m/%Y",os.time{year = yearValue, month = monthValue, day = dayValue }+zileBan*24*60*60)

                    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned , banatDe = @banatDe ,zileBan = @zileBan, cauzaBan = @cauzaBan, banPanaPe = @banPanaPe WHERE id = @user_id", {
                      ['@user_id'] = idJucator, 
                      ['@banned'] = 1, 
                      ['@banatDe'] = "SERVER", 
                      ['@zileBan'] = zileBan, 
                      ['@cauzaBan'] = cauzaBan,
                      ['@banPanaPe'] = expiry_date
                    }, function (rows)                  
                  end)                  
                  end)                           
               	  vRP.kick1337(source,cauzaBan)
                  vRP.ban1337(source,cauzaBan)
                  vRPclient.notify(player,{"banned user "..idJucator})
                end
              end)
            end)
          else
            TriggerClientEvent('chatMessage', source, "Jucatorul e deja banat.")
          end
        end)
      end
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

local function ch_unban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unban") and onduty[user_id] == 0 then
    vRP.prompt(player,"User id to unban: ","",function(player,id)
      id = parseInt(id)
      vRP.setBanned(id,false)
      vRPclient.notify(player,{"un-banned user "..id})
      local embed = {
        {
          ["color"] = 0xFF0000,
          ["title"] = "**".. "UNBAN".."**",
          ["description"] = "Administratorul "..GetPlayerName(player).."("..user_id..") i-a dat unban jucatorului  "..id
        }
      }
      PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end


local function ch_coords(player,choice)
  vRPclient.getPosition(player,{},function(x,y,z)
    vRP.prompt(player,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
  end)
end

local function ch_tptome(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and onduty[user_id] == 0 then
  vRPclient.getPosition(player,{},function(x,y,z)
    vRP.prompt(player,"User id:","",function(player,user_id) 
      local tplayer = vRP.getUserSource(tonumber(user_id))
      if tplayer ~= nil then
        vRPclient.teleport(tplayer,{x,y,z})
        local embed = {
          {
            ["color"] = 0xFF0000,
            ["title"] = "**".. "TELEPORT TO ME".."**",
            ["description"] = "Administratorul "..GetPlayerName(player).."("..user_id..") l-a teleportat pe "..GetPlayerName(tplayer).." la el"
          }
        }
        PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
      end
    end)
  end)
else
  vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

local function ch_tpto(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and onduty[user_id] == 0 then
  vRP.prompt(player,"User id:","",function(player,user_id) 
    local tplayer = vRP.getUserSource(tonumber(user_id))
    if tplayer ~= nil then
      vRPclient.getPosition(tplayer,{},function(x,y,z)
        vRPclient.teleport(player,{x,y,z})
        local embed = {
          {
            ["color"] = 0xFF0000,
            ["title"] = "**".. "TELEPORT TO TO PLAYER".."**",
            ["description"] = "Administratorul "..GetPlayerName(player).."("..user_id..") si-a dat teleport la jucatorul"..GetPlayerName(tplayer)
          }
        }
        PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
      end)
    end
  end)
else
  vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

local function ch_playergivemoneyto(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayers(player,{15},function(nplayers)
      usrList = ""
      for k,v in pairs(nplayers) do
        usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end
      if usrList ~= "" then
        vRP.prompt({player,"Jucatori din apropriere: " .. usrList .. "","",function(player,nuser_id) 
          nuser_id = nuser_id
          if nuser_id ~= nil and nuser_id ~= "" then 
            local target = vRP.getUserSource({tonumber(nuser_id)})
            if target ~= nil then
              vRP.prompt({player,lang.money.give.prompt(),"",function(player,amount)
                local amount = parseInt(amount)
                if amount > 0 then
                  if vRP.tryPayment({user_id,amount}) then
                    local pID = vRP.getUserId({target})
                    local money = vRP.getMoney({pID})                   
                    vRP.giveMoney({pID,amount})
                    vRPclient.notify(player,{lang.money.given({amount})})
                    vRPclient.notify(target,{lang.money.received({amount})})

                  else
                    vRPclient.notify(player,{lang.money.not_enough()})
                  end
                else
                  vRPclient.notify(player,{lang.common.invalid_value()})
                end
              end})
            else
              vRPclient.notify(player,{lang.common.no_player_near()})
            end
          else
            vRPclient.notify(player,{lang.common.no_player_near()})
          end
        end})
      else
        vRPclient.notify(player,{"~r~Niciun jucator in apropriere."})
      end
    end)
  end
end
local function ch_tptocoords(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and onduty[user_id] == 0 then
  vRP.prompt(player,"Coords x,y,z:","",function(player,fcoords) 
    local coords = {}
    for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
      table.insert(coords,tonumber(coord))
    end

    local x,y,z = 0,0,0
    if coords[1] ~= nil then x = coords[1] end
    if coords[2] ~= nil then y = coords[2] end
    if coords[3] ~= nil then z = coords[3] end

    vRPclient.teleport(player,{x,y,z})

    local embed = {
      {
        ["color"] = 0xFF0000,
        ["title"] = "**".. "TELEPORT TO COORDS".."**",
        ["description"] = "Administratorul "..GetPlayerName(player).." si-a dat teleport la coordonatele "..x,y,z
      }
    }
    PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

  end)
else
  vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
end
end

local function ch_giveMoney(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and onduty[user_id] == 0 then
    vRP.prompt(player,"Amount:","",function(player,amount) 
      amount = parseInt(amount)
      if amount <= 5000000 then
        vRP.giveMoney(user_id, amount)
                   
        local embed = {
          {
            ["color"] = 0xFF0000,
            ["title"] = "**".. "GIVEMONEY".."**",
            ["description"] = "Administratorul "..GetPlayerName(player).."("..user_id..") a folosit givemoney si si-a dat  **"..amount.."$**"
          }
        }
        PerformHttpRequest(webhookAdmin, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
      else
        vRPclient.notify(player,"Nu-ti poti seta o valoare asa mare!")
      end
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
 end

end

local function ch_giveitem(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and onduty[user_id] == 0 then
    vRP.prompt(player,"Id name:","",function(player,idname) 
      idname = idname or ""
      vRP.prompt(player,"Amount:","",function(player,amount) 
        amount = parseInt(amount)
        vRP.giveInventoryItem(user_id, idname, amount,true)
      end)
    end)
  else
    vRPclient.notify(player,{"∑~r~[STAFF-info] ~m~- ~m~Nu esti ON DUTY"})
 end
end

function vRP.getUserWarns(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	return tmp.warns
end

function vRP.warnUser(user_id)
	local warnuri = vRP.getUserWarns(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if(warnuri < 3)then
		warns = warnuri + 1
		if tmp then
			tmp.warns = warns
		end
		exports.ghmattimysql:execute("UPDATE vrp_users SET warns = @warns WHERE id = @user_id", {['@user_id'] = user_id, ['@warns'] = warns})
	else
		local source = vRP.getUserSource(user_id)
		TriggerClientEvent('chatMessage', -1, "^8[WARN] ^2"..GetPlayerName(source).." ^8a primit ^2Ban Permanent ^8pentru ^23 Warn-uri!")
		vRP.ban1337(source,"Ai primit peste 3 warn-uri!")
	end
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	exports.ghmattimysql:execute("SELECT warns FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
		local warns = tonumber(rows[1].warns)
		local tmp = vRP.getUserTmpTable(user_id)
		if tmp then
			tmp.warns = warns
		end
  end)
end)

local function ch_warnUser(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil == 0 then
		vRP.prompt(player,"ID-ul jucatorului: ","",function(player,userID)
			userID = parseInt(userID)
			if (tonumber(userID)) then
				local theTarget = vRP.getUserSource(userID)
				if(theTarget)then
					warns = (vRP.getUserWarns(userID)+1)
					vRPclient.notify(theTarget,{"~w~[WARN] ~r~Ai primit warn de la ~g~"..GetPlayerName(player).."\n~r~Ai ~g~"..warns.." ~r~warn-uri!"})
					vRPclient.notify(player,{"~w~[WARN] ~r~I-ai dat warn lui ~g~"..GetPlayerName(theTarget).."\n~r~Acum are ~g~"..warns.." ~r~warn-uri!"})
					vRP.warnUser(userID)
				end
			end
		end)
end
end


local function ch_calladmin(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"Describe your problem:","",function(player,desc) 
      desc = desc or ""
      if desc ~= nil and desc ~= "" then
      local answered = false
      local players = {}
      for k,v in pairs(vRP.rusers) do
        local player = vRP.getUserSource(tonumber(k))
        -- check user
        if vRP.hasPermission(k,"admin.tickets") and player ~= nil then
          table.insert(players,player)
        end
      end

      -- send notify and alert to all listening players
      for k,v in pairs(players) do
        usrID = vRP.getUserId(v)
      if onduty[usrID] == 1 then
        vRPclient.notify(player, {""})
      else if onduty[usrID] == 0 then
        vRP.request(v,"Admin ticket (user_id = "..user_id..") take/TP to ?: "..htmlEntities.encode(desc), 60, function(v,ok)
          if ok then -- take the call
            if not answered then
              -- answer the call
                vRPclient.notify(player,{"Un admin a preluat ticket-ul ."})
                vRPclient.getPosition(player, {}, function(x,y,z)
                vRPclient.teleport(v,{x,y,z})
              end)
              answered = true
              vRP.sendStaffMessage("^2["..GetPlayerName(v).."]^0 a luat tichetul lui ^2" ..user_id.. "( problema: " ..htmlEntities.encode(desc).. ")" ) 
              local sender_id = vRP.getUserId(v)
              exports.ghmattimysql:execute("UPDATE vrp_users SET raport = raport + 1 WHERE id = @sender_id",{['@sender_id'] = sender_id })

              local embed = {
                {
                  ["color"] = 0xFF0000,
                  ["title"] = "**".. "TICKET".."**",
                  ["description"] = "Administratorul "..GetPlayerName(v).."("..sender_id..") i-a acceptat ticket-ul lui "..GetPlayerName(player).."["..user_id.."]"
                }
              }
              PerformHttpRequest("https://discord.com/api/webhooks/843422702496776212/WQb9ip9QiNk9NTuT4-c_gCU9I8_Htfi90CCKljsYcfzFqx-tfHtMR78k__ivUz-mG3q4", function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
            else
              vRPclient.notify(v,{"Ticket dejaluat."})
            end
          end
        end)
      end
      end
      end
      else
        vRPclient.notify(player,{"Empty Admin Call."})
      --end
    end
    end)
  end
end

RegisterCommand('resetraport', function(source, args, msg)
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id, "dev") then
        vRPclient.notify(source, {"~g~Rapoartele au fost resetate cu succes"})
        exports.ghmattimysql:execute("UPDATE `vrp_users` SET `raport` = 0")
    end
end)

RegisterCommand('rapoarte', function(source, args, msg)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.tickets") then
        exports.ghmattimysql:execute("SELECT `raport`, `id` FROM `vrp_users` WHERE `raport` != 0", {}, function(rows)
            local content = "<em><b>RAPORT STAFF</b></em>"
            for i, v in pairs(rows) do
                content = content .. "<br/><em>ID: " .. v.id .. " -> " .. v.raport .. " rapoarte</em>"
            end
            vRPclient.setDiv(source,{"ples_raport",".div_ples_raport{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
            Wait(10000)
            vRPclient.removeDiv(source,{"ples_raport"})
        end)
    end
end)

playersSpectating = {}
playersToSpectate = {}

local function specPlayer(player,choice)
	local user_id = vRP.getUserId(player)
	target = playersToSpectate[choice]
	if(user_id == target)then
		vRPclient.notify(player,{"~r~Nu te poti cauta pe tine!"})
	else
		theTarget = vRP.getUserSource(target)
		vRPclient.spectatePlayer(player,{theTarget})
		playersSpectating[user_id] = target
	end
	vRP.closeMenu(player)
end

local function cancelSpec(player,choice)
	local user_id = vRP.getUserId(player)
	playersSpectating[user_id] = nil
end

local function ch_spec(player,choice)
	users = vRP.getUsers()
	vRP.closeMenu(player)
	SetTimeout(400, function()
		vRP.buildMenu("Spectate Player", {player = player}, function(menu)
			menu.name = "Spectate Player"
			menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
			menu.onclose = function(player) vRP.openMainMenu(player) end	
			if(playersSpectating[user_id] == nil)then
				myName = tostring(GetPlayerName(player))
				for k,v in pairs(users) do
					playerName = tostring(GetPlayerName(v))
					playersToSpectate[playerName] = tonumber(k)
					menu[playerName] = {specPlayer, "Spectate a player"}
				end
			else
				menu["Anuleaza Spectate-ul"] = {cancelSpec, "Anuleaza spectate-ul jucatorului"}
			end
			vRP.openMenu(player, menu)
		end)
	end)
end


local function ch_noclip(player, choice)
  vRPclient.toggleNoclip(player, {})
end

-- Hotkey Open Admin Menu 1/2
function vRP.openAdminMenu(source)
  vRP.buildMenu("admin", {player = source}, function(menudata)
    menudata.name = "Admin"
    menudata.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
    vRP.openMenu(source,menudata)
  end)
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
  vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices["Admin"] = {function(player,choice)
      vRP.buildMenu("admin", {player = player}, function(menu)
        menu.name = "Admin"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu

        if vRP.hasPermission(user_id,"player.group.add") then
          menu["Add group"] = {ch_addgroup}
        end
        if vRP.hasPermission(user_id,"player.group.remove") then
          menu["Remove group"] = {ch_removegroup}
        end
        if vRP.hasPermission(user_id,"player.ban") then
          menu["Da warn"] = {ch_warnUser}
        end
        if vRP.hasPermission(user_id,"player.kick") then
          menu["Kick"] = {ch_kick}
        end
        if vRP.hasPermission(user_id,"player.ban") then
          menu["Ban"] = {ch_ban}
        end
        if vRP.hasPermission(user_id,"player.VanishBan") then
          menu["Ban Vanish"] = {ch_ban}
        end
        if vRP.hasPermission(user_id,"player.unban") then
          menu["Unban"] = {ch_unban}
        end
        if vRP.hasPermission(user_id,"player.noclip") then
          menu["Noclip"] = {ch_noclip}
        end
        if vRP.hasPermission(user_id,"player.coords") then
          menu["Coords"] = {ch_coords}
        end
        if vRP.hasPermission(user_id,"player.tptome") then
          menu["TpToMe"] = {ch_tptome}
        end
        if vRP.hasPermission(user_id,"player.spectate") then
          menu["Spectate Player"] = {ch_spec}
        end        
        if vRP.hasPermission(user_id,"player.tpto") then
          menu["TpTo"] = {ch_tpto}
        end
        if vRP.hasPermission(user_id,"player.tpto") then
          menu["TpToCoords"] = {ch_tptocoords}
        end
        if vRP.hasPermission(user_id,"staff.duty") then
          menu["STAFF DUTY"] = {ch_adminduty}
        end
        if vRP.hasPermission(user_id,"player.giveMoney") then
          menu["Give money"] = {ch_giveMoney}
        end
        if vRP.hasPermission(user_id,"player.giveitem") then
          menu["Give item"] = {ch_giveitem}
        end
		if vRP.hasPermission(user_id,"player.calladmin") then
          menu["Ofera bani"] = {ch_playergivemoneyto}
        end
        if vRP.hasPermission(user_id,"player.calladmin") then
          menu["Call admin"] = {ch_calladmin}
        end

        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
	end
end)

RegisterCommand('restartserver', function(source, args, rawCommand)
	if(source == 0)then
		users = vRP.getUsers()
		if(rawCommand:sub(9) == nil) or (rawCommand:sub(9) == "")then
			reason = "[RESTART] Serverul a fost restartat! Te rugam sa revii in cateva minute!"
		else
			reason = rawCommand:sub(9)
		end
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN ^21 MINUT!")
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN^21 MINUT!")
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN ^21 MINUT!")
		SetTimeout(30000, function()
			TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
			TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
			TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
			SetTimeout(30000, function()
				for i, v in pairs(users) do
					vRP.kick1337(v,reason)
				end
			end)
		end)
	else
		user_id = vRP.getUserId(source)
		if vRP.hasPermission(user_id,"acces.restart") then
			users = vRP.getUsers()
			if(rawCommand:sub(9) == nil) or (rawCommand:sub(9) == "")then
				reason = "[RESTART] Serverul a fost restartat! Te rugam sa revii in cateva minute!"
			else
				reason = rawCommand:sub(9)
			end
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN ^21 MINUT!")
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN ^21 MINUT!")
		TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART INTR-UN ^21 MINUT!")
		SetTimeout(30000, function()
			TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
			TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
			TriggerClientEvent('chatMessage', -1, "[CConsola]", { 255, 0, 0 }, "SE VA DA RESTART IN ^230 DE SECUNDE!")
				SetTimeout(30000, function()
					for i, v in pairs(users) do
						vRP.kick1337(v,reason)
					end
				end)
			end)
		end
	end
end)

-- admin god mode
-- function task_god()
  -- SetTimeout(10000, task_god)

  -- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
    -- vRP.setHunger(v, 0)
    -- vRP.setThirst(v, 0)

    -- local player = vRP.getUserSource(v)
    -- if player ~= nil then
      -- vRPclient.setHealth(player, {200})
    -- end
  -- end
-- end

-- task_god()