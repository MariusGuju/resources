local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPclient = Tunnel.getInterface("vRP","vrp_staff")
vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP","vrp_staff")

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    if first_spawn then
        local user_id = vRP.getUserId({source})
        if vRP.hasGroup({user_id,"fondator"}) then
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Fondatorul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")
        elseif vRP.hasGroup({user_id,"Community Manager"}) then
                TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Managerul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")
        elseif vRP.hasGroup({user_id,"dev"}) then 
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Scripterul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")
        elseif vRP.hasGroup({user_id,"Head Of Staff"}) then 
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 HOS-ul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!") 
        elseif vRP.hasGroup({user_id,"admin"})  then   
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Adminul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")
        elseif vRP.hasGroup({user_id,"moderator"})   then  
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Moderatorul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")  
        elseif vRP.hasGroup({user_id,"trialhelper"})   then  
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Helperul in teste ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")  
        elseif vRP.hasGroup({user_id,"helper"}) then    
            TriggerClientEvent('chatMessage', -1, "^1[STAFF]^7 Helperul ^1"..GetPlayerName(source).."["..user_id.."]^7 tocmai a intrat pe server!")                                         
        end
    end
end)

function refferal(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        print("referal mesaj")
        exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id AND folositref = 0", {['@user_id'] = user_id}, function(folosit)
            print(#folosit)
            if #folosit == 1 then
                vRP.prompt({player, "Cine te-a adus pe server?", "", function(player, idceliref)
                    if idceliref ~= nil then
                        if tonumber(idceliref) ~= user_id then
                            local jucatorref = vRP.getUserSource({idceliref})
                            exports.ghmattimysql:execute("UPDATE vrp_users SET refferal = refferal + 1 WHERE id = @user_id", {['@user_id'] = idceliref})
                            exports.ghmattimysql:execute("UPDATE vrp_users SET folositref = 1 WHERE id = @user_id", {['@user_id'] = user_id})
                            vRPclient.notify(player,{"Felicitari , te-ai afiliat cu ~g~"..idceliref.."~w~ , si pentru asta ai primit : ~g~500RON"})
                            vRP.giveMoney({user_id,500})
                            local userref = vRP.getUserSource({idceliref})
                            exports.ghmattimysql:execute("UPDATE vrp_user_moneys SET bank = bank + @suma WHERE user_id = @user_id", {['@suma'] = 500,['@user_id'] = idceliref})
                            if userref ~= nil then
                                vRPclient.notify(userref,{user_id.." a fost afiliat de tine si , ~w~ai primit ~g~500RON ~w~pentru asta !"})
                            end
                        else
                            vRPclient.notify(player,{"Nu poti sa te afiliezi singur"})
                        end
                    end
                end})
            else
                vRPclient.notify(player,{"Deja ai fost afiliat de cineva"})
            end
        end)
    end
end

RegisterCommand('testref', function(source, args, rawCommand)
    refferal(source,choice)
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		choices["Referal"] = {refferal, "Te afiliezi cu cineva si primesti : <font color='green'>$500</font>"}
	    add(choices)
    end
end})