local valor_fixo = false 	
local valor = 200 			
local valor_min = 50 		

local permissao = "hacker.job" 	
local item_necessario = true			
local item = "laptophacking"			

local lokatzii = {
	{261.51309204102,204.75910949707,110.2869644165}, 
	{-1053.6899414063,-230.54859924316,44.020938873291}, 	
}

function vRPeskJobs.spawnHeckermen(source)
    vRPCeskJobs.puneHEKERMENUL(source,{lokatzii})
end

RegisterNetEvent('finish:hacker')
AddEventHandler("finish:hacker", function(sucess,rtime)
	local user_id = vRP.getUserId({source})
	if valor_fixo then 
		vRP.giveMoney({user_id, valor})
		vRPclient.notify(source,{"Ai primit ~r~R$"..valor.."~w~pentru piratarea instituției."})
	else
		rtime = math.floor(rtime/100)
		if rtime < valor_min then rtime = valor_min end
		vRP.giveMoney({user_id, rtime})
		vRPclient.notify(source,{"Ai primit ~r~R$"..rtime.."~w~pentru piratarea instituției."})
	end
end)

RegisterNetEvent('start:hacker')
AddEventHandler("start:hacker", function()
	local source = source
	local user_id = vRP.getUserId({source})
	if item_necessario then
		TriggerClientEvent('start:hacker', source, true)
	else
		TriggerClientEvent('start:hacker', source, true)
	end
end)

