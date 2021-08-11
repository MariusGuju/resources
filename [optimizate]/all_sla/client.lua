lideri = {
    {"Chestor General"}
}

politie = {
    {"Cadet", "Chestor General", "M.A.I"},
    {"Agent", "Chestor General", "M.A.I"},
    {"Agent Principal", "Chestor General", "M.A.I"},
    {"Agent Sef Principal", "Chestor General", "M.A.I"},
    {"Inspector", "Chestor General", "M.A.I"},
    {"Sub Comisar", "Chestor General", "M.A.I"},
    {"Comisar", "Chestor General", "M.A.I"}
}



local function ch_invitagradpd(player,choice)
    local user_id = vRP.getUserId(player)
    for i, v in pairs(politie) do
        factiune = v[3]
        lider = v[2]
        grup = v[1]
        if user_id ~= nil and vRP.hasGroup(user_id,lider) then
            vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
                id = parseInt(id)
                local target = vRP.getUserSource(id)
                vRP.addUserGroup(id,grup)
                    vRPclient.notify(player,{"~w~ L-ai adaugat in ~g~"..factiune.." ~w~ pe ID:~g~ "..id})
                    vRPclient.notify(target,{"~w~ Ai fost adaugat in ~g~"..factiune})
            end)
        end
    end
end

local function ch_promveazagradpd(player,choice)
    local user_id = vRP.getUserId(player)
    for i, v in pairs(politie) do
        factiune = v[3]
        lider = v[2]
        grup = v[1]
        if user_id ~= nil and vRP.hasGroup(user_id,lider) then
            vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
                id = parseInt(id)
                local target = vRP.getUserSource(id)
                if vRP.hasGroup(id,grup) then
                    vRP.addUserGroup(id,grup)
                    vRPclient.notify(player,{"~w~ L-ai promovat pe ID:~g~ "..id.." ~g~la gradul de "..grup})
                    vRPclient.notify(target,{"~w~ Ai fost promovat la gradul de "..grup})
                else 
                    vRP.hasGroup(id,"Chestor")
                    vRPclient.notify(player,{"~w~ Este deja Co-Lider! ~w~ Nu ai cum sa il mai promovezi!"})
                end
            end)
        end
    end
end

local function ch_excludegradpd(player,choice)
    local user_id = vRP.getUserId(player)
    for i, v in pairs(politie) do
        factiune = v[3]
        lider = v[2]
        grup = v[1]
        if user_id ~= nil and vRP.hasGroup(user_id,lider) then
            vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
                id = parseInt(id)
                if id ~= nil then 
                    local target = vRP.getUserSource(id)
                    vRP.addUserGroup(id,"Somer")
                        vRPclient.notify(player,{"~w~ L-ai dat afara din "..factiune.." ~w~ pe ID:~g~ "..id})
                        vRPclient.notify(target,{"~r~ Ai fost dat afara din "..factiune})
                end    
            end)
        end
    end
end


vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
		if vRP.hasGroup(user_id,"Chestor General") or vRP.hasGroup(user_id,"lider2")  then 
			local choices = {}

			choices["Meniu factiune"] = {function(player,choice)
				vRP.buildMenu("Lider", {player = player}, function(menu)
					menu.name = "Lider"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu(player) end

				if vRP.hasGroup(user_id,"Chestor General") then
					menu["Recruteaza"] = {ch_invitagradpd}
				end
				if vRP.hasGroup(user_id,"Chestor General") then
					menu["Promoveaza"] = {ch_promveazagradpd}
				end
				if vRP.hasGroup(user_id,"Chestor General") then
					menu["Exclude"] = {ch_excludegradpd}
		
				end
					vRP.openMenu(player,menu)
			end)
		end}
      add(choices)
	  end
    end
end)