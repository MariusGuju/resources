
local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
local version = module("version")
Debug.active = config.debug

vRP = {}
Proxy.addInterface("vRP",vRP)
tvRP = {}
Tunnel.bindInterface("vRP",tvRP) 
local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)
vRPclient = Tunnel.getInterface("vRP","vRP") 
vRPjobs = Proxy.getInterface("vRP_jobs")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}

hoursPlayed = {}

print("[NorbSiMaruServer] init base tables")

function vRP.getUserIdByIdentifiers(ids, cbr)
  local task = Task(cbr)
  
  if ids ~= nil and #ids then
      local i = 0

  -- search identifiers
  local function search()
      i = i+1
      if i <= #ids then
          if(string.match(ids[i], "ip:"))then
              search()
          else
              exports.ghmattimysql:execute("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {['@identifier'] = ids[i]}, function (rows)

                    if #rows > 0 then  -- found
                        task({rows[1].user_id})
                    else -- not found
                        search()
                    end
                  -- end
              end)
          end
      else -- no ids found, create user
        exports.ghmattimysql:execute("INSERT INTO vrp_users(`whitelisted`, `banned`) VALUES(@whitelisted, @banned)",
    {
    ['@whitelisted'] = 0, 
    ['@banned'] = 0
    }, 
        function (rows)
    
          if rows  then
                  local user_id = rows["insertId"]
                  -- add identifiers
                  for l,w in pairs(ids) do
                      --if (string.find(w, "ip:") == nil) then  -- ignore ip identifier
                          exports.ghmattimysql:execute("INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)", {['@user_id'] = user_id, ['@identifier'] = w})
                      --end
                  end

                  task({user_id})
              else
                  task()
              end
          end)
        end
      end
      search()
  else
      task()
   end
end


-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
  local ids = GetPlayerIdentifiers(source)
  local idk = "idk_"
  for k,v in pairs(ids) do
    idk = idk..v
  end

  return idk
end

function vRP.getPlayerEndpoint(player)
  return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.getPlayerName(player)
  return GetPlayerName(player) or "unknown"
end

--- sql
function vRP.isBanned(user_id, cbr)
  local task = Task(cbr, {false})
  exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (rows)
    if #rows > 0 then
      task({rows[1].banned})
    else
      task()
    end
  end)
end
--- sql




--- sql
function vRP.setBanned(user_id,banned,reason,by)
	if(banned == false)then
		reason = ""
	end
	if(tostring(by) ~= "Consola")then
		theAdmin = vRP.getUserId(by)
		adminName = GetPlayerName(by)
		banBy = adminName.." ["..theAdmin.."]"
	else
		banBy = "Consola"
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, cauzaBan = @reason, BanatDe = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = banBy})
end

--function vRP.setBanned(user_id,banned)
 ---- exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned WHERE id = @user_id", {['@user_id'] = user_id, ['@banned'] = 1}, function (rows)  end)
--end


--- sql
function vRP.isWhitelisted(user_id, cbr)
  local task = Task(cbr, {false})
  exports.ghmattimysql:execute("SELECT whitelisted FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (rows)
    if #rows > 0 then
      task({rows[1].whitelisted})
    else
      task()
    end
  end)
end

--- sql
function vRP.setWhitelisted(user_id,whitelisted)
  exports.ghmattimysql:execute("UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id", {['@user_id'] = user_id, ['@whitelisted'] = whitelisted}, function (rows) end)
end

--- sql
function vRP.getLastLogin(user_id, cbr)
  local task = Task(cbr,{""})
  exports.ghmattimysql:execute("SELECT last_login FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (rows)
    if #rows > 0 then
      task({rows[1].last_login})
    else
      task()
    end
  end)
end

function vRP.setUData(user_id,key,value)
  --print("userdata:"..user_id.." DATA: KEY "..key.." VALUE: "..value)
  --print("setudata")
  exports.ghmattimysql:execute("REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)", {['@user_id'] = user_id, ['@key'] = key, ['@value'] = value}, function (rows) end)
end

