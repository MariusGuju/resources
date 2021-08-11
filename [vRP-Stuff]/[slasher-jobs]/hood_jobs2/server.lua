local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_jobs")
vRPCjobs = Tunnel.getInterface("vRP_jobs","vRP_jobs")

vRPjobs = {}
Tunnel.bindInterface("vRP_jobs",vRPjobs)
Proxy.addInterface("vRP_jobs",vRPjobs)

--[[
MySQL.createCommand("vRP/set_player_job","UPDATE vrp_users SET job = @theJob WHERE id = @user_id")
MySQL.createCommand("vRP/get_player_job","SELECT * FROM vrp_users WHERE id = @user_id")
--]]

jobCheckpoint = {-1081.3146972656,-247.17333984375,37.763278961182}

jobs = {"Gunoier", "Sofer Autobuz", "Uber Eatz", "Croitor"}

function vRPjobs.getPlayerJob(user_id)
	local tmp = vRP.getUserTmpTable({user_id})
	if (tmp.job ~= nil) then
		return tostring(tmp.job)
	end
	return "Somer"
end

function vRPjobs.hasPlayerJob(user_id)
	local tmp = vRP.getUserTmpTable({user_id})
	if tmp then
		theJob = tostring(tmp.job)
		if(tostring(theJob) == "Somer")then
			return false
		else
			return true
		end
	else
		return false
	end
	return false
end

--function vRP.setPlayerJob(user_id,theJob)
--	MySQL.execute("vRP/set_player_job", {theJob = theJob, user_id = user_id})
--end

function vRPjobs.setPlayerJob(user_id, theJob)
	vRP.setPlayerJob({user_id, theJob})

	exports.ghmattimysql:execute("UPDATE vrp_users SET job = @theJob WHERE id = @user_id", {
		['@user_id'] = user_id,
		['@theJob'] = theJob
	}, function (rows)
	end)
end

function vRPjobs.setAsUnemployed(user_id)
	vRP.setPlayerJob({user_id, "Somer"})
	exports.ghmattimysql:execute("UPDATE vrp_users SET job = @theJob WHERE id = @user_id", {
		['@user_id'] = user_id,
		['@theJob'] = "Somer"
	}, function (rows)
	end)
end

local jobs_menu = {name="Joburi",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

jobs_menu[".Demisioneaza"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(vRPjobs.hasPlayerJob(user_id))then
		local playerJob = vRPjobs.getPlayerJob(user_id)
		vRPjobs.setAsUnemployed(user_id)
		vRPclient.notify(player, {"[JOB] ~r~Ti-ai dat demisia din functia de ~g~"..playerJob})
		vRP.closeMenu({player})
	else
		vRPclient.notify(player, {"[JOB] ~r~Esti deja somer!"})
	end
end, "Da-ti demisia!"}

for i, v in pairs(jobs) do
	local jobName = tostring(v)
	jobs_menu[jobName] = {function(player, choice) 
		local user_id = vRP.getUserId({player})
		--if(vRPjobs.hasPlayerJob(user_id))then
			--local playerJob = vRPjobs.getPlayerJob(user_id)
		--	vRPclient.notify(player, {"[JOB] ~r~Esti deja angajat ca ~g~"..playerJob.."~r~! Demisioneaza mai intai!"})
	--	else
			if(jobName == "Gunoier")then
				vRPjobs.executeTrashJob(player)
				vRPclient.notify(player, {"[JOB] ~g~Te-ai angajat ca ~r~"..jobName.."!! ~g~Du-te la camionul verde de pe harta pentru a incepe!"})
			elseif(jobName == "Sofer Autobuz")then
				vRPjobs.executeBusDriverJob(player)
				vRPclient.notify(player, {"[JOB] ~g~Te-ai angajat ca ~r~"..jobName.."! ~g~Du-te la ~b~camionul albastru ~g~de pe harta pentru a incepe!"})
			elseif(jobName == "Uber Eatz")then
				vRPjobs.executeFoodDeliveryJob(player)
				vRPclient.notify(player, {"[JOB] ~g~Te-ai angajat ca ~r~"..jobName.."! ~g~Du-te la motorul cu steag verde de pe harta pentru a incepe!"})
			elseif(jobName == "Croitor")then
				vRPjobs.spawnTailorJob(player)
				vRPclient.notify(player, {"[JOB] ~g~Te-ai angajat ca ~r~"..jobName.."! ~g~Du-te la foarfeca verde de pe harta pentru a incepe!"})
			end
			vRPjobs.setPlayerJob(user_id, jobName)
			vRP.closeMenu({player})
		--end
	end, "Angajeaza-te ca <font color='green'>"..jobName.."</font>"}
end

local function build_client_jobs(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local function jobs_enter()
			local user_id = vRP.getUserId({source})
			if user_id ~= nil then
				vRP.openMenu({source,jobs_menu})
			end
		end

		local function jobs_leave()
			vRP.closeMenu({source})
		end
		x, y, z = jobCheckpoint[1], jobCheckpoint[2], jobCheckpoint[3]
		vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})
		vRPclient.addMarkerNames(source,{x, y, z, "~r~Jo~y~bu~b~ri", 0, 0.9})

		vRP.setArea({source,"vRP:jobs",x,y,z,1,1.5,jobs_enter,jobs_leave})
	end
end

RegisterCommand("cls", function(source)
	build_client_jobs(source)
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_jobs(source)
		exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (rows)
			if #rows > 0 then
				theJob = tostring(rows[1].job)
				if(theJob ~= "Somer")then
					vRP.setPlayerJob({user_id, theJob})
					vRPclient.notify(source, {"[JOB] ~g~Esti angajat ca ~b~"..theJob})
				else
					vRPclient.notify(source, {"[JOB] ~g~Nu ai loc de munca! Du-te la ~g~Primarie ~r~pentru a te angaja!"})
				end
			end
		end)

	end
end)