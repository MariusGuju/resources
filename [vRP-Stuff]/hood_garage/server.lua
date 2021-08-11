local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_garage")
vRPCgarage = Tunnel.getInterface("vRP_garage","vRP_garage")
vRPgarage = {}
Tunnel.bindInterface("vRP_garage",vRPgarage)
Proxy.addInterface("vRP_garage",vRPgarage)

--[[
CREATE TABLE IF NOT EXISTS esk_garaje(
  id INTEGER AUTO_INCREMENT,
  tipGaraj INTEGER,
  x FLOAT ,
  y FLOAT ,
  z FLOAT ,
 PRIMARY KEY(id)
);
--]]

-- SQL SHIT
-- ## ADMINI###
--MySQL.createCommand("vRP/adauga_garaj","INSERT IGNORE INTO esk_garaje (tipGaraj,x,y,z) VALUES (@tipGaraj,@x,@y,@z)")
--MySQL.createCommand("vRP/get_garaje","SELECT * FROM esk_garaje")
--MySQL.createCommand("vRP/get_masinile_mele","SELECT vehicle,vehicle_plate,upgrades FROM vrp_user_vehicles WHERE user_id = @user_id")

function vRPgarage.spawngaraje(source)
    exports.ghmattimysql:execute("SELECT * FROM esk_garaje", {}, function (garaje)
        if #garaje > 0 then
            vRPCgarage.spawngaraje(source,{garaje})
        end
    end)
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRPgarage.spawngaraje(player)
end)

RegisterCommand("grj", function(source)
	vRPgarage.spawngaraje(source)
end)

RegisterCommand("creazagaraj", function(source)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    --if vRP.hasGroup({user_id,"Fondator"}) then
        info = "\n1=~b~Politie~w~\n2=~r~Medici~w~\n3=~p~Mafie~w~\n4=~y~VIP~w~\n5=Jucatori\n~w~6=Factiune\n7=~b~Elicopter~w~"
        vRPclient.notify(player,{"~b~[~w~TIPURI GARAJE~b~]~w~"..info})
        TriggerClientEvent('iaLocatieGaraje',player)
    --else
    --    vRPclient.notify(player,{"Varule, doar developerul are acces la comanda asta, esti tampit?"})
    end
end)

RegisterServerEvent('creazaGaraj')
AddEventHandler('creazaGaraj',function(coords_x,coords_y,coords_z)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRP.prompt({player,"Tip Garaj (1-7)","",function(player,tipGaraj)
        tipGaraj = parseInt(tipGaraj)
        if (tipGaraj > 0 and tipGaraj <= 7) then
            exports.ghmattimysql:execute("INSERT IGNORE INTO esk_garaje (tipGaraj,x,y,z) VALUES (@tipGaraj,@x,@y,@z)", {
                ['@tipGaraj'] = tipGaraj, 
                ['@x'] = coords_x,
                ['@y'] = coords_y,
                ['@z'] = coords_z
            }, function (rows)
            end)
            vRPgarage.spawngaraje(player)
        else
            vRPclient.notify(player,{"~w~ Trebuie sa pui un numar intre 1-5 la tipul garajelor"})
        end
    end})
end)


RegisterServerEvent('deschideGaraj')
AddEventHandler('deschideGaraj',function(idGaraj)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    exports.ghmattimysql:execute("SELECT vehicle,vehicle_plate,upgrades,olx FROM vrp_user_vehicles WHERE user_id = @user_id", {
        ['@user_id'] = user_id
    }, function (rable)
    	if user_id ~= nil then

            vRP.buildMenu({"Garaj", {user_id = user_id, player = player}, function(menu)
                menu.name="Garaj"
                menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
                        
                for k,v in pairs (Config.tipgaraje) do
                    if (idGaraj == k) then
                        for i,v in pairs (v.masini) do
                            permisiune = v[2]
                            if vRP.hasPermission({user_id,permisiune}) then
                                if( idGaraj == 1 or idGaraj == 2 or idGaraj == 3 or idGaraj == 6 )then
                                    menu['.Parcheaza Vehiculul'] = {function(player,choice) park(player) end, "Parcheaza Vehiculul"}
                                    menu[v[3]] = {function(player,choice) spawnVehicle(player,v[1]) end, "Masina: "..v[3].."<br>Tip Garaj: <br>Masinile nu sunt personale!"}
                                elseif (idGaraj == 4 or idGaraj == 5) then
                                    for j,x in pairs(rable) do
                                        local vehicle = x.vehicle
                                        local tuning = x.upgrades
                                        local placuta = x.vehicle_plate
                                        local olx = x.olx

                                        if olx == 0 then infoolx = 'Nu' else infoolx = 'Da' end
                                        if vehicle == v[1] then
                                            menu['.Parcheaza Vehiculul'] = {function(player,choice) park(player) end, "Parcheaza Vehiculul"}
                                            menu[v[3]] = {function(player,choice) spawnPersonalVehicle(player,vehicle,placuta,tuning,olx) end, "Masina: "..v[3].."<br>Inmatriculata: "..x.vehicle_plate.."<br>OLX: "..infoolx}
                                        end
                                    end
                                elseif ( idGaraj == 7 ) then
                                    menu['.Parcheaza Elicopterul'] = {function(player,choice) park(player) end, "Parcheaza Elicopterul"}
                                    menu[v[3]] = {function(player,choice) spawnElicopter(player,v[1]) end, "Elicopter: "..v[3]}
                                end
                            end
                        end
                    end
                end
                vRP.openMenu({player,menu})

            end})
        end
        end)
        function park(player)
            local user_id = vRP.getUserId({player})
            vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
                if ok then
                    vRPclient.despawnGarageVehicle(player,{vtype,15}) 
                else
                    vRPclient.notify(player,{"Nu ai un vehicul personal in apropiere"})
                end
            end)
        end
        function spawnVehicle(player,vehiculf)
            local user_id = vRP.getUserId({player})
            veh_type = "car"
            placuta = "Factiune"
            vRPclient.spawnGarageVehicle(player,{veh_type,vehiculf,placuta})
            vRP.closeMenu({player})
        end
        function spawnElicopter(player,vehicle)
            local user_id = vRP.getUserId({player})
            vtype = "car"
            vRPclient.spawnGarageVehicle(player,{vtype,vehicle})
            vRP.closeMenu({player})
        end
        function spawnPersonalVehicle(player,vehicle,placuta,tuning,olx)
            if olx == 0 then
                local user_id = vRP.getUserId({player})
                vtype = "car"
                vRPclient.spawnGarageVehicle(player,{vtype,vehicle,placuta,tuning})
                vRP.closeMenu({player})
            else
                vRPclient.notify(player,{"Ai masina in olx, nu o poti scoate!"})
            end
        end

end)
