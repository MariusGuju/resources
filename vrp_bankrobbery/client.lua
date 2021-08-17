local robbing = false
local isDone = true
local bank = ""
local new_blip = nil
local theBlip = nil
local secondsRemaining = 0
local robbers = {}

function bank_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

banks = {
	["fleeca"] = {
		position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		nameofbank = "Banca Raiffeisen (Fleeca Bank)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleecahighway"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		nameofbank = "Banca UniCredit (Fleeca Bank Highway)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleecaalta"] = {
		position = { ['x'] = 311.12713623046, ['y'] = -283.18838500976, ['z'] = 54.174530029296 },
		nameofbank = "Banca UniCredit Țiriac (Fleeca Bank Alta)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleecaburton"] = {
		position = { ['x'] = -354.06427001954, ['y'] = -54.15805053711, ['z'] = 49.046321868896 },
		nameofbank = "Banca ING (Fleeca Bank Burton)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleecavinewood"] = {
		position = { ['x'] = -1211.8055419922, ['y'] = -335.8913269043, ['z'] = 37.790771484375 },
		nameofbank = "Banca BRD (Fleeca Bank Vinewood Hills)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleecadesert"] = {
		position = { ['x'] = 1176.86865234375, ['y'] = 2711.91357421875, ['z'] = 38.097785949707 },
		nameofbank = "Banca Transilvania (Fleeca Bank Desert)",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		nameofbank = "Banca BCR (Blaine County Savings)",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["pacific"] = {
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		nameofbank = "Banca Națională (Depozitul Roman)",
		lastrobbed = 0,
		from = 1,
		to = 12
	}
}

RegisterNetEvent('es_bank:currentlyrobbing')
AddEventHandler('es_bank:currentlyrobbing', function(robb)
	robbing = true
	isDone = false
	bank = robb
	secondsRemaining = 600
end)

RegisterNetEvent('es_bank:toofarlocal')
AddEventHandler('es_bank:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '(SYSTEM)', {255, 0, 0}, "Jaful a fost anulat. Nu ai furat nimic.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('es_bank:playerdiedlocal')
AddEventHandler('es_bank:playerdiedlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '(SYSTEM)', {255, 0, 0}, "Jaful a fost anulat. Ai murit !")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '(SYSTEM)', {255, 0, 0}, "Jaful a fost anulat. Nu ai furat nimic.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('es_bank:robberycomplete')
AddEventHandler('es_bank:robberycomplete', function()
	robbing = false
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = false
end)


RegisterNetEvent('es_bank:stopRobbery')
AddEventHandler('es_bank:stopRobbery', function(user_id)
	robbing = false
	isDone = true
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(10000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 278)
		SetBlipColour(blip, 49)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robbable Bank")
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if (robbing == false) and (isDone == true) then
					DrawMarker(29, v.position.x, v.position.y, v.position.z, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, true, true, 0,0)
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						if (incircle == false) then
							bank_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a Jefuii ~b~" .. v.nameofbank .. " ~w~!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_bank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
						incircle = false
					end
				end
			end
		end

		if (robbing == true) and (isDone == false) then
		    SetPlayerWantedLevel(PlayerId(), 0, 0)
            SetPlayerWantedLevelNow(PlayerId(), 0)
			
			bank_drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Timpul Jafului: ~r~" .. secondsRemaining .. "~w~ secunde ramase.", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position
			local ped = GetPlayerPed(-1)
			
            if IsEntityDead(ped) then
			TriggerServerEvent('es_bank:playerdied', bank)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15)then
				TriggerServerEvent('es_bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)