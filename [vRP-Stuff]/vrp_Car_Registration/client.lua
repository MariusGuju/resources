--[[
    FiveM Scripts
    The Official HackerGeo Script 
	WEBISTE: www.HackerGeo.com
	GITHUB: GITHUB.com/HackerGeoTheBest
	STEAM: SteamCommunity.com/id/HackerGeo1

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Official Scripts by HackerGeo ------------------------------------------
--------------------------------------------------------------------------------------------------------------------



local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "car registration",
    menu_subtitle = "options",
    color_r = 128,
    color_g = 0,
    color_b = 0,
}

local DTutOpen = false
BuyRegistration = false

RegisterNetEvent('registration:CheckInscStatus')
AddEventHandler('registration:CheckInscStatus', function()

	BuyRegistration = true
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

BuyRegistration = true

function startbuy()
        if BuyRegistration then
		    TriggerServerEvent('registration:cumdr3fs')
		end
end

RegisterNetEvent('registration:startbuy')
AddEventHandler('registration:startbuy', function()
	openGui()
	Menu.hidden = not Menu.hidden
end)

RegisterNetEvent('registration:EndBuyRegistration')
AddEventHandler('registration:EndBuyRegistration', function()
	EndBuyRegistration()
end)

function EndBuyRegistration()
        if BuyRegistration then
			TriggerServerEvent('registration:success')
			BuyRegistration = true
			drawNotification("Ai inscris ~y~masina~w~!")
			EndTestTasks()
		end
end

RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
  BuyRegistration = true
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

local talktoped = true

coordonatlocatieasigurare = {
	{440.0817565918,-981.3203125,30.999603805542}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i = 1, #coordonatlocatieasigurare do
		    asigurareCoord2 = coordonatlocatieasigurare[i]
			-- DrawMarker(36, asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 254, 179, 0, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], true ) < 1 then
				DrawSpecialText("~w~Apasa ~g~[E] ~w~pentru a inscrie masina!")
				if(IsControlJustReleased(1, 38))then
				    if talktoped then
						Citizen.Wait(500)
						REGISTRATIONMenu()
						Menu.hidden = false
						talktoped = false
					else
						talktoped = true
					end
				end
				Menu.renderGUI(options)
			end
		end
	end
end)


function REGISTRATIONMenu()
	ClearMenu()
    options.menu_title = "Cumpara Inscriere Auto"
	Menu.addButton("Inscriere Auto","CarMenu",nil)
    Menu.addButton("Inchide","CloseMenu",nil) 
end

function CarMenu()
    ClearMenu()
    options.menu_title = "Inscriere Auto Masina"
	Menu.addButton("Inscriere Auto [$250000]","startbuy",nil)
    Menu.addButton("Return","REGISTRATIONMenu",nil) 
end

function CloseMenu()
		Menu.hidden = true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end