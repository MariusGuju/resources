
vRP = Proxy.getInterface("vRP")
vRPg = Proxy.getInterface("vRP_garages")
heading = 0


function deleteVehiclePedIsIn()
  local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)
  SetVehicleHasBeenOwnedByPlayer(v,false)
 
  Citizen.InvokeNative(0xAD738C3085FE7E11, v, false, true) -- set not as mission entity
  SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
end

function isCursorInPosition(x,y,width,height)
	local sx, sy = GetActiveScreenResolution()
  local cx, cy = GetNuiCursorPosition ( )
  local cx, cy = (cx / sx), (cy / sy)
  
	local width = width / 2
	local height = height / 2
  
  if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
	  return true
  else
	  return false
  end
end


RegisterNetEvent( 'wk:deleteVehicle2' )
AddEventHandler( 'wk:deleteVehicle2', function()
    local ped = GetPlayerPed( -1 )
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)
        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)
            if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if (DoesEntityExist(vehicle)) then 
                	ShowNotification("~r~Unable to delete vehicle, try again.")
                else 
                	ShowNotification("Vehicle deleted.")
                end 
            else 
                ShowNotification( "You must be in the driver's seat!" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1)
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if (DoesEntityExist(vehicle)) then 
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)

                if ( DoesEntityExist(vehicle)) then 
                	ShowNotification("~r~Unable to delete vehicle, try again.")
                else 
                	ShowNotification("Vehicle deleted.")
                end 
            else 
                ShowNotification("You must be in or near a vehicle to delete it.")
            end 
        end 
    end 
end )

function deleteCar(entity)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end


function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end


function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false,false)
end

local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.15,
		y = 0.08,
		width = 0.27,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "Showroom",
			name = "main",
			buttons = {
				{name = "Masini", description = ""},
				{name = "Motociclete", description = ""},
				{name = "VIP", description = ""},
			}
		},
		["Masini"] = {
			title = "Masini",
			name = "Masini",
			buttons = {
				{name = "Low budget", description = ''},
				{name = "Clasa Business", description = ''},
				{name = "Clasa Familie", description = ''},
				{name = "Clasice", description = ''},
				{name = "Sport", description = ''},
				{name = "Lux", description = ''},
				{name = "Suv", description = ''},
			}
		},
        ["Low budget"] = {
            title = "Low budget",
            name = "Low budget",
            buttons = {
        --{"emperor", costs = 1500, speed = 25, acceleration = 11, brakes = 70, hp = 33,numemasina = "Emperor"},
        {name = "Honda S2000 AP2", costs = 9000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, model = "ap2"},
        --{"2004astr", costs = 3500, speed = 10, acceleration = 73, brakes = 30, hp = 66, numemasina = "Opel Astra Ja"},
        {model = "VW Jetta 1998", costs = 2000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "asea"},
        {model = "asterope", costs = 2100, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Dacia Logan 2004"},
        {model = "bmwe38", costs = 3500, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "BMW Seria 7 e38"},
        {model = "civic", costs = 2500, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Honda Civic 2000"},
        {model = "corsa05", costs = 2300, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Opel Corsa 2005"},
        {model = "daduster", costs = 7000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Dacia Duster"},
        {model = "ds4", costs = 6000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Citroen DS4"},
        {model = "golfgti", costs = 5800, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "VW Golf 5 GTI"},
        {model = "infernus", costs = 3000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Dacia Logan 2007"},
        {model = "NA6", costs = 3000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Mazda Miata MX-5"},
        {model = "polo2018", costs = 17000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Volkswagen Polo 2018"},
        {model = "s600w220", costs = 20000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Mercedes s600 W220"},
        {model = "sandero", costs = 5000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Dacia Sandero"},
        {model = "sandero08", costs = 5000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Dacia Sandero 08"},
        {model = "subwrx", costs = 7000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Subaru WRX"},
        {model = "tico", costs = 1100, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Daewoo Tico"},
        {model = "volvo850r", costs = 4000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Volvo 850 R"},
        {model = "x5e53", costs = 25000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "BMW x5 E53"},
            }
        },
        ["Clasa Business"] = {
            title = "Clasa Business",
            name = "Clasa Business",
            buttons = {
                --{name = "BMW X6M", costs = 90000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, model = "x6m"},
       --{"17m760i", costs = 190000, speed = 10, acceleration = 73, brakes = 30, hp = 66,numemasina = "BMW 760i"},
        {model = "a8fsi", costs = 75000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Audi A8 2011"},
        {model = "contgt13", costs = 225000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Bentley Continental 2013"},
        {model ="dzsb", costs = 475000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Rollce Royce Phantom"},
        --{"intunder", costs = 60000, speed = 10, acceleration = 73, brakes = 30, hp = 66,numemasina = "Lincoln Continental"},
        {model ="passat", costs = 70000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Volkswagen Passat B8"},
        {model ="s500w222", costs = 375000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Mercedes S500 W222"},
        {model ="xfr", costs = 75600, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Jaguar XFR"},  
            }
        },
        ["Clasa Familie"] = {
            title = "Clasa Familie",
            name = "Clasa Familie",
            buttons = {
                --{name = "Mercedes SLR", costs = 86000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, model = "moss"}, -- d
        {model = "a8audi", costs = 15000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Audi A8"}, 
        {model = "bmwe65", costs = 7500,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "BMW Seria 7 e65 2006"}, 
        {model = "camry18", costs = 28000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Toyota Camry 2018"}, 
        {model = "charger", costs = 35000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Dodge Charger 2014"}, 
        {model = "exemplar", costs = 14000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Hyundai Elantra"}, 
        {model = "felon", costs = 65000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Chrysler Genesis G80"}, 
        {model = "ibiza", costs = 28000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Seat Ibiza"}, 
        {model = "ody18", costs = 45000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Honda Odyssey 2019"},
        {model = "pacev", costs = 30000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Renault Escape 2019"}, 
        {model = "passatr", costs = 75000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Volkswagen Passat B8 Break"}, 
        {model = "s60pole", costs = 71250,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Volvo S60"}, 
        {model = "schafter6", costs = 65000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Infinity Q50"},
        {model = "tailgater", costs = 45000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Taurus"}, 
        {model = "tmodel", costs = 57800,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Tesla Model 3"},
        {model = "v60", costs = 62000,  speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Volvo V60"}, 
            }
        },
        ["Clasice"] = {
            title = "Clasice",
            name = "Clasice",
            buttons = {
        {model = "69charger", costs =350000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Dodge Charger 69"},
        {model = "belair", costs = 40000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Chevy' Belair"},
        {model = "buccaneer", costs = 45000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Chevrolet Impala OLD SCHOOL"},
        {model = "c10", costs = 38000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Chevy' c10"},
        {model = "casco", costs = 74500, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Hot Rod"},
        {model = "eleanor", costs = 215000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Mustang GT500 Shelby 1967"},
        {model = "emperor", costs = 32000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Crown Victoria 1980"},
        {model = "fordh", costs = 1750000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Mustang Hoonigan"},
        {model = "fugitive", costs = 1400, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Lada"},
        {model = "infernus", costs = 750000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ferrari Testarossa"},
        {model = "mbw111", costs = 184000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Mercedes Benz S220 w111"},
        {model = "mgb", costs = 65000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "MGB GT"},
        {model = "Nova", costs = 255000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Chevrolet Nova"},
        {model = "pstan48", costs = 75000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Packard"},
        {model = "rx3", costs = 42500, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Mazda RX3"},
        {model = "tbird", costs = 48250, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Ford Thunderbird"},
        {model = "turbo33", costs = 60000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Porsche turbo 930"},
        {model = "vigero", costs = 475000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, name = "Dodge Challanger"}, 
            }
        },
        ["Sport"] = {
            title = "Sport",
            name = "Sport",
            buttons = {
        {model = "4c", costs = 78000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Alfa Romeo 4C"},
        {model = "180sx", costs = 6500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Nissan 180SX"},
        {model = "370z", costs = 34500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Nissan 370z"},
        {model = "a45amg", costs = 85000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mercedes A45 AMG"},
        {model = "acr", costs = 175000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Dodge Viper acr"},
        {model = "aqv", costs = 62500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Alfa Romeo Giulia"},
        --faratextura{"audirs6tk", costs = 135000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Audi RS6 TK"},
        {model = "audis8om", costs = 115000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi S8"},
        {model = "ben17", costs = 157000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Bentley Continental GT"},
        {model = "bmwm8", costs = 192500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M8"},
        {model = "brz", costs = 65000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Subaru BRZ"},
        {model = "brzbn", costs = 52500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Subaru BRZ v2"},
        {model = "c7", costs = 84500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Chevrolet Corvette (C7)"},
        {model = "c8", costs = 91500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Chevrolet Corvette (C8)"},
        {model = "CATS", costs = 84500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Cadilac CTS-V"},
        {model = "cx75", costs = 85500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jaguar CX 75"},
        {model = "e60", costs = 6000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M5 E60"},
        {model = "evo9", costs = 32000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "MITSUBISHI LANCER EVO 9"},
        {model = "F82", costs = 93500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M4 f82"},
        {model = "f620", costs = 125000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Maserati GranTurismo"},
        {model = "f824slw", costs = 97000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M4 F82 SLW"},
        {model = "FC3S", costs = 15000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mazda RX-7 FC3S"},
        {model = "furoregt", costs = 165000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jaguar XKR-S GT"},
        {model = "hondacivictr", costs = 51250,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Honda Type R"},
        {model = "jackal", costs = 42500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Subaru STi R"},
        {model = "kiagt", costs = 465000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Kia Stinger 2020"},
        {model = "lc500", costs = 92500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Lexus LC500"},
        {model = "m2", costs = 87500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M2"},
        {model = "m3", costs = 120000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M3"},
        {model = "m6f13", costs = 145000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW M6 F13"},
        {model = "mb18", costs = 185000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mercedes Benz S63 AMG Cabrio"},
        {model = "mgrantur2010", costs = 125000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Maserati  GranTurismo  2010"},
        {model = "miniroads", costs = 32500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mini Couper Roadester"},
        {model = "models", costs = 425000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Tesla Model S"},
        {model = "p90d", costs = 475000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Tesla Model P90 D"},
        {model = "moss", costs = 275000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mercedes Benz SLR"},
        {model =  "mustang19", costs = 85000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Ford Mustang 19"},
        {model = "rcf", costs = 95000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Lexus RC F"},
        {model = "rs6", costs = 145000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi RS 6"},
        {model = "rs6tk", costs = 145000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, namename = "Audi RS 6 TK 2"},
        {model = "rs7", costs = 175000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi RS 7"},
        {model = "rs318", costs = 98000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi RS 3 2018"},
        {model = "rx8r", costs = 37850, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Mazda RX8-R"},
        {model = "s5", costs = 97500, costs = 450000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi S5"},
        {model = "skyline", costs = 75200,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Nissan skyline"},
        {model = "supra2", costs = 125000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Toyota Supra"},
        {model = "supraa90", costs = 195000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Toyota Supra 2019"},
        {model = "teslapd", costs = 485000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Tesla PD-S1000"},
        --{"viper", costs = 155000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Dodge Viper"},
        {model = "z4bmw", costs = 95000,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW Z4"},
        {model = "zl12017", costs = 117500,  speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Chevrolet Camaro 2017"},
            }
        },
        ["Suv"] = {
            title = "Suv",
            name = "Suv",
            buttons = {
        --{"18velar", costs = 95000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Range Rover Velar"},
        {model = "amarok", costs = 65000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "VW Amarok"},
        --{"bentayga17", costs = 220000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Bentley Bentayga"},
        {model = "bjxl", costs = 30000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Kia Sportage"},
        {model = "Cavalcade2", costs = 92500, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Audi q7"},
        {model = "cayenne", costs = 145000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Porsche Cayenne"},
        {model = "fpacehm", costs = 115000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jaguar F Pace SVR"},
        {model = "FX50s", costs = 24000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Infinity fx50s"},
        --{"g65", costs = 450000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Mercedes G65"},
        {model = "gmcs", costs = 65000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "GMC Sierra 1500"},
        {model = "gmcyd", costs = 92000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "GMC Yukon Denali"},
        {model = "gmt900escalade", costs = 165000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Cadilac Escalade"},
        {model = "jeep2012", costs = 74000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jeep 2012"},
        {model = "jeepreneg", costs = 75000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jeep Renegade"},
        {model = "levante", costs = 120000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Maserati Levante"},
        {model = "navigator", costs = 145000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Lincoln Navigator"},
        {model = "patriot", costs = 115000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Hummer H1"},
        {model = "q30", costs = 45000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Infiniti q30"},
        --faratextura{"quashqai16", costs = 65000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Nissan Quashqai"},
        --{"rrst", costs = 185000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Range Rover Sport"},
        {model = "santafe", costs = 27000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Hyundai SantaFe"},
        {model = "srt8", costs = 98000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jeep SRT8"},
        {model = "stelvio", costs = 68500, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Alfa Romeo Stelvio"},
        {model = "titan17", costs = 45000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "nNissan Titanume"},
        {model = "trailcat", costs = 95000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jeep Trailcat"},
        {model = "trhawk", costs = 86000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "Jeep Grand Cherokee S"},
        {model = "x6m", costs = 145000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, name = "BMW x6 M"},
        --faratextura{"jukonxl", costs = 70000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "GMC Yukon XL"},
            }
        },
        ["Lux"] = {
            title = "Lux",
            name = "Lux",
            buttons = {
--{"720s", costs = 565000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "McLaren 720s"},
        {model = "2019chiron", costs = 2998000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Bugatti Chiron"},
        {model = "amv19", costs = 245000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Aston Martin Vantage 2019"},
        {model = "arv10", costs = 290000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Audi R8 V10"},
        {model = "ast", costs = 475000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Aston Martin Vanquish DB9"},
        --{"bdivo", costs = 3950000, speed = 33, acceleration = 22, brakes = 5, hp = 99,numemasina = "Bugatti Divo"},
        {model = "comet2", costs = 200000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Porsche 718 Cayman S"},
        {model = "db9v", costs = 550000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Aston Martin DB9V Cabrio"},
        {model = "f430s", costs = 450000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Ferrari F430 S"},
        {model = "f812", costs = 556000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Ferrari F812"},
        {model = "fct", costs = 545000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Ferrari Califronia"},
        {model = "filthynsx", costs = 212000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Acura NSX"},
        {model = "gto", costs = 455000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Ferrari GTO"},
        {model = "gtr", costs = 245000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Nissan GTR"},
        {model = "i8", costs = 235000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "BMW I8"},
        {model = "lhuracan", costs = 650000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Lamborghini Huracan"},
        {model = "mp412c", costs = 375000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "McLaren MP4 12C"},
        {model = "p911r", costs = 690000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Porsche 911r"},
        {model = "r8ppi", costs = 175000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Audi R8 PPI"},
        {model = "senna", costs = 4500000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "McLaren Senna"},
        {model = "spyker", costs = 265000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Spyker C8"},
        {model = "tr22", costs = 425000,  speed = 65, acce = 55, brake = 35, trac = 40, description = {}, name = "Tesla Roadster"},
            }
        },

        ["Motociclete"] = {
            title = "Motociclete",
            name = "Motociclete",
            buttons = {
        {model = "r1",costs = 70000, description = {}, name = "Yamaha R1"},
        {model = "blazer6",costs = 5000, description = {}, name = "ATV"},
        {model = "bmws",costs = 65000, description = {}, name = "BMW S1000"},
        {model = "desmo",costs = 60000, description = {}, name = "Ducatti Desmo"},
        {model = "exciter",costs = 18000, description = {}, name = "Yamaha Exciter"},
            }
        },
 		["VIP"] = {
			title = "VIP",
			name = "VIP",
			buttons = {
{model = "Koenisegg Regera VIP4", costs = 1, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, name = "MasiniLipsa"},
			}
		},
	}
}

-- return vehshop

local fakecar = {model = '', car = nil}
local vehshop_locations = {
{entering = {-33.758636474609,-1113.2640380859,26.422357559204}, inside = {-75.095962524414,-818.67309570313,326.17517089844}, outside = {-33.758636474609,-1113.2640380859,26.422357559204}},
}

local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false


function vehPrs_drawTxt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function vehSR_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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

function vehSR_IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	--326 car blip 227 225
	vehSR_ShowVehshopBlips(true)
	firstspawn = 1
end
end)

function drawScreenText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(0)
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
    DrawText(x - width/2, y - height/2 + 0.005)
end

function vehSR_ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,642)
			SetBlipScale(blip,1.1)
			SetBlipColour(blip,1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("DealerShip")
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and vehshop.opened == false and IsPedInAnyVehicle(vehSR_LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(vehSR_LocalPed())) < 2.0 then
						drawScreenText(0.5, 0.93, 0,0, 0.5, "~w~Apasa ~g~[E]~w~ pentru a intra in ~r~Showroom~w~.", 255, 255, 255, 230, 1, 4, 1)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

vehSR_ShowVehshopBlips(true)

function vehSR_f(n)
	return n + 0.0001
end

function vehSR_LocalPed()
	return GetPlayerPed(-1)
end

function vehSR_try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end
function vehSR_firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
--local veh = nil
function vehSR_OpenCreator()
	boughtcar = false
	local ped = vehSR_LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	SetEntityVisible(ped,false)
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

local vehicle_costs = 0
function vehSR_CloseCreator(vehicle,veh_type)
	Citizen.CreateThread(function()
		local ped = vehSR_LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
			vRP.teleport({-33.758636474609,-1113.2640380859,26.422357559204})
			SetEntityHeading(ped, 180.0)
			scaleform = nil
		else
			deleteVehiclePedIsIn()
			vRP.teleport({-33.758636474609,-1113.2640380859,26.422357559204})
			SetEntityHeading(ped, 180.0)
			--vRPg.spawnBoughtVehicle({veh_type, vehicle})
			SetEntityVisible(ped,true)
			FreezeEntityPosition(ped,false)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function vehSR_drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0, 0, 0,195)
	end
	DrawRect(x,y+0.02,menu.width,0.004,0,0,0,255)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function vehSR_drawMenuTitle(txt,x,y)
local menu = vehshop.menu
	SetTextFont(4)
	SetTextProportional(0)
	SetTextOutline()
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

simeonX, simeonY, simeonZ = -32.049884796143,-1114.2701416016,26.422355651855


function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(1)
        SetTextProportional(1)
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

function DrawText3Y(x,y,z, text, r,g,b,a)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*3
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.4*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(4)
        SetTextColour(r, g, b, 240)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 255)
		SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function DrawText3Z(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
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

Citizen.CreateThread(function()
	simeon = 1283141381
	RequestModel( simeon )
	while ( not HasModelLoaded( simeon ) ) do
		Citizen.Wait( 100 )
	end
	theSimeon = CreatePed(4, simeon, simeonX, simeonY, simeonZ-1, 30, false, false)
	SetModelAsNoLongerNeeded(simeon)
	SetEntityHeading(theSimeon, 80.0)
	FreezeEntityPosition(theSimeon, true)
	SetEntityInvincible(theSimeon, true)
	SetBlockingOfNonTemporaryEvents(theSimeon, true)
end)

--[[Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, simeonX, simeonY, simeonZ) < 5.5)then
			DrawText3D(simeonX, simeonY, simeonZ+1.15+0.20, "Cheche' Mihaitza", 1.2)
			DrawText3Z(simeonX, simeonY, simeonZ+1.15, "~w~[~g~Car Dealer~w~]", 1.2)
		end
		Citizen.Wait(2)
	end
end)]]


function vehSR_tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function vehSR_Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function vehSR_drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.06, y - menu.height/2 + 0.0028)
end

function showroom_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
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

testDriveCar = nil
testDriveSeconds = 60
isInTestDrive = false
isInCar = false

function destroyTestDriveCar()
	if(testDriveCar ~= nil)then
		if(DoesEntityExist(testDriveCar))then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(testDriveCar))
		end
		testDriveCar = nil
		isInTestDrive = false
	end
	testDriveSeconds = 60
	vRP.teleport({-33.758636474609,-1113.2640380859,26.422357559204}) --Terminare drive
	SetEntityHeading(GetPlayerPed(-1), 180.0)
	vRP.notify({"~r~The test drive is over!"})
end

AddEventHandler("playerDropped", function()
	if(testDriveCar ~= nil)then
		destroyTestDriveCar()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1100)
		if(testDriveCar ~= nil) and (isInTestDrive == false) then
			isInTestDrive = true
		else
			isInTestDrive = false
		end
		if(testDriveCar ~= nil)then
			local IsInVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(IsInVehicle ~= nil)then
				if(testDriveCar == IsInVehicle)then
					if(testDriveSeconds > 0)then
						testDriveSeconds = testDriveSeconds - 1
					else
						destroyTestDriveCar()
					end
					isInCar = true
				else
					isInCar = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(testDriveSeconds < 60)then
			showroom_drawTxt(1.30, 1.40, 1.0,1.0,0.35, "~g~TestDrive: ~r~"..testDriveSeconds.." ~y~Seconds", 255, 255, 255, 255)
		end
		if(isInTestDrive) then
			if(isInCar == false)then
				destroyTestDriveCar()
			end
		end
	end
end)

carcosts = "0 LEI"
local backlock = false
Citizen.CreateThread(function()
	local last_dir
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,46) and vehSR_IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				vehSR_CloseCreator("","")
			else
				vehSR_OpenCreator()
			end
		end
		if vehshop.opened then
			showroom_drawTxt(0.51, 1.073, 1.0,1.0,0.4, "~g~[ENTER] ~w~-> ~r~Cumpara Masina", 255, 255, 255, 255)
			showroom_drawTxt(0.51, 1.1, 1.0,1.0,0.4, "~g~[E] ~w~-> ~r~Arata Textura Masinii", 255, 255, 255, 255)
			showroom_drawTxt(0.51, 1.13, 1.0,1.0,0.4, "~g~[F] ~w~-> ~r~Testeaza Masina", 255, 255, 255, 255)
			local ped = vehSR_LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			vehSR_drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			vehSR_drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			vehSR_drawTxt(vehshop.selectedbutton.."/"..vehSR_tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = vehSR_tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "Low budget" or vehshop.currentmenu == "Ford" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Clasa Business" or vehshop.currentmenu == "Chevrolet" or vehshop.currentmenu == "Rolls Royce" or vehshop.currentmenu == "Jaguar" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "Mafie" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "Tiruri" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "Clasa Familie" or vehshop.currentmenu == "Clasice" or vehshop.currentmenu == "Sport" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "Lux" or vehshop.currentmenu == "Suv" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porsche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Masini" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "Masini Scumpe" or vehshop.currentmenu == "Motociclete" or vehshop.currentmenu == "Politie" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "Trailer Park Boys" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "VIP" or vehshop.currentmenu == "Masini Personale" or vehshop.currentmenu == "aviVIP" or vehshop.currentmenu == "heliVIP" or vehshop.currentmenu == "Jandarmerie" then
							vehSR_drawMenuRight("$"..button.costs,vehshop.menu.x+0.015,y,selected)
							carcosts = "$"..button.costs
						else
							vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "Low budget" or vehshop.currentmenu == "Ford" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Clasa Business" or vehshop.currentmenu == "Chevrolet" or vehshop.currentmenu == "Rolls Royce" or vehshop.currentmenu == "Jaguar" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "Mafie" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "Tiruri" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "Clasa Familie" or vehshop.currentmenu == "Clasice" or vehshop.currentmenu == "Sport" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "Lux" or vehshop.currentmenu == "Suv" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porsche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Masini" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "Masini Scumpe" or vehshop.currentmenu == "Motociclete" or vehshop.currentmenu == "Politie" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "Trailer Park Boys" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "VIP" or vehshop.currentmenu == "Masini Personale" or vehshop.currentmenu == "aviVIP" or vehshop.currentmenu == "heliVIP" or vehshop.currentmenu == "Jandarmerie"  then
						if selected then
							hash = GetHashKey(button.model)
							if IsControlJustPressed(1,23) then
								if(testDriveCar == nil)then
									if DoesEntityExist(fakecar.car) then
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
										scaleform = nil
									end
									fakecar = {model = '', car = nil}
									while not HasModelLoaded(hash) do
										RequestModel(hash)
										Citizen.Wait(10)
										showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
									end
									if HasModelLoaded(hash) then
										testDriveCar = CreateVehicle(hash,-914.83026123046,-3287.1538085938,13.521618843078,60.962993621826,false,false)
										SetModelAsNoLongerNeeded(hash)
										TaskWarpPedIntoVehicle(GetPlayerPed(-1),testDriveCar,-1)
										vRP.notify({"~g~You have ~r~1 Minute~g~ to test drive this vehicle!"})
										for i = 0,24 do
											SetVehicleModKit(testDriveCar,0)
											RemoveVehicleMod(testDriveCar,i)
										end
										if(testDriveCar)then
											vehshop.opened = false
											vehshop.menu.from = 1
											vehshop.menu.to = 10
											SetEntityVisible(GetPlayerPed(-1),true)
											FreezeEntityPosition(GetPlayerPed(-1),false)
											scaleform = nil
										end
									end
								end
							end
							if fakecar.model ~= button.model then
								if IsControlJustPressed(1,38) then
									if DoesEntityExist(fakecar.car) then
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
										scaleform = nil
									end
									local pos = currentlocation.pos.inside									
									local i = 0
									while not HasModelLoaded(hash) and i < 500 do
										RequestModel(hash)
										Citizen.Wait(10)
										i = i+1
										showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
									end

									-- spawn car
									if HasModelLoaded(hash) then
									--if timer < 255 then
										veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
										FreezeEntityPosition(veh,true)
										SetEntityInvincible(veh,true)
										SetVehicleDoorsLocked(veh,4)
										SetModelAsNoLongerNeeded(hash)
										--SetEntityCollision(veh,false,false)
										TaskWarpPedIntoVehicle(vehSR_LocalPed(),veh,-1)
										for i = 0,24 do
											SetVehicleModKit(veh,0)
											RemoveVehicleMod(veh,i)
										end
										fakecar = { model = button.model, car = veh}
										Citizen.CreateThread(function()
											while DoesEntityExist(veh) do
												Citizen.Wait(25)
												SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
											end
										end)

										scaleform = Initialize("mp_car_stats_01", carcosts, button.name)
									else
										if last_dir then
											if vehshop.selectedbutton < buttoncount then
												vehshop.selectedbutton = vehshop.selectedbutton +1
												if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
													vehshop.menu.to = vehshop.menu.to + 1
													vehshop.menu.from = vehshop.menu.from + 1
												end
											else
												last_dir = false
												vehshop.selectedbutton = vehshop.selectedbutton -1
												if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
													vehshop.menu.from = vehshop.menu.from -1
													vehshop.menu.to = vehshop.menu.to - 1
												end
											end
										else
											if vehshop.selectedbutton > 1 then
												vehshop.selectedbutton = vehshop.selectedbutton -1
												if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
													vehshop.menu.from = vehshop.menu.from -1
													vehshop.menu.to = vehshop.menu.to - 1
												end
											else
												last_dir = true
												vehshop.selectedbutton = vehshop.selectedbutton +1
												if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
													vehshop.menu.to = vehshop.menu.to + 1
													vehshop.menu.from = vehshop.menu.from + 1
												end
											end
										end
									end
								end
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						vehSR_ButtonSelected(button)
					end
				end
			end
			if IsControlJustPressed(1,202) then
				vehSR_Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				last_dir = false
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				last_dir = true
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function drawscreentext(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(8)
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
	DrawText(x, y)
end

function vehSR_round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function vehSR_ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Masini" then
			vehSR_OpenMenu('Masini')
		elseif btn == "suv-offroad" then
			vehSR_OpenMenu('suv-offroad')
		elseif btn == "bikes" then
			vehSR_OpenMenu('bikes')
		elseif btn == "Motociclete" then
			vehSR_OpenMenu('Motociclete')
		elseif btn == "Masini Factiuni" then
			vehSR_OpenMenu('Masini Factiuni')
		elseif btn == "Mafie" then
			vehSR_OpenMenu('Mafie')
		elseif btn == "Hitman" then
			vehSR_OpenMenu('Hitman')
		elseif btn == "Tiruri" then
			vehSR_OpenMenu('Tiruri')
	    elseif btn == "thelostmc" then
		    vehSR_OpenMenu('thelostmc')
		elseif btn == "VIP" then
			vehSR_OpenMenu('VIP')
		elseif btn == "Masini Personale" then
			vehSR_OpenMenu('Masini Personale')
		elseif btn == "aviation" then
			vehSR_OpenMenu('aviation')
		elseif btn == "Masini Scumpe" then
			vehSR_OpenMenu('Masini Scumpe')
		end
	elseif this == "Masini" then
		if btn == "Low budget" then
			vehSR_OpenMenu('Low budget')
		elseif btn == "Toyota" then
			vehSR_OpenMenu('Toyota')
		elseif btn == "Ford" then
			vehSR_OpenMenu('Ford')
		elseif btn == "Clasa Business" then
			vehSR_OpenMenu('Clasa Business')
		elseif btn == "Chevrolet" then
			vehSR_OpenMenu('Chevrolet')
	    elseif btn == "Rolls Royce" then
			vehSR_OpenMenu('Rolls Royce')
		elseif btn == "Jaguar" then
			vehSR_OpenMenu('Jaguar')
		elseif btn == "Clasa Familie" then
			vehSR_OpenMenu('Clasa Familie')
		elseif btn == "Clasice" then
			vehSR_OpenMenu('Clasice')
		elseif btn == "Sport" then
			vehSR_OpenMenu('Sport')
		elseif btn == "fast-and-furios" then
			vehSR_OpenMenu('fast-and-furios')
		elseif btn == "Lux" then
			vehSR_OpenMenu("Lux")
		elseif btn == "Mafie" then
			vehSR_OpenMenu('Mafie')
		elseif btn == "Suv" then
			vehSR_OpenMenu('Suv')
		elseif btn == "Aston Martin" then
			vehSR_OpenMenu('Aston Martin')
		elseif btn == "Porsche" then
			vehSR_OpenMenu('Porsche')
		elseif btn == "Toyota" then
			vehSR_OpenMenu('Toyota')
		elseif btn == "Masini" then
			vehSR_OpenMenu('Masini')
		elseif btn == "Masini Scumpe" then
			vehSR_OpenMenu('Masini Scumpe')
		end
	elseif this == "Masini Factiuni" then
		if btn == "Jandarmerie" then
			vehSR_OpenMenu('Jandarmerie')
		elseif btn == "Politie" then
			vehSR_OpenMenu('Politie')
		elseif btn == "Mafie" then
			vehSR_OpenMenu('Mafie')
		elseif btn == "Hitman" then
			vehSR_OpenMenu('Hitman')
		elseif btn == "fisher" then
			vehSR_OpenMenu('fisher')
		elseif btn == "weazelnews" then
			vehSR_OpenMenu('weazelnews')
		elseif btn == "ems" then
			vehSR_OpenMenu('ems')
		elseif btn == "Trailer Park Boys" then
			vehSR_OpenMenu('Trailer Park Boys')
		elseif btn == "lawyer" then
			vehSR_OpenMenu('lawyer')
		elseif btn == "delivery" then
			vehSR_OpenMenu("delivery")
		elseif btn == "repair" then
			vehSR_OpenMenu('repair')
		elseif btn == "bankdriver" then
			vehSR_OpenMenu('bankdriver')
		elseif btn == "medicalweed" then
			vehSR_OpenMenu('medicalweed')
		end
	elseif this == "aviation" then
		if btn == "aviVIP" then
			vehSR_OpenMenu('aviVIP')
		elseif btn == "heliVIP" then
			vehSR_OpenMenu('heliVIP')
		end
	elseif this == "Low budget" or this == "Ford" or this == "Toyota" or this == "Clasa Business" or this == "Chevrolet" or this == "Rolls Royce" or this == "Jaguar" or this == "suv-offroad" or this == "Clasa Familie" or this == "Clasice" or this == "Sport" or this == "Mafie" or this == "Hitman" or this == "Tiruri" or this == "thelostmc" or this == "fast-and-furios" or this == "Lux" or this == "Suv" or this == "Aston Martin" or this == "Porsche" or this == "Toyota" or this == "Masini" or this == "bikes" or this == "Masini Scumpe" or this == "Politie" or this == "Jandarmerie" or this == "Hitman" or this == "fisher" or this == "weazelnews" or this == "ems" or this == "Trailer Park Boys" or this == "lawyer" or this == "delivery" or this == "repair" or this == "bankdriver" or this == "medicalweed" or this == "VIP" or this == "Masini Personale" or this == "aviVIP" or this == "heliVIP" or this == "Jandarmerie" then
		vehshop.opened = false
		
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
			scaleform = nil
		end
		local pos = currentlocation.pos.inside									
		local i = 0
		while not HasModelLoaded(hash) and i < 500 do
			RequestModel(hash)
			Citizen.Wait(10)
			i = i+1
			showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
		end

		if HasModelLoaded(hash) then
			veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
			FreezeEntityPosition(veh,true)
			SetEntityInvincible(veh,true)
			SetVehicleDoorsLocked(veh,4)
			SetModelAsNoLongerNeeded(hash)
			TaskWarpPedIntoVehicle(vehSR_LocalPed(),veh,-1)
			for i = 0,24 do
				SetVehicleModKit(veh,0)
				RemoveVehicleMod(veh,i)
			end
			fakecar = { model = button.model, car = veh}
			Citizen.CreateThread(function()
				while DoesEntityExist(veh) do
					Citizen.Wait(25)
					SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
				end
			end)
			scaleform = Initialize("mp_car_stats_01", carcosts, button.name)
		else
			if last_dir then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				else
					last_dir = false
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			else
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				else
					last_dir = true
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end


		Citizen.CreateThread(function()
			while true do
				ShowCursorThisFrame()
				DisableControlAction(0,24,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0, 1, true)
				DisableControlAction(0, 2, true)
				DisableControlAction(0, 27, true)
				DisableControlAction(0, 172, true)
				DisableControlAction(0, 173, true)
				DisableControlAction(0, 174, true)
				DisableControlAction(0, 175, true)
				DisableControlAction(0, 176, true)
				DisableControlAction(0, 177, true)

				backlock = true

				local CuloareButoane = {
					OK = {68, 68, 68},
					NotOK = {68, 68, 68}
				}

				CuloareButoane.OK = {68, 68, 68}
				CuloareButoane.NotOK = {68, 68, 68}

				if isCursorInPosition(0.550,0.515,0.065,0.035) then
					SetCursorSprite(5)
					CuloareButoane.OK = {234, 178, 10}
					if(IsDisabledControlJustPressed(0, 24))then
						local ante = button.costs
						if button.reducere then
							button.costs = math.floor(button.costs / 2)
						end
						TriggerServerEvent('veh_SR:CumparaRabla',this,button.model,button.costs,"car",button.name,false,false)
						button.costs = ante
						break
					end
				elseif isCursorInPosition(0.430,0.515,0.065,0.035) then 
					SetCursorSprite(5)
					CuloareButoane.NotOK = {234, 178, 10}
					if(IsDisabledControlJustPressed(0, 24))then
						if DoesEntityExist(fakecar.car) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
							scaleform = nil
						end
						fakecar = {model = '', car = nil}

						vehshop.opened = true
						break
					end
				else
					SetCursorSprite(1)
				end

				DrawRect(0.49,0.45,0.20,0.20,0,0,0,150)
				DrawRect(0.49,0.365,0.20,0.03,234, 178, 10, 180)

				drawscreentext("Achizitionare Masina",6,0,0.45,0.350,0.455,255,255,255,255)
				drawscreentext("Esti sigur ca vrei sa cumperi vehiculul",6,0,0.415,0.390,0.45,255,255,255,255)
				--drawscreentext("~g~"..button.name.." $",6,0,0.427,0.445,0.45,255,255,255,255)
				drawscreentext("~g~"..button.name.." ~w~ pentru ~r~ "..button.costs.. " $",6,0,0.427,0.445,0.45,255,255,255,255)

				DrawRect(0.430,0.515,0.065,0.035,CuloareButoane.NotOK[1],CuloareButoane.NotOK[2],CuloareButoane.NotOK[3], 180)
				drawscreentext("~r~Nu",4,0,0.425,0.500,0.4,48,28,119, 255, 0)

				DrawRect(0.550,0.515,0.065,0.035,CuloareButoane.OK[1],CuloareButoane.OK[2],CuloareButoane.OK[3], 180)
				drawscreentext("~g~Da",4,0,0.545,0.500,0.4,48,28,119, 255, 0)
				Citizen.Wait(0)
			end
		end)
	elseif  this == "Motociclete" then
		vehshop.opened = false
		
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
			scaleform = nil
		end
		local pos = currentlocation.pos.inside									
		local i = 0
		while not HasModelLoaded(hash) and i < 500 do
			RequestModel(hash)
			Citizen.Wait(10)
			i = i+1
			showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
		end

		if HasModelLoaded(hash) then
			veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
			FreezeEntityPosition(veh,true)
			SetEntityInvincible(veh,true)
			SetVehicleDoorsLocked(veh,4)
			SetModelAsNoLongerNeeded(hash)
			TaskWarpPedIntoVehicle(vehSR_LocalPed(),veh,-1)
			for i = 0,24 do
				SetVehicleModKit(veh,0)
				RemoveVehicleMod(veh,i)
			end
			fakecar = { model = button.model, car = veh}
			Citizen.CreateThread(function()
				while DoesEntityExist(veh) do
					Citizen.Wait(25)
					SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
				end
			end)
			scaleform = Initialize("mp_car_stats_01", carcosts, button.name)
		else
			if last_dir then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				else
					last_dir = false
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			else
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				else
					last_dir = true
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end


		Citizen.CreateThread(function()
			while true do
				ShowCursorThisFrame()
				DisableControlAction(0,24,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0, 1, true)
				DisableControlAction(0, 2, true)
				DisableControlAction(0, 27, true)
				DisableControlAction(0, 172, true)
				DisableControlAction(0, 173, true)
				DisableControlAction(0, 174, true)
				DisableControlAction(0, 175, true)
				DisableControlAction(0, 176, true)
				DisableControlAction(0, 177, true)

				backlock = true

				local CuloareButoane = {
					DA = {68, 68, 68},
					Anuleaza = {68, 68, 68}
				}

				CuloareButoane.OK = {68, 68, 68}
				CuloareButoane.NotOK = {68, 68, 68}

				if isCursorInPosition(0.550,0.515,0.065,0.035) then
					SetCursorSprite(5)
					CuloareButoane.OK = {234, 178, 10}
					if(IsDisabledControlJustPressed(0, 24))then
						local ante = button.costs
						if button.reducere then
							button.costs = math.floor(button.costs / 2)
						end
						TriggerServerEvent('veh_SR:CumparaRabla',this,button.model,button.costs,"bike",false,false)
						button.costs = ante
						break
					end
				elseif isCursorInPosition(0.430,0.515,0.065,0.035) then 
					SetCursorSprite(5)
					CuloareButoane.NotOK = {234, 178, 10}
					if(IsDisabledControlJustPressed(0, 24))then
						if DoesEntityExist(fakecar.car) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
							scaleform = nil
						end
						fakecar = {model = '', car = nil}

						vehshop.opened = true
						break
					end
				else
					SetCursorSprite(1)
				end

				DrawRect(0.49,0.45,0.20,0.20,0,0,0,150)
				DrawRect(0.49,0.365,0.20,0.03,234, 178, 10, 180)

				drawscreentext("Achizitionare Masina",6,0,0.45,0.350,0.455,255,255,255,255)
				drawscreentext("Esti sigur ca vrei sa cumperi vehiculul",6,0,0.415,0.390,0.45,255,255,255,255)
				--drawscreentext("~g~"..button.name.." $",6,0,0.427,0.445,0.45,255,255,255,255)
				drawscreentext("~g~"..button.name.." ~w~ pentru ~r~ "..button.costs.. " $",6,0,0.427,0.445,0.45,255,255,255,255)

				DrawRect(0.430,0.515,0.065,0.035,CuloareButoane.NotOK[1],CuloareButoane.NotOK[2],CuloareButoane.NotOK[3], 180)
				drawscreentext("~r~Nu",4,0,0.425,0.500,0.4,48,28,119, 255, 0)

				DrawRect(0.550,0.515,0.065,0.035,CuloareButoane.OK[1],CuloareButoane.OK[2],CuloareButoane.OK[3], 180)
				drawscreentext("~g~Da",4,0,0.545,0.500,0.4,48,28,119, 255, 0)
				Citizen.Wait(0)
			end
		end)
		
	end
end

RegisterNetEvent('veh_SR:CloseMenu')
AddEventHandler('veh_SR:CloseMenu', function(vehicle, veh_type)
	boughtcar = true
	vehSR_CloseCreator(vehicle,veh_type)
	scaleform = nil
end)

function vehSR_OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "Masini" then
		vehshop.lastmenu = "main"
	elseif menu == "suv-offroad"  then
		vehshop.lastmenu = "main"
	elseif menu == "Motociclete"  then
		vehshop.lastmenu = "main"
	elseif menu == "Mafie"  then
		vehshop.lastmenu = "main"
	elseif menu == "Tiruri"  then
		vehshop.lastmenu = "main"
	elseif menu == "Hitman"  then
		vehshop.lastmenu = "main"
	elseif menu == "thelostmc"  then
		vehshop.lastmenu = "main"
    elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == "Masini Factiuni"  then
		vehshop.lastmenu = "main"
	elseif menu == "VIP"  then
		vehshop.lastmenu = "main"
	elseif menu == "Masini Personale"  then
		vehshop.lastmenu = "main"
	elseif menu == "aviation"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end


function vehSR_Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		vehSR_CloseCreator("","")
	elseif vehshop.currentmenu == "Low budget" or vehshop.currentmenu == "Ford" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Clasa Business" or vehshop.currentmenu == "Chevrolet" or vehshop.currentmenu == "Rolls Royce" or vehshop.currentmenu == "Jaguar" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "Mafie" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "Tiruri" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "Clasa Familie" or vehshop.currentmenu == "Clasice" or vehshop.currentmenu == "Sport" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "Lux" or vehshop.currentmenu == "Suv" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porsche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "Masini" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "Masini Scumpe" or vehshop.currentmenu == "Motociclete" or vehshop.currentmenu == "Politie" or vehshop.currentmenu == "Jandarmerie" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "Hitman" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "Trailer Park Boys" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "VIP" or vehshop.currentmenu == "Masini Personale" or vehshop.currentmenu == "aviation" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
			scaleform = nil
		end
		fakecar = {model = '', car = nil}
		vehSR_OpenMenu(vehshop.lastmenu)
	else
		vehSR_OpenMenu(vehshop.lastmenu)
	end

end


function vehSR_stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

RegisterNetEvent('meniu')
AddEventHandler('meniu', function()
	vehshop.opened = true
end)

scaleform = nil
function Initialize(scaleform, costs, vehName, speed, acce, brake, trac)
	scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
	PushScaleformMovieFunctionParameterString(vehName)
	PushScaleformMovieFunctionParameterString(costs)
	PushScaleformMovieFunctionParameterString("MPCarHUD")
	PushScaleformMovieFunctionParameterString("Benefactor")
	PushScaleformMovieFunctionParameterString("Speed")
	PushScaleformMovieFunctionParameterString("Acceleration")
	PushScaleformMovieFunctionParameterString("Brakes")
	PushScaleformMovieFunctionParameterString("Traction")
	PushScaleformMovieFunctionParameterInt(speed or 100)
	PushScaleformMovieFunctionParameterInt(acce or 100)
	PushScaleformMovieFunctionParameterInt(brake or 100)
	PushScaleformMovieFunctionParameterInt(trac or 100)
	PopScaleformMovieFunctionVoid()
	return scaleform
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(fakecar.model ~= nil) and (scaleform ~= nil)then
			local x = 0.67
			local y = 0.52
			local width = 0.65
			local height = width / 0.68
			DrawScaleformMovie(scaleform, x, y, width, height)
		end
	end
end)

function drawscreentext(text,font,centre,x,y,scale,r,g,b,a)
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
	DrawText(x, y)
end

function drawscreentext2(text,font,centre,x,y,scale,r,g,b,a)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(0)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function pulaCumparata(text)
    Citizen.CreateThread(function()
        local sx, sy = GetActiveScreenResolution()
        local cx, cy = GetNuiCursorPosition()   
        local cx, cy = ( cx / sx ), ( cy / sy )
        local alpha = 255
        while true do
            cy = cy+0.003
            if alpha <= 0 then
                alpha = 0.550
                break
            end
            alpha = alpha -2
            DrawSprite("money", "money", cx, cy, 0.013, 0.015, 0.0, 255, 255, 255, alpha)
            if text ~= nil then
                drawscreentext2(text,4,0,cx+0.01, cy-0.01,0.25,0, 255, 0,alpha)
            end
            Citizen.Wait(0)
        end
    end)
end


function info(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.45, 0.45)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end