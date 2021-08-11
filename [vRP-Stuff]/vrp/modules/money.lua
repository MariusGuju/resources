local lang = vRP.lang
--[[-106.93295288086,6468.7436523438,31.626703262329]]
local playerMoney = {}

-- Money module, wallet/bank API
-- The money is managed with direct SQL requests to prevent most potential value corruptions
-- the wallet empty itself when respawning (after death)

local data = [[
  CREATE TABLE IF NOT EXISTS vrp_user_moneys(
    user_id INTEGER,
    wallet INTEGER,
    bank INTEGER,
    CONSTRAINT pk_user_moneys PRIMARY KEY(user_id),
    CONSTRAINT fk_user_moneys_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
  );
  ]]


local data = [[
  CREATE TABLE IF NOT EXISTS vrp_money_logs(
  from_user_id INTEGER,
  to_user_id INTEGER,
  amount INTEGER,
  time TIMESTAMP 
);
]]

-- load config
local cfg = module("cfg/money")

-- API
-- get money
-- cbreturn nil if error
function vRP.formatMoney(amount)
  local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
function vRP.getMoney(user_id)
  if(playerMoney[user_id])then
    return playerMoney[user_id].wallet
  else
    return 0
  end
end

function vRP.hasBankAccount(user_id)
  if(playerMoney[user_id])then
    if playerMoney[user_id].hasBankAccount == "Da" then
      return true
    end
    return false
  else
    return false
  end
end
-- set money
function vRP.setMoney(user_id,value)
  if(tonumber(value) >= 0)then
    if(playerMoney[user_id])then
      playerMoney[user_id].wallet = value
    end
    exports.ghmattimysql:execute('UPDATE vrp_users SET walletMoney = @wallet WHERE id = @user_id', {["@wallet"] = value, ["@user_id"] = user_id}, function(data)end)
  end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"money",lang.money.display({"$ "..vRP.formatMoney(value)})})
  end
end
-- try a payment
-- return true or false (debited if true)
function vRP.tryPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if (money >= amount) and (amount >= 0) then
    vRP.setMoney(user_id,money-amount)
    return true
  else
    return false
  end
end

-- give money
function vRP.giveMoney(user_id,amount,jobs)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
  vRPclient.arataTranzactie(vRP.getUserSource(user_id),{"plus",amount})
  if jobs then
    jobGoal.cresteJobGoal({tonumber(amount)})
  end
end

-- get bank money
function vRP.getBankMoney(user_id)
  if(playerMoney[user_id])then
    if playerMoney[user_id].hasBankAccount == "Da" then
      return playerMoney[user_id].bank
    end
    return 0
  else
    return 0
  end
end

-- set bank money
function vRP.setBankMoney(user_id,value)
  if(playerMoney[user_id])then
    playerMoney[user_id].bank = value
  end
  exports.ghmattimysql:execute('UPDATE vrp_users SET bankMoney = @bank WHERE id = @user_id', {["@bank"] = value, ["@user_id"] = user_id}, function(data)end)
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"bmoney",lang.money.bdisplay({"$ "..vRP.formatMoney(value)})})
  end
end

-- give bank money
function vRP.giveBankMoney(user_id,amount)
  player = vRP.getUserSource(user_id)
  if playerMoney[user_id].hasBankAccount == "Da" then
    if amount > 0 then
      local money = vRP.getBankMoney(user_id)
      vRP.setBankMoney(user_id,money+amount)
      vRPclient.arataTranzactie(vRP.getUserSource(user_id),{"plus",amount})
    end
  else
    vRPclient.notify(player,{"~r~Nu detii un cont bancar! Du-te la banca sa-ti deschizi unul."})
  end
end

-- try a withdraw
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id,amount)
  player = vRP.getUserSource(user_id)
  if playerMoney[user_id].hasBankAccount == "Da" then
    local money = vRP.getBankMoney(user_id)
    if amount > 0 and money >= amount then
      vRP.setBankMoney(user_id,money-amount)
      vRP.giveMoney(user_id,amount)

      return true
    else
      return false
    end
  else
    vRPclient.notify(player,{"~r~Nu detii un cont bancar! Du-te la banca sa-ti deschizi unul."})
    return false
  end
end

