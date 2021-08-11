vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vRP_garage")
vRPgarage = Tunnel.getInterface("vRP_garage","vRP_garage")
vRPgarageC = {}
Tunnel.bindInterface("vRP_garage",vRPgarageC)
vRPserver = Tunnel.getInterface("vRP_garage","vRP_garage")

local garajeInfo = {}

function vRPgarageC.spawngaraje(garaje)
    garajeInfo = garaje
    for k,v in pairs (garajeInfo) do
        x = v.x
        y = v.y
        z = v.z
        blipid = 50
        if v.tipGaraj == 1 then 
		blipc = 38 
		elseif v.tipGaraj == 2 then 
		blipc = 1 
		elseif v.tipGaraj == 3 then 
		blipc = 76 
		elseif v.tipGaraj == 4 then 
		blipc = 5 
		elseif v.tipGaraj == 5 then 
        blipc = 2
        elseif v.tipGaraj == 6 then 
        blipc = 8
        elseif v.tipGaraj == 7 then 
		blipc = 10 
        end
        local blip = AddBlipForCoord(x,y,z)
        SetBlipSprite(blip, blipid)
        SetBlipColour(blip, blipc)
        SetBlipScale(blip, 0.65)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Garaj['..v.tipGaraj.."]")
        EndTextCommandSetBlipName(blip)
    end
end


Citizen.CreateThread(function()
    while true do
        for k,v in pairs (garajeInfo) do
            while Vdist2(GetEntityCoords(PlayerPedId()),  v.x, v.y, v.z) <= 15 do
                Wait(0)
                for g, p in pairs (Config.tipgaraje) do
					if g == v.tipGaraj then
						local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a da store la masina"
						local textt = "~w~Apasa ~INPUT_CONTEXT~ pentru a deschide garajul #"..p.tipGaraj
						DrawMarker(36, v.x,v.y,v.z , 0, 0, 0, 0, 0, 0, 0.8001,0.8001,0.8001, p.marker[1],p.marker[2],p.marker[3], 100, 0, 0, 0, 1, 0, 0, 0)
						if Vdist2(GetEntityCoords(PlayerPedId()),  v.x, v.y, v.z) <= 2 then

							HelpText(textt)
							if ( IsControlJustReleased(0,51) )then
								TriggerServerEvent('deschideGaraj',v.tipGaraj)
							end
                        end
                    end
                end
            end
        end
        Wait(350)
    end
end)


RegisterNetEvent('iaLocatieGaraje')
AddEventHandler('iaLocatieGaraje',function()
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('creazaGaraj',coords.x,coords.y,coords.z)
end)

RegisterNetEvent('spawnVf')
AddEventHandler('spawnVf',function(rabla)
    if rabla and not IsVehicleDriveable(rabla) then 
        SetVehicleHasBeenOwnedByPlayer(rabla,false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, rabla, false, true) 
    end
    while not HasModelLoaded(rabla) do
        RequestModel(rabla)
        Citizen.Wait(10)
    end
    if HasModelLoaded(rabla) then
        local coords = GetEntityCoords(PlayerPedId())
        local nveh = CreateVehicle(rabla, coords.x,coords.y,coords.z+0.5, 0.0, true, false)
        NetworkFadeInEntity(nveh,0)
        SetVehicleOnGroundProperly(nveh)
        SetEntityInvincible(nveh,false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleNumberPlateText(nveh, "Factiune")
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetModelAsNoLongerNeeded(rabla)
    end
end)


--// FUNCTII

notify = function(text, length)
    local wait = GetGameTimer()+length*1000
    while wait >= GetGameTimer() do
        Wait(0)
        drawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), text)
    end
end

HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

drawText = function(text, x, y)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextOutline()
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

drawText3D = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end


