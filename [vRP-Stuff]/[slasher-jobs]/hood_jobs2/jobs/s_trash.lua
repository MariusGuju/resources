trashSpawnLocs = {
	[1] = {1711.0128173828,-1576.0037841796,112.58661651612},
	[2] = {1714.4001464844,-1566.099609375,112.62517547608}
}

trashLoadLocs = {
	{143.83424377442,-1696.9743652344,29.29167175293},
	{-572.15356445312,-858.56140136718,26.234426498414},
	{-361.3010559082,-960.61145019532,31.080610275268},
	{73.188835144042,-208.74322509766,54.491394042968},
	{664.70928955078,204.56454467774,94.60832977295},	
	{1180.9938964844,-302.46334838868,69.098510742188},
	{972.4722290039,-946.1683959961,42.31855392456},
	{941.19250488282,-1002.414489746,38.50330734253},
	{713.67407226562,-1099.451538086,22.359395980834},
	{951.91638183594,-1576.7163085938,30.412168502808},
	{1197.9340820312,-1272.2504882812,35.226760864258},
	{897.7797241211,-1256.057006836,25.751804351806},
	{847.89245605468,-1409.7109375,26.101028442382},
	{598.00415039062,-2788.2504882812,6.058093547821},
	{150.22766113282,-2400.0695800782,6.0002517700196}
}

finishTrashPoint = {1728.4772949218,-1573.335571289,112.610496521}

trashDrivers = {}

function vRPjobs.executeTrashJob(thePlayer)
	vRPCjobs.trashPopulateData(thePlayer, {trashSpawnLocs, trashLoadLocs, finishTrashPoint})
end

function vRPjobs.spawnTrashTruck()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Gunoier")then
		if(trashDrivers[user_id] == nil)then
			trashDrivers[user_id] = 0
			vRPCjobs.spawnTrashTruck(thePlayer, {})
		else
			vRPclient.notify(thePlayer, {"[GUNOIER] ~r~Ai deja o gunoiera spawnata!"})
		end
	else
		vRPclient.notify(thePlayer, {"[GUNOIER] ~r~Nu esti angajat ca ~y~Gunoier"})
	end
end

function vRPjobs.addToTrashPay(thePay)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Gunoier") and (trashDrivers[user_id] ~= nil)then
		trashDrivers[user_id] = trashDrivers[user_id] + thePay
	end
end

function vRPjobs.stopTrashJob()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Gunoier") and (trashDrivers[user_id] ~= nil)then
		trashDrivers[user_id] = nil
	end
end

function vRPjobs.payTrashDriver()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local rewardMoney = tonumber(trashDrivers[user_id])
	vRP.giveMoney({user_id, rewardMoney})
	updateGoalContributie = rewardMoney / 2
	exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
	exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = rewardMoney}, function (rows) end)
	vRPclient.notify(thePlayer, {"[GUNOIER] ~g~Ai primit ~y~$"..rewardMoney.." ~g~pentru tura de ~b~Gunoier"})
	trashDrivers[user_id] = nil
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		SetTimeout(1000, function()
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Gunoier")then
				vRPjobs.executeTrashJob(source)
			end
		end)
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Gunoier")then
		trashDrivers[user_id] = nil
		vRPCjobs.deleteTrashTruck(source, {})
	end
end)