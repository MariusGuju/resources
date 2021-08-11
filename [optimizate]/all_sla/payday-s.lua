--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","all_sla")
local cfg = module("vrp_level", "cfg/display")



salarii = {
	{"agent.salariu", 600,"M.A.I"},  --politie  agent            500
	{"agentp.salariu", 600,"M.A.I"},   ---sias    agent          510
	{"agents.salariu", 650,"M.A.I"},   --politie   agent-sef      525
	{"agentsp.salariu", 650,"M.A.I"},   --sias      agent-sef     535
	{"subinspector.salariu", 700,"M.A.I"},  --politie  inspector  550
	{"inspector.salariu", 700,"M.A.I"},   --sias   inspector      560
	{"inspectorp.salariu", 750,"M.A.I"},   --politie   inspector principal   600
	{"subcomisar.salariu", 750,"M.A.I"},    --sias     comisar       610
	{"comisar.salariu", 800,"M.A.I"},       --politie   comisar       650
	{"comisars.salariu", 800,"M.A.I"},      --sias       comisar sef    670
	{"chestor.salariu", 900,"M.A.I"},        --politie   chestor secundar     700
	{"chestorp.salariu", 900,"M.A.I"},        --sias      chestor secundar    710
	{"chestors.salariu", 1000,"M.A.I"},         --sias    chestor general      750
	{"chestorg.salariu", 1000,"M.A.I"},       --chestor    chestor general     750
	{"ems.salariu", 700,"UPU-SMURD"},             --400 
	{"stagiar.salariu", 800,"UPU-SMURD"},         --425
	{"chirurg.salariu", 900,"UPU-SMURD"},          --450
	{"dmedical.salariu", 1000,"UPU-SMURD"},         --500
	{"dspital.salariu", 1100,"UPU-SMURD"},          --550
	--{"job.salariu", 700,"Locul de munca"},       --trebuie scos de pe server 
	{"repair.salariu", 250,"Costel Vulcanizare"},   --aici ar trebu sa stabilim un pret pentru reparatiea la masina
	{"vip1.salariu", 600,"VIP SILVER"},   -- 550
	{"vip2.salariu", 750,"VIP GOLD"},      --800
	{"vip3.salariu", 900,"VIP PLATINUM"},   --1050
	{"vip4.salariu", 1100,"VIP DIAMOND"},
	{"soferp.salariu", 200, "Dispercerat Taximetrie"},   --1550
	{"user.salariu", 250,"Premiu NorbSiMaruServer"},
	{"vagos.salariu", 400,"Capul Mafiei"},
	{"rusa.masini", 400,"Capul Mafiei"},
	{"sinaloa.masini", 400,"Capul Mafiei"},	
	{"premium.salariu", 1000,"Premiu NorbSiMaruServer"},     --aici trebuie schimbat din ajutor somaj premiu the vrp
	{"nitro.salariu", 200,"Bonus pentru NitroBoost"},     --aici trebuie schimbat din ajutor somaj premiu the vrp
	{"sponsor.salariu", 1000,"Sponsorizare"}  --aici e de vazut 
}

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

RegisterServerEvent('salar')
AddEventHandler('salar', function(minute,secunde)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if minute == 30 and secunde == 60 then
		print("payday mesaj")
		exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
			for i, v in pairs(salarii) do
				permisiune = v[1]
				if(vRP.hasPermission({user_id, permisiune}))then
					salar = v[2]
					deLaGrupa = v[3]
					level = rows[1].level
					experience = rows[1].experience
					chirias = rows[1].chirias
					--print(chirias)
					if chirias > 0 then
						--print(chirias)
						exports.ghmattimysql:execute("SELECT * FROM esk_case WHERE id = @idc", {['@idc'] = chirias}, function (rowsz)
							pretCasaChirie = rowsz[1].pretChirie
							chirieAdunataDeja = rowsz[1].chirieAdunata
							updateChirieAdunata =  rowsz[1].chirieAdunata + pretCasaChirie
							vRP.tryPayment({user_id,pretCasaChirie})
							vRPclient.notify(player,{"Ai platit ~g~$"..pretCasaChirie.."~w~ pentru chirie la casa ~b~#"..chirias})
							exports.ghmattimysql:execute("UPDATE esk_case SET chirieAdunata = @chirieAdunata WHERE id = @id", {
								['@id'] = chirias,
								['@chirieAdunata'] = updateChirieAdunata
							}, function (rowsz)
							end)
						end)
					end
					xpnec = 5*level+9
					bonuslevel = ((level/2)*salar)/20
					vRP.giveMoney({user_id,salar})--
					vRP.giveMoney({user_id,bonuslevel})
					vRP.givePuncte({user_id, 1})
					if experience < xpnec then
						exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
							['@id'] = user_id
						}, function (rowsz)
						end)
					else
						TriggerClientEvent('mesajPeChat',player,'^4[PAYDAY]', {255, 0, 0},"Nu ai primit puncte de experienta din cauza ca ai deja levelul plin, da-ti LEVEL UP")	
					end
					TriggerClientEvent("salarPrimit",player,deLaGrupa,salar,bonuslevel,level)
				end
			end
		end)
	end
end)

--[[RegisterServerEvent('contorizare')
AddEventHandler('contorizare', function(minute,secunde)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local paydayluat = 0
	if minute == 30 and secunde == 60 then
		paydayluat = paydayluat + 1
	end
	if paydayluat == 3 then

end)]]