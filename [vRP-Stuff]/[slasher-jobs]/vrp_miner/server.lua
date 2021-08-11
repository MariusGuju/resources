local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPcs = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_casino")
vRPCasinoC = Tunnel.getInterface("vRP_casino","vRP_casino")
Tunnel.bindInterface("vRP_casino",vRPcs)


vRP.defInventoryItem({"teava", "Teava Arma", "", function(args) end})
vRP.defInventoryItem({"incarcator", "Incarcator Arma", "", function(args) end})
vRP.defInventoryItem({"arc", "Arc Arma", "", function(args) end})
vRP.defInventoryItem({"teavaglont", "Teava Glont Arma", "", function(args) end})
vRP.defInventoryItem({"tragaci", "Tragaci Arma", "", function(args) end})


RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function()
    local _source = source
    local user_id = vRP.getUserId({source})
        if user_id ~= nil then
            if vRP.getInventoryItemAmount({user_id,'minereunecunoscut'}) < 40 then
				vRP.giveInventoryItem({user_id,'minereunecunoscut', 5})
			else
				vRPclient.notify(source,{"~r~[Miner] Nu ai mai gasit Minere - uri Necunoscute . Revin - o mai tarziu poate o gasesti ceva !"})
            end
        end
    end)

    
RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function()
    local _source = source
    local user_id = vRP.getUserId({source})
        if user_id ~= nil then
            if vRP.getInventoryItemAmount({user_id,'minereunecunoscut'}) > 9 then
                TriggerClientEvent("esx_miner:washing", source)
                Citizen.Wait(15900)
				vRP.giveInventoryItem({user_id,'minereucurat', 10})
				vRP.tryGetInventoryItem({user_id,"minereunecunoscut", 10})
			elseif vRP.getInventoryItemAmount({user_id,'minereunecunoscut'}) < 10 then
					vRPclient.notify(source,{"~y~Nu ai destule Minereuri \nAi nevoie de ~r~[10] ~y~Minereuri"})
            end
        end
    end)

RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function()
    local _source = source
	local user_id = vRP.getUserId({_source})
    local randomChance = math.random(1, 100)
        if user_id ~= nil then
            if vRP.getInventoryItemAmount({user_id,'minereucurat'}) > 9 then
                TriggerClientEvent("esx_miner:remelting", _source)
                Citizen.Wait(15900)
                if randomChance < 5 then
					vRP.giveInventoryItem({user_id,"diamant", 2})
					vRP.tryGetInventoryItem({user_id,"minereucurat", 10})
					vRPclient.notify(_source,{"Ai primit ~b~[5] Diamante ~w~pentru 10 Minereuri Spalate"})
                elseif randomChance > 5 and randomChance < 20 then
					vRP.giveInventoryItem({user_id,"aur", 5})
					vRP.tryGetInventoryItem({user_id,"minereucurat", 10})
					vRPclient.notify(_source,{"Ai primit ~y~[5] Aur ~w~pentru 10 Minereuri Spalate"})
                elseif randomChance > 20 and randomChance < 40 then
					vRP.giveInventoryItem({user_id,"argint", 5})
					vRP.tryGetInventoryItem({user_id,"minereucurat", 10})
					vRPclient.notify(_source,{"Ai primit ~t~[5] Argint ~w~pentru 10 Minereuri Spalate"})
				elseif randomChance > 40 and randomChance < 90 then
				--	vRP.giveInventoryItem({user_id,"fier", 5})
					vRP.giveInventoryItem({user_id,"piatra", 10})
					vRP.tryGetInventoryItem({user_id,"minereucurat", 10})
					vRPclient.notify(_source,{"Ai primit ~t~[10] Piatra ~w~pentru 10 Minereuri Spalate"})
				elseif randomChance > 90 then
					--	vRP.giveInventoryItem({user_id,"fier", 5})
						vRPclient.notify(_source,{"Ai pierdut minereul in aparatul de topire !"})
                end
			elseif vRP.getInventoryItemAmount({user_id,'minereucurat'}) < 10 then
				vRPclient.notify(_source,{"Ai nevoie de ~r~[10] ~w~Minereuri Spalate"})
            end
        end
    end)