-- try a deposit
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id,amount)
  player = vRP.getUserSource(user_id)
  if playerMoney[user_id].hasBankAccount == "Da" then
    if amount > 0 and vRP.tryPayment(user_id,amount) then
      vRP.giveBankMoney(user_id,amount)
      return true
    else
      return false
    end
  else
    vRPclient.notify(player,{"~r~Nu detii un cont bancar! Du-te la banca sa-ti deschizi unul."})
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- return true or false (debited if true)
function vRP.tryFullPayment(user_id,amount)
  player = vRP.getUserSource(user_id)
  if playerMoney[user_id].hasBankAccount == "Da" then
    local money = vRP.getMoney(user_id)
    if money >= amount  and (amount >= 0) then -- enough, simple payment
      return vRP.tryPayment(user_id, amount)
    else  -- not enough, withdraw -> payment
      if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
        return vRP.tryPayment(user_id, amount)
      end
    end

    return false
  else
    vRPclient.notify(player,{"~r~Nu detii un cont bancar! Du-te la banca sa-ti deschizi unul."})
    return false
  end
end
function vRP.getAur(user_id)
  if(playerMoney[user_id])then
    return playerMoney[user_id].getAur
  else
    return 0
  end
  end
  function vRP.getPuncte(user_id)
  if(playerMoney[user_id])then
    return playerMoney[user_id].getPuncte
  else
    return 0
  end
  end
function vRP.getWarKingsRpCoins(user_id)
  if(playerMoney[user_id])then
    return playerMoney[user_id].WarKingsRpCoins
  else
    return 0
  end
  end
--[[ Set Gift Points ( Dependency of vRP.giveGiftPoints )
> Verifica daca GiftPointsurile tale sunt mai mari decat 500 pentru a nu trece de limita.
]]

--[[function vRP.setGiftCoins(user_id,value)
  if(playerMoney[user_id])then
    if(tonumber(value) >= 0)then
      if(tonumber(value) <= 500)then
        if(playerMoney[user_id].giftPoints + value <= 500)then
          playerMoney[user_id].giftPoints = value
          exports["GHMattiMySQL"]:QueryAsync('UPDATE vrp_users SET giftPoints = @giftPoints WHERE id = @user_id', {["giftPoints"] = value, ["user_id"] = user_id}, function(data)end)
        end
    else
      end
    end
  end
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"gmoney",lang.money.gdisplay({value})})
  end
end]]

function vRP.setWarKingsRpCoins(user_id,value)
  if(tonumber(value) >= 0)then
    if(playerMoney[user_id])then
      playerMoney[user_id].WarKingsRpCoins = value
    end
    exports.ghmattimysql:execute('UPDATE vrp_users SET WarKingsRpCoins = @giftPoints WHERE id = @user_id', {["@giftPoints"] = value, ["@user_id"] = user_id}, function(data)end)
  end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"gmoney",lang.money.gdisplay({value})})
  end
end
function vRP.setAur(user_id,value)
  if(tonumber(value) >= 0)then
    if(playerMoney[user_id])then
      playerMoney[user_id].WarKingsRpCoins = value
    end
    exports.ghmattimysql:execute('UPDATE vrp_users SET setAur = @setAur WHERE id = @user_id', {["@setAur"] = value, ["@user_id"] = user_id}, function(data)end)
  end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"amoney",lang.money.adisplay({value})})
  end
end
function vRP.setPuncte(user_id,value)
  if(tonumber(value) >= 0)then
    if(playerMoney[user_id])then
      playerMoney[user_id].WarKingsRpCoins = value
    end
    exports.ghmattimysql:execute('UPDATE vrp_users SET setPuncte = @setPuncte WHERE id = @user_id', {["@setPuncte"] = value, ["@user_id"] = user_id}, function(data)end)
  end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"pmoney",lang.money.pdisplay({value})})
  end
end
function vRP.tryCoinsPayment(user_id,amount)
  local coins = vRP.getWarKingsRpCoins(user_id)
  if (coins >= amount) and (amount >= 0) then
    vRP.setWarKingsRpCoins(user_id,coins-amount)
    return true
  else
    return false
  end
end
function vRP.giveWarKingsRpCoins(user_id,amount)
  local coins = vRP.getWarKingsRpCoins(user_id)
  vRP.setWarKingsRpCoins(user_id,coins+amount)
end




