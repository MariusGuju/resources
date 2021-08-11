

taginaltime1 = 1.25
taginaltime2 = 1.00
taginaltime3 = 0.75

local certificat = {
	{"Certificat Auto",452.29147338867,-985.43267822266,30.689512252808}
}

local asigurare = {
	{"Asigurare Auto",452.1311340332,-981.78552246094,30.689512252808}
}

local armePD = {
	{482.72027587891,-995.25524902344,30.689643859863},--politie
	--{-58.006217956543,981.96087646484,234.57720947266},--SCU
	--{-1500.0819091797,835.70678710938,178.703125},--LOSVAGOS
	--{-1866.4425048828,2065.2578125,135.43461608887},--rusa
	--{928.86853027344,-2531.2199707031,28.302663803101},--Peaky Blinders
	--{-1520.4920654297,109.66164398193,50.027324676514},--Siciliana
	--{-2679.5251464844,1328.3400878906,144.25773620605}, --Sinaloa
	{1210.5141601563,-1498.5952148438,34.843082427979}, --Blotz
	{1405.1999511719,1138.0965576172,109.74565887451}--hitman
}


-- rainbow effect
  

Citizen.CreateThread(function ()--
    while true do
		Citizen.Wait(0)
		local locatiamea = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(certificat) do

				if GetDistanceBetweenCoords(452.29147338867,-985.43267822266,30.689512252808, locatiamea.x,locatiamea.y,locatiamea.z, false) < 10 then
					DrawMarker(29,452.29147338867,-985.43267822266,30.689512252808 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001,176,14,14, 150, 0, 1, 0, 1, 0, 0, 0)
					--DrawMarker(6, 443.32348632812,-981.59344482422,30.68960762024 ,  0, 0, 0, 0, 0, 0, 0.8001,0.8001,0.8001,176,14,14, 150, 1, 1, 0, 1, 0, 0, 0)
					--mesaj(443.32348632812,-981.59344482422,30.68960762024 + taginaltime3, "~w~Cumpara ~y~Certificatul Auto")
					
					if GetDistanceBetweenCoords(452.29147338867,-985.43267822266,30.689512252808, locatiamea.x,locatiamea.y,locatiamea.z, false) < 2 then
						msjinfo("Apasa ~INPUT_CONTEXT~ pentru a lua~r~ Certificatul Auto \n ~r~[ ~g~250$ ~r~]")
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent("cumparaCertificat")
						end
					end
				end
			end

			for k,v in pairs(asigurare) do

				if GetDistanceBetweenCoords(452.1311340332,-981.78552246094,30.689512252808, locatiamea.x,locatiamea.y,locatiamea.z, false) < 10 then
					DrawMarker(29,452.1311340332,-981.78552246094,30.689512252808 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001,176,14,14, 150, 0, 1, 0, 1, 0, 0, 0)
					--DrawMarker(6, 439.30444335938,-981.33947753906,30.68960762024  ,  0, 0, 0, 0, 0, 0, 0.8001,0.8001,0.8001,176,14,14, 150, 1, 1, 0, 1, 0, 0, 0)
					--mesaj(439.30444335938,-981.33947753906,30.68960762024 + taginaltime3, "~w~Cumpara ~y~Asigurarea Auto")
					
					if GetDistanceBetweenCoords(452.1311340332,-981.78552246094,30.689512252808, locatiamea.x,locatiamea.y,locatiamea.z, false) < 2 then
						msjinfo("Apasa ~INPUT_CONTEXT~ pentru a lua~r~ Asigurarea Auto \n ~r~[ ~g~250$ ~r~]")
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent("cumparaAsigurare")
						end
					end
				end
			end

			for k,v in pairs (armePD) do
				if GetDistanceBetweenCoords(v[1],v[2],v[3],locatiamea.x,locatiamea.y, locatiamea.z, false) < 1 then
					msjinfo("Apasa ~INPUT_CONTEXT~ pentru a deschide meniul de ~r~ arme politie")
					if(IsControlJustReleased(1, 51))then
						TriggerServerEvent("meniuArme")
					end
				end
			end

	end
end)

RegisterNetEvent("colete")
AddEventHandler("colete", function()
  local ped = GetPlayerPed(-1)
  AddArmourToPed(ped, 100)
end)

TestDone = false

RegisterNetEvent('dmv:CheckLicStatus')
AddEventHandler('dmv:CheckLicStatus', function()
	TestDone = true
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
	  if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and not TestDone then
		DrawMissionText2("~r~Conduci fara permis! Mergi la Politie sa dai testul!", 2000)
	  end
	  end
  end)

-------------------------------------FUNCTII
function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function msjinfo(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function curcubeu( frequency )
	local result = {}
	local curtime = GetGameTimer() / 4000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

taginaltime = 0.8

function mesaj(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.35*scale, 0.65*scale)
        SetTextFont(4)
        SetTextProportional(1)
		local rainbow = curcubeu( 1 )
		SetTextColour( 176,14,14, 255 )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
	    World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

function mesaj2(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.28*scale, 0.7*scale)
        SetTextFont(1)
        SetTextProportional(1)
		local rainbow = curcubeu( 1 )
		SetTextColour( 176,14,14, 255 )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
	    World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	local rainbow = curcubeu( 1 )
	SetTextColour( 176,14,14, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end


local signatureFont
local idReady = false
local baseColor = vector4(255, 255, 255, 255)

Citizen.CreateThread(function()
	-- Font
	RegisterFontFile('sgn')
    	signatureFont = RegisterFontId('Adinda Melia')

    	-- Img Sprites
    	local permis = CreateRuntimeTxd("permis_bg")
	CreateRuntimeTextureFromImage(permis, "permis_bg", "assests/permis.png")

	local buletin = CreateRuntimeTxd("buletin_bg")
	CreateRuntimeTextureFromImage(buletin, "buletin_bg", "assests/buletin.png")

	print("plesIds Initialized")
	idReady = true
end)

local function drawTxt(text, font, thePos, scale, center, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(center)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(thePos)
end

RegisterNetEvent("ples-id:showPermis")
AddEventHandler("ples-id:showPermis", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, PlayerPedId())
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, GetPlayerPed(player))
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)

			local sign = data.prenume..data.nume:reverse():sub(data.nume:len())

			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite("permis_bg", "permis_bg", pos, 0.28, 0.3, 0.0, baseColor)
					DrawSprite(headshot, headshot, pos-vector2(0.1, -0.01), 0.058, 0.1, 0.0, baseColor)
					drawTxt(data.prenume, 0, pos-vector2(0.0448, 0.12), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.nume, 0, pos-vector2(0.0448, 0.1), 0.26, 5, 0, 5, 5, 255)
					drawTxt(sign, signatureFont, pos-vector2(0.032, 0.0), 0.35, 0, 5, 5, 5, 255)
				end
			end)

			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)

RegisterNetEvent("ples-id:showBuletin")
AddEventHandler("ples-id:showBuletin", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local sex = 5 -- male
			local pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, PlayerPedId())
			if not IsPedMale(PlayerPedId()) then sex = 4 end
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, GetPlayerPed(player))
				if not IsPedMale(GetPlayerPed(player)) then sex = 4 end
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)

			data.nume = data.nume:upper()
			data.prenume = data.prenume:upper()
			local anul_nasterii = 20 - (data.age or 24)
			if anul_nasterii < 0 then
				anul_nasterii = 100 + anul_nasterii
			end

			local sexChr = "M"
			if sex == 4 then sexChr = "F" end

			local cnp = string.format("~r~%d~b~%02d%02d%02d~r~%06d", sex ,anul_nasterii, math.random(1, 12), math.random(1, 30), data.usr_id)
			local sect = math.random(1, 4)
			local nastere = "Mun. Bucuresti Sect. "..sect
			if data.adresa == "Str.  Nr. " then
				data.adresa = "Caminul pentru Boschetari Bucuresti"
			end
			local directiva = "S.P.C.E.P. Sector "..sect

			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite("buletin_bg", "buletin_bg", pos, 0.25, 0.3, 0.0, baseColor)
					DrawSprite(headshot, headshot, pos-vector2(0.0855, 0.03), 0.058, 0.1, 0.0, baseColor)

					drawTxt(cnp, 0, pos-vector2(0.04, 0.09+0.0015), 0.22, 0, 5, 5, 5, 255)

					drawTxt(data.nume, 0, pos-vector2(0.05, 0.07-0.001), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.prenume, 0, pos-vector2(0.05, 0.05-0.003), 0.26, 0, 5, 5, 5, 255)
					drawTxt("Romana / ROU", 0, pos-vector2(0.05, 0.03-0.004), 0.26, 0, 5, 5, 5, 255)
					drawTxt(sexChr, 0, pos-vector2(-0.095, 0.03-0.004), 0.26, 0, 5, 5, 5, 255)
					drawTxt(nastere, 0, pos-vector2(0.05, 0.01-0.005), 0.26, 0, 5, 5, 5, 255)
					drawTxt(nastere, 0, pos-vector2(0.05, -0.01-0.007), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.adresa, 0, pos-vector2(0.05, -0.025-0.007), 0.26, 0, 5, 5, 5, 255)
					drawTxt(directiva, 0, pos-vector2(0.05, -0.045-0.009), 0.26, 0, 5, 5, 5, 255) 
					drawTxt("05.12.20-18.11.2030", 0, pos-vector2(-0.0548, -0.045-0.009), 0.26, 0, 5, 5, 5, 255) 
				end
			end)

			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)