local casinoRoulette_menu = {name="Crafting",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local casinoCasier_menu = {name="Amanet",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
-- local crafting_menu = {name="Crafting",css={top="75px", header_color="rgba(0,125,255,0.75)"}}


VanzareLingou = {
    {-619.75634765625,-233.99868774414,38.057052612304},
    {-619.75634765625,-233.99868774414,38.057052612304}
}

Crafting = {
    {1443.400390625,6332.2763671875,23.981895446777},
    {924.35131835938, -942.13037109375,43.3}
}

-- Crafting2 = {
--     {-26.649248123168,-1981.5606689454,5.8509364128112},
--     {924.35131835938, -942.13037109375,43.3}
-- }

-- crafting_menu["Crafteaza AK-47"] = {function(player, choice)
-- 	local user_id = vRP.getUserId({player})
-- 	if(user_id ~= nil and user_id ~= "")then
-- 		vRP.prompt({player, "Cate AK-uri vrei sa craftezi ?", "", function(player, AK)
-- 			if(AK ~= "" and AK ~= nil)then
-- 				if(tonumber(AK))then
-- 					AK = tonumber(AK)
-- 					if(AK == 1) then
-- 						if vRP.tryGetInventoryItem({user_id,"teava",1,false}) then
-- 							vRP.tryGetInventoryItem({user_id,"incarcator",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"arc",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"teavaglont",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"tragaci",1,false})

-- 							vRP.giveInventoryItem({user_id, "wbody|weapon_assaultrifle", 1, true})
							
-- 							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ AK- ul cu ~g~succes !"})
-- 							vRP.closeMenu({player})
-- 						else
-- 							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
-- 						end
-- 					else
-- 						vRPclient.notify(player, {"[Crafting] ~r~Poti crafta doar unu cate unu !"})
-- 					end
-- 				else
-- 					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar !"})
-- 				end
-- 			else
-- 				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar !"})
-- 			end
-- 		end})
-- 	end
-- end, "<font color='white'>1 AK</font> = <font color='white'> 1 Teava , 1 Incarcator, 1 Arc, 1 Teava Glont, 1 Tragaci"}


-- crafting_menu["Crafteaza M4"] = {function(player, choice)
-- 	local user_id = vRP.getUserId({player})
-- 	if(user_id ~= nil and user_id ~= "")then
-- 		vRP.prompt({player, "Cate AK-uri vrei sa craftezi ?", "", function(player, AK)
-- 			if(AK ~= "" and AK ~= nil)then
-- 				if(tonumber(AK))then
-- 					AK = tonumber(AK)
-- 					if(AK == 1) then
-- 						if vRP.tryGetInventoryItem({user_id,"teava",1,false}) then
-- 							vRP.tryGetInventoryItem({user_id,"incarcator",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"arc",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"teavaglont",1,false})
-- 							vRP.tryGetInventoryItem({user_id,"tragaci",1,false})

-- 							vRPclient.giveWeapons(user_id,{{
-- 								["WEAPON_COMPACTRIFLE"] = {ammo=200}
-- 							  }, true})
							
-- 							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ M4- ul cu ~g~succes !"})
-- 							vRP.closeMenu({player})
-- 						else
-- 							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
-- 						end
-- 					else
-- 						vRPclient.notify(player, {"[Crafting] ~r~Poti crafta doar unu cate unu !"})
-- 					end
-- 				else
-- 					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar !"})
-- 				end
-- 			else
-- 				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar !"})
-- 			end
-- 		end})
-- 	end
-- end, "<font color='white'>1 M4</font> = <font color='white'> 1 Teava , 1 Incarcator, 1 Arc, 1 Teava Glont, 1 Tragaci"}

casinoRoulette_menu["Crafteaza Lingou Aur"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri vrei sa craftezi ?", "Un Lingou se crafteaza din 10 bucati de Aur", function(player, Aur)
			if(Aur ~= "" and Aur ~= nil)then
				if(tonumber(Aur))then
					Aur = tonumber(Aur)
					if(Aur > 0) and (Aur <= 999)then
						if vRP.tryGetInventoryItem({user_id,"aur",Aur * 10,false}) then
							vRP.giveInventoryItem({user_id,"lingouaur",Aur})
							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ Lingoul/Lingourile de Aur cu ~g~succes !"})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
						end
					else
						vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri intre 0 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='yellow'>10 bucati de Aur</font> = <font color='yellow'> 1 Lingou de Aur"}


casinoRoulette_menu["Crafteaza Lingou Diamant"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri vrei sa craftezi ?", "Un Lingou se crafteaza din 10 bucati de Diamant", function(player, Diamant)
			if(Diamant ~= "" and Diamant ~= nil)then
				if(tonumber(Diamant))then
					Diamant = tonumber(Diamant)
					if(Diamant > 0) and (Diamant <= 999)then
						if vRP.tryGetInventoryItem({user_id,"diamant",Diamant * 10,false}) then
							vRP.giveInventoryItem({user_id,"lingoudiamant",Diamant})
							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ Lingoul/Lingourile de Diamant cu ~g~succes !"})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
						end
					else
						vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri intre 0 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='cyan'>10 bucati de Diamant</font> = <font color='cyan'> 1 Lingou de Diamant"}


casinoRoulette_menu["Crafteaza Lingou Argint"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri vrei sa craftezi ?", "Un Lingou se crafteaza din 10 bucati de Argint", function(player, Argint)
			if(Argint ~= "" and Argint ~= nil)then
				if(tonumber(Argint))then
					Argint = tonumber(Argint)
					if(Argint > 0) and (Argint <= 999)then
						if vRP.tryGetInventoryItem({user_id,"argint",Argint * 10,false}) then
							vRP.giveInventoryItem({user_id,"lingouargint",Argint})
							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ Lingoul/Lingourile de Argint cu ~g~succes !"})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
						end
					else
						vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='gray'>10 bucati de Argint</font> = <font color='gray'> 1 Lingou de Argint"}


casinoRoulette_menu["Crafteaza Piatra"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri vrei sa craftezi ?", "Un Lingou se crafteaza din 10 bucati de Argint", function(player, Piatra)
			if(Piatra ~= "" and Piatra ~= nil)then
				if(tonumber(Piatra))then
					Piatra = tonumber(Piatra)
					if(Piatra > 0) and (Piatra <= 999)then
						if vRP.tryGetInventoryItem({user_id,"piatra",Piatra * 10,false}) then
							vRP.giveInventoryItem({user_id,"piatrafull",Piatra})
							vRPclient.notify(player, {"[Crafting] ~g~Ai craftat ~y~ Bucata/Bucatiile de Piatra cu ~g~succes !"})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Crafting] ~r~Nu ai destule Bucati !"})
						end
					else
						vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Crafting] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='gray'> 10 bucati de Piatra</font> = <font color='gray'> O Piatra"}


casinoCasier_menu["Vinde Piatra"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Pietre vrei sa vinzi ?", "O Piatra valoreaza 10 $", function(player, Piatra)
			if(Piatra ~= "" and Piatra ~= nil)then
				if(tonumber(Piatra))then
					Piatra = tonumber(Piatra)
					if(Piatra > 0) and (Piatra <= 999)then
						if vRP.tryGetInventoryItem({user_id,"piatrafull",Piatra,false}) then
							local PretPiatra = math.floor(Piatra * 10)
							vRP.giveMoney({user_id, PretPiatra})

							vRPclient.notify(player,{"Ai primit +1 EXP Point pentru vanzare"})
							vRPclient.notify(player, {"[Amanet] ~g~Ai vandut ~t~"..Piatra.." Pietre ~g~pentru ~r~$"..PretPiatra})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Amanet] ~r~Nu ai destule Pietre !"})
						end
					else
						vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Pietre intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Pietre !"})
				end
			else
				vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Pietre !"})
			end
		end})
	end
end, "<font color='gray'>O Piatra</font> = <font color='green'>10 $"}


casinoCasier_menu["Vinde Lingou Argint"] = {function(player, choice)
	local user_id = vRP.getUserId({player}) -- 700
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri de Argint vrei sa vinzi ?", "1 Lingou valoreaza 100 $", function(player, LingouArgint)
			if(LingouArgint ~= "" and LingouArgint ~= nil)then
				if(tonumber(LingouArgint))then
					LingouArgint = tonumber(LingouArgint)
					if(LingouArgint > 0) and (LingouArgint <= 999)then
						if vRP.tryGetInventoryItem({user_id,"lingouargint",LingouArgint,false}) then
							local PretLingouArgint = math.floor(LingouArgint * 100)
							vRP.giveMoney({user_id, PretLingouArgint})

							vRPclient.notify(player,{"Ai primit +1 EXP Point pentru vanzare"})
							vRPclient.notify(player, {"[Amanet] ~g~Ai vandut ~t~"..LingouArgint.." Lingouri de Argint ~g~pentru ~r~$"..PretLingouArgint})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Amanet] ~r~Nu ai destule Lingouri !"})
						end
					else
						vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='gray'>1 Lingou de Argint</font> = <font color='green'>100$"}


casinoCasier_menu["Vinde Lingou Diamant"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri de diamant vrei sa vinzi ?", "1 Lingou valoreaza 500 $", function(player, LingouDiamant)
			if(LingouDiamant ~= "" and LingouDiamant ~= nil)then
				if(tonumber(LingouDiamant))then
					LingouDiamant = tonumber(LingouDiamant)
					if(LingouDiamant > 0) and (LingouDiamant <= 999)then
						if vRP.tryGetInventoryItem({user_id,"lingoudiamant",LingouDiamant,false}) then
							local PretLingouDiamant = math.floor(LingouDiamant * 500)  -- 1000
							vRP.giveMoney({user_id, PretLingouDiamant})

							vRPclient.notify(player,{"Ai primit +1 EXP Point pentru vanzare"})
							vRPclient.notify(player, {"[Amanet] ~g~Ai vandut ~b~"..LingouDiamant.." Lingouri de Diamant ~g~pentru ~r~$"..PretLingouDiamant})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Amanet] ~r~Nu ai destule Lingouri !"})
						end
					else
						vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri !"})
				end
			else
				vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri !"})
			end
		end})
	end
