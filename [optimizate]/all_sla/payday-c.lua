 --[[
 SCRIPT CREATED ONLY FOR VRP !
 If u want change it for ESX, make a new server event and trigger it from client side.
 For any help, contact me! --]]
vRP = Proxy.getInterface("vRP")

local minute = 30
local secunde = 60


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000) 
		secunde = secunde - 1
		if secunde == 0 then
			secunde = 60
			minute = minute -1
			if minute == 0  then
				minute = 30
				secunde = 60
				TriggerServerEvent('salar',minute,secunde)
				--[[TriggerServerEvent('contorizare',minute,secunde)]]
				timpPayday(1.417, 1.361, 1.0,1.0,0.35, "~w~PAYDAY IN:~b~ "..minute..":"..secunde.."", 255, 255, 255, 255)
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		timpPayday(1.417, 1.361, 1.0,1.0,0.35, "~w~PAYDAY IN:~b~ "..minute..":"..secunde.."", 255, 255, 255, 255)
	end
end)]]

RegisterNetEvent('salarPrimit')
AddEventHandler('salarPrimit', function(deLaGrupa,salar,bonuslevel,level)
	deLaGrupa = deLaGrupa
	salar = salar
	bonuslevel = bonuslevel
	level = level
	Citizen.CreateThread(function()
		function Initialize(scaleform)
			local scaleform = RequestScaleformMovie(scaleform)
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(1000)
			end
			PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            PushScaleformMovieFunctionParameterString("AI PRIMIT ~g~ SALARIUL")
            PushScaleformMovieFunctionParameterString("SALARIUL: ~g~$"..salar.."~w~ DE LA ~y~ "..deLaGrupa.."~w~ + BONUS ~g~$"..bonuslevel.."~w~ DE LA ~b~LEVEL:"..level)
			PopScaleformMovieFunctionVoid()
			PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
			Citizen.SetTimeout(5000, function()
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
			Citizen.Wait(1000)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	

	end)

end)


function drawRct(x,y,width,height,r,g,b,a)
    DrawRect(x + width/2, y + height/2, width*2.8, height+0.002, r, g, b, a)
end

function timpPayday(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

