local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_giftbox")


RegisterServerEvent('verificagift')
AddEventHandler('verificagift', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	local sumabani = math.random(100, 700)
	local sumaaur = math.random(0,1)
	local sansadeprimireaur = math.random(1,6)
	local sumajackpot = math.random(3000,10000)
	local sumaaurjackpot = math.random(1,5)
	local numajackpot = math.random(0,300)
	local sansaMasina = math.random(300,700)
	local sansaVip = math.random(300,700)
	local masini = math.random(1,3)
	local pachetevip = math.random(1,3)

	if vRP.tryPaymentPuncte({user_id,10}) then

		if sansaMasina == -100 then
				if masini > 0  then
					masinarand = math.random(1,3)
					if masinarand == 1 then
						numeMasina = "Koenisegg Regerra"
					end
					if masinarand == 2 then
						numeMasina = "Audi RS5"
					end
					if masinarand == 3 then
						numeMasina = "Ferrari Aperta"
					end
					TriggerClientEvent('chatMessage', -1, '^3[MASINA-JACKPOT-GIFT]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^4"..numeMasina.." ^9 [GG PLEB]" )
					return
				end
		end

		if sansaVip == 0 then
				if pachetevip > 0  then
					grupa = math.random(1,3)
					if grupa == 1 then
						numevip = "VIP 1"
						grup = "vip"
					end
					if grupa == 2 then
						numevip = "VIP 2"
						grup = "vip2"
					end
					if grupa == 3 then
						numevip = "VIP 3"
						grup = "vip3"
					end
					if vRP.hasGroup({user_id,grup}) then
					else
						TriggerClientEvent('chatMessage', -1, '^3[VIP-JACKPOT-GIFT]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^2" ..numevip.."^9[GG PLEB]" )
						vRP.addUserGroup({user_id,grup})
						return
					end
				else
				end
		end

			if (numajackpot == 29) then
				vRP.giveMoney({user_id, sumajackpot})
				vRP.giveAur({user_id, sumaaurjackpot})
				TriggerClientEvent('chatMessage', -1, '^3[JACKPOT-GIFT]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^2" ..sumajackpot.."$, ^0 si  ^5" ..sumaaurjackpot.." ^0AUR!" )
				return
			else
			vRP.giveMoney({user_id, sumabani})
			end
			if (sansadeprimireaur == 1) then
			vRP.giveAur({user_id, sumaaur})
TriggerClientEvent('chatMessage', -1, '^4[GIFTBOX]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^2" ..sumabani.."$, ^0 si  ^5" ..sumaaur.." ^0AUR!" )
return
			else
sumaaur = 0
				TriggerClientEvent('chatMessage', -1, '^4[GIFTBOX]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^2" ..sumabani.."$, ^0 si  ^5" ..sumaaur.." ^0AUR!" )
				return
            end
			--TriggerClientEvent('chatMessage', -1, '^4[GIFTBOX]', {255, 0, 0}, "^4" ..name.. "^0 a castigat: ^2" ..sumabani.."$, ^0 si  ^5" ..sumaaur.." ^0AUR!" )
		else
			TriggerClientEvent('nuaipuncte', player)
	end

end)