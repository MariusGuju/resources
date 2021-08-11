local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

RSCclient = Tunnel.getInterface("vrp_pnames","vrp_pnames")
vRPclient = Tunnel.getInterface("vRP","vrp_pnames")
vRP = Proxy.getInterface("vRP")


factions = {
	{"esk", "esk"}
}

local function update_name(player, user_id, source)
	vRP.getUserIdentity({user_id, function(identity)
		if identity ~= nil then
			group = "Civilian"
			for i, v in pairs(factions) do
				theGroup = tostring(v[1])
				theName = tostring(v[2])
				if(vRP.hasGroup({user_id, theGroup}))then
					group = theGroup
				end
			end
			RSCclient.insertUser(player,{user_id,source,vRP.hasPermission({user_id, "player.group.add"}),group})
		end
	end})
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
		update_name(source,k,v)
		update_name(v,user_id,source)
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
		RSCclient.removeUser(v,{user_id})
	end
end)

--[[
AddEventHandler('chatMessage', function(source, color, msg)
	cm = stringsplit(msg, " ")
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if(vRP.hasPermission({user_id, "id.admin"}))then
	if cm[1] == "/noid" then
		CancelEvent()
		TriggerClientEvent("SetGod", -1, player)
		TriggerClientEvent('chatMessage', -1, "^0[^4Krimes^0]", {255, 0, 0}, "^0Un admin a ^1dezactivat ^0id-urile.")
	end    
	if cm[1] == "/id" then
		CancelEvent()
		TriggerClientEvent("SetGod1", -1, player)
		TriggerClientEvent('chatMessage', -1, "^0[^4Krimes^0]", {255, 0, 0}, "^0Un admin a ^2activat ^0id-urile.")
	end
end)
--]]

function stringsplit(inputstr, sep)
  if sep == nil then
      sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      t[i] = str
      i = i + 1
  end
  return t
end