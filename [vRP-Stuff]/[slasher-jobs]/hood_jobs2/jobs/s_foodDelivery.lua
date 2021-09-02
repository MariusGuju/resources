fDeliveryLocations = {
	{-819.55072021484,267.93579101562,86.395973205566},
	{-197.7691040039,86.154273986816,69.756248474122},
	{315.87115478516,501.42428588868,153.17979431152},
	{-230.4842224121,488.44897460938,128.76803588868},
	{-775.15936279296,312.81448364258,85.698135375976},
	{-1116.8157958984,304.25888061524,66.521270751954},
	{-1579.9289550782,-33.994640350342,57.56517791748},
	{-1643.1025390625,-411.88488769532,42.077892303466},
	{-328.2096862793,369.87362670898,110.0061416626},
	{321.0319519043,-1759.9439697266,29.637830734252},
	{385.38854980468,-1881.8702392578,26.031164169312},
	{1214.4187011718,-1644.1274414062,48.645984649658},
	{-634.70849609375,208.78964233398,74.14527130127},
	{-451.18768310546,395.57482910156,104.77416992188},
	{-595.37310791016,530.06005859375,107.75540924072},
	{-1007.0379638672,513.00170898438,79.597389221192},
	{-1413.5086669922,462.3547668457,109.20852661132},
	{-1394.087524414,-919.75305175782,11.081608772278},
	{-1086.08984375,-1503.6739501954,5.7073111534118},
	{-1750.3107910156,-697.19537353516,10.175079345704},
	{46.066696166992,-1864.226196289,23.278295516968},
	{85.769981384278,-1959.5791015625,21.12167930603},
	{23.187299728394,-1896.5762939454,22.965883255004},
	{20.94361114502,-1844.4470214844,24.60174369812},
	{-50.410766601562,-1783.2958984375,28.300821304322},
	{-45.798526763916,-1445.4519042968,32.429607391358},
	{5.2221970558166,-1884.1954345704,23.697267532348},
	{270.06341552734,-1917.103149414,26.180419921875},
	{512.50555419922,-1790.7609863282,28.919481277466},
	{1207.3409423828,-620.26953125,66.438636779786},
	{1372.9887695312,-555.71850585938,74.685668945312},
	{1060.8348388672,-378.30853271484,68.230758666992}
}

fDeliverySpawnLoc = {-1164.1016845704,-889.11041259766,14.14921951294}

fDeliveryDrivers = {}

function vRPjobs.executeFoodDeliveryJob(thePlayer)
	vRPCjobs.fDeliveryPopulateData(thePlayer, {fDeliverySpawnLoc, fDeliveryLocations})
end

function vRPjobs.spawnFoodDeliveryScooter()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Uber Eatz")then
		if(fDeliveryDrivers[user_id] == nil)then
			fDeliveryDrivers[user_id] = true
			vRPCjobs.spawnFoodDeliveryScooter(thePlayer, {})
		else
			vRPclient.notify(thePlayer, {"[UBER EATZ] ~r~Ai deja un scuter spawnat!"})
		end
	else
		vRPclient.notify(thePlayer, {"[UBER EATZ] ~r~Nu esti angajat la ~y~Uber Eatz"})
	end
end

function vRPjobs.stopFoodDelivery()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Uber Eatz") and (fDeliveryDrivers[user_id] ~= nil)then
		fDeliveryDrivers[user_id] = nil
	end
end

function vRPjobs.payFoodDeliveryDriver()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if((theJob == "Uber Eatz") and (fDeliveryDrivers[user_id] ~= nil))then
		local rewardMoney = math.random(80000, 100000)
		vRP.giveMoney({user_id, rewardMoney})
		vRPclient.notify(thePlayer, {"[UBER EATZ] ~g~Ai livrat comanda si ai primit ~y~$"..rewardMoney})
		updateGoalContributie = rewardMoney / 2
		exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
		exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = rewardMoney}, function (rows) end)
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		SetTimeout(1000, function()
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Uber Eatz")then
				vRPjobs.executeFoodDeliveryJob(source)
			end
		end)
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Uber Eatz")then
		fDeliveryDrivers[user_id] = nil
		vRPCjobs.deleteTrashTruck(source, {})
	end
end)