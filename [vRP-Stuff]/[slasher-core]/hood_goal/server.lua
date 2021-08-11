local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_jobgl")
vRPCjobgoal = Tunnel.getInterface("esk_jobgl","esk_jobgl")
vRPjobgoal = {}
Tunnel.bindInterface("esk_jobgl",vRPjobgoal)
Proxy.addInterface("esk_jobgl",vRPjobgoal)

-- alter table vrp_users add goalj integer not null default 0;
--[[
CREATE TABLE IF NOT EXISTS esk_goal(
  goal integer not null default 1
);
]]

--[[RegisterServerEvent('getGoal')
AddEventHandler('getGoal',function(maxGoal)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        exports.ghmattimysql:execute("SELECT * FROM esk_goal", {}, function (rows)
            exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (goalulmeu)
                exports.ghmattimysql:execute("SELECT goalj FROM vrp_users", {}, function (goalJucatori)
                    if #rows > 0 then
                        if rows[1].goal >= maxGoal then
                            local users = vRP.getUsers()
                            for k,v in pairs (users) do
                                vRP.giveMoney({k,goalulmeu[1].goalj})
                                vRPclient.notify(player,{"Ai primit ~g~$"..goalulmeu[1].goalj.." + 1 CUFAR GUR~w~ Contributie de la terminarea ~b~GOAL-ULUI~w~. Felicitari!"})
                                vRP.giveInventoryItem({k, "cufargur.", 1, true})
                            end
                            for k,v in pairs (goalJucatori) do
                                local idOnline = vRP.getUserId({k})
                                if idOnline == nil then
                                --print("ID JUCATOR OFFLINE: "..k.." SUMA PE CARE O PRIMESTE: $"..v.goalj)
                                    exports.ghmattimysql:execute("UPDATE vrp_user_moneys SET wallet= wallet +@baniPlus WHERE user_id = @user_id", {['@user_id'] = k,['@baniPlus'] = v.goalj}, function (rowsx) end)
                                end
                            end
        
                            TriggerClientEvent('mesajPeChat', -1, "^4[GOAL] ^7 S-A RESETAT. CEI PREZENTI PE SERVER AU PRIMIT BONUSUL!")
                            exports.ghmattimysql:execute("UPDATE vrp_users SET goalj=@goalj", {['@goalj'] = 0}, function (rows) end)
                            exports.ghmattimysql:execute("UPDATE esk_goal SET goal=@goal", {['@goal'] = 1}, function (rowsz) end)
                        else
                            vRPCjobgoal.spawnJobGoal(player,{rows[1].goal,goalulmeu[1].goalj})
                        end
                    end
                end)
            end)
        end)
    end
end)]]

-- optimizare proasta la aia de sus


RegisterServerEvent('getGoal')
AddEventHandler('getGoal',function(maxGoal)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        if maxGoal ~= nil then
        exports.ghmattimysql:execute("SELECT * FROM esk_goal", {}, function (rows)
            if rows[1].goal >= maxGoal then
                exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (goalulmeu)
                    exports.ghmattimysql:execute("SELECT goalj FROM vrp_users", {}, function (goalJucatori)
                    
                        local users = vRP.getUsers()
                        local bonusgoal = goalulmeu[1].goalj*0.5
                        local maxbani = goalulmeu[1].goalj + bonusgoal
                        for k,v in pairs (users) do
                            vRP.giveMoney({k,maxbani})
                            vRPclient.notify(player,{"Ai primit ~g~$"..maxbani.."~w~ Contributie de la terminarea ~b~GOAL-ULUI~w~. Felicitari!"})
                        end
                        for k,v in pairs (goalJucatori) do
                            local idOnline = vRP.getUserId({k})
                            if idOnline == nil then
                            --print("ID JUCATOR OFFLINE: "..k.." SUMA PE CARE O PRIMESTE: $"..v.goalj)
                                exports.ghmattimysql:execute("UPDATE vrp_user_moneys SET wallet= wallet +@baniPlus WHERE user_id = @user_id", {['@user_id'] = k,['@baniPlus'] = v.goalj}, function (rowsx) end)
                            end
                        end
                        TriggerClientEvent('chatMessage', -1, "^4[GOAL] ^7 S-A RESETAT. CEI PREZENTI PE SERVER AU PRIMIT BONUSUL!")
                        exports.ghmattimysql:execute("UPDATE vrp_users SET goalj=@goalj", {['@goalj'] = 0}, function (rows) end)
                        exports.ghmattimysql:execute("UPDATE esk_goal SET goal=@goal", {['@goal'] = 5}, function (rows) end)
                    end)
                end)
                
            else
                exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (goalulmeu)
                    vRPCjobgoal.spawnJobGoal(player,{rows[1].goal,goalulmeu[1].goalj})
                end)
            end
        end)
    end
    end
end)
