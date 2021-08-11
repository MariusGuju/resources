local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
 
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_licenses")

local commands = {
  ["/k"] = {
    -- /pos to log postion to file with user name and msg
    action = function(source, args, msg) 
        TriggerClientEvent('KneelHU', source, {})
    end
 },
}


AddEventHandler("chatMessage", function(source, args, msg)
    if msg:sub(1, 1) == "/" then
        text = splitString(msg, " ")
        cmd = text[1]
		args = text[2]
		for k,v in ipairs(text) do
          if k > 2 then
		    args = args.." "..v
          end
		end
		for k,v in pairs(commands) do
          if cmd == k then
		    v.action(source, args, msg)
        	CancelEvent()
          end
		end
    end
end)

local ch_slasherarest = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
     TriggerClientEvent('slasher:aresteazanabu', nplayer, source) 
     TriggerClientEvent('slasher:aresteaza', source)  
     Citizen.Wait(5000)
     vRPclient.toggleHandcuff(nplayer,{})
    else
      vRPclient.notify(player,{"Nu e niciun jucator in apropiere"})
    end
  end)
end, "Aresteaza infractoru"}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Aresteaza"] = ch_slasherarest
    end
	
    add(choices)
  end
end})
