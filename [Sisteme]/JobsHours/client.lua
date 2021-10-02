
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","iajoburi")

function text(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function blip()
	local blip = AddBlipForCoord()
	SetBlipSprite(blip,351)
end

Citizen.CreateThread(function()
	blip()
    hologrameVERE()
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
	local scale = (1/dist)*20
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov  
	SetTextScale(scaleX*scale, scaleY*scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x,y,z+2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

--[[       v[1]     	  v[2]		   v[3]		     v[4]       v[5]             v[6]       v[7]                 v[8]  		 v[9]			v[10]	 		v[11]		v[12]		 v[13]				v[14]	 ]]
--[[    coordonate.x , coordonate.y, coordonate.z  , text ,  tip markere    ,    vDist  , scadere din z    ,   culoare.r,   culoare.g,     culoare.b,     scale.x,     scale.y,    scale.z,       scaleTextTotal ]]

holos = {
	{-1632.4173583984,186.05285644531,61.280368804932,    "[~r~INFO JOB~s~]",        32,  		9,    1.300,   255,   0,   0,    0.801, 0.801, 0.8001,   0.1 	},
	{152.45585632324,-3105.0861816406,5.8963098526001, 							    "~h~~y~Job Stivuitor" ,             20, 		    8.9,  0.700,   255, 255, 255,	 0.601, 0.601, 0.5001,   0.19	},
	{-57.001544952392,-2448.6643066406,7.2357635498046,							    "~h~~g~Tirist job",      20,          8.9,  0.700,   255, 255, 255,	 0.601, 0.601, 0.5001,   0.19	},
	{-318.51998901367,-610.16638183594,33.558151245117,							    "~h~~g~Uber",      20,          8.9,  0.700,   255, 255, 255,	 0.601, 0.601, 0.5001,   0.19	},
	{1272.7019042969,-1714.8043212891,54.771507263184,							    "~h~~g~Hacker",      20,          8.9,  0.700,   255, 255, 255,	 0.601, 0.601, 0.5001,   0.19	},
}

function hologrameVERE()
	while true do
		Citizen.Wait(0)
			for k, v in pairs(holos) do
			if GetDistanceBetweenCoords( v[1],v[2],v[3], GetEntityCoords(GetPlayerPed(-1))) < v[6] then
				Draw3DText( v[1],v[2],v[3]  -v[7] ,""..v[4].."", 4, 0.1, v[14])
				DrawMarker( v[5], v[1],v[2],v[3], 0, 0, 0, 0, 0, 0, v[11], v[12], v[13], v[8], v[9], v[10], 255, 0, 0, 0, 5)
			end
		end
	end
end

joburi = {
--[| 	 v[1]					                v[2]							            v[3]							            |]--
--[| event-ul din sv side				  drawTxt[notificarea]							  coordonate					                |]--
	{'vrp:stivuitor',				"iei jobul de ~h~~y~Stivuitor","",			152.45585632324,-3105.0861816406,5.8963098526001							},
	{'vrp:tirist',			"iei jobul de ~h~~y~Tirist","",		    -57.001544952392,-2448.6643066406,7.2357635498046						    },
	{'vrp:uber',			"iei jobul de ~h~~y~Uber","",		    -318.51998901367,-610.16638183594,33.558151245117},
	{'vrp:hacker',			"iei jobul de ~h~~y~Hacker","",		    1272.7019042969,-1714.8043212891,54.771507263184},
}

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		for k, v in pairs(joburi) do
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[4],v[5],v[6], true ) < 1.1 then
				text("Apasa [~r~E~s~] ca sa "..v[2])
				if(IsControlJustPressed(1, 38)) then
				TriggerServerEvent(v[1])
				end
			end
		end
	end
end)
