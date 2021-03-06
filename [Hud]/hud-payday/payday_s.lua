--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")
vRP = Proxy.getInterface("vRP")
vRPgb = Proxy.getInterface("vRP_giftbox")
vRPnc = Proxy.getInterface("vRP_newcoin")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")
salarii = {
--VIP-uri--
{"vip1.salariu", 50000,"VIP SILVER"},   
{"vip2.salariu", 100000,"VIP GOLD"},      
{"vip3.salariu", 150000,"VIP PLATINUM"},  
{"vip4.salariu", 250000,"VIP DIAMOND"},

{"sageata.salar", 100000,"Sageata Mafie"},
{"membru.salar", 250000,"Membru Mafie"},
{"camatar.salar", 350000,"Camatar Mafie"},
{"interlop.salar", 450000,"Interlop Mafie"},
{"colider.salar", 550000,"Co-Lider Mafie"},
{"lider.salar", 650000,"Lider Mafie"},	

--Sponsor Menu --
{"sponsor.salariu", 100000,"Sponsor LiquidRoRR"},
--Salar Cetatian
{"user.salariu", 10000,"Cetatian Orasului Liquid"},

}

local value2 = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then 
		MySQL.query("vRP/getPremium", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			if rows[1].premium == 1 then
			value2[user_id] = 1 
			else
			value2[user_id] = 0
				end
			end
		end)
	end
end)

RegisterServerEvent('salar')
AddEventHandler('salar', function(salar)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	pictura = "CHAR_ANDREAS"
	titlu = "Liquid Bank"
	mesaj = "Ai primit salariul ~g~$"
	local n = math.random(1,10000)
	for i, v in pairs(salarii) do
		permisiune = v[1]
		if(vRP.hasPermission({user_id, permisiune}))then
			salar = v[2]
			deLaGrupa = v[3]
			if value2[user_id] == 1 then
				vRP.giveBankMoney({user_id,salar + n})
				vRPclient.notifyPicture(player,{pictura, 9, titlu, false, mesaj..salar.. "~w~. "..deLaGrupa.." si "..n.." de la ~w~premium"})
			else
				vRP.giveBankMoney({user_id,salar})
				vRPclient.notifyPicture(player,{pictura, 9, titlu, false, mesaj..salar.. "~w~. "..deLaGrupa})
			end
			vRP.giveInventoryItem({user_id,"water",1,true})
			vRP.giveInventoryItem({user_id,"tacos",1,true})
			
		end
	end
end)