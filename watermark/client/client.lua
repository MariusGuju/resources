
onlinePlayers = 0
local maxPlayers = GetConvar("sv_maxclients", 128)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
    local txd = CreateRuntimeTxd("logo")
	--CreateRuntimeTextureFromImage(txd, "logo", "stream/nuipornita.png")

	while true do
		onlinePlayers = #GetActivePlayers()
		Citizen.Wait(20000)
	end
end)

local fontId
Citizen.CreateThread(function()
	RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
end)

function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/15, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    while true do 
        x = 0.92
        y = 0.82
		--DrawSprite("logo","logo",x,y,0.06*0.7, 0.1*0.7,0.0,255,255,255,255)
		drawHudText(x, y + 0.05,0.0,0.0,0.3,"Online: "..#GetActivePlayers().."/"..maxPlayers,255,255,255,255,1,fontId,1)
		drawHudText(x, y + 0.0657,0.0,0.0,0.3,"discord.io/NorbSiMaruServer",255, 119, 0,255,1,fontId,1)
		Wait(1)
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/15, y - height/2 + 0.005)
end
