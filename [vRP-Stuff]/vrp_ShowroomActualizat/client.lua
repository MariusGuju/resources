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
            {numeVehicul = "tico", price = 2000000, speed = 25, acceleration = 15, brakes = 15, hp = 35, numemasina = "Tico", maxspeed= 95, maxspeedbar = 90, tip = 'Daewoo'},
        },
    
        [2] = {
        tablename = 'Dacia',
            {numeVehicul = "dacia1310", price = 5000000, speed = 25, acceleration = 25, brakes = 18, hp = 35, numemasina = "Dacia 1310", maxspeed= 165, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "logan2004", price = 6000000, speed = 32, acceleration = 29, brakes = 20, hp = 44, numemasina = "Dacia Logan", maxspeed= 165, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "loganmcv", price = 4000000, speed = 32, acceleration = 28, brakes = 19, hp = 42, numemasina = "Dacia Logan MCV", maxspeed= 145, maxspeedbar = 91, tip = 'Dacia'},
            {numeVehicul = "sandero21", price = 10000000, speed = 36, acceleration = 28, brakes = 18, hp = 46, numemasina = "Dacia Sandero", maxspeed= 195, maxspeedbar = 91, tip = 'Dacia'},
        },
    
        [3] = {
        tablename = 'Opel',
            {numeVehicul = "2004astra", price = 10000000, speed = 32, acceleration = 23, brakes = 17, hp = 42, numemasina = "Opel Astra", maxspeed= 190, maxspeedbar = 91, tip = 'Opel'},
        },
    
        [4] = {
        tablename = 'BMW',
            {numeVehicul = "e34", price = 15000000, speed = 46, acceleration = 25, brakes = 19, hp = 56, numemasina = "BMW E34", maxspeed= 190, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m3e46", price = 20000000, speed = 54, acceleration = 37, brakes = 27, hp = 64, numemasina = "BMW M3 E46", maxspeed= 235, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m5e60", price = 25000000, speed = 58, acceleration = 36, brakes = 28, hp = 68, numemasina = "BMW M5 E60", maxspeed= 250, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "x5mnou", price = 50000000, speed = 58, acceleration = 50, brakes = 30, hp = 70, numemasina = "BMW X5M", maxspeed= 325, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m5f90", price = 90000000, speed = 75, acceleration = 55, brakes = 50, hp = 85, numemasina = "BMW M5 F90", maxspeed= 300, maxspeedbar = 91, tip = 'BMW'},
            {numeVehicul = "m760li", price = 110000000, speed = 75, acceleration = 45, brakes = 35, hp = 83, numemasina = "BMW M760Li", maxspeed= 340, maxspeedbar = 91, tip = 'BMW'},
        },
    
        [5] = {
        tablename = 'Audi',
            {numeVehicul = "audia4", price = 15000000, speed = 46, acceleration = 29, brakes = 18, hp = 56, numemasina = "Audi A4", maxspeed= 215, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "q72012", price = 25000000, speed = 56, acceleration = 35, brakes = 26, hp = 66, numemasina = "Audi Q7", maxspeed= 260, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "q820", price = 35000000, speed = 58, acceleration = 40, brakes = 35, hp = 68, numemasina = "Audi Q8", maxspeed= 280, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "a8audi", price = 30000000, speed = 62, acceleration = 30, brakes = 25, hp = 72, numemasina = "Audi A8", maxspeed= 270, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "aaq4", price = 50000000, speed = 70, acceleration = 35, brakes = 30, hp = 80, numemasina = "Audi A4 ABT", maxspeed= 310, maxspeedbar = 91, tip = 'Audi'},
            {numeVehicul = "rs5r", price = 75000000, speed = 75, acceleration = 55, brakes = 60, hp = 85, numemasina = "Audi RS5", maxspeed= 325, maxspeedbar = 91, tip = 'Audi'},
        },
    
        [6] = {
        tablename = 'Mercedes-Benz',
            {numeVehicul = "w210", price = 15000000, speed = 50, acceleration = 25, brakes = 35, hp = 60, numemasina = "Mercedes Benz E420", maxspeed= 220, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "v250", price = 18000000, speed = 52, acceleration = 50, brakes = 45, hp = 62, numemasina = "Mercedes V Class", maxspeed= 235, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "cls2015m", price = 90000000, speed = 62, acceleration = 60, brakes = 45, hp = 72, numemasina = "Mercedes Benz CLS", maxspeed= 380, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "mlbrabus", price = 50000000, speed = 62, acceleration = 35, brakes = 35, hp = 75, numemasina = "ML Brabus", maxspeed= 285, maxspeedbar = 91, tip = 'Mercedes-Benz'},
            {numeVehicul = "e63amg", price = 65000000, speed = 70, acceleration = 30, brakes = 30, hp = 80, numemasina = "Mercedes Benz E63 AMG", maxspeed= 320, maxspeedbar = 91, tip = 'Mercedes-Benz'},
        },
    
        [7] = {
        tablename = 'Volkswagen',
           {numeVehicul = "golfmk3", price = 15000000, speed = 40, acceleration = 25, brakes = 35, hp = 50, numemasina = "Golf MK3", maxspeed= 200, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "golfgti", price = 20000000, speed = 50, acceleration = 25, brakes = 20, hp = 60, numemasina = "Golf 5 GTI", maxspeed= 240, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "passat", price = 45000000, speed = 54, acceleration = 35, brakes = 40, hp = 64, numemasina = "Volkswagen Passat", maxspeed= 320, maxspeedbar = 91, tip = 'Volkswagen'},
           {numeVehicul = "R50", price = 35000000, speed = 54, acceleration = 30, brakes = 40, hp = 67, numemasina = "Volkswagen Tuareg", maxspeed= 290, maxspeedbar = 91, tip = 'Volkswagen'},
        }, 

        [8] = {
        tablename = 'Bentley',
            {numeVehicul = "bentaygast", price = 95000000, speed = 56, acceleration = 45, brakes = 30, hp = 66, numemasina = "Bentley Bentayga", maxspeed= 350, maxspeedbar = 91, tip = 'Bentley'},
            {numeVehicul = "bengt2012", price = 70000000, speed = 70, acceleration = 45, brakes = 30, hp = 80, numemasina = "Bentley Continental GT", maxspeed= 340, maxspeedbar = 91, tip = 'Bentley'},
            {numeVehicul = "rmodbentley1", price = 85000000, speed = 65, acceleration = 50, brakes = 50, hp = 75, numemasina = "Bentley NO1 RMOD", maxspeed= 340, maxspeedbar = 91, tip = 'Bentley'},           
        }, 
        
        [9] = {
        tablename = 'Lexus',
            {numeVehicul = "IS200T", price = 35000000, speed = 54, acceleration = 30, brakes = 50, hp = 64, numemasina = "Lexus IS200T", maxspeed= 300, maxspeedbar = 91, tip = 'Lexus'},
            {numeVehicul = "gs350", price = 20000000, speed = 70, acceleration = 45, brakes = 60, hp = 80, numemasina = "Lexus GS 350", maxspeed= 255, maxspeedbar = 91, tip = 'Lexus'},    
        }, 
        
        [10] = {
        tablename = 'Toyota',
            {numeVehicul = "vxr", price = 30000000, speed = 54, acceleration = 40, brakes = 35, hp = 64, numemasina = "Toyota Land Cruiser", maxspeed= 250, maxspeedbar = 91, tip = 'Toyota'},
            {numeVehicul = "supra2", price = 60000000, speed = 80, acceleration = 55, brakes = 40, hp = 80, numemasina = "Toyota Supra", maxspeed= 255, maxspeedbar = 91, tip = 'Toyota'},
        },
        
        [11] = {
        tablename = 'Porsche',          
            {numeVehicul = "pcs18", price = 60000000, speed = 56, acceleration = 45, brakes = 51, hp = 60, numemasina = "Porsche Cayenne", maxspeed= 335, maxspeedbar = 91, tip = 'Porsche'},
            {numeVehicul = "pts21", price = 80000000, speed = 56, acceleration = 45, brakes = 48, hp = 35, numemasina = "Porsche 911 Turbo S", maxspeed= 345, maxspeedbar = 91, tip = 'Porsche'},
            {numeVehicul = "panamera17turbo", price = 130000000, speed = 75, acceleration = 55, brakes = 55, hp = 85, numemasina = "Porsche Panamera", maxspeed= 405, maxspeedbar = 91, tip = 'Porsche'},
        },
        
        [12] = {
        tablename = 'Nissan',                       
            {numeVehicul = "patroly60", price = 15000000, speed = 46, acceleration = 30, brakes = 50, hp = 56, numemasina = "Nissan Patrol", maxspeed= 210, maxspeedbar = 91, tip = 'Nissan'},
            {numeVehicul = "rmodz350pandem", price = 120000000, speed = 56, acceleration = 35, brakes = 40, hp = 66, numemasina = "Nissan 350Z RMOD", maxspeed= 415, maxspeedbar = 91, tip = 'Nissan'},
            {numeVehicul = "gtrnismo17", price = 105000000, speed = 80, acceleration = 65, brakes = 50, hp = 90, numemasina = "Nissan GTR Nismo", maxspeed= 370, maxspeedbar = 91, tip = 'Nissan'},
        },
        
        [13] = {
        tablename = 'Mazda',                  
            {numeVehicul = "fd3s", price = 35000000, speed = 52, acceleration = 45, brakes = 60, hp = 62, numemasina = "Mazda RX7", maxspeed= 295, maxspeedbar = 91, tip = 'Mazda'},
            {numeVehicul = "mx5", price = 30000000, speed = 54, acceleration = 40, brakes = 50, hp = 64, numemasina = "Mazda MX5", maxspeed= 290, maxspeedbar = 91, tip = 'Mazda'},
            {numeVehicul = "mz3", price = 15000000, speed = 56, acceleration = 35, brakes = 45, hp = 66, numemasina = "Mazda Speed 3", maxspeed= 245, maxspeedbar = 91, tip = 'Mazda'},
        },
        
        [14] = {
        tablename = 'Ford',                       
            {numeVehicul = "f15078", price = 15000000, speed = 44, acceleration = 40, brakes = 55, hp = 54, numemasina = "Ford F150", maxspeed= 185, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "19Raptor", price = 30000000, speed = 50, acceleration = 47, brakes = 60, hp = 60, numemasina = "Ford Raptor", maxspeed= 245, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "st", price = 25000000, speed = 54, acceleration = 40, brakes = 55, hp = 64, numemasina = "Ford Focus", maxspeed= 255, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "mach1", price = 1100000000, speed = 56, acceleration = 40, brakes = 70, hp = 66, numemasina = "Ford Mustang Mach", maxspeed= 400, maxspeedbar = 91, tip = 'Ford'},
            {numeVehicul = "19gt500", price = 95000000, speed = 60, acceleration = 45, brakes = 40, hp = 70, numemasina = "Ford Mustang Shelby GT500", maxspeed= 385, maxspeedbar = 91, tip = 'Ford'},
        },
        
        [15] = {
        tablename = 'Ferrari',                     
            {numeVehicul = "enzo", price = 900000000, speed = 80, acceleration = 65, brakes = 65, hp = 90, numemasina = "Ferrari Enzo", maxspeed= 370, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "f812", price = 110000000, speed = 84, acceleration = 60, brakes = 65, hp = 94, numemasina = "Ferrari 812", maxspeed= 390, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "rmodf12tdf", price = 70000000 , speed = 75, acceleration = 55, brakes = 60, hp = 85, numemasina = "Ferrari F12 RMOD", maxspeed= 345, maxspeedbar = 91, tip = 'Ferrari'},
            {numeVehicul = "rmodf40", price = 85000000, speed = 75, acceleration = 60, brakes = 75, hp = 87, numemasina = "Ferrari F40 RMOD", maxspeed= 360, maxspeedbar = 91, tip = 'Ferrari'},
        },
        
        [16] = {
            tablename = 'Lamborghini',                        
                {numeVehicul = "urus", price = 75000000, speed = 68, acceleration = 58, brakes = 63, hp = 78, numemasina = "Lamborghini Urus", maxspeed= 380, maxspeedbar = 91, tip = 'Lamborghini'},
                {numeVehicul = "lp700r", price = 85000000, speed = 84, acceleration = 60, brakes = 79, hp = 94, numemasina = "Lamborghini Aventador LP700", maxspeed= 370, maxspeedbar = 91, tip = 'Lamborghini'},
                {numeVehicul = "rmodveneno", price = 140000000, speed = 84, acceleration = 75, brakes = 50, hp = 95, numemasina = "Lamborghini Veneno", maxspeed= 410, maxspeedbar = 91, tip = 'Lamborghini'},
           
            },
            
            [17] = {
            tablename = 'Bugatti',                      
                {numeVehicul = "chiron17", price = 115000000, speed = 90, acceleration = 70, brakes = 50, hp = 97, numemasina = "Bugatti Chiron", maxspeed= 400, maxspeedbar = 91, tip = 'Bugatti'},
                {numeVehicul = "bdivo", price = 140000000, speed = 90, acceleration = 45, brakes = 50, hp = 99, numemasina = "Bugatti Divo", maxspeed= 445, maxspeedbar = 91, tip = 'Bugatti'},
            },
    
            [18] = {
                tablename = 'Dodge',                      
                    {numeVehicul = "12charger", price = 55000000, speed = 90, acceleration = 50, brakes = 75, hp = 97, numemasina = "Dodge Charger HellCat", maxspeed= 280, maxspeedbar = 91, tip = 'Dodge'},
                },

            [19] = {
                tablename = 'Motoare',                      
                    {numeVehicul = "450crf", price = 10000000, speed = 90, acceleration = 35, brakes = 85, hp = 97, numemasina = "Honda CRF", maxspeed= 235, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "d99", price = 25000000, speed = 90, acceleration = 65, brakes = 85, hp = 97, numemasina = "Ducati 1199", maxspeed= 340, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "diavel", price = 20000000, speed = 90, acceleration = 55, brakes = 85, hp = 97, numemasina = "Ducati Diavel", maxspeed= 305, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "dm1200", price = 35000000, speed = 90, acceleration = 55, brakes = 85, hp = 97, numemasina = "Ducati DM1200", maxspeed= 375, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "f4rr", price = 30000000, speed = 90, acceleration = 65, brakes = 85, hp = 97, numemasina = "Ducati XR", maxspeed= 370, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "hexer", price = 20000000, speed = 90, acceleration = 55, brakes = 85, hp = 97, numemasina = "Harley Davidson Hexer", maxspeed= 270, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "nh2r", price = 40000000, speed = 90, acceleration = 70, brakes = 85, hp = 97, numemasina = "Kawasaki Ninja", maxspeed= 385, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "r1", price = 50000000, speed = 90, acceleration = 90, brakes = 85, hp = 97, numemasina = "Yamaha R1", maxspeed= 450, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "r6", price = 25000000, speed = 90, acceleration = 65, brakes = 85, hp = 97, numemasina = "Yamaha R6", maxspeed= 320, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "z1000", price = 15000000, speed = 90, acceleration = 50, brakes = 85, hp = 97, numemasina = "Kawasaki Z1000", maxspeed= 310, maxspeedbar = 91, tip = 'Motor'},
                    {numeVehicul = "yz450", price = 10000000, speed = 90, acceleration = 40, brakes = 85, hp = 97, numemasina = "ATV Monster", maxspeed= 225, maxspeedbar = 91, tip = 'Motor'},
                },
        
        [20] = {
        tablename = 'Masini VIP',
        {numeVehicul = "rmodcharger69", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Dodge Charger R/T 69", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Bronze'},
        {numeVehicul = "rmodquadra", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Quadra Turbo-R RMOD", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Bronze'},

        {numeVehicul = "benzsl63", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Mercedes-AMG SL63", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Silver'},
        {numeVehicul = "rmodmustang", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Mustang", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Silver'},
        {numeVehicul = "rmodbolide", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Bugatti Bolide RMOD", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Silver'},

        {numeVehicul = "dawnonyx", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Rolls Royce Dawn Onyx", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Gold'},
        {numeVehicul = "rmodm4", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "BMW M4 RaijinBodykit", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Gold'},
        {numeVehicul = "rmodfordgt", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Ford GT", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Gold'},
        {numeVehicul = "rmodpagani", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Pagani", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Gold'},

        {numeVehicul = "rmodjeep", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Jeep", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},
        {numeVehicul = "rmodspeed", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "McLaren", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},
        {numeVehicul = "rmodcamaro", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Chevrolet Camaro RMOD", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},
        {numeVehicul = "rmodmartin", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Martin RMOD", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},
        {numeVehicul = "dawnonyx", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Rolls Royce Dawn Onyx", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},
        {numeVehicul = "rmodrs7spoiler", price = 1, speed = 90, acceleration = 80, brakes = 85, hp = 97, numemasina = "Audi RS7", maxspeed= 360, maxspeedbar = 91, tip = 'Vip Diamond'},


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