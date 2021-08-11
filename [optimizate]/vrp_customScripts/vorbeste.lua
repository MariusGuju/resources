local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 500

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end



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
    DrawText(x - width/2, y - height/2 + 0.005)
end

function name(x,y ,width,height,scale, text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(155,155,155, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    while true do
    local rainbow = RGBRainbow( 1 )
		Citizen.Wait(1)
		local t = 0
			for i = 0,128 do
				if(GetPlayerName(i))then
					if(NetworkIsPlayerTalking(i))then
						t = t + 1

						if(t == 1)then
								drawTxt(0.515, 0.95, 1.0,1.0,0.4, "Vorbeste:", rainbow.r,rainbow.g,rainbow.b, 255)
						end

						drawTxt(0.520, 0.95 + (t * 0.023), 1.0,1.0,0.4, "" .. GetPlayerName(i), 255, 255, 255, 255)
					end
				end
			end
	end
end)