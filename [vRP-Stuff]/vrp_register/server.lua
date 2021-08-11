--[[BASE]]--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","hood_register")

--[[SQL]]--
--[[
MySQL.createCommand("vRP/register_column", "ALTER TABLE vrp_users ADD IF NOT EXISTS  inreg INTEGER(50) NOT NULL default 0 ")
MySQL.createCommand("vRP/register_success", "UPDATE vrp_users SET inreg=1 WHERE id = @id")
MySQL.createCommand("vRP/register_fail", "UPDATE vrp_users SET inreg=0 WHERE id = @id")
MySQL.createCommand("vRP/register_search", "SELECT * FROM vrp_users WHERE id=@id")
MySQL.createCommand("vRP/nameSerach", "SELECT * FROM vrp_user_identities WHERE user_id=@user_id")

MySQL.createCommand("vRP/update_nume","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")
--]]
-- init
--MySQL.query("vRP/register_column")

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@id", {['@id'] = user_id}, function (rows)
		inreg = rows[1].inreg
		if inreg > 0 then
			print ("USER: ["..user_id.."] inregistrat")
			TriggerClientEvent('verificaInregistrare',player,inreg)
		else
			print ("USER: ["..user_id.."] neinregistrat")
			TriggerClientEvent('verificaInregistrare',player,inreg)
		end
	end)

end)

function checkName(theText)
	local foundSpace, valid = false, true
	local spaceBefore = false
	local current = ''
	for i = 1, #theText do
		local char = theText:sub( i, i )
		if char == ' ' then 
			if i == #theText or i == 1 or spaceBefore then 
				valid = false
				break
			end
			current = ''
			spaceBefore = true
		elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) then 
			current = current .. char
			spaceBefore = false
		else 
			valid = false
			break
		end
	end
	
	if (valid == true)  then
		return true
	else
		return false
	end
end

RegisterServerEvent('insereaza')
AddEventHandler('insereaza', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local nume = ""
	local prenume = ""
	vRP.prompt({player, "Numele: ", "", function(player,nume)
			vRP.prompt({player, "Prenume: ", "", function(player,prenume)
				vRP.prompt({player, "Varsta: MINIM:12, MAXIM:100", "", function(player,varsta)
					varsta = parseInt(varsta)
					if varsta >= 12 and varsta <= 150 then
						if (checkName(nume)) then
							if (checkName(prenume)) then
								vRPclient.notify(player,{"Te-ai inregistrat cu ~g~succes~w~ pe  NorbSiMaruServer~w~ Romania!"})
								TriggerClientEvent('inregistrat',player,user_id,nume,prenume,varsta)

								exports.ghmattimysql:execute("UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id", {
									['@user_id'] = user_id, 
									['@firstname'] = nume,
									['@name'] = prenume,
									['@age'] = varsta
								}, function (rowsz)
								end)

								exports.ghmattimysql:execute("UPDATE vrp_users SET inreg=@inreg WHERE id = @user_id", {
									['@user_id'] = user_id,
									['@inreg'] = 1
								}, function (rowsz)
								end)
							else
								Wait(100)
								print("Valoare invalida")
								DropPlayer(player,"[LOGIN-SYSTEM] Ai primit kick de la [SYSTEM], Cauza: Valori invalide la inregistrare(*Prenume)!")
							end
						else

							Wait(100)
							print("Valoare invalida")
							DropPlayer(player,"[LOGIN-SYSTEM] Ai primit kick de la [SYSTEM], Cauza: Valori invalide la inregistrare(*Nume)!")
						end
					else

						Wait(100)
						print("Valoare invalida")
						DropPlayer(player,"[LOGIN-SYSTEM] Ai primit kick de la [SYSTEM], Cauza: Valori invalide la inregistrare(*Varsta) Nume >12-150<!")
					end
			end})
		end})
	end})
end)


RegisterCommand('bb', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@id", {['@id'] = user_id}, function (rows)
		inreg = rows[1].inreg
		if inreg > 0 then
			print ("USER: ["..user_id.."] inregistrat")
			TriggerClientEvent('verificaInregistrare',player,inreg)
		else
			print ("USER: ["..user_id.."] neinregistrat")
			TriggerClientEvent('verificaInregistrare',player,inreg)
		end
	end)

end)

AddEventHandler("playerConnecting", function (name,kick,defer)
	defer.defer()
	Citizen.Wait(50)

	if(name:find("<") ~= nil or name:find(">") ~= nil) then
		defer.done("nu-ti merge cu NorbSiMaruServer Romania")
		return
	end
	defer.done()
end)

