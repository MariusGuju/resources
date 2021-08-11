local timeAndDateString = nil


function GetOnlinePlayers()
    local players = 0

    for i = 0, 127 do
        if NetworkIsPlayerActive(i) then
            players = players + 1
        end
    end

    return tonumber(players)
end

	Citizen.CreateThread(function()
		while true do
			Wait(1)
			timeAndDateString = ""
			players = "Online: "..#GetActivePlayers().."/128"
			
			timeAndDateString = players
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.30, 0.30)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextRightJustify(true)
			SetTextWrap(0,0.95)
			SetTextEntry("STRING")
			
			AddTextComponentString(timeAndDateString)
			DrawText(0.5, 0.01)
		end
	end)