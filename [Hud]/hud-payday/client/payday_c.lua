 --[[
 SCRIPT CREATED ONLY FOR VRP !
 If u want change it for ESX, make a new server event and trigger it from client side.
 For any help, contact me! 
 www.krimes.ro | EskaPe#5716 (Discord) | discord.me/rpkrimes
--]]
vRP = Proxy.getInterface("vRP")

local minute = 30
local secunde = 60
local fontId
Citizen.CreateThread(function()
	RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
end)

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
				TriggerServerEvent('salar')
			end
		end
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(1) -- "..minute..":"..secunde..""
		timpPayday(0.17, 0.9, 1.0,1.0,0.3, "~w~PAYDAY", 255, 255, 255, 255)
		timpPayday(0.18, 0.915, 1.0,1.0,0.3, "~o~"..minute.."m "..secunde.."s", 255, 255, 255, 255)
	end
end)





function timpPayday(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	--SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
