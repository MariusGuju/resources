local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_jobs")
vRPCeskJobs = Tunnel.getInterface("esk_jobs","esk_jobs")

vRPeskJobs = {}
Tunnel.bindInterface("esk_jobs",vRPeskJobs)
Proxy.addInterface("esk_jobs",vRPeskJobs)




infoJobAngajat = {}

function vRPeskJobs.puneJob(infoJob)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	local ore = vRP.getUserHoursPlayed({source})
    if infoJobAngajat[user_id] == nil and ore >= 15 then
        if infoJob == 1 then
            infoJobAngajat[user_id] = "Postas"
            vRPeskJobs.punePostas(player)
            --vRP.addGroup({user_id,"Postas"})
            vRPclient.eskNotify(player,{"Te-ai angajat ca si ~b~"..infoJobAngajat[user_id],6000})
        elseif infoJob == 2 then
            infoJobAngajat[user_id] = "Livrator Bancar"
            vRPeskJobs.bagaGruppe6(player)
            --vRP.addGroup({user_id,"Livrator Bancar"})
            vRPclient.eskNotify(player,{"Te-ai angajat ca si ~b~"..infoJobAngajat[user_id],6000})
        end
    else
        vRPclient.eskNotify(player,{"Tasteaza ~b~ /quitjob ~w~ pentru a putea lua alt job! / Sau verifica daca ai 15 ORE JUCATE ~b~",6000})
    end
    --vRPclient.eskNotify(player,{"MOMENTAM ACESTE JOBURI SUNT OPRITE DIN MOTIVE TEHNICE!",6000})
end


RegisterCommand("quitjob", function(source)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if infoJobAngajat[user_id] ~= nil then
        if infoJobAngajat[user_id] == "Postas" then
            vRPclient.eskNotify(player,{"Ti-ai dat demisia cu succes de la ~b~Posta",6000})
            vRPeskJobs.quitPostas(player)
            infoJobAngajat[user_id] = nil
        elseif infoJobAngajat[user_id] == "Livrator Bancar" then
            vRPclient.eskNotify(player,{"Ti-ai dat demisia cu succes de la ~b~Banca",6000})
            infoJobAngajat[user_id] = nil
            vRPeskJobs.quitGruppe6(player)
        end
        --vRP.addUserGroup({user_id,"Somer"})
    else
        vRPclient.eskNotify(source,{"Trebuie sa iti iei un job pentru a putea folosii aceasta comanda",6000})
    end
end)
