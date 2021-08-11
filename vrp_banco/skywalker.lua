local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_banking")

vRPlogs = Proxy.getInterface("vRP_logs")

vRPbanking = {}
Tunnel.bindInterface("vrp_banking",vRPbanking)
Proxy.addInterface("vrp_banking",vRPbanking)
vRPbm = {}
function vRPbm.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end
RegisterServerEvent('bank:puladeposit')
AddEventHandler('bank:puladeposit', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	local name = GetPlayerName(source)
	if(tonumber(amount))then
		amount = tonumber(amount)
		if amount > 0 then
		if(vRP.tryPayment({user_id, amount}))then
			vRP.setBankMoney({user_id, bankMoney+amount})
			vRP.setMoney({user_id, walletMoney-amount})
			vRPclient.notify(thePlayer, {"~g~Ai depus ~y~$"..amount.." ~g~in banca!"})
		else
			vRPclient.notify(thePlayer, {"~r~Nu ai destui bani la tine!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
		TriggerClientEvent('chatMessage', -1, '^8[ANTI-PLOZI SYSTEM]', {255, 0, 0}, "^9" ..name.. "[ID: " ..user_id.. " ] a incercat sa faca bug-ul la banca.. ce scarba proasta.." )
	end
	end
end)


RegisterServerEvent('bank:pulawith')
AddEventHandler('bank:pulawith', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	if(tonumber(amount))then	
		amount = tonumber(amount)
		if(amount > 0 and amount <= bankMoney)then
			vRP.setBankMoney({user_id, bankMoney-amount})
			vRP.setMoney({user_id, walletMoney+amount})
			vRPclient.notify(thePlayer, {"~g~Ai retras ~y~$"..amount.." ~g~din banca!"})
		else
			vRPclient.notify(thePlayer, {"~r~Nu ai destui bani in banca!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local bankMoney = vRP.getBankMoney({user_id})
	TriggerClientEvent('currentbalance1', thePlayer, bankMoney)
end)

RegisterServerEvent('bank:pulatransfer')
AddEventHandler('bank:pulatransfer', function(to, amount)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(tonumber(to)  and to ~= "" and to ~= nil)then
		to = tonumber(to)
		theTarget = vRP.getUserSource({to})
		if(theTarget)then
			if(thePlayer == theTarget)then
				vRPclient.notify(thePlayer, {"~r~Nu iti poti transfera bani tie!"})
			else
				if(tonumber(amount) and tonumber(amount) > 0 and amount ~= "" and amount ~= nil)then
					amount = tonumber(amount)
					bankMoney = vRP.getBankMoney({user_id})
					if(bankMoney >= amount)then
						newBankMoney = tonumber(bankMoney - amount)
						vRP.setBankMoney({user_id, newBankMoney})
						vRP.giveBankMoney({to, amount})
						vRPbm.logInfoToFile("money.txt", user_id.." i-a dat "..amount.." $ lui "..to)
						vRPclient.notify(thePlayer, {"~g~Ai transferat ~y~$"..amount.." ~g~lui ~b~"..GetPlayerName(theTarget)})
						vRPclient.notify(theTarget, {"~y~"..GetPlayerName(thePlayer).." ~g~ti-a transferat ~b~$"..amount})
					else
						vRPclient.notify(thePlayer, {"~r~Nu ai destui bani in banca!"})
					end
				else
					vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
				end
			end
		else
			vRPclient.notify(thePlayer, {"~r~Jucatorul nu a fost gasit"})
		end
	end
end)