end, "<font color='cyan'>1 Lingou de Diamant</font> = <font color='green'>500 $"}


casinoCasier_menu["Vinde Lingou Aur"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate Lingouri de Aur vrei sa vinzi ?", "1 Lingou valoreaza 350 $", function(player, LingouAur)
			if(LingouAur ~= "" and LingouAur ~= nil)then
				if(tonumber(LingouAur))then 
					LingouAur = tonumber(LingouAur)
					if(LingouAur > 0) and (LingouAur <= 999)then
						if vRP.tryGetInventoryItem({user_id,"lingouaur",LingouAur,false}) then
							local PretLingouAur = math.floor(LingouAur * 350)
							vRP.giveMoney({user_id, PretLingouAur}) -- 500

							vRPclient.notify(player,{"Ai primit +1 EXP Point pentru vanzare"})
							TriggerClientEvent("LingouAur", player, PretLingouAur)
							TriggerClientEvent("cumparare", player)

							vRPclient.notify(player, {"[Amanet] ~g~Ai vandut ~y~"..LingouAur.." Lingou de Aur ~g~pentru ~r~$"..PretLingouAur})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Amanet] ~r~Nu ai destule Lingouri!"})
						end
					else
						vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri!"})
				end
			else
				vRPclient.notify(player, {"[Amanet] ~r~Trebuie sa introduci un numar de Lingouri!"})
			end
		end})
	end
