vRP = Proxy.getInterface("vrp")
vRPserver = Tunnel.getInterface("vrp","esk_showroom")
vRPshowroom = Tunnel.getInterface("esk_showroom","esk_showroom")
vRPshowroomC = {}
Tunnel.bindInterface("esk_showroom",vRPshowroomC)
vRPserver = Tunnel.getInterface("esk_showroom","esk_showroom")


local coordonateOpenShowroom = {-29.197132110596,-1104.6080322266,26.422359466553}
local coordonateInShowroom = {227.95265197754,-991.97448730469,-98.999984741211}


local inShowroom = false
local vehicles = {}
local cam = nil
local categorie = 1
local selectie = 1

local camHacks = {
    ['onvehicle'] = {
        offsetX = -3.0,
        offsetY = 5.0,
        offsetZ = 1.3,
        pointCamAtCoordX = 0.0,
        pointCamAtCoordY = 4.5,
        pointCamAtCoordZ = 0.5
    }
}


local vehicles = {
    [1] = {
        tablename = 'Daewoo',
            {numeVehicul = "tico", price = 3000, speed = 25, acceleration = 15, brakes = 20, hp = 35, numemasina = "Tico", maxspeed= 100, maxspeedbar = 91, tip = 'Daewoo'},
        },
    
        [2] = {
        tablename = 'Dacia',
            {numeVehicul = "dacia1310", price = 430, speed = 25, acceleration = 15, brakes = 20, hp = 35, numemasina = "Dacia 1310", maxspeed= 120, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "logan2004", price = 830, speed = 32, acceleration = 23, brakes = 29, hp = 44, numemasina = "Dacia Logan", maxspeed= 160, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "loganmcv", price = 100, speed = 32, acceleration = 21, brakes = 27, hp = 42, numemasina = "Dacia Logan MCV", maxspeed= 160, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "sandero21", price = 1300, speed = 36, acceleration = 26, brakes = 31, hp = 46, numemasina = "Dacia Sandero", maxspeed= 180, maxspeedbar = 91, tip = 'Dacia'},
        },
    
        [3] = {
        tablename = 'Opel',
            {numeVehicul = "2004astra", price = 1700, speed = 32, acceleration = 22, brakes = 27, hp = 42, numemasina = "Opel Astra", maxspeed= 160, maxspeedbar = 91, tip = 'Opel'},
        },
    
        [4] = {
        tablename = 'BMW',
            {numeVehicul = "e34", price = 4000, speed = 46, acceleration = 36, brakes = 41, hp = 56, numemasina = "BMW E34", maxspeed= 190, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m3e46", price = 7500, speed = 54, acceleration = 44, brakes = 49, hp = 64, numemasina = "BMW M3 E46", maxspeed= 260, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m5e60", price = 9000, speed = 58, acceleration = 48, brakes = 53, hp = 68, numemasina = "BMW M5 E60", maxspeed= 280, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "x5mnou", price = 24670, speed = 58, acceleration = 45, brakes = 58, hp = 70, numemasina = "BMW X5M", maxspeed= 280, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m5f90", price = 31000, speed = 75, acceleration = 65, brakes = 70, hp = 85, numemasina = "BMW M5 F90", maxspeed= 300, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m760li", price = 56500, speed = 75, acceleration = 62, brakes = 72, hp = 83, numemasina = "BMW M760Li", maxspeed= 300, maxspeedbar = 91, tip = 'BMW'},
        },
    
        [5] = {
        tablename = 'Audi',
            {numeVehicul = "audia4", price = 8000, speed = 46, acceleration = 36, brakes = 41, hp = 56, numemasina = "Audi A4", maxspeed= 190, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "q72012", price = 30000, speed = 56, acceleration = 46, brakes = 51, hp = 66, numemasina = "Audi Q7", maxspeed= 230, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "q820", price = 31000, speed = 58, acceleration = 48, brakes = 53, hp = 68, numemasina = "Audi Q8", maxspeed= 240, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "a8audi", price = 40000, speed = 62, acceleration = 52, brakes = 57, hp = 72, numemasina = "Audi A8", maxspeed= 260, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "aaq4", price = 24000, speed = 70, acceleration = 60, brakes = 65, hp = 80, numemasina = "Audi A4 ABT", maxspeed= 280, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "rs5r", price = 26533, speed = 75, acceleration = 65, brakes = 70, hp = 85, numemasina = "Audi RS5", maxspeed= 300, maxspeedbar = 91, tip = 'Audi'},
        },
    
        [6] = {
        tablename = 'Mercedes-Benz',
            {numeVehicul = "w210", price = 33000, speed = 50, acceleration = 40, brakes = 45, hp = 60, numemasina = "Mercedes Benz E420", maxspeed= 200, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "v250", price = 37000, speed = 52, acceleration = 42, brakes = 47, hp = 62, numemasina = "Mercedes V Class", maxspeed= 210, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "cls2015m", price = 48000, speed = 62, acceleration = 52, brakes = 47, hp = 72, numemasina = "Mercedes Benz CLS", maxspeed= 260, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "mlbrabus", price = 57000, speed = 62, acceleration = 50, brakes = 50, hp = 75, numemasina = "ML Brabus", maxspeed= 260, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "e63amg", price = 55000, speed = 70, acceleration = 60, brakes = 65, hp = 80, numemasina = "Mercedes Benz E63 AMG", maxspeed= 280, maxspeedbar = 91, tip = 'Mercedes-Benz'},
        },
    
        [7] = {
        tablename = 'Volkswagen',
           {numeVehicul = "golfmk3", price = 3000, speed = 40, acceleration = 30, brakes = 35, hp = 50, numemasina = "Golf MK3", maxspeed= 170, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "golfgti", price = 5500, speed = 50, acceleration = 40, brakes = 45, hp = 60, numemasina = "Golf 5 GTI", maxspeed= 200, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "passat", price = 21000, speed = 54, acceleration = 44, brakes = 49, hp = 64, numemasina = "Volkswagen Passat", maxspeed= 220, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "R50", price = 15000, speed = 54, acceleration = 46, brakes = 52, hp = 67, numemasina = "Volkswagen Tuareg", maxspeed= 220, maxspeedbar = 91, tip = 'Volkswagen'},
        }, 

        [8] = {
        tablename = 'Bentley',
            {numeVehicul = "bentaygast", price = 120000, speed = 56, acceleration = 46, brakes = 51, hp = 66, numemasina = "Bentley Bentayga", maxspeed= 240, maxspeedbar = 91, tip = 'Bentley'},
            {numeVehicul = "bengt2012", price = 150000, speed = 70, acceleration = 60, brakes = 65, hp = 80, numemasina = "Bentley Continental GT", maxspeed= 280, maxspeedbar = 91, tip = 'Bentley'},
            {numeVehicul = "rmodbentley1", price = 180000, speed = 65, acceleration = 55, brakes = 60, hp = 75, numemasina = "Bentley NO1 RMOD", maxspeed= 260, maxspeedbar = 91, tip = 'Bentley'},           
        }, 
        
        [9] = {
        tablename = 'Lexus',
            {numeVehicul = "IS200T", price = 38000, speed = 54, acceleration = 44, brakes = 49, hp = 64, numemasina = "Lexus IS200T", maxspeed= 220, maxspeedbar = 91, tip = 'Lexus'},
            {numeVehicul = "wald2018", price = 47000, speed = 60, acceleration = 50, brakes = 55, hp = 70, numemasina = "Lexus LX 570 Wald", maxspeed= 240, maxspeedbar = 91, tip = 'Lexus'},
            {numeVehicul = "gs350", price = 50000, speed = 70, acceleration = 60, brakes = 65, hp = 80, numemasina = "Lexus GS 350", maxspeed= 280, maxspeedbar = 91, tip = 'Lexus'},    
        }, 
        
        [10] = {
        tablename = 'Toyota',
            {numeVehicul = "vxr", price = 39000, speed = 54, acceleration = 44, brakes = 49, hp = 64, numemasina = "Toyota Land Cruiser", maxspeed= 220, maxspeedbar = 91, tip = 'Toyota'},
            {numeVehicul = "supra2", price = 43000, speed = 80, acceleration = 70, brakes = 75, hp = 80, numemasina = "Toyota Supra", maxspeed= 320, maxspeedbar = 91, tip = 'Toyota'},
        },
        
        [11] = {
        tablename = 'Porsche',          
            {numeVehicul = "pcs18", price = 90000, speed = 56, acceleration = 46, brakes = 51, hp = 66, numemasina = "Porsche Cayenne", maxspeed= 240, maxspeedbar = 91, tip = 'Porsche'},
            {numeVehicul = "pts21", price = 94000, speed = 56, acceleration = 48, brakes = 48, hp = 68, numemasina = "Porsche 911 Turbo S", maxspeed= 240, maxspeedbar = 91, tip = 'Porsche'},
            {numeVehicul = "panamera17turbo", price = 50000, speed = 75, acceleration = 65, brakes = 70, hp = 85, numemasina = "Porsche Panamera", maxspeed= 300, maxspeedbar = 91, tip = 'Porsche'},
        },
        
        [12] = {
        tablename = 'Nissan',                       
            {numeVehicul = "patroly60", price = 13500, speed = 46, acceleration = 36, brakes = 41, hp = 56, numemasina = "Nissan Patrol", maxspeed= 180, maxspeedbar = 91, tip = 'Nissan'},
            {numeVehicul = "rmodz350pandem", price = 35000, speed = 56, acceleration = 46, brakes = 51, hp = 66, numemasina = "Nissan 350Z RMOD", maxspeed= 240, maxspeedbar = 91, tip = 'Nissan'},
            {numeVehicul = "gtrnismo17", price = 70000, speed = 80, acceleration = 70, brakes = 75, hp = 90, numemasina = "Nissan GTR Nismo", maxspeed= 320, maxspeedbar = 91, tip = 'Nissan'},
        },
        
        [13] = {
        tablename = 'Mazda',                  
            {numeVehicul = "fd3s", price = 38000, speed = 52, acceleration = 42, brakes = 47, hp = 62, numemasina = "Mazda RX7", maxspeed= 210, maxspeedbar = 91, tip = 'Mazda'},
            {numeVehicul = "mx5", price = 35000, speed = 54, acceleration = 44, brakes = 49, hp = 64, numemasina = "Mazda MX5", maxspeed= 220, maxspeedbar = 91, tip = 'Mazda'},
            {numeVehicul = "mz3", price = 45000, speed = 56, acceleration = 46, brakes = 51, hp = 66, numemasina = "Mazda Speed 3", maxspeed= 230, maxspeedbar = 91, tip = 'Mazda'},
        },
        
        [14] = {
        tablename = 'Ford',                       
            {numeVehicul = "f15078", price = 20000, speed = 44, acceleration = 34, brakes = 39, hp = 54, numemasina = "Ford F150", maxspeed= 160, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "19Raptor", price = 67000, speed = 50, acceleration = 40, brakes = 45, hp = 60, numemasina = "Ford Raptor", maxspeed= 200, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "st", price = 50000, speed = 54, acceleration = 44, brakes = 50, hp = 64, numemasina = "Ford Focus", maxspeed= 240, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "mach1", price = 44000, speed = 56, acceleration = 46, brakes = 52, hp = 66, numemasina = "Ford Mustang Mach", maxspeed= 260, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "19gt500", price = 70000, speed = 60, acceleration = 50, brakes = 55, hp = 70, numemasina = "Ford Mustang Shelby GT500", maxspeed= 280, maxspeedbar = 91, tip = 'Ford'},
        },
        
        [15] = {
        tablename = 'Ferrari',                     
            {numeVehicul = "enzo", price = 130000, speed = 80, acceleration = 70, brakes = 75, hp = 90, numemasina = "Ferrari Enzo", maxspeed= 320, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "f812", price = 90000, speed = 84, acceleration = 74, brakes = 79, hp = 94, numemasina = "Ferrari 812", maxspeed= 340, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "rmodf12tdf", price = 95000 , speed = 75, acceleration = 65, brakes = 70, hp = 85, numemasina = "Ferrari F12 RMOD", maxspeed= 300, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "rmodf40", price = 110000, speed = 75, acceleration = 67, brakes = 72, hp = 87, numemasina = "Ferrari F40 RMOD", maxspeed= 300, maxspeedbar = 91, tip = 'Ferrari'},
        },
        
        [16] = {
            tablename = 'Lamborghini',                        
                {numeVehicul = "urus", price = 160000, speed = 68, acceleration = 58, brakes = 63, hp = 78, numemasina = "Lamborghini Urus", maxspeed= 320, maxspeedbar = 91, tip = 'Lamborghini'},
                {numeVehicul = "lp700r", price = 200000, speed = 84, acceleration = 74, brakes = 79, hp = 94, numemasina = "Lamborghini Aventador LP700", maxspeed= 340, maxspeedbar = 91, tip = 'Lamborghini'},
                {numeVehicul = "rmodveneno", price = 150000, speed = 84, acceleration = 75, brakes = 80, hp = 95, numemasina = "Lamborghini Veneno", maxspeed= 340, maxspeedbar = 91, tip = 'Lamborghini'},
                {numeVehicul = "sesto", price = 200000, speed = 84, acceleration = 77, brakes = 82, hp = 94, numemasina = "Lamborghini Sesto Elemento", maxspeed= 340, maxspeedbar = 91, tip = 'Lamborghini'},
            },
            
            [17] = {
            tablename = 'Bugatti',                      
                {numeVehicul = "chiron17", price = 300000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Bugatti Chiron", maxspeed= 360, maxspeedbar = 91, tip = 'Bugatti'},
                {numeVehicul = "bdivo", price = 280000, speed = 90, acceleration = 82, brakes = 87, hp = 99, numemasina = "Bugatti Divo", maxspeed= 360, maxspeedbar = 91, tip = 'Bugatti'},
            },
    
            [18] = {
                tablename = 'Dodge',                      
                    {numeVehicul = "12charger", price = 40000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Dodge Charger HellCat", maxspeed= 360, maxspeedbar = 91, tip = 'Dodge'},
                },

            [19] = {
                tablename = 'Motoare',                      
                    {numeVehicul = "450crf", price = 7000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Honda CRF", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "d99", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Ducati 1199", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "diavel", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Ducati Diavel", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "dm1200", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Ducati DM1200", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "f4rr", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Ducati XR", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "hexer", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Harley Davidson Hexer", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "nh2r", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Kawasaki Ninja", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "r1", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Yamaha R1", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "r6", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Yamaha R6", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "z1000", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Kawasaki Z1000", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "yz450", price = 10000, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "ATV Monster", maxspeed= 360, maxspeedbar = 91, tip = 'Motor'},
                },
        
        [20] = {
        tablename = 'Masini VIP',
        
            {numeVehicul = "rmodpagani", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Pagani RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SILVER'},
            {numeVehicul = "dawnonyx", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Rolls Royce Dawn Onyx", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SILVER'},
            {numeVehicul = "rmodmustang", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Ford Mustang RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SILVER'},
                
            {numeVehicul = "rmodcamaro", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Chevrolet Camaro RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP GOLD'},
            {numeVehicul = "rmodmartin", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Aston Martin RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP GOLD'},
            {numeVehicul = "rmodfordgt", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Ford GT RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP GOLD'},
                
            {numeVehicul = "benzsl63", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Mercedes Benz SL63 RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP DIAMOND'},
            {numeVehicul = "rmodjeep", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Jeep Grand Cherokee RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP DIAMOND'},
            {numeVehicul = "rmodcharger69", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Dodge Charger 1969 RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP DIAMOND'},
                
            {numeVehicul = "rmodspeed", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "McLaren Speed RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SUPREME'},
            {numeVehicul = "rmodbolide", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Bugatti Bolide RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SUPREME'},
            {numeVehicul = "rmodm4", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "BMW M4 RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SUPREME'},
            {numeVehicul = "rmodquadra", price = 1, speed = 66, acceleration = 59, brakes = 55, hp = 73, numemasina = "Quadra Turbo-R RMOD", maxspeed= 280, maxspeedbar = 91, tip = 'VIP SUPREME'},
        },
        [21] = {
            tablename = 'Joburi',
            
            {numeVehicul = "packer", price = 100000, speed = 25, acceleration = 15, brakes = 20, hp = 35, numemasina = "Tir Personal", maxspeed= 100, maxspeedbar = 91, tip = 'Joburi'},

            },            
}
    



Citizen.CreateThread(function()
    while true do
        Wait(350)
        while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpenShowroom)) <= 5  do
            Wait(0)
            if inShowroom ~= true then
                text = "Apasa ~INPUT_CONTEXT~ pentru intra in showroom"
                HelpText(text)
                if ( IsControlJustReleased(0,51) )then
                    openShowroom()
                end
            end
        end
    end
end)


-- function CreationCamHead(part)
--     if camHacks[part] ~= nil then
--         cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

--         local coordsCam = GetOffsetFromEntityInWorldCoords(PlayerPedId(), camHacks[part].offsetX, camHacks[part].offsetY,camHacks[part].offsetZ)
--         local coordsPly = GetEntityCoords(PlayerPedId())
--         SetCamCoord(cam, coordsCam)
--         PointCamAtCoord(cam, coordsPly['x']+camHacks[part].pointCamAtCoordX, coordsPly['y']+camHacks[part].pointCamAtCoordY, coordsPly['z']+camHacks[part].pointCamAtCoordZ)

--         SetCamActive(cam, true)
--         RenderScriptCams(true, true, 500, true, true)
--     else
--         print('====================================================================')
--         print('[SHOWROOM] EROARE LA COMANDA CreationCamHead(). PARTEA ESTE invalida! ')
--         print('====================================================================')
--     end
-- end

function CreationCamHead(part)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coordonateInShowroom[1],coordonateInShowroom[2]-6.0,coordonateInShowroom[3]+1.3)
    RenderScriptCams(1, 0, 0, 1, 1)
    DisplayRadar(false)
end

local categoriile = {}
function openShowroom()
    inShowroom = true
    SetEntityCoords(GetPlayerPed(-1), 227.95265197754,-991.97448730469,-98.999984741211)
    SetEntityVisible(GetPlayerPed(-1), false)
    Wait(100) -- IMPORTANT, LASA-L AICI DETAH CA POATE IAR FUTI CEVA!!!
    SetNuiFocus(true, true)
    CreationCamHead()
    for k,v in pairs (vehicles) do
        table.insert(categoriile,'<button onclick="schimbaCategoria('..k..')" class="button">'..v.tablename..' </button>')
        -- table.insert(categoriile,'<a onclick="schimbaCategoria('..k..')">'..v.tablename..'</a>')
    end
    SendNUIMessage({
        action = "deschideShowroomlolxd",
        -- categorii = categoriile
    })
    SendNUIMessage({
        act = "adaugaCategori",
        categorii = categoriile,
        stil = 'inline-block'
    })
end

RegisterNUICallback('goBack', function(data,cb)
    if inShowroom == true then
        SendNUIMessage({
            act = "adaugaCategori",
            categorii = categoriile,
            stil = 'inline-block'
        })
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        DeleteEntity(rablactuala)
    end
end)

local vehiculele = {}
RegisterNUICallback('changeCategory', function(data,cb)
    categorie = data.categorieSelectata
    if #vehiculele == 0 then
        adaugaMasinileInShowroom()
    else
        for k in pairs(vehiculele) do
            vehiculele[k] = nil
        end
        adaugaMasinileInShowroom()
    end
end)

RegisterNUICallback('spawnVehicle', function(data,cb)
    selectie = data.idSelectie
    spawnRablament(vehicles[categorie][selectie].numeVehicul)
end)

function adaugaMasinileInShowroom()
    SendNUIMessage({
        act = "adaugaCategori",
        categori = categoriile,
        stil = 'none'
    })
    for k,v in pairs(vehicles) do
        if categorie == k then
            for i,p in pairs(v) do
                if p.numeVehicul ~= nil then
                    if vehiculele ~= nil then
                        insert = '<button onclick="spawnMasina('..i..')" class="button">'..p.numemasina..'</button>'
                        table.insert(vehiculele,insert)
                    end
                end
            end
        end
    end
    SendNUIMessage({
        action = "adaugaMasinile",
        masinile = vehiculele
    })
end

function spawnRablament(model)
    RequestModel(model)
    local timpfake = 0
    while not HasModelLoaded(model) and timpfake < 500 do
        Wait(0)
        SetNuiFocus(false, false)
        timpfake = timpfake + 1
    end
    SetNuiFocus(true, true)
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    if rablactuala == nil then
        local nveh = CreateVehicle(model, 227.95265197754,-991.97448730469,-98.999984741211+1.5, 220.0, false, false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleEngineOn(nveh,false,false,0)
        SetVehicleDirtLevel(nveh,0.0)
    else
        DeleteEntity(rablactuala)
        local nveh = CreateVehicle(model, 227.95265197754,-991.97448730469,-98.999984741211+1.5, 220.0, false, false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleEngineOn(nveh,false,true,true)
        SetVehicleDirtLevel(nveh,0.0)
    end
    maxspeed = math.floor(GetVehicleModelMaxSpeed(GetHashKey(vehicles[categorie][selectie].numeVehicul))*3.6)
    SendNUIMessage({
        action = "adaugaInfoDespremasina",
        numemasina = vehicles[categorie][selectie].numemasina,
        pret = vehicles[categorie][selectie].price,
        hp = vehicles[categorie][selectie].hp,
        acceleration = vehicles[categorie][selectie].acceleration,
        brakes = vehicles[categorie][selectie].brakes,
        -- maxspeed = vehicles[categorie][selectie].maxspeed,
        maxspeed = maxspeed,
        maxspeedbar = vehicles[categorie][selectie].maxspeedbar,
        tipvehicul = vehicles[categorie][selectie].tip,
    })
end


RegisterNUICallback('exitshowroom', function(data, cb)
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    DisplayRadar(true)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)
    inShowroom = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpenShowroom))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(vehiculele) do
        vehiculele[k] = nil
    end
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end)

RegisterNUICallback('schimbaCuloare', function(data, cb)
    if inShowroom == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        if data.culoareselectata == 1 then
            r,g,b,r2,g2,b2 = 255, 255, 255, 0,0,0
        elseif data.culoareselectata == 2 then
            r,g,b,r2,g2,b2 = 0, 0, 0, 0,0,0
        elseif data.culoareselectata == 3 then
            r,g,b,r2,g2,b2 = 78, 78, 78, 0,0,0
        elseif data.culoareselectata == 4 then
            r,g,b,r2,g2,b2 = 255, 251, 0, 0,0,0
        elseif data.culoareselectata == 5 then
            r,g,b,r2,g2,b2 = 0, 255, 0, 0,0,0
        elseif data.culoareselectata == 6 then
            r,g,b,r2,g2,b2 = 194, 30, 30, 0,0,0
        elseif data.culoareselectata == 7 then
            r,g,b,r2,g2,b2 = 10, 101, 221, 0,0,0
        elseif data.culoareselectata == 8 then
            r,g,b,r2,g2,b2 = 200, 24, 171, 0,0,0
        elseif data.culoareselectata == 9 then
            r,g,b,r2,g2,b2 = 0, 247, 255, 0,0,0
        elseif data.culoareselectata == 10 then
            r,g,b,r2,g2,b2 = 86, 6, 110, 0,0,0
        elseif data.culoareselectata == 11 then
            r,g,b,r2,g2,b2 = 184, 132, 12, 0,0,0
        elseif data.culoareselectata == 12 then
            r,g,b,r2,g2,b2 = 255, 94, 0, 0,0,0
        end
        if rablactuala ~= nil then
            SetVehicleCustomPrimaryColour(rablactuala, r, g, b)
        end
    end
end)

RegisterNUICallback('schimbaHeading', function(data, cb)
    if inShowroom == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        if rablactuala ~= nil then
            SetEntityHeading(rablactuala, data.h+0.0 / 5)
        end
    end
end)

function getTuning()
    myveh = {}
    veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    SetVehicleModKit(veh,0)
    myveh.vehicle = veh
    myveh.plate = GetVehicleNumberPlateText(veh)
    myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
    myveh.modelhash = GetEntityModel(veh)
    r,g,b = GetVehicleCustomPrimaryColour(veh)
    r2,g2,b2 = GetVehicleCustomSecondaryColour(veh)
    myveh.color =  table.pack(r,g,b,r2,g2,b2)
    myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
    nr,ng,nb = GetVehicleNeonLightsColour(veh)
    myveh.neoncolor = table.pack(nr,ng,nb)
    myveh.neon = {}
    myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
    myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
    myveh.mods = {}
    for i = 0, 48 do
        myveh.mods[i] = {mod = nil}
    end
    for i,t in pairs(myveh.mods) do
        if i == 22 or i == 18 then
            if IsToggleModOn(veh,i) then
                t.mod = 1
            else
                t.mod = 0
            end
        elseif i == 23 or i == 24 then
            t.mod = GetVehicleMod(veh,i)
            t.variation = GetVehicleModVariation(veh, i)
        else
            t.mod = GetVehicleMod(veh,i)
        end
    end
    if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
        myveh.windowtint = false
    else
        myveh.windowtint = GetVehicleWindowTint(veh)
    end
    myveh.headlightscolor = GetVehicleHeadlightsColour(veh)
    myveh.wheeltype = GetVehicleWheelType(veh)
    myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)

    myveh.neon.left = IsVehicleNeonLightEnabled(veh,0)
    myveh.neon.right = IsVehicleNeonLightEnabled(veh,1)
    myveh.neon.front = IsVehicleNeonLightEnabled(veh,2)
    myveh.neon.back = IsVehicleNeonLightEnabled(veh,3)

    --Menu stuff
    local chassis,interior,bumper,fbumper,rbumper = false,false,false,false

    for i = 0,48 do
        if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
            if i == 1 then
                bumper = true
                fbumper = true
            elseif i == 2 then
                bumper = true
                rbumper = true
            elseif (i >= 42 and i <= 46) or i == 5 then
                chassis = true
            elseif i >= 27 and i <= 37 then
                interior = true
            end
        end
    end
    return myveh
end


RegisterNUICallback('cumparaMasina', function(data, cb)
    if inShowroom == true then
        tuning = getTuning()
        DisplayRadar(true)
        vRPshowroom.cumparaMasina({vehicles[categorie][selectie].numeVehicul,vehicles[categorie][selectie].price,selectie,categorie,tuning})
        inchideShowroom()
    end
end)

function inchideShowroom()
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    DisplayRadar(true)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SendNUIMessage({
        action = "inchideShowroom",
    })
    SetNuiFocus(false, false)
    inShowroom = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpenShowroom))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end

RegisterNUICallback('testeazaMasina', function(data, cb)
    if inShowroom == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        DeleteEntity(rablactuala)
        DestroyCam(cam, false)
        DisplayRadar(true)
        SetCamActive(cam, false)
        RenderScriptCams(0, false, 100, false, false)
        SetNuiFocus(false, false)
        SetEntityVisible(GetPlayerPed(-1), true)
        SendNUIMessage({
            action = "inchideShowroom"
        })
        local timp = 30
    
        Wait(10)

        spawntestvehicle()
        Wait(1000)
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        CreateThread(function()
            while true do
                Wait(1000)
                timp = timp - 1
                if timp == 0 or not IsPedInAnyVehicle(PlayerPedId(),false) then
                    DeleteEntity(rablactuala)
                    for k in pairs(categoriile) do
                        categoriile[k] = nil
                    end
                    openShowroom()
                    inTestDrive = false
                    spawnRablament(vehicles[categorie][selectie].numeVehicul)
                    break
                end
            end
        end)
    end
end)

function spawntestvehicle()
    inTestDrive = true
    DisplayRadar(true)
    local testcar = CreateVehicle(vehicles[categorie][selectie].numeVehicul, -911.39739990234,-3289.1572265625,13.944427490234+0.5, 130.0, true, false)
    SetPedIntoVehicle(GetPlayerPed(-1),testcar,-1)
    SetVehicleEngineOn(testcar,false,false,0)
    SetVehicleDirtLevel(testcar,0.0)
end


HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end