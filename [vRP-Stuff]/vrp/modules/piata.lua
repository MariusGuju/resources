local tdCords = {153.67901611328,-977.48028564454,30.091928482056}

local menu_piata = {
	name = "Piata",
	css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
}

menu_piata["Vinde Struguri Albi"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate kilograme de struuguri vrei sa vinzi ?", "", function(player, StruguriAlbi)
			if(StruguriAlbi ~= "" and StruguriAlbi ~= nil)then
				if(tonumber(StruguriAlbi))then
					StruguriAlbi = tonumber(StruguriAlbi)
					if(StruguriAlbi > 0) and (StruguriAlbi <= 999)then
						if vRP.tryGetInventoryItem({user_id,"strugure",StruguriAlbi * 10,false}) then
							local PretStruguriAlbi = math.floor(StruguriAlbi * 7)
							updateGoalContributie = PretStruguriAlbi / 2
							exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
							exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
							exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
								['@id'] = user_id
							}, function (rows)
    						end)
							vRP.giveMoney({user_id, PretStruguriAlbi})
							vRPclient.notify(player, {"[Piata] ~g~Ai vandut ~y~"..StruguriAlbi.." kilograme de Struguri Albi ~g~pentru ~r~$"..PretStruguriAlbi})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Piata] ~r~Nu ai destui Struguri !"})
						end
					else
						vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri !"})
				end
			else
				vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri !"})
			end
		end})
	end
end, "<font color='white'> 1 KG = <font color='green'>7 $  <font color='white'> (1 KG = 10 Bucati)"}


menu_piata["Vinde Struguri Negri"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate kilograme de struuguri vrei sa vinzi ?", "", function(player, StruguriNegri)
			if(StruguriNegri ~= "" and StruguriNegri ~= nil)then
				if(tonumber(StruguriNegri))then
					StruguriNegri = tonumber(StruguriNegri)
					if(StruguriNegri > 0) and (StruguriNegri <= 999)then
						if vRP.tryGetInventoryItem({user_id,"struguri",StruguriNegri * 10,false}) then
							local PretStruguriNegri = math.floor(StruguriNegri * 5)
							updateGoalContributie = PretStruguriNegri / 2
							exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
							exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
							exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
								['@id'] = user_id
							}, function (rows)
    						end)
							vRP.giveMoney({user_id, PretStruguriNegri})
							vRPclient.notify(player, {"[Piata] ~g~Ai vandut ~y~"..StruguriNegri.." kilograme ded Struguri Albi ~g~pentru ~r~$"..PretStruguriNegri})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Piata] ~r~Nu ai destui Struguri !"})
						end
					else
						vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri !"})
				end
			else
				vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar de Struguri !"})
			end
		end})
	end
end, "<font color='white'> 1 KG = <font color='green'>5 $  <font color='white'> (1 KG = 10 Bucati)"}


menu_piata["Vinde Lapte de Vaca"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cat Lapte de Vaca vrei sa vinzi ?", "", function(player, Lapte)
			if(Lapte ~= "" and Lapte ~= nil)then
				if(tonumber(Lapte))then
					Lapte = tonumber(Lapte)
					if(Lapte > 0) and (Lapte <= 999)then
						if vRP.tryGetInventoryItem({user_id,"lapte",Lapte * 10,false}) then
							local PretLapte = math.floor(Lapte * 5)
							updateGoalContributie = PretLapte / 2
							exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
							exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
							exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
								['@id'] = user_id
							}, function (rows)
    						end)
							vRP.giveMoney({user_id, PretLapte})
							vRPclient.notify(player, {"[Piata] ~g~Ai vandut ~y~"..Lapte.." kilograme ~g~pentru ~r~$"..PretLapte})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Piata] ~r~Nu ai destule Sticle de Lapte !"})
						end
					else
						vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar !"})
				end
			else
				vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar !"})
			end
		end})
	end
end, "<font color='white'> 1 KG de Lapte = <font color='green'>5 $  <font color='white'> (1 KG = 10 Bucati)"}


menu_piata["Vinde Carne de Vaca"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cata Carne de Vaca vrei sa vinzi ?", "", function(player, Carne)
			if(Carne ~= "" and Carne ~= nil)then
				if(tonumber(Carne))then
					Carne = tonumber(Carne)
					if(Carne > 0) and (Carne <= 999)then
						if vRP.tryGetInventoryItem({user_id,"carne",Carne,false}) then
							local PretLapte = math.floor(Carne * 15)
							updateGoalContributie = PretLapte / 2
							exports.ghmattimysql:execute("UPDATE vrp_users SET goalj= goalj + @updategoal WHERE id = @user_id", {['user_id'] = user_id,['@updategoal'] = updateGoalContributie }, function (rows) end)
							exports.ghmattimysql:execute("UPDATE esk_goal SET goal=goal + @goalGlobal", {['@goalGlobal'] = deliveryMoney}, function (rows) end)
							exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+1 WHERE id=@id", {
								['@id'] = user_id
							}, function (rows)
    						end)
							vRP.giveMoney({user_id, PretLapte})
							vRPclient.notify(player, {"[Piata] ~g~Ai vandut ~y~"..Carne.." kilograme ~g~pentru ~r~$"..PretLapte})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"[Piata] ~r~Nu ai destula Carne !"})
						end
					else
						vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar intre 1 si 99!"})
					end
				else
					vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar !"})
				end
			else
				vRPclient.notify(player, {"[Piata] ~r~Trebuie sa introduci un numar !"})
			end
		end})
	end
end, "<font color='white'> 1 KG de Carne = <font color='green'> 15 $  <font color='white'> (1 KG = 10 Bucati)"}


local function build_piata(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then

		local x, y, z = table.unpack(tdCords)

		local conf_enter = function(player, area)
			local user_id = vRP.getUserId({player})
			if user_id ~= nil then
				if menu_piata then 
					vRP.openMenu({player, menu_piata}) 
				end

			end
		end

		local conf_leave = function(player, area)
			vRP.closeMenu({player})
		end

		vRPclient.addMarker(source,{x,y,z-0.95,1,1,0.9,0, 66, 134, 244,150})
		vRP.setArea({source, "vRP:confisatdePles", x, y, z, 3, 2, conf_enter, conf_leave})
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_piata(source)
  end
end)


RegisterCommand("piata", function(ply)
    build_piata(ply)
end)
