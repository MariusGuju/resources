vRPCtinta = {}
Tunnel.bindInterface("all_sla",vRPCtinta)
Proxy.addInterface("all_sla",vRPCtinta)
vRPStinta = Tunnel.getInterface("all_sla","all_sla")
vRP = Proxy.getInterface("vRP")

local activat = true

Citizen.CreateThread( function()
    while true do 
        Wait(1000)
        if (activat == true) then
		    HideHudComponentThisFrame(14)	
        end
    end 
end)

RegisterCommand("tinta", function(source)
    if vRPStinta.verificapermisiunea() then 
        vRPCtinta.activare()
    end
end)

function vRPCtinta.activare()
    activat = false
end
