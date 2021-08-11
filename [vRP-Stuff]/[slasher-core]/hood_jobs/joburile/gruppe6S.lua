local chestii = {
    {1,"Adu Masina",-10.24977684021,-657.16137695313,33.451141357422, mesaj = "cheama masina", markerid = 36 },
    {2,"Ia sacii",-7.0042343139648,-654.25915527344,33.450157165527, mesaj = "lua sacii", markerid = 29}
}

local bancomate = {
    {  1, 119.10, -883.70, 31.12 , status = true },
    {  2, -1315.80, -834.76, 16.96 , status = true },
    {  3, 285.44, 143.38, 104.17 , status = true },
    {  4, 1138.23, -468.89, 66.73 , status = true },
    {  5, 1077.70, -776.54, 58.24 , status = true },
    {  6, -710.03, -818.90, 23.72 , status = true },
    {  7, -821.63, -1081.89, 11.13 , status = true },
    {  8, -1409.75, -100.44, 52.38 , status = true },
    {  9, -846.29, -341.28, 38.68 , status = true },
    {  10, -2072.36, -317.23, 13.31 , status = true },
    {  11, -526.64, -1222.97, 18.45 , status = true },
    {  12, -254.41, -692.46, 33.60 , status = true },
    {  13, -203.69, -861.47, 30.26 , status = true },
    {  14, -303.30, -829.81, 32.41 , status = true },
    {  15, -301.72, -830.03, 32.41 , status = true }, 
    {  16, 146.05, -1035.03, 29.34 , status = true },
    {  17, 147.66, -1035.67, 29.34 , status = true },
    {  18, -258.80, -723.40, 33.46 , status = true },
    {  19, -256.15, -716.00, 33.51 , status = true },
    {  20, -537.85, -854.37, 29.28 , status = true  }
}

function vRPeskJobs.bagaGruppe6(source)
    vRPCeskJobs.puneChestiiGruppe6(source,{chestii,true})
end

function vRPeskJobs.quitGruppe6(source)
    vRPCeskJobs.puneChestiiGruppe6(source,{chestii,false})
end


function
	 vRPeskJobs.respawnGruppe6()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRPCeskJobs.puneChestiiGruppe6(player,{chestii})
    vRPCeskJobs.bagaBancomatele(player,{bancomate})
end

function vRPeskJobs.reward()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local randomEXP = math.random (0,1)
    local reward = math.random(20,50)
    if randomEXP == 1 then
        vRPclient.eskNotify(player,{"[Livrator Bancar] Ai primit ~b~+1 EXP~w~ si ~g~$"..reward.."~w~ de la job",5000})
        vRP.giveMoney({user_id,reward})
        print("jobs6s mesaj")
        exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
            ['@id'] = user_id
        }, function (rows)
        end)
    else
        vRPclient.eskNotify(player,{"[Livrator Bancar] Ai primit ~g~$"..reward.."~w~ de la job",5000})
        vRP.giveMoney({user_id,reward})
        updateGoalContributie = reward / 2
        print("jobs6s mesaj")
        exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
        exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = reward}, function (rows) end)
    end
end

function vRPeskJobs.spawnBancomate()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRPclient.eskNotify(source,{"Du-te la bancomate si lasa pungile cu bani pentru a primii un reward!",10000})
    vRPCeskJobs.bagaBancomatele(player,{bancomate})
end