end, "<font color='yellow'>1 Lingou de Aur</font> = <font color='green'>350 $"}


function vRPcs.spawnLingouDealer(thePlayer)
    local casCasier_enter = function(player, area)
        local user_id = vRP.getUserId({player})
        if user_id ~= "" and user_id ~= nil then
            vRP.openMenu({player, casinoCasier_menu})
        end
    end

    local casCasier_leave = function(player, area)
        local user_id = vRP.getUserId({player})
        if user_id ~= "" and user_id ~= nil then
            vRP.closeMenu({player})
        end
    end

    for i, v in pairs(VanzareLingou) do
        if(i == 1)then
            vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~b~Amanet"})
            vRP.setArea({thePlayer,"vRP:cashier:"..i,v[1], v[2], v[3],1.7,1.5,casCasier_enter,casCasier_leave})
        else
            vRPCasinoC.createCasinoNPCs(thePlayer,{"A_M_Y_business_01",v[1], v[2], v[3], 179.9213104248, "Jimmy_Anderson"})
		end
    end
end

function vRPcs.spawnTheRoulettes(thePlayer)
	local casRoulette_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoRoulette_menu})
		end
	end

	local casRoulette_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	for i, v in pairs(Crafting)do
		vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~r~Roulette"})
		vRP.setArea({thePlayer,"vRP:casino:roulette:"..i,v[1], v[2], v[3],1,1.5,casRoulette_enter, casRoulette_leave})
	end
end


-- function vRPcs.spawnCraftingArme(thePlayer)
-- 	local crafting_enter = function(player, area)
-- 		local user_id = vRP.getUserId({player})
-- 		if user_id ~= "" and user_id ~= nil then
-- 			vRP.openMenu({player, crafting_menu})
-- 		end
-- 	end

-- 	local crafting_leave = function(player, area)
-- 		local user_id = vRP.getUserId({player})
-- 		if user_id ~= "" and user_id ~= nil then
-- 			vRP.closeMenu({player})
-- 		end
-- 	end

-- 	for i, v in pairs(Crafting2)do
-- 		vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~r~Roulette"})
-- 		vRP.setArea({thePlayer,"vRP:casino:roulette:"..i,v[1], v[2], v[3],1,1.5,crafting_enter, crafting_leave})
-- 	end
-- end



AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    SetTimeout(1500, function()
		vRPcs.spawnLingouDealer(source)
		vRPcs.spawnTheRoulettes(source)
		-- vRPcs.spawnCraftingArme(source)
    end)
end)