local function ch_give(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and vRP.tryPayment(user_id,amount) then
              vRP.giveMoney(nuser_id,amount)
              vRPclient.notify(player,{lang.money.given({amount})})
              vRPclient.notify(nplayer,{lang.money.received({amount})})
            else
              vRPclient.notify(player,{lang.money.not_enough()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

-- add player give money to main menu
vRP.registerMenuBuilder("interaction", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}

    add(choices)
  end
end)


---[[ CREATE BANK ACCOUNT ]]--
local coordonate = {-1629.2785644531,188.46214294434,60.61474609375}
local npcPos = {-1629.2785644531,188.46214294434,60.61474609375}
local bankAccount = {
  name = "Bank Account",
  css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
}

bankAccount["Cont Bancar"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if player ~= nil then
    if playerMoney[user_id].hasBankAccount == "Da" then
      vRPclient.notify(player,{"~r~Deja ai un cont bancar deschis!"})
    else
      if vRP.getUserHoursPlayed(user_id) >= 0 then
        vRP.prompt(player, "Esti sigur ca vrei sa-ti deschizi un cont bancar?", "da/nu", function(player,raspuns)
          if raspuns ~= nil then
            if raspuns == "da" or raspuns == "Da" or raspuns == "DA" or raspuns == "dA" then
              TriggerClientEvent("MPF",player,"~w~Ti-ai deschis un cont bancar la ~b~BCR~r~ Romania ~w~\n Ai primit bonusul de inceput de ~g~1.000$")
              exports.ghmattimysql:execute('UPDATE vrp_users SET hasBankAccount = @true WHERE id = @user_id',{['@user_id'] = user_id,['@true'] = "Da"})
              playerMoney[user_id].hasBankAccount = "Da"
              vRP.setBankMoney(user_id,5000)
              vRPclient.notify(player,{"~w~[~b~BCR ~r~Romania~w~] ~g~Ti-ai deschis un cont bancar, acum poti folosi toate facilitatile bancii!"})
            else
              vRPclient.notify(player,{"~r~Se pare ca nu vrei sa-ti deschizi un cont bancar,revino data viitoare."})
            end
          else
            vRPclient.notify(player,{"~r~Raspuns invalid!"})
          end

        end)
      else
        vRPclient.notify(player,{"~r~Nu poti sa-ti deschizi un cont bancar daca nu ai peste ~g~2 ore jucate!"})
      end
    end
  end

end, "<font color='cyan'>Deschide-ti un cont bancar</font> <br> <br> Deschide-ti un cont bancar pentru a avea parte de toate beneficiile <font color='blue'>BCR</font> <font color='red'>Banking</font>"}

local function build_client_shop(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then

    local x, y, z = table.unpack(coordonate)

    local conf_enter = function(player, area)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        if bankAccount then 
            vRP.openMenu(player, bankAccount)
        end
      end
    end

    local conf_leave = function(player, area)
      vRP.closeMenu(player)
    end
    
    vRPclient.addMarkerNames(source,{npcPos[1],npcPos[2],npcPos[3]+1.1, "Bancher", 1.3})
    vRPclient.addMarkerNames(source,{npcPos[1],npcPos[2],npcPos[3]+1.0, "~b~[ ~w~Hai baiete la mine sa-ti deschizi un cont bancar! ~b~]", 0.6})
    vRPclient.createNPC(source,{"~g~Bancher","ig_bankman",npcPos[1],npcPos[2],npcPos[3]-1.0,120.0,0.0,0.0})
    vRPclient.addMarker(source,{x,y,z-0.95,1,1,0.9,0, 0, 255, 0,150})
    vRP.setArea(source, "vRP:bankAccount", x, y, z, 3, 2, conf_enter, conf_leave,true,"Apasa ~g~[E] ~w~pentru a-ti deschide un ~r~Cont Bancar")
  end
end

RegisterCommand("fixbank", function(source)
  build_client_shop(source)
end)

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @user_id', {["@user_id"] = user_id}, function(rows)
    if #rows > 0 then
      playerMoney[user_id] = {bank = rows[1].bankMoney, wallet = rows[1].walletMoney,hasBankAccount = rows[1].hasBankAccount, WarKingsRpCoins = rows[1].WarKingsRpCoins}
    end
  end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
  playerMoney[user_id] = nil
end)

-- money hud
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    -- add money display
    build_client_shop(source)
    vRPclient.setDiv(source,{"money",cfg.display_css,lang.money.display({"$ "..vRP.formatMoney(vRP.getMoney(user_id))})})
    vRPclient.setDiv(source,{"bmoney",cfg.display_css,lang.money.bdisplay({"$ "..vRP.formatMoney(vRP.getBankMoney(user_id))})})
  end
end)
