--- Script based on Sighmir's vrp_display
vRPN = {}
Tunnel.bindInterface("vrp_pnames",vRPN)
vRP = Proxy.getInterface("vRP")
local players = {}
local permissions = {}
local groups = {}

local function curcubeu( frequency )
	local result = {}
	local curtime = GetGameTimer() / 4000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

function DrawText3D(x,y,z, text, r,g,b,a)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
		local rainbow = curcubeu( 1 )
		SetTextColour( rainbow.r, rainbow.g, rainbow.b, a)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local idtest = false
Citizen.CreateThread(function()
    while true do
        for i=0,99 do N_0x31698aa80e0223f8(i)
        end

        for k,v in pairs(players) do
            local ped = GetPlayerPed(v)
            local ply = GetPlayerPed(-1)

			if ((ped ~= ply) or config.self) then
				local x1, y1, z1 = table.unpack(GetEntityCoords(ply, true))
				local x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
				local distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

				if ((distance < config.range)) and (not config.admin_only or permissions[k]) then
					local group = groups[k]
					local text = ""
					if (group == "esk") then
                        z2 = z2+0.1
                        local rainbow = curcubeu( 1 )
                        r,g,b,a =rainbow.r, rainbow.g, rainbow.b, 255
						text = text .. "EskaPe\n[NU FAC RP]".."\n"
					else
						r,g,b,a = config.colors.default.r,config.colors.default.g,config.colors.default.b,config.colors.default.a
					end

					if NetworkIsPlayerTalking(v) and config.speaker then
                        z2 = z2+0.25
                        r,g,b,a = config.colors.speaker.r,config.colors.speaker.g,config.colors.speaker.b,config.colors.speaker.a
                        text = text .. config.lang[config.lang.default].speaking .. "\n"
                    end

                    if config.id and not config.name then text = text .. k
                    elseif config.id then text = text .. ' (' .. k .. ')'
                    end

                    DrawText3D(x2, y2, z2+1, text, r,g,b,a)
				end  
			end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('SetGod')
AddEventHandler('SetGod', function(user_id)
    local user_id = GetPlayerFromServerId(source)
    idtest = true
end)
RegisterNetEvent('SetGod1')
AddEventHandler('SetGod1', function(user_id)
    local user_id = GetPlayerFromServerId(source)
    idtest = false
end)


function vRPN.insertUser(user_id,source,permission,group)
    players[user_id] = GetPlayerFromServerId(source)
    permissions[user_id] = permission
	groups[user_id] = group
end

function vRPN.removeUser(user_id)
    players[user_id] = nil
end