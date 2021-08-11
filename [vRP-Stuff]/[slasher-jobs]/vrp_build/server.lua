local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_santierist")
vRPCsantierist = Tunnel.getInterface("vRP_santierist","vRP_santierist")

vRPsantierist = {}
Tunnel.bindInterface("vRP_santierist",vRP_santierist)
Proxy.addInterface("vRP_santierist",vRP_santierist)

RegisterServerEvent("vRP_job_santierist:pay")
AddEventHandler("vRP_job_santierist:pay",function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local salariu = 35
    if user_id ~= nil and player then
        updateGoalContributie = salariu
	    exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
	    exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
	    exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
		    ['@id'] = user_id
	    }, function (rows)
        end)
        vRP.giveMoney({user_id,salariu})
        vRPclient.notify(player,{"[CR]Ai primit 50 LEI pentru lucrarea facuta","success"})
    end
end)

