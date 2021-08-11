local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPclient = Tunnel.getInterface("vRP", "all_sla")

vRP = Proxy.getInterface("vRP")

vRPStinta = {}
Tunnel.bindInterface("all_sla",vRPStinta)
Proxy.addInterface("all_sla",vRPStinta)
vRPCtinta = Tunnel.getInterface("all_sla","all_sla")

function vRPStinta.verificapermisiunea()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    
    if vRP.hasPermission({user_id, "permisie.tinta"}) then
        vRPCtinta.activare(player,{})
        vRPclient.notify(vRP.getUserSource({user_id}), {"~w~[~r~TINTA~w~] ~w~Ai activat tinta cu ~g~succes ~w~!"})
    else
        vRPclient.notify(vRP.getUserSource({user_id}), {"~w~[~r~TINTA~w~] ~w~Nu ai ~r~acces ~w~la '~g~Activare tinta~w~' !"})
    end

end