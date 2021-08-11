local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","EUP")



vrpEUP.RegisterServerCallback('verifica', function(source, cb)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id,"eup.menu"}) then
        permisiune = true
        vRPclient.notify(player,{"[~o~EUP~w~] ~g~Ai deschis meniul EUP"})
        vRPclient.notify(player,{"[~o~EUP-INFO~w~]Pune click-ul pe mijlocul ecranului ca sa nu se mai invarta!"})
        vRPclient.notify(player,{"[~o~ATENTIE~w~]Daca vei lua un skin care nu apartine rolului tau,vei fi dat afara!"})
    else
        permisiune = false
        vRPclient.notify(player,{"[~o~EUP~w~] ~r~Nu ai acces la aceasta comanda!"})
    end

    cb(permisiune)

end)
