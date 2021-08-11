local chestii = {
    {1,"Adu Masina",118.8565826416,101.57083892822,81.129463195801, mesaj = "cheama masina", markerid = 36},
    {2,"Ia cutiile",113.07457733154,103.61035919189,81.080375671387, mesaj = "lua cutiile", markerid = 29}
}

local case = {
	{1,260.7998046875,22.3049659729,88.127281188965, status = true },
	{2,260.74243164063,22.335771560669,92.127220153809, status = true },
	{3,352.91513061523,-142.26138305664,66.688186645508, status = true },
	{4,-13.889856338501,-11.483261108398,71.145248413086, status = true },
	{5,-21.579330444336,-24.507572174072,73.245391845703, status = true },
	{6,-77.176399230957,13.892274856567,71.729309082031, status = true },
	{7,-99.841728210449,22.838390350342,71.41162109375, status = true },
	{8,-413.8251953125,220.44371032715,83.426338195801, status = true },
	{9,-772.77496337891,313.00994873047,85.698089599609, status = true },
	{10,329.44152832031,-224.86204528809,54.221767425537, status = true },
	{11,336.98403930664,-224.82263183594,54.221767425537, status = true },
	{12,340.74957275391,-214.79689025879,54.221767425537, status = true },
	{13,329.50942993164,-225.11807250977,58.019256591797, status = true },
	{14,342.67086791992,-209.42115783691,58.019256591797, status = true },
    {15,502.04791259766,112.61975097656,96.640167236328, status = true}
}
function vRPeskJobs.punePostas(source)
    vRPCeskJobs.puneChestiiPostas(source,{chestii,true})
end

function vRPeskJobs.quitPostas(source)
    vRPCeskJobs.puneChestiiPostas(source,{chestii,false})
end


function vRPeskJobs.rewardPostas()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local randomEXP = math.random (0,1)
    local reward = math.random(5,7)
    if randomEXP == 1 then
        vRPclient.eskNotify(player,{"[POSTAS]Ai primit ~b~+1 EXP~w~ si ~g~$"..reward.."~w~ de la job",5000})
        vRP.giveMoney({user_id,reward})
        print("jobsposs mesaj")
        exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
            ['@id'] = user_id
        }, function (rows)
        end)
    else
        vRPclient.eskNotify(player,{"[POSTAS]Ai primit ~g~$"..reward.."~w~ de la job",5000})
        vRP.giveMoney({user_id,reward})
    end
	updateGoalContributie = reward / 2
    print("jobsposs mesaj")
	exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
	exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = reward}, function (rows) end)
end
function vRPeskJobs.spawnCasele()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRPclient.eskNotify(player,{"Du-te la markerele marcate pe harta pentru a livra coletele!",7000})
    vRPCeskJobs.bagaCheckpointcase(player,{case})
end