local lit_1 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.3, y = -0.2, z =0.15, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.25, y = -0.2, z =0.15, r = 90.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.2, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.2, r = 90.0},
}

local lit_2 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.2, y = -0.2, z =0.35, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.3, y = -0.2, z =0.35, r = 90.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.35, r = 90.0},
}

local lit_3 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.35, r = 90.0},
}

local lit = {
	{lit = "v_med_emptybed", distance_stop = 2.4, name = lit_1, title = Config.Language.lit_1},
	{lit = "v_med_bed1", distance_stop = 2.4, name = lit_2, title = Config.Language.lit_2},
	{lit = "v_med_bed2", distance_stop = 2.4, name = lit_3, title = Config.Language.lit_3},
}

Citizen.CreateThread(function()
	WarMenu.CreateMenu('prop', Config.Language.name_hospital)
	while true do
		if (Vdist(GetEntityCoords(GetPlayerPed(-1), false), Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z) <= 0.8) then
			if(Vdist(GetEntityCoords(GetPlayerPed(-1), true), Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z) < 400.0) then
				DrawMarker(1, Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				Drawing.draw3DText(Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 0.800, Config.Language.name_hospital, 1, 0.3, 0.2, 255, 255, 255, 215)
				Drawing.draw3DText(Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 1.100, Config.Language.open_menu, 1, 0.2, 0.1, 125, 125, 125, 215)
			end  
			if IsControlJustReleased(0, 38) then
				WarMenu.OpenMenu('prop')
			end
		end
		if WarMenu.IsMenuOpened('prop') then
			DrawMarker(1, Config.SpawnBed.x, Config.SpawnBed.y, Config.SpawnBed.z - 1, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 0.15, 255, 255, 255,255, 0, 0, 0,0)
			for _,e in pairs(lit) do
				if WarMenu.Button(e.title) then
					while not HasModelLoaded(e.lit) do
						RequestModel(e.lit)
						Citizen.Wait(1)
					end
					print("hatz")
					local object = CreateObject(GetHashKey(e.lit), Config.SpawnBed.x, Config.SpawnBed.y, Config.SpawnBed.z-1.0, true)
					SetEntityHeading(object, 249.76)
					
					WarMenu.CloseMenu('prop')
				end
			end
			if WarMenu.Button(Config.Language.delete_bed) then
				for _,z in pairs(lit) do
					local prop = GetClosestObjectOfType(Config.SpawnBed.x, Config.SpawnBed.y, Config.SpawnBed.z, 1.5, GetHashKey(z.lit))
					if (prop ~= 0) then
						if DoesEntityExist(prop) then
							SetEntityAsMissionEntity(prop, true, true)
							DeleteEntity(prop)
							
						end
					end
				end
				WarMenu.CloseMenu('prop')
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	WarMenu.CreateMenu('hopital', Config.Language.name_hospital)
	while true do
		local sleep = 2000	
		local pedCoords = GetEntityCoords(GetPlayerPed(-1))
		for _,i in pairs(lit) do
			local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(i.lit), false)
		
			if DoesEntityExist(closestObject) then
				sleep = 5
				local propCoords = GetEntityCoords(closestObject)
				local propForward = GetEntityForwardVector(closestObject)
				local litCoords = (propCoords + propForward)
				local sitCoords = (propCoords + propForward * 0.1)
				local pickupCoords = (propCoords + propForward * 1.2)
				local pickupCoords2 = (propCoords + propForward * - 1.2)

				if GetDistanceBetweenCoords(pedCoords, litCoords, true) <= 5.0 then
					if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.4 then
						hintToDisplay(Config.Language.press_menu)
						if IsControlJustPressed(0, 38) then
							WarMenu.OpenMenu('hopital')
						end
					end

					if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 0.7 then
						hintToDisplay(Config.Language.take_bed)
						if IsControlJustPressed(0, 38) then
							prendre(closestObject)
							
						end
					end

					if GetDistanceBetweenCoords(pedCoords, pickupCoords2, true) <= 0.7 then
						hintToDisplay(Config.Language.take_bed)
						if IsControlJustPressed(0, 38) then
							prendre(closestObject)
						end
					end
				end

				if WarMenu.IsMenuOpened('hopital') then
					for _,k in pairs(i.name) do
						if WarMenu.Button(k.name) then
							LoadAnim(k.anim)
							--AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
							--local x, y, z = GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
							--SetEntityCoords(GetPlayerPed(-1), x, y, z)
							--local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject))
							--SetEntityCoords(GetPlayerPed(-1), x, y, z)
							--local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - i.distance_stop)
							--SetEntityCoords(GetPlayerPed(-1), x-1.0, y-2.3, z-1.0)
							--SetEntityCoords(GetPlayerPed(-1), x-0.2, y-2.3, z-1.2)
							AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, true, true, true, true, 2, true)
							--SetEntityCoords(GetPlayerPed(-1), k.x, k.y, k.z)
							WarMenu.CloseMenu('hopital')
	
							TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)
						end
					end
					if WarMenu.Button(Config.Language.go_out_bed) then
						DetachEntity(GetPlayerPed(-1), true, true)
						local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - i.distance_stop)
						SetEntityCoords(GetPlayerPed(-1), x, y, z)
						WarMenu.CloseMenu('hopital')
						
					end
					WarMenu.Display()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function prendre(propObject)
	
	NetworkRequestControlOfEntity(propObject)

	LoadAnim("anim@heists@box_carry@")
	
	AttachEntityToEntity(propObject, GetPlayerPed(-1), GetPlayerPed(-1), 0.0, 1.6, -0.43 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(propObject, GetPlayerPed(-1)) do
		Citizen.Wait(5)
		hintToDisplay(Config.Language.release_bed)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(GetPlayerPed(-1)) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
		end

		if IsControlJustPressed(0, 38) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
		end
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
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