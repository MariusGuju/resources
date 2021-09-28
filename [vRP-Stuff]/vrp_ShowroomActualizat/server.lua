local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_showroom")
vRPCshowroom = Tunnel.getInterface("esk_showroom","esk_showroom")
vRPshowroom = {}
Tunnel.bindInterface("esk_showroom",vRPshowroom)
Proxy.addInterface("esk_showroom",vRPshowroom)


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

local function generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
  
	local number = ""
	for i=1,#format do
	  local char = string.sub(format, i,i)
	  if char == "D" then number = number..string.char(zbyte+math.random(0,9))
	  elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
	  else number = number..char end
	end
  
	return number
end  

function vRPshowroom.cumparaMasina(model,pret,selectie,categorie,tuning)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vehicles[categorie][selectie].numeVehicul == model then
        if vehicles[categorie][selectie].price == pret then
            
            exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = model}, function (haveCar)
                if #haveCar > 0 then
                    vRPclient.notify(player,{"Ai deja aceasta masina!"})
                else
                    if vRP.tryFullPayment({user_id,pret}) then
                        vRP.getUserIdentity({user_id, function(identity)
                        local plate = generateStringNumber("DDDLLL")
    

                            exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                ['@user_id'] = user_id,
                                ['@vehicle'] = model,
                                ['@upgrades'] = json.encode(tuning),
                                ['@vehicle_plate'] = "Liquid|Romania "..plate
                            }, function (rows) end)

                            
                            vRPclient.notify(player, {"Ai platit ~g~$"..pret.." pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                        end})
                    else
                        vRPclient.notify(player, {"~r~Nu ai suficienti bani"})
                    end
                end
            end)
        else
            vRPclient.notify(player,{"~r~[ERROR]Pretul acestei masini nu corespunde cu cel selectat! Contacteaza un fondator!"})
        end
    end
end