function vRP.getUData(user_id,key,cbr)
  local task = Task(cbr,{""})
  --print("getudata")
  exports.ghmattimysql:execute("SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key", {['@user_id'] = user_id, ['@key'] = key}, function (rows)
    if #rows > 0 then
    -- print('GET UDATA dValue: '..rows[1].dvalue)
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

function vRP.setSData(key,value)
  --print("SERVER DATA: KEY"..key.."    VALUE: "..value)
  print("setsdata")
  exports.ghmattimysql:execute("REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)", {['@key'] = key, ['@value'] = value}, function (rows) end)
end

function vRP.getSData(key, cbr)
  local task = Task(cbr,{""})

  exports.ghmattimysql:execute("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {['@key'] = key}, function (rows)
    Citizen.Wait(100)
    if #rows > 0 then
      --print('GET SDATA dValue: '..rows[1].dvalue)
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
  return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
  return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
  return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  return tmp and tmp.spawns == 1
end


function vRP.getUserId(source)
  if source ~= nil then
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
      return vRP.users[ids[1]]
    end
  end

  return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
  local users = {}
  for k,v in pairs(vRP.user_sources) do
    users[k] = v
  end

  return users
end

function vRP.getActivePlayers()
  return #vRP.user_sources
end

-- return source or nil
function vRP.getUserSource(user_id)
  return vRP.user_sources[user_id]
end

function vRP.ban1337(source,reason)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    vRP.setBanned(user_id,true)
    vRP.kick1337(source,"[Banned] "..reason)
  end
end
function vRP.ban(source,reason,admin)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    vRP.setBanned(user_id,1,reason,admin)
	motiv = "De: "..admin.."\nMotiv: "..reason.."\nID-ul Tau: ["..user_id.."]\n\nPentru unban intra pe Discord: discord.io/NorbSiMaruServer"
    vRP.kick1337(source,"[Banned] "..motiv)
  end
end

function vRP.kick1337(source,reason)
  DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
  TriggerEvent("vRP:save")

  Debug.pbegin("vRP save datatables")
  for k,v in pairs(vRP.user_tables) do
    --print("save_datables")
    vRP.setUData(k,"vRP:datatable",json.encode(v))
  end

  Debug.pend()
  SetTimeout(config.save_interval*1000, task_save_datatables)
end
task_save_datatables()


function vRP.getUserHoursPlayed(user_id)
  if(hoursPlayed[user_id] ~= nil)then
    return math.floor(hoursPlayed[user_id])
  else
    return 0
  end
end

function tvRP.updateHoursPlayed(hours)
  user_id = vRP.getUserId(source)
  exports.ghmattimysql:execute("UPDATE vrp_users SET hoursPlayed = hoursPlayed + @hours WHERE id = @user_id", {['@hours'] = hours, ['@user_id'] = user_id})
  hoursPlayed[user_id] = hoursPlayed[user_id] + hours
end

-- handlers
--MySQL.createCommand("vRP/selectInfoBan","SELECT * FROM vrp_users WHERE id = @id")

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

AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
  deferrals.defer()

  local source = source
  Debug.pbegin("playerConnecting")
  local ids = GetPlayerIdentifiers(source)

  if ids ~= nil and #ids > 0 then
    deferrals.update("[NorbSiMaruServer] Checking identifiers...")
    vRP.getUserIdByIdentifiers(ids, function(user_id)
      -- if user_id ~= nil and vRP.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
      if user_id ~= nil then -- check user validity 
        deferrals.update("[NorbSiMaruServer] Checking banned...")
        if string.len(name) >= 1 and string.len(name) < 30 then
          deferrals.update("[NorbSiMaruServer] Checking Nickname number...")
        vRP.isBanned(user_id, function(banned)
          if not banned then
            deferrals.update("[NorbSiMaruServer] Checking whitelisted...")
            vRP.isWhitelisted(user_id, function(whitelisted)
              if not config.whitelist or whitelisted then
                Debug.pbegin("playerConnecting_delayed")
                if vRP.rusers[user_id] == nil then -- not present on the server, init
                  -- init entries
                  vRP.users[ids[1]] = user_id
                  vRP.rusers[user_id] = ids[1]
                  vRP.user_tables[user_id] = {}
                  vRP.user_tmp_tables[user_id] = {}
                  vRP.user_sources[user_id] = source

                  -- load user data table
                  deferrals.update("[NorbSiMaruServer] Loading datatable...")
                  vRP.getUData(user_id, "vRP:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then vRP.user_tables[user_id] = data end

                    -- init user tmp table
                    local tmpdata = vRP.getUserTmpTable(user_id)

                    deferrals.update("[NorbSiMaruServer] Getting last login...")
                    vRP.getLastLogin(user_id, function(last_login)
                      tmpdata.last_login = last_login or ""
                      tmpdata.spawns = 0
                      local ep = vRP.getPlayerEndpoint(source)
                      local last_login_stamp = ep.." "..os.date("%H:%M:%S %d/%m/%Y")

                      exports.ghmattimysql:execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {['@user_id'] = user_id, ['@last_login'] = last_login_stamp }, function (rows) end)

                      print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") joined (user_id = "..user_id..")")

                      local embed = {
                        {
                          ["color"] = 0xFF0000,
                          ["title"] = "**".. "INTRARE PE SERVER".."**",
                          ["description"] = name.." joined (user_id = "..user_id..")"
                        }
                      }
                      PerformHttpRequest('https://discord.com/api/webhooks/843422702496776212/WQb9ip9QiNk9NTuT4-c_gCU9I8_Htfi90CCKljsYcfzFqx-tfHtMR78k__ivUz-mG3q4', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

                      TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                      deferrals.done()
                    end)
                  end)
                else -- already connected
                  print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") re-joined (user_id = "..user_id..")")

                  local embed = {
                    {
                      ["color"] = 0xFF0000,
                      ["title"] = "**".. "RE-INTRARE PE SERVER".."**",
                      ["description"] = name.." re-joined (user_id = "..user_id..")"
                    }
                  }
                  PerformHttpRequest('https://discord.com/api/webhooks/843422702496776212/WQb9ip9QiNk9NTuT4-c_gCU9I8_Htfi90CCKljsYcfzFqx-tfHtMR78k__ivUz-mG3q4', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })


                  TriggerEvent("vRP:playerRejoin", user_id, source, name)
                  deferrals.done()

                  local tmpdata = vRP.getUserTmpTable(user_id)
                  tmpdata.spawns = 0
                end

                Debug.pend()
              else
                print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") (user_id = "..user_id.."),Nu are whitelist")
                deferrals.done("[NorbSiMaruServer] Nu ai whitelist pentru a intra pe server (user_id = "..user_id.."),pentru a primi whitelist intra pe discord: invite.gg/NorbSiMaruServer pentru mai multe informatii.")
              end
            end)
          else

            print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: banned (user_id = "..user_id..")")
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = user_id}, function (rows)
              vRP.getLastLogin(user_id, function(last_login)
                local ep = vRP.getPlayerEndpoint(source)
                local last_login_stampinfo = os.date("%d/%m/%Y")
                local last_login_stampinfoHour = os.date("ORA: %H:%M:%S")
                local info = rows[1].banPanaPe:split("/") -- pana cand are ban
                local info2 = last_login_stampinfo:split("/") -- de cand a luat ban

                if rows[1].banPanaPe <= last_login_stampinfo then
                  deferrals.done("[NorbSiMaruServer Server] REINTRA! Ai primit unban cu succes >< \n ID-ul tau: "..user_id..". \n De catre: "..rows[1].banatDe.." \n Pentru : "..rows[1].zileBan.." zile\nCauza Ban:"..rows[1].cauzaBan.." \nBan primit pe: "..last_login_stampinfo.." | ORA:"..last_login_stampinfoHour.." \n Expira pe: "..rows[1].banPanaPe.." [AI PRIMIT UNBAN] \n [ Aplica o cerere de unban pe invite.gg/NorbSiMaruServer ]")

                  exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, banatDe = @banatDe, zileBan = @zileBan, cauzaBan = @cauzaBan, banPanaPe = @banPanaPe WHERE id = @user_id", {['@user_id'] = user_id, ['@banned'] = 0, ['@banatDe'] = "NU", ['@zileBan'] = 0, ['@cauzaBan']= "MU", ['@banPanaPe']=0}, function (rowsBanned)end)
                else
                  deferrals.done("[NorbSiMaruServer Server] Esti banat Cumetre >< \n ID-ul tau: "..user_id..". \n De catre: "..rows[1].banatDe.." \n Pentru : "..rows[1].zileBan.." zile \nCauza Ban:"..rows[1].cauzaBan.."\n Ban primit pe: "..last_login_stampinfo.." | "..last_login_stampinfoHour.." \n Expira pe: "..rows[1].banPanaPe.." [BANAT] \n [ Aplica o cerere de unban pe invite.gg/NorbSiMaruServer ]")
                end
              end)
            end)

          end
        end)
      else
        print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: Numele tau este prea lung")
        deferrals.done("[NorbSiMaruServer] Numele tau este prea lung.")
      end
      else
        print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: identification error")
        deferrals.done("[NorbSiMaruServer] Identification error.")
      end
    end)
  else
    print("[NorbSiMaruServer] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: missing identifiers")
    deferrals.done("[NorbSiMaruServer] Missing identifiers.")
  end
  Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
  local source = source
  Debug.pbegin("playerDropped")

  -- remove player from connected clients
  vRPclient.removePlayer(-1,{source})


  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    TriggerEvent("vRP:playerLeave", user_id, source)

    -- save user data table
    --print("save_datables")
    vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))

    print("[vRP] "..vRP.getPlayerEndpoint(source).." disconnected (user_id = "..user_id..")")
    local embed = {
      {
        ["color"] = 0xFF0000,
        ["title"] = "**".. "A IESIT DE PE SERVER FUTU-I MAICA LUI DE SOBOLAN".."**",
        ["description"] = " disconnected (user_id = "..user_id..")"
      }
    }
    PerformHttpRequest('https://discord.com/api/webhooks/843422702496776212/WQb9ip9QiNk9NTuT4-c_gCU9I8_Htfi90CCKljsYcfzFqx-tfHtMR78k__ivUz-mG3q4', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

    vRP.users[vRP.rusers[user_id]] = nil
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
  end
  Debug.pend()
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
  Debug.pbegin("playerSpawned")
  -- register user sources and then set first spawn to false
  local user_id = vRP.getUserId(source)
  local player = source
  if user_id ~= nil then
    vRP.user_sources[user_id] = source
    local tmp = vRP.getUserTmpTable(user_id)
    tmp.spawns = tmp.spawns+1
    local first_spawn = (tmp.spawns == 1)

    if first_spawn then
      -- first spawn, reference player
      -- send players to new player
      for k,v in pairs(vRP.user_sources) do
        vRPclient.addPlayer(source,{v})
      end
      -- send new player to all players
      vRPclient.addPlayer(-1,{source})
    end
    
    exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function(theHours)
			hoursPlayed[user_id] = tonumber(theHours[1].hoursPlayed)
	  end)
    -- set client tunnel delay at first spawn
    Tunnel.setDestDelay(player, config.load_delay)

    -- show loading
    exports.ghmattimysql:executeSync("UPDATE vrp_users SET username = @username WHERE id = @user_id",{["user_id"] = user_id, ["username"] = GetPlayerName(player)}, function(data) end)
    --exports.ghmattimysql:execute("UPDATE vrp_users SET username = @username WHERE id = @user_id",{["user_id"] = user_id, ["username"] = GetPlayerName(player)}, function(data) end)
    vRPclient.setProgressBar(player,{"vRP:loading", "botright", "Se incarca resursele...", 0,0,0, 100})
    
    SetTimeout(2000, function() -- trigger spawn event
      TriggerEvent("vRP:playerSpawn",user_id,player,first_spawn)

      SetTimeout(config.load_duration*1000, function() -- set client delay to normal delay
        Tunnel.setDestDelay(player, config.global_delay)
        vRPclient.removeProgressBar(player,{"vRP:loading"})
      end)
    end)
  end

  Debug.pend()
end)

RegisterServerEvent("vRP:playerDied")
--NetworkSetTalkerProximity(proximity+0.0001)