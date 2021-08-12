
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local opresteControale = false
local inAvion = false
local avionTerminat = false
local inIntro = false
local introTerminat = false
local inregistreaza = false
local freeze = false

-- tranzitie
local inregistrat = false
local cloudOpacity = 0.01 -- (default: 0.01)
local muteSound = true -- (default: true)



RegisterNetEvent('verificaInregistrare')
AddEventHandler('verificaInregistrare', function(inreg)
	if inreg == 1 then
		print('inregistrat')
	else
		freeze = true
		DoScreenFadeOut(800)
		Wait(100)
		DoScreenFadeIn(1000)
		if not introTerminat then
			introServer()
		end
	end
end)

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end


Citizen.CreateThread(function()
	while true do  
		Citizen.Wait(0)
		local locatiamea = GetEntityCoords(GetPlayerPed(-1))
		local dist = round(GetDistanceBetweenCoords(-1626.8177490234,185.85870361328,60.552436828613, locatiamea.x,locatiamea.y,locatiamea.z))
		if dist <= 10 then
			DrawText3D(-1626.8177490234,185.85870361328,60.552436828613+1, "Liquid|Romania~b~ROMANIA~w~\nSalut, bine ai venit in oras!\nAsteapta un taxi sau suna la ~y~Taxi!", 2, 6)
		end
	end
end)

Citizen.CreateThread(function()
	while true do  
		Citizen.Wait(0)
		if freeze then
			FreezeEntityPosition(GetPlayerPed(-1), true)
			DisableControlAction(0, 75)
		else
			FreezeEntityPosition(GetPlayerPed(-1), false)
		end
	end
end)

function introServer()
	Citizen.Wait(0)
	SetEntityVisible(GetPlayerPed(-1), false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetEntityCoords(GetPlayerPed(-1),222.41590881348,-1042.3555908203,54.531940460205,true, false, false,true)
    TriggerEvent("pNotify:SendNotification",{
        text = "<b style='color:#1E90FF'>Despre server</b> <br /><br /><b style='color:#fdbf21'>STAFF</b>: Cu multa munca si ambitie, am deschis serverul nostru,<b style='color:#1E90FF'> Liquid|Romania</b>  <b style='color:#fdbf21'> Romania HARD ROLEPLAY</b>!<br /><br /><b style='color:#1E90FF'> SCRIPT </b>: Un grup de oameni experimentati si pasionati pe diferite domenii au dezvoltat unul dintre cele mai unice servere din ROMANIA!<br /><br /><b style='color:#1E90FF'> CAND </b> si <b style='color:#fdbf21'>CUM</b>? : Am decis sa deschidem acest server , <b style='color:#ff4c4c'>Norb si Maru</b>, au dezvoltat unul dintre cele mai unice servere, impreuna cu sustinerea si ajutorul <b style='color:#fdbf21'>STAFF-ULUI</b>, dupa multe saptamani de munca ,probleme intr-un final am deschis <b style='color:#fdbf21'>Liquid|Romania!</b><br />",
        type = "alert",
        timeout = (18500), --inapoi  18500
        layout = "center",
        queue = "global"
    })
	Citizen.Wait(11500) --inapoi 20000
	SetEntityCoords(GetPlayerPed(-1),-293.80242919922,-517.28063964844,82.515983581543,true, false, false,true)
	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#1E90FF'>Drumuri si poduri</b> <br /><br />Conform legii intr-o zona rezidentiala, de trafic intens, viteza automobilelor nu trebuie sa depaseasca 50 KM/H<br /><br />In zone urbane, cu trafic obisnuit, viteza ideala nu depaseste 80KM/H <br /><br />In cazul autostrazilor, legea doreste ca automobilele sa nu depaseasca viteza de 130KM/H<br />",
		type = "alert",
		timeout = (10000),  --inapoi 10000
		layout = "center",
		queue = "global"
	})
	Citizen.Wait(11500) --inapoi 11500
	SetEntityCoords(GetPlayerPed(-1),393.24786376953,-943.24426269531,52.790142059326,true, false, false,true)
	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#1E90FF'>Politia</b> <br/><br/> Politia Romana, organizatie guvernamentala pentru aplicarea legii, exercita atributii privind prevenirea, descoperirea si cercetarea in conditiile legii a tuturor infractiunilor.<br/> <br/><br/> BCCO este biroul de combatere al criminalitatii organizate din cadrul Politiei Romane!<br/>",
		type = "alert",
		timeout = (10000), --inapoi 10000
		layout = "center",
		queue = "global"
	})
	Citizen.Wait(11500)  --inapoi 11500
	SetEntityCoords(GetPlayerPed(-1),188.59785461426,193.18286132813,133.37438964844,true, false, false,true)
	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#1E90FF'>Banca</b> <br /><br />Banca este cel mai sigur loc unde ai putea sa pastrezi banii in cazul atacurilor sau in cazul in care aveti de-a face cu mafiile!. <br />",
		type = "alert",
		timeout = (10000), --inapoi 10000
		layout = "center",
		queue = "global"
	})				
	Citizen.Wait(1)	
	introTerminat = true
	opresteControale = true	
	TriggerServerEvent('insereaza')
end


RegisterNetEvent('inregistrat')
AddEventHandler('inregistrat', function(user_id,nume,prenume,varsta)
	user_id = user_id
	nume = nume
	prenume = prenume
	varsta = varsta
	freeze = false
	opresteControale = true
	Citizen.CreateThread(function()
		function Initialize(scaleform)
			local scaleform = RequestScaleformMovie(scaleform)
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end
			
			PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString("<FONT COLOR='#ffffff'>BINE AI VENIT PE The<FONT COLOR='#00aeff'>Hood<FONT COLOR='#ffffff'> ROMANIA")
			PushScaleformMovieFunctionParameterString("<FONT COLOR='#ffffff'>Capitanul <FONT COLOR='#00aeff'>Gicu Franaru <FONT COLOR='#ffffff'>te va duce in oras!\n** GRIJA MARE CUM II VORBESTI, NU VREI SA FACA KAMIKAZE\nID:~g~"..user_id.."~w~, Nume: ~g~"..nume.."~w~, Prenume: ~g~"..prenume.."~w~, Varsta: ~g~"..varsta)

			PopScaleformMovieFunctionVoid()
			PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
			Citizen.SetTimeout(5000, function() -- pus 5000
				PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
				PushScaleformMovieFunctionParameterInt(1)
				PushScaleformMovieFunctionParameterFloat(0.33)
				PopScaleformMovieFunctionVoid()
				PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			end)
			return scaleform
		end
	
		scaleform = Initialize("mp_big_message_freemode")
		
		while true do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end

		local handle = RegisterPedheadshotTransparent(PlayerPedId())

		while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
			Citizen.Wait(0)
		end
		local txd = GetPedheadshotTxdString(handle)


		BeginTextCommandThefeedPost("STRING")
		AddTextComponentSubstringPlayerName("SALUT, BINE AI VENIT CETATEANULE\nSEDERE PLACUTA LA NOI IN ORAS!")


		local title = GetPlayerName(PlayerId())
		local subtitle = "Liquid|Romania ~b~ROMANIA"
		local iconType = 0
		local flash = false 
		EndTextCommandThefeedPostMessagetext(txd, txd, flash, iconType, title, subtitle)


		local showInBrief = true
		local blink = false 
		EndTextCommandThefeedPostTicker(blink, showInBrief)
		

		UnregisterPedheadshot(handle)
		
	end)
	avion()
end)


function avion ()
	Citizen.CreateThread(function()
		while true do 
			Wait(0)
			if not inAvion then
				opresteControale = true
				inAvion = true	
				SetEntityVisible(GetPlayerPed(-1),false)
				Wait(500)
				SetEntityCoords(GetPlayerPed(-1), -65.208251953125,-3693.6789550781,126.94667816162 ,true,false,false,true )
				avion = GetHashKey("shamal")
				pilot = GetHashKey('a_m_y_business_02')
				RequestModel(avion)
				RequestModel(pilot)
				while not HasModelLoaded(avion) do
					Citizen.Wait(0)
				end
				while not HasModelLoaded(pilot) do
				Citizen.Wait(0)
				end

				vehicle = CreateVehicle(avion, -65.208251953125,-3693.6789550781,126.94667816162 , -300.6, false, false)
				SetPedIntoVehicle(GetPlayerPed(-1), vehicle, 2)
				sefAvion = CreatePedInsideVehicle(vehicle, 4, pilot, -1, true, true)
				TaskPlaneMission(sefAvion, vehicle, 0, 0,  -65.208251953125,-3693.6789550781,126.94667816162, 1, 1.0, 0, 2.4, 2313.3, 11.3)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 62.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 62.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 50.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 32.2)
				Citizen.Wait(3000)
				SetVehicleForwardSpeed(vehicle, 35.2)
				TaskPlaneLand(sefAvion, vehicle, -1250.3282470703,-2999.1760253906,14.246403694153, -1614.2706298828,-2788.3017578125,13.986220359802)
				while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1614.2706298828,-2788.3017578125,13.986220359802, true) > 10 do
					Citizen.Wait(10)
				end
				DoScreenFadeOut(800)
				Citizen.Wait(2000)
				DeleteEntity(vehicle)
				DeleteEntity(sefAvion)
				Citizen.Wait(3500)
				DoScreenFadeIn(2800)
				avionTerminat = true
				opresteControale = false
				SetEntityVisible(GetPlayerPed(-1), true)
				SetEntityCoords(GetPlayerPed(-1),-1635.6501464844,181.12353515625,61.757316589355,true, false, false,true)
				DisableControlAction(0, 75,false)
			end
		end
	end)
end


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if opresteControale == true then
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 24,  true) -- Shoot 
			DisableControlAction(0, 92,  true) -- Shoot in car
			DisableControlAction(0, 24,  true)
			DisableControlAction(0, 25,  true)
			DisableControlAction(0, 45,  true)
			DisableControlAction(0, 76,  true)
			DisableControlAction(0, 102,  true)
			DisableControlAction(0, 278,  true)
			DisableControlAction(0, 279,  true)
			DisableControlAction(0, 280,  true)
			DisableControlAction(0, 281,  true)
			DisableControlAction(0, 140, true) -- Attack
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 25, true) -- Attack
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['LEFTALT'], true)
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F9'], true)
			DisableControlAction(2, Keys['F10'], true)
			DisableControlAction(2, Keys['Y'], true)
			DisableControlAction(0, Keys['A'], true)
			DisableControlAction(0, Keys['D'], true)
			DisableControlAction(2, Keys["~"], true) 
			DisableControlAction(2, Keys["X"], true)
			DisableControlAction(0, Keys["X"], true)  
			DisableControlAction(2, Keys["T"], true)
			DisableControlAction(0, Keys["T"], true) 
			DisableControlAction(2, 49, true)
			DisableControlAction(0, 49, true) 
		end
	end
end)
-- tranzitia
function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

function InitialSetup()
    SetManualShutdownLoadingScreenNui(true)
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 0, 1)
    end
end

function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end
function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end