local iamasinainplm = {    
    {"asea","user.salariu","VW Jetta 1998"},
    {"bmwe38","user.salariu","BMW Seria 7 e38"},
    {"civic","user.salariu","Honda Civic 2000"},
    {"corsa05","user.salariu","Opel Corsa 2005"},
    {"daduster","user.salariu","Dacia Duster"},
    {"ds4","user.salariu","Citroen DS4"},
    {"golfgti","user.salariu","VW Golf 5 GTI"},
    {"logan","user.salariu","Dacia Logan 2007"},
    {"NA6","user.salariu","Mazda Miata MX-5"},
    {"polo2018","user.salariu","Volkswagen Polo 2018"},
    {"s600w220","user.salariu","Mercedes s600 W220"},
    {"sandero","user.salariu","Dacia Sandero"},
    {"sandero08","user.salariu","Dacia Sandero 08"},
    {"subwrx","user.salariu","Subaru WRX"},
    {"tico","user.salariu","Tico"},
    {"volvo850r","user.salariu","Volvo 850 R"},
    {"x5e53","user.salariu","BMW x5 E53"},
    {"a8fsi","user.salariu","Audi A8 2011"},
    {"contgt13","user.salariu","Bentley Continental 2013"},
    {"dzsb","user.salariu","Rollce Royce Phantom"},
    {"intunder","user.salariu","Lincoln Continental"},
    {"passat","user.salariu","Volkswagen Passat B8"},
    {"s500w222","user.salariu","Mercedes S500 W222"},
    {"xfr","user.salariu","Jaguar XFR"},
    {"a8audi","user.salariu","Audi A8 2008"},
    {"bmwe65","user.salariu","BMW Seria 7 e65 2006"},
    {"camry18","user.salariu","Toyota Camry 2018"},
    {"charger","user.salariu","Dodge Charger 2014"},
    {"exemplar","user.salariu","Hyundai Elantra"},
    {"felon","user.salariu","Chrysler Genesis G80"},
    {"ibiza","user.salariu","Seat Ibiza"},
    {"ody18","user.salariu","Honda Odyssey 2019"},
    {"pacev","user.salariu","Renault Escape 2019"},
    {"passatr","user.salariu","Volkswagen Passat B8 Break"},
    {"s60pole","user.salariu","Volvo S60"},
    {"schafter6","user.salariu","Infinity q50"},
    {"tailgater","user.salariu","Ford Taurus"},
    {"tmodel","user.salariu","Tesla Model 3"},
    {"v60","user.salariu","Volvo V60"},
    {"69charger","user.salariu","Dodge Charger 69"},
    {"belair","user.salariu","Chevy' Belair"},
    {"buccaneer","user.salariu","Chevrolet Impala OLD SCHOOL"},
    {"c10","user.salariu","Chevy' c10"},
    {"casco","user.salariu","Ford Hot Rod"},
    {"eleanor","user.salariu","Ford Mustang GT500 Shelby 1967"},
    {"emperor","user.salariu","Ford Crown Victoria 1980"},
    {"fordh","user.salariu","Ford Mustang Hoonigan"},
    {"fugitive","user.salariu","Lada"},
    {"infernus","user.salariu","Ferrari Testarossa"},
    {"mbw111","user.salariu","Mercedes Benz S220 w111"},
    {"mgb","user.salariu","MGB GT"},
    {"Nova","user.salariu","Chevrolet Nova"},
    {"pstan48","user.salariu","Packard"},
    {"rx3","user.salariu","Mazda RX3"},
    {"tbird","user.salariu","Ford Thunderbird"},
    {"turbo33","user.salariu","Porsche turbo 930"},
    {"vigero","user.salariu","Dodge Challanger"},
    {"18velar","user.salariu","Range Rover Velar"},
    {"amarok","user.salariu","VW Amarok"},
    {"bjxl","user.salariu","Kia Sportage"},
    {"Cavalcade2","user.salariu","Audi q7"},
    {"cayenne","user.salariu","Porsche Cayenne"},
    {"fpacehm","user.salariu","Jaguar F Pace SVR"},
    {"FX50s","user.salariu","Infinity FX50s"},
    {"gmcs","user.salariu","GMC Sierra 1500"},
    {"gmcyd","user.salariu","GMC Yukon Denali"},
    {"gmt900escalade","user.salariu","Cadilac Escalade"},
    {"jeep2012","user.salariu","Jeep 2012"},
    {"jeepreneg","user.salariu","Jeep Renegade"},
    {"levante","user.salariu","Maserati Levante"},
    {"navigator","user.salariu","Lincoln Navigator"},
    {"patriot","user.salariu","Hummer H1"},
    {"q30","user.salariu","Infiniti q30"},
    {"quashqai16","user.salariu","Nissan Quashqa"},
    {"rrst","user.salariu","Range Rover Sport"},
    {"santafe","user.salariu","Hyundai SantaFe"},
    {"srt8","user.salariu","Jeep SRT8"},
    {"stelvio","user.salariu","Alfa Romeo Stelvio"},
    {"titan17","user.salariu","Nissan Titan"},
    {"trailcat","user.salariu","Jeep Trailcat"},
    {"trhawk","user.salariu","Jeep Grand Cherokee S"},
    {"x6m","user.salariu","BMW x6 M"},
    {"jukonxl","user.salariu","GMC Yukon X"},
    {"kangoo","user.salariu","Renault Kangoo"},
    {"v250","user.salariu","Mercedes V250"},
    {"yukonxl","user.salariu","GMC"},
    {"4c","user.salariu","Alfa Romeo 4C"},
    {"180sx","user.salariu","Nissan 180SX"},
    {"370z","user.salariu","Nissan 370z"},
    {"a45amg","user.salariu","Mercedes A45 AMG"},
    {"acr","user.salariu","Dodge Viper acr"},
    {"aqv","user.salariu","Alfa Romeo Giulia"},
    {"audirs6tk","user.salariu","Audi RS6 TK"},
    {"audis8om","user.salariu","Audi S8"},
    {"ben17","user.salariu","Bentley Continental GT"},
    {"bmwm8","user.salariu","BMW M8"},
    {"brz","user.salariu","Subaru BRZ"},
    {"brzbn","user.salariu","Subaru BRZ v2"},
    {"c7","user.salariu","Chevrolet Corvette (C7)"},
    {"c8","user.salariu","Chevrolet Corvette (C8)"},
    {"CATS","user.salariu","Cadilac CTS-V"},
    {"cx75","user.salariu","Jaguar CX 75"},
    {"e60","user.salariu","BMW M5 E60"},
    {"evo9","user.salariu","MITSUBISHI LANCER EVO 9"},
    {"f82","user.salariu","BMW M4 F82"},
    {"f620","user.salariu","Maserati GranTurismo"},
    {"f824slw","user.salariu","BMW M4 F82 SLW"},
    {"FC3S","user.salariu","Mazda RX-7 FC3S"},
    {"furoregt","user.salariu","Jaguar XKR-S GT"},
    {"hondacivictr","user.salariu","Honda Type R"},
    {"jackal","user.salariu","Kia Stinger 2020"},
    {"lc500","user.salariu","Lexus LC500"},
    {"m2","user.salariu","BMW M2"},
    {"m3","user.salariu","BMW M3"},
    {"m6f13","user.salariu","BMW M6 F13"},
    {"mb18","user.salariu","Mercedes Benz S63 AMG Cabrio"},
    {"mgrantur2010","user.salariu","Maserati  GranTurismo  2010"},
    {"miniroads","user.salariu","Mini Couper Roadester"},
    {"models","user.salariu","Tesla Model S"},
    {"p90d","user.salariu","Tesla Model P90 D"},
    {"moss","user.salariu","Mercedes Benz SLR"},
    {"mustang19","user.salariu","Ford Mustang 19"},
    {"rcf","user.salariu","Lexus RC F"},
    {"rs6","user.salariu","Audi RS 6"},
    {"rs6tk","user.salariu","Audi RS 6 TK"},
    {"rs7","user.salariu","Audi RS 7"},
    {"rs318","user.salariu","Audi RS 3 2018"},
    {"rx8r","user.salariu","Mazda RX8 R"},
    {"s5","user.salariu","Audi S5"},
    {"skyline","user.salariu","Nissan Skyline"},
    {"supra2","user.salariu","Toyota Supra"},
    {"supraa90","user.salariu","Toyota Supra 2019"},
    {"teslapd","user.salariu","Tesla PD-S1000"},
    {"viper","user.salariu","Dodge Viper"},
    {"z4bmw","user.salariu","BMW Z4"},
    {"zl12017","user.salariu","Chevrolet Camaro 2017"},
    {"2019chiron","user.salariu","Bugatti Chiron"},
    {"amv19","user.salariu","Aston Martin Vantage 2019"},
    {"arv10","user.salariu","Audi R8 V10"},
    {"ast","user.salariu","Aston Martin Vanquish DB9"},
    {"comet2","user.salariu","Porsche 718 Cayman S"},
    {"db9v","user.salariu","Aston Martin DB9V Cabrio"},
    {"f430s","user.salariu","Ferrari F430 S"},
    {"f812","user.salariu","Ferrari F812"},
    {"fct","user.salariu","Ferrari Califronia"},
    {"filthynsx","user.salariu","Acura NSX"},
    {"gto","user.salariu","Ferrari GTO"},
    {"gtr","user.salariu","Nissan GTR"},
    {"i8","user.salariu","BMW I8"},
    {"lhuracan","user.salariu","Lamborghini Huracan"},
    {"mp412c","user.salariu","McLaren MP4 12C"},
    {"p911r","user.salariu","Porsche 911r"},
    {"r8ppi","user.salariu","Audi R8 PPI"},
    {"senna","user.salariu","McLaren Senna"},
    {"spyker","user.salariu","Spyker C8"},
    {"tr22","user.salariu","Tesla Roadster"},
    {"r1","user.salariu","Yamaha R1"},
    {"blazer6","user.salariu","ATV"},
    {"bmws","user.salariu","BMW S1000"},
    {"desmo","user.salariu","Ducatti Desmo"},
    {"exciter","user.salariu","Yamaha Exciter"}
}

--[[Citizen.CreateThread(function()
    while true do
      Citizen.Wait(49)
      if not isVehiclesLoaded then
        for k,v in pairs(iamasinainplm) do
          targetVehicle = v[1]
  
          if not IsModelInCdimage(targetVehicle) or not IsModelAVehicle(targetVehicle) then
            Citizen.Trace(targetVehicle .. " could not be found as a vehicle.")
            return
          end
  
          RequestModel(targetVehicle)
          
  
          while not HasModelLoaded(targetVehicle) do
            Citizen.Trace("[VehicleLoader] Loading vehicle " ..targetVehicle)
            Citizen.Wait(500) 
          end
  
          if HasModelLoaded(targetVehicle) then
  
          end
          SetModelAsNoLongerNeeded(targetVehicle)
        end
      isVehiclesLoaded = true
      end
    end
  end)]]