busSpawnLocs = {
	[1] = {457.64465332032,-647.5498046875,28.22996711731},
	[2] = {458.85217285156,-633.15838623046,28.49598312378},
	[3] = {460.83367919922,-618.74090576172,28.490180969238}
}

busLoadLocs = {
	{446.13436889648,-674.48352050782,28.468620300292, false},
	{342.05743408204,-685.52685546875,29.345029830932, false},
	{307.59091186524,-766.40692138672,29.257970809936, true},
	{286.68829345704,-844.5482788086,29.11434173584, false},
	{204.87097167968,-824.21417236328,30.877170562744, false},
	{114.69412994384,-785.70880126954,31.359680175782, true},
	{-15.724514007568,-744.02734375,32.423904418946, false},
	{-159.02043151856,-686.77032470704,34.517623901368, false},
	{-244.82369995118,-656.86572265625,33.177612304688, false},
	{-199.5069885254,-514.28936767578,34.767024993896, false},
	{-261.70483398438,-344.6124572754,30.01676940918, false},
	{-378.31338500976,-266.30029296875,34.572612762452, false},
	{-443.54153442382,-238.33311462402,36.076007843018, false},
	{-524.88665771484,-267.91903686524,35.286109924316, true},
	{-614.55944824218,-319.18328857422,34.738998413086, false},
	{-653.60626220704,-290.46691894532,35.504539489746, false},
	{-752.85272216796,-109.84552764892,37.727279663086, false},
	{-594.07232666016,-59.125328063964,42.028797149658, false},
	{-557.3334350586,-29.030445098876,43.419521331788, false},
	{-594.03601074218,5.3750019073486,43.470542907714, false},
	{-694.6566772461,-7.7694001197814,38.147178649902, true},
	{-797.50360107422,-62.56103515625,37.793224334716, false},
	{-927.20086669922,-124.59349822998,37.621971130372, true},
	{-1008.8112792968,-172.57611083984,37.827739715576, false},
	{-1230.4438476562,-297.18911743164,37.626804351806, false},
	{-1414.898803711,-405.57977294922,36.366512298584, false},
	{-1480.8586425782,-440.27954101562,35.47248840332, false},
	{-1525.5915527344,-468.18435668946,35.383449554444, true},
	{-1635.6463623046,-559.7417602539,33.581111907958, false},
	{-1625.2685546875,-607.14526367188,32.790340423584, false},
	{-1535.3330078125,-667.2666015625,28.90389251709, false},
	{-1477.7371826172,-632.10815429688,30.517822265625, true},
	{-1396.6945800782,-575.48388671875,30.293865203858, false},
	{-1316.8299560546,-527.01574707032,32.784450531006, false},
	{-1274.0516357422,-544.23010253906,31.03455734253, false},
	{-1188.9395751954,-643.7890625,23.33450126648, false},
	{-1052.6206054688,-794.13275146484,18.98310661316, false},
	{-862.78289794922,-950.44616699218,15.757440567016, false},
	{-782.6401977539,-1095.8739013672,10.718092918396, false},
	{-668.88861083984,-1275.870727539,10.671800613404, false},
	{-602.0908203125,-1260.0417480468,11.672262191772, false},
	{-533.25903320312,-1110.4447021484,22.109872817994, false},
	{-469.18661499024,-1104.9639892578,27.547304153442, false},
	{-312.52252197266,-1141.2166748046,24.08289527893, false},
	{-167.8152923584,-1149.847290039,23.27227973938, true},
	{79.926231384278,-1131.6049804688,29.27725982666, false},
	{206.88217163086,-1152.6271972656,29.350481033326, false},
	{214.75367736816,-1266.9360351562,29.345527648926, false},
	{170.48680114746,-1373.0111083984,29.335916519166, false},
	{254.81205749512,-1474.5354003906,29.210702896118, true},
	{353.68438720704,-1548.573852539,29.29658317566, false},
	{439.49102783204,-1616.6165771484,29.334770202636, false},
	{542.03533935546,-1556.153930664,29.211254119874, false},
	{538.14422607422,-1376.9829101562,29.270030975342, false},
	{503.6625366211,-1150.984375,29.293075561524, false},
	{487.23776245118,-822.33447265625,25.109920501708, false},
	{409.9761352539,-787.90399169922,29.214849472046, true},
	{408.7497253418,-696.28021240234,29.233535766602, false}
}

finishBusPoint = {448.48852539062,-582.52069091796,28.499757766724}

busDrivers = {}

function vRPjobs.executeBusDriverJob(thePlayer)
	vRPCjobs.busPopulateData(thePlayer, {busSpawnLocs, busLoadLocs, finishBusPoint})
end

function vRPjobs.spawnTheBus()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Sofer Autobuz")then
		if(busDrivers[user_id] == nil)then
			busDrivers[user_id] = 0
			vRPCjobs.spawnTheBus(thePlayer, {})
		else
			vRPclient.notify(thePlayer, {"[BUS] ~r~Ai deja un autobuz spawnat!"})
		end
	else
		vRPclient.notify(thePlayer, {"[BUS] ~r~Nu esti angajat ca ~y~Sofer Autobuz"})
	end
end

function vRPjobs.stopBusRoute()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Sofer Autobuz") and (busDrivers[user_id] ~= nil)then
		busDrivers[user_id] = nil
	end
end

function vRPjobs.payBusDriverAtStop()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local thePay = math.random(4, 7)
	vRP.giveMoney({user_id, thePay})
	updateGoalContributie = thePay / 2
	exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
	exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = thePay}, function (rows) end)
	vRPclient.notify(thePlayer, {"[BUS] ~g~Ai primit ~y~$"..thePay.." ~g~de la aceasta statie!"})
end

function vRPjobs.payBusDriver(routesDone)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	local rewardMoney = routesDone * 2
	vRP.giveMoney({user_id, rewardMoney})
	vRPclient.notify(thePlayer, {"[BUS] ~g~Ai primit ~y~$"..rewardMoney.." ~g~pentru tura de ~b~Sofer Autobuz"})
	busDrivers[user_id] = nil
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		SetTimeout(1000, function()
			local theJob = vRPjobs.getPlayerJob(user_id)
			if(theJob == "Sofer Autobuz")then
				vRPjobs.executeBusDriverJob(source)
			end
		end)
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local theJob = vRPjobs.getPlayerJob(user_id)
	if(theJob == "Sofer Autobuz")then
		busDrivers[user_id] = nil
		vRPCjobs.deleteTrashTruck(source, {})
	end
end)