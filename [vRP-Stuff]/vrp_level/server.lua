local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_level")
local cfg = module("vrp_level", "cfg/display")

-- mysql commands
--MySQL.createCommand("vRP/level_table","ALTER TABLE vrp_users ADD level INTEGER DEFAULT 0, ADD experience INTEGER DEFAULT 0")
--MySQL.createCommand("vRP/up_level","UPDATE vrp_users SET level=level+1 WHERE id=@id") -1636.2857666016,180.97286987305,61.757270812988
--MySQL.createCommand("vRP/xp_modify","UPDATE vrp_users SET experience = @experience  WHERE id=@id")
--MySQL.createCommand("vRP/up_experience","UPDATE vrp_users SET experience=experience+1 WHERE id=@id")
--MySQL.createCommand("vRP/select_xp","SELECT * FROM vrp_users WHERE id=@id")

--MySQL.execute("vRP/level_table")
function round(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end


AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if first_spawn then
		exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
			experience = rows[1].experience
			level = rows[1].level
			xpnec = 10*level+15
		end)
	end
  end)



RegisterServerEvent('vrp:level_increase')
AddEventHandler('vrp:level_increase', function()
	local a = false
	local user_id = vRP.getUserId({source})

	  exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
		['@id'] = user_id
	}, function (rowsz)
	end)
end)

local function inchide(player, choice)
	return
end

local function xpLevel (experience,level,xpnec)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
		experience = rows[1].experience
		level = rows[1].level
		xpnec = 5*level+9
	end)

end

local function lvlUp(player,choice)
	local user_id = vRP.getUserId({player})
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
		local experience = rows[1].experience
		local level = rows[1].level
		local xpnec = 5*level+9
		if experience >= xpnec then 
			  exports.ghmattimysql:execute("UPDATE vrp_users SET level=level+1 WHERE id=@id", {
				['@id'] = user_id
			}, function (rows)
			end)
			TriggerClientEvent('chatMessage',player,'^4[LEVEL]', {255, 0, 0},"Ai luat level up")	

			  exports.ghmattimysql:execute("UPDATE vrp_users SET experience = @experience  WHERE id=@id", {
				['@id'] = user_id,
				['@experience'] = experience - xpnec
			}, function (rows)
			end)
		else
			TriggerClientEvent('chatMessage',player,'^4[LEVEL]', {255, 0, 0},"Nu ai destula experienta.")	
		end
	end)

end


vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}

		exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)

			local experience = rows[1].experience
			local level = rows[1].level
			local xpnec = 5*level+9

			choices["Level UP"] = {lvlUp, "Sistemul de Level <br> LEVEL:<font color=\"orange\">"..level.."</font><br>EXP:<font color=\"orange\">"..experience.."</font>/<font color=\"orange\">"..xpnec.."</font>"}


			add(choices)
		end)

	end
end})