local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPrb = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_rob")
RBclient = Tunnel.getInterface("vrp_rob","vrp_rob")
vRPrbC = Tunnel.getInterface("vrp_rob","vrp_rob")



vrpRob.RegisterServerCallback('verificaPD', function(source, cb)
    --[[
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    pd = vRP.getUsersByGroup({"Chestor General"})
    pd2 = vRP.getUsersByGroup({"Comisar Sef"})
    pd3 =  vRP.getUsersByGroup({"Comisar"})
    pd4 = vRP.getUsersByGroup({"Sub Comisar"})
    pd5 = vRP.getUsersByGroup({"Inspector Sef"})
    pd6 = vRP.getUsersByGroup({"Inspector"})
    pd7 = vRP.getUsersByGroup({"Sub-Inspector"})
    pd8 = vRP.getUsersByGroup({"Agent"})
    
    --local fraieri = ( tonumber(#pd) + tonumber(#pd2) + tonumber(#pd3) + tonumber(#pd4) + tonumber(#pd5) + tonumber(#pd6))
    local fraieri = vRP.getUsersByPermission({"police.menu_interaction"})
    cb(fraieri)
    --]]
    cb(5)
    local users = vRP.getUsers({})
    for k,v in pairs (users) do
        if vRP.hasPermission({k,"police.menu_interaction"}) then
            -- idk here
        end
    end
end)

vrpRob.RegisterServerCallback('verificaIteme', function(source, cb,bankID)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    for k, v in ipairs(Config.BankRobbery) do
        if bankID == k then
            for i,j in pairs (v.iteme) do
                if vRP.tryGetInventoryItem({user_id,j[1],j[2],true}) then
                    cb(true)
                else
                    --print('nu ')
                    cb(false)
                    vRPclient.notify(player,{"Ai nevoie de "..j[1].." x"..j[2]})
                end
            end
        end
    end
end)

RegisterServerEvent('vrp_rob:ChamadoPolicial')
AddEventHandler('vrp_rob:ChamadoPolicial', function (message, coords)
    local jucatori = vRP.getUsers()
    for i = 1, #jucatori do
        local id = vRP.getUserId({jucatori[i]})
        local membru = vRP.getUserSource({id})

            vRPclient.notifyPicture(id,{"CHAR_LESTER", 1, "Rob in progres", false, message})
            TriggerClientEvent('chatMessage', -1, "[JAF]", { 255, 0, 0 }, "Rob in progres La banca Pacific!")

    end
end)

RegisterServerEvent('iaBani')
AddEventHandler('iaBani', function ()
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local bani = math.random(60,120)
    --vRP.giveMoney({user_id,bani})
    --vRPclient.notify(player,{"Ai primit ~g~$"..bani})
    vRP.giveInventoryItem({user_id,"dirty_money",bani,true})
end)




function vRPrb.copsonline()
	local cops = vRP.getUsersByPermission({"user.paycheck"})
	return #cops 
end

function vRPrb.permissao()
    local source = source
    local user_id = vRP.getUserId({source})
    return vRP.hasPermission({user_id, "user.paycheck"})
end

function vRPrb.getBox(bank)
    local money = Config.BankRobbery[bank].Money.Amount
    if money > 0 then
        if money >= Config.BankRobbery[bank].Money.StartMoney/2 then
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Full
        else
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Half
        end
    else
        Config.BankRobbery[bank].Money.Box = Config.Boxes.Empty
    end
    box = Config.BankRobbery[bank].Money.Box
    return box
end

function vRPrb.getitem(item)
    local source = source
	local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem(user_id,item,1,true) then
		return true
    else
		return false
	end
end


RegisterServerEvent('vrp_rob:deleteDrill')
AddEventHandler('vrp_rob:deleteDrill', function(coords)
    TriggerClientEvent('vrp_rob:deleteDrillCl', -1, coords)
end)


function generateRandomMoney(src, bank)
	local xPlayer = vRP.getUserId({src})
    while true do
        local randommoney = math.random(1500, 2500)
        if Config.BankRobbery[bank].Money.Amount - randommoney >= 0 then
            Config.BankRobbery[bank].Money.Amount = Config.BankRobbery[bank].Money.Amount - randommoney
			vRP.giveInventoryItem({xPlayer,"dirty_money",randommoney,true})
            break
        end
        Wait(0)
    end
end

RegisterServerEvent('vrp_rob:takeMoney')
AddEventHandler('vrp_rob:takeMoney', function(bank)
    local src = source
	local xPlayer = vRP.getUserId({src})
    if Config.BankRobbery[bank].Money.Amount - 250 >= 0 then
        generateRandomMoney(src, bank)
    else
        if Config.BankRobbery[bank].Money.Amount > 0 then
			vRP.giveInventoryItem({xPlayer,"money",Config.BankRobbery[bank].Money.Amount,true})

            Config.BankRobbery[bank].Money.Amount = 0
        end
    end
    TriggerClientEvent('vrp_rob:updateMoney', -1, bank, Config.BankRobbery[bank].Money.Amount )
end)

RegisterServerEvent('vrp_rob:printFrozenDoors')
AddEventHandler('vrp_rob:printFrozenDoors', function()
    for i = 1, #Config.BankRobbery do 
        for j = 1, #Config.BankRobbery[i].Doors do
            local d = Config.BankRobbery[i].Doors[j]
        end
    end
end)

RegisterServerEvent('vrp_rob:setDoorFreezeStatus')
AddEventHandler('vrp_rob:setDoorFreezeStatus', function(bank, door, status)
    Config.BankRobbery[bank].Doors[door].Frozen = status
    TriggerClientEvent('vrp_rob:setDoorFreezeStatusCl', -1, bank, door, status)
end)

RegisterServerEvent('vrp_rob:getDoorFreezeStatus')
AddEventHandler('vrp_rob:getDoorFreezeStatus', function(bank, door)
    TriggerClientEvent('vrp_rob:setDoorFreezeStatusCl', source, bank, door, Config.BankRobbery[bank].Doors[door].Frozen)
end)

RegisterServerEvent('vrp_rob:toggleSafe')
AddEventHandler('vrp_rob:toggleSafe', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
    TriggerClientEvent('vrp_rob:safeLooted', -1, bank, safe, toggle)
end)

RegisterServerEvent('vrp_rob:lootSafe')
AddEventHandler('vrp_rob:lootSafe', function(bank, safe)
    local src = source
	local xPlayer = vRP.getUserId({src})
    local randommoney = math.random(Config.SafeMinimum, Config.SafeMax)
	vRP.giveInventoryItem({xPlayer,"dirty_money",randommoney,true})
	vRPclient._notify(src,"Ai gasit ~g~ R$".. randommoney .."! in seif")
    Config.BankRobbery[bank].Safes[safe].Looted = true
    TriggerClientEvent('vrp_rob:safeLooted', -1, bank, safe, true)
end)

AddEventHandler('playerConnecting', function()
    local src = source
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Doors do
            Wait(0)
            TriggerClientEvent('vrp_rob:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Doors[j].Frozen)
        end
    end
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Safes do
            Wait(0)
            TriggerClientEvent('vrp_rob:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Safes[j].Looted)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Doors do
                Wait(0)
                TriggerClientEvent('vrp_rob:setDoorFreezeStatusCl', -1, i, j, Config.BankRobbery[i].Doors[j].Frozen)
            end
        end
        Wait(30000)
    end
end)


RegisterServerEvent("utk_oh:startloot")
AddEventHandler("utk_oh:startloot", function()
    TriggerClientEvent("utk_oh:startloot_c", -1)
end)
