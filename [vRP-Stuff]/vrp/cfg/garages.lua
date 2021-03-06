
local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition 
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be sawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: vtype, blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.75 -- sell for 75% of the original price
--this is the limit amount that you can put when you are trying to sell your personall vehicle to another player
cfg.limit = 100000000


cfg.garage_types = {
  ["Fisher's Boat"] = {
    _config = {vtype="boat",blipid=427,blipcolor=28,permissions={"fisher.vehicle"}},
    ["suntrap"] = {"Fisher's boat",0, "Your favorite boat!"}
  },
  ["Low Budget"] = {
    _config = {vtype="car",blipid=50,blipcolor=40},  
  ["2004astra"] = {"Opel Astra J",3500, ""},
  ["ap2"] = {"Honda S2000 AP2 ",9000, ""},
  ["asea"] = {"VW Jetta 1998 ",2000, ""},
  ["asterope"] = {"Dacia Logan 2004 ",2100, ""},
  ["bmwe38"] = {"BMW Seria 7 e38",3500, ""},
  ["civic"] = {"Honda Civic 2000",2500, ""},
  ["corsa05"] = {"Opel Corsa 2005",2300, ""},
  ["daduster"] = {"Dacia Duster",7000, ""},
  ["ds4"] = {"Citroen DS4",6000, ""},
  ["fd"] = {"Mazda RX-7 Older",5500, ""},
  ["golfgti"] = {"VW Golf 5 GTI ",5800, ""},
  ["logan"] = {"Dacia Logan 2007 ",3000, ""},
  ["NA6"] = {"Mazda Miata MX-5 ",3000, ""},
  ["polo2018"] = {"Volkswagen Polo 2018  ",17000, ""},
  ["s600w220"] = {"Mercedes s600 W220",20000,""},
  ["sandero"] = {"Dacia Sandero",5000,""},
  ["sandero08"] = {"Dacia Sandero 08",5000,""},
  ["subwrx"] = {"Subaru WRX",7000, ""},
  ["tico"] = {"Subaru WRX",1100, ""},
  ["v242"] = {"Volvo V242",3200, ""},
  ["volvo850r"] = {"Volvo 850 R",4000, ""},
  ["x5e53"] = {"BMW x5 E53",10000, ""},

},
["Business"] = {
  _config = {vtype="car",blipid=50,blipcolor=26},  
  ["17m760i"] = {"BMW 760i",178000,""},
  ["a8fsi"] = {"Audi A8 2011",20000,""},
  ["contgt13"] = {"Bentley Continental 2013",75000,""},
  ["dzsb"] = {"Rollce Royce Phantom ",320000,""},
  ["intunder"] = {"Lincoln Continental",60000,""},
  ["passat"] = {"Volkswagen Passat B8 ",55000, ""},
  ["s500w222"] = {"Mercedes S500 W222 ",190000,""},
  ["wraith"] = {"Rollce Royce Wraith  ",330000,""},
  ["xfr"] = {"Jaguar XFR",35000,""},

}, --
["Family"] = {
  _config = {vtype="car",blipid=50,blipcolor=61},  
  ["a8audi"] = {"Audi A8 2008",13000,""},
  ["bmwe65"] = {"BMW Seria 7 e65 2006",7500,""},
  ["camry18"] = {"Toyota Camry 2018 ",25000,""},
  ["charger"] = {"Dodge Charger 2014 ",16000,""},
  ["exemplar"] = {"Hyundai Elantra  ",14000,""},
  ["felon"] = {"Chrysler Genesis G80",50000,""},
  ["ibiza"] = {"Seat Ibiza",28000,""},
  ["ody18"] = {"Honda Odyssey 2019 ",40000, ""},
  ["pacev"] = {"Renault Escape 2019 ",20000, ""},
  ["passatr"] = {"Volkswagen Passat B8 Break ",55000, ""},
  ["s60pole"] = {"Volvo S60",50000, ""},
  ["schafter6"] = {"Infinity Q50",40000, ""},
  ["tailgater"] = {"Ford Taurus ",30000, ""},
  ["tmodel"] = {"Tesla Model 3 ",45000, ""},
  ["v60"] = {"Volvo V60 ",45000, ""},

},
["Classic"] = {
  _config = {vtype="car",blipid=50,blipcolor=12},  
  ["69charger"] = {"Dodge Charger 69",90000, ""},
  ["belair"] = {"Chevy' Belair",25000, ""},
  ["buccaneer"] = {"Chevrolet Impala OLD SCHOOL",23000, ""},
  ["c10"] = {"Chevy' c10",28000, ""},
  ["casco"] = {"Ford Hot Rod",20000, ""},
  ["elenor"] = {"Ford Mustang GT500 Shelby 1967",97000, ""},
  ["emperor"] = {"Ford Crown Victoria 1980",9900, ""},
  ["fordh"] = {"Ford Mustang Hoonigan ",100000, ""},
  ["fugitive"] = {"Lada ",1400, ""},
  ["infernus"] = {"Ferrari Testarossa",150000, ""},
  ["mbw111"] = {"Mercedes Benz S220 w111",60000, ""},
  ["mgb"] = {"MGB GT",10000, ""},
  ["Nova"] = {"Chevrolet Nova  ",30000, ""},
  ["pstan48"] = {"Packard",50000, ""},
  ["rx3"] = {"Mazda RX3",20000, ""},
  ["s30"] = {"Nissan 240z",19500, ""},
  ["tbird"] = {"Ford Thunderbird",37000, ""},
 -- ["turbo33"] = {"Porsche turbo 930 ",111000, ""},
  --["vigero"] = {"Dodge Challanger ",111000, ""},

--Ford Hoonigan 
},
["SUV"] = {
  _config = {vtype="car",blipid=50,blipcolor=25},  
  ["18velar"] = {"Range Rover Velar",60000, ""},
  ["amarok"] = {"VW Amarok ",40000, ""},
  ["bentayga17"] = {" Bentley Bentayga",170000, ""},
  ["bjxl"] = {" Kia Sportage",30000, ""},
  ["Cavalcade2"] = {"Audi q7",70000, ""},
  ["cayenne"] = {"Porsche Cayenne",95000, ""},
  ["fpacehm"] = {"Jaguar F Pace SVR",70000, ""},
  ["fx50s"] = {"Infinity FX50s",24000, ""},
  ["g65"] = {"Mercedes G65",300000, ""},
  ["g65amg"] = {"Mercedes G65 AMG",320000, ""},
  ["gmcs"] = {"GMC Sierra 1500 ",45000, ""},
  ["gmcyd"] = {"GMC Yukon Denali ",69000, ""},
  ["gmt900escalade"] = {"Cadilac Escalade ",79000, ""},
  ["jeep2012"] = {"Jeep 2012 ",43000, ""},
  ["jeepreneg"] = {"Jeep Renegade ",40000, ""},
  ["levante"] = {"Maserati Levante  ",86000, ""},
  ["nagviagtor"] = {"Lincoln Navigator",86000, ""},
  ["patriot"] = {"Hummer H1",80000, ""},
  ["q30"] = {"Infiniti q30",45000, ""},
  ["quashqai16"] = {"Nissan Quashqai",40000, ""},
  ["rrst"] = {"Range Rover Sport",81000, ""},
  ["santafe"] = {"Hyundai SantaFe",27000, ""},
  ["srt8"] = {"Jeep SRT8",70000, ""},
  ["stelvio"] = {"Alfa Romeo Stelvio",45000, ""},
  ["titan17"] = {"Nissan Titan",30000, ""},
  ["trailcat"] = {"Jeep Trailcat",60000, ""},
  ["trhawk"] = {"Jeep Grand Cherokee S",50000, ""},
  ["x6m"] = {"BMW x6 M",99000, ""},
  ["jukonxl"] = {"GMC Yukon XL",55000, ""},


},
["VANS"] = {
  _config = {vtype="car",blipid=50,blipcolor=66},  
  ["kangoo"] = {"Renault Kangoo  ",7000, ""},
  ["v250"] = {"Mercedes V250  ",60000, ""},


  },
  ["SPORTS"] = {
    _config = {vtype="car",blipid=50,blipcolor=50},  
    ["a8audi"] = {"Audi A8 2008",13000,""},
    ["bmwe65"] = {"BMW Seria 7 e65 2006",7500,""},
    ["camry18"] = {"Toyota Camry 2018 ",25000,""},
    ["charger"] = {"Dodge Charger 2014 ",16000,""},
    ["exemplar"] = {"Hyundai Elantra  ",14000,""},
    ["felon"] = {"Chrysler Genesis G80",50000,""},
    ["ibiza"] = {"Seat Ibiza",28000,""},
    ["ody18"] = {"Honda Odyssey 2019 ",40000, ""},
    ["pacev"] = {"Renault Escape 2019 ",20000, ""},
    ["passatr"] = {"Volkswagen Passat B8 Break ",55000, ""},
    ["s60pole"] = {"Volvo S60",50000, ""},
    ["schafter6"] = {"Infinity Q50",40000, ""},
    ["tailgater"] = {"Ford Taurus ",30000, ""},
    ["tmodel"] = {"Tesla Model 3 ",45000, ""},
    ["v60"] = {"Volvo V60 ",45000, ""},
    ["4c"] = {"Alfa Romeo 4C",60000, ""},
    ["180sx"] = {"Nissan 180SX",6500, ""},
    ["370z"] = {"Nissan 370z",25000, ""},
    ["a45amg"] = {"Mercedes A45 AMG",60000,""},
    ["acr"] = {"Dodge Viper acr",120000, ""},
    ["180sx"] = {"Nissan 180SX",6500, ""},
    ["aqv"] = {"Alfa Romeo Giulia  ",45000, ""},
    ["audirs6tk"] = {"Audi RS6 TK ",100000, ""},
    ["audis8om"] = {"Audi S8",80000, ""},
    ["ben17"] = {"Bentley Continental GT",120000, ""},
    ["bmwm8"] = {"BMW M8",145000, ""},
    ["brz"] = {"Subaru BRZ",35000, ""},
    ["brzbn"] = {"Subaru BRZ v2",35500, ""},
    ["c7"] = {"Chevrolet Corvette (C7)",65000, ""},
    ["c8"] = {"Chevrolet Corvette (C8)",69000, ""},
    ["CATS"] = {"Cadilac CTS-V",60000, ""},
    ["cx75"] = {"Jaguar CX 75",60000, ""},
    ["e60"] = {"BMW M5 E60",6000, ""},
    ["evo9"] = {"MITSUBISHI LANCER EVO 9",24000, ""},
    ["f82"] = {"BMW M4 F82",75000, ""},
    ["f620"] = {"Maserati GranTurismo",78000, ""},
    ["f824slw"] = {"BMW M4 F82 SLW",78000, ""},
    ["fc3s"] = {"Mazda RX-7 FC3S",7500, ""},
    ["furoregt"] = {"Jaguar XKR-S GT",130000, ""},
    ["hondacivictr"] = {"Honda Type R",32888, ""},
    ["jackal"] = {"Subaru STi R",30000, ""},
    ["kiagt"] = {"Kia Stinger 2020",40000, ""},
    ["lc500"] = {"Lexus LC500",65000, ""},
    ["m2"] = {"BMW M2",60000, ""},
    ["m3"] = {"BMW M3",80000, ""},
    ["m6f13"] = {"BMW M6 F13",105000, ""},
    ["mb18"] = {"Mercedes Benz S63 AMG Cabrio",140000, ""},
    ["mgrantur2010"] = {"Maserati  GranTurismo  2010",50000, ""},
    ["miniroads"] = {"Mini Couper Roadester",15000, ""},
    ["models"] = {"Tesla Model S",90000, ""},
    ["p90d"] = {"Tesla Model P90 D",100000, ""},
    ["moss"] = {"Mercedes Benz SLR ",200000, ""},
    ["mustang19"] = {"Ford Mustang 19",50000, ""},
    ["rcf"] = {"Lexus RC F",65000, ""},
    ["rs6"] = {"Audi RS 6",90000, ""},
    ["rs6tk"] = {"Audi RS 6 TK",120000, ""},
    ["rs7"] = {"Audi RS 7",140000, ""},
    ["rs318"] = {"Audi RS 3 2018",70000, ""},
    ["rx8r"] = {"Mazda RX8 R",24000, ""},
    ["s5"] = {"Audi S5",65000, ""},
    ["skyline"] = {"Nissan Skyline",45000, ""},
    ["supra2"] = {"Toyota Supra",55000, ""},
    ["supraa90"] = {"Toyota Supra ",60000, ""},
    ["teslapd"] = {"Tesla PD-S1000 ",130000, ""},
    ["viper"] = {"Dodge Viper ",130000, ""},
    ["z4bmw"] = {"BMW Z4  ",60000, ""},
    ["zl12017"] = {"Chevrolet Camaro 2017 ",74000, ""},

  },
  ["Supercars"] = {
    _config = {vtype="car",blipid=50,blipcolor=54},  
    ["720s"] = {"McLaren 720s",299000, ""},
    ["2019chiron"] = {"Bugatti Chiron",2998000, ""},
    ["amv19"] = {"Aston Martin Vantage 2019",150000, ""},
    ["arv10"] = {"Audi R8 V10",214000, ""},
    ["ast"] = {"Aston Martin Vanquish DB9",350000, ""},
    ["bdivo"] = {"Bugatti Divo",5800000, ""},
    ["comet2"] = {"Porsche 718 Cayman S",130000, ""},
    ["db9v"] = {"Aston Martin DB9V Cabrio",130000, ""},
    ["f430s"] = {"Ferrari F430 S",160000, ""},
    ["f812"] = {"Ferrari F812",360000, ""},
    ["fct"] = {"Ferrari Califronia",360000, ""},
    ["filthynsx"] = {"Acura NSX",157000, ""},
    ["gto"] = {"Ferrari GTO ",145000, ""},
    ["gtr"] = {"Nissan GTR ",185000, ""},
    ["i8"] = {"BMW I8 ",169900, ""},
    ["lhuracan"] = {"Lamborghini Huracan ",320000, ""},
    ["lp770"] = {"Lamborghini Centenario 770 ",1900000, ""},
    ["mp412c"] = {"McLaren MP4 12C  ",260000, ""},
    ["p1"] = {"McLaren P1",500000, ""},
    ["p911r"] = {"Porsche 911r",420000, ""},
    ["r8ppi"] = {"Audi R8 PPI",120000, ""},
    ["senna"] = {"McLaren Senna ",700000, ""},
    ["spyker"] = {" Spyker C8 ",200000, ""},
    ["tr22"] = {"Tesla Roadster ",200000, ""},

    --Ferrari Testarossa
  },
["House Garage"] = {
  _config = {vtype="car",blipid=357,blipcolor=69},
  ["2004astra"] = {"Opel Astra J",3500, ""},
  ["packer"] = {"Tir personal",3500, ""},
  ["ap2"] = {"Honda S2000 AP2 ",9000, ""},
  ["asea"] = {"VW Jetta 1998 ",2000, ""},
  ["asterope"] = {"Dacia Logan 2004 ",2100, ""},
  ["bmwe38"] = {"BMW Seria 7 e38",3500, ""},
  ["civic"] = {"Honda Civic 2000",2500, ""},
  ["corsa05"] = {"Opel Corsa 2005",2300, ""},
  ["daduster"] = {"Dacia Duster",7000, ""},
  ["ds4"] = {"Citroen DS4",6000, ""},
  ["fd"] = {"Mazda RX-7 Older",5500, ""},
  ["golfgti"] = {"VW Golf 5 GTI ",5800, ""},
  ["logan"] = {"Dacia Logan 2007 ",3000, ""},
  ["NA6"] = {"Mazda Miata MX-5 ",3000, ""},
  ["polo2018"] = {"Volkswagen Polo 2018  ",17000, ""},
  ["s600w220"] = {"Mercedes s600 W220",20000,""},
  ["sandero"] = {"Dacia Sandero",5000,""},
  ["sandero08"] = {"Dacia Sandero 08",5000,""},
  ["subwrx"] = {"Subaru WRX",7000, ""},
  ["tico"] = {"Subaru WRX",1100, ""},
  ["v242"] = {"Volvo V242",3200, ""},
  ["volvo850r"] = {"Volvo 850 R",4000, ""},
  ["x5e53"] = {"BMW x5 E53",10000, ""},
  ["17m760i"] = {"BMW 760i",178000,""},
  ["a8fsi"] = {"Audi A8 2011",20000,""},
  ["contgt13"] = {"Bentley Continental 2013",75000,""},
  ["dzsb"] = {"Rollce Royce Phantom ",320000,""},
  ["intunder"] = {"Lincoln Continental",60000,""},
  ["passat"] = {"Volkswagen Passat B8 ",55000, ""},
  ["s500w222"] = {"Mercedes S500 W222 ",190000,""},
  ["wraith"] = {"Rollce Royce Wraith  ",330000,""},
  ["xfr"] = {"Jaguar XFR",35000,""},
  ["69charger"] = {"Dodge Charger 69",90000, ""},
  ["belair"] = {"Chevy' Belair",25000, ""},
  ["buccaneer"] = {"Chevrolet Impala OLD SCHOOL",23000, ""},
  ["c10"] = {"Chevy' c10",28000, ""},
  ["casco"] = {"Ford Hot Rod",20000, ""},
  ["elenor"] = {"Ford Mustang GT500 Shelby 1967",97000, ""},
  ["emperor"] = {"Ford Crown Victoria 1980",9900, ""},
  ["fordh"] = {"Ford Mustang Hoonigan ",100000, ""},
  ["fugitive"] = {"Lada ",1400, ""},
  ["infernus"] = {"Ferrari Testarossa",150000, ""},
  ["mbw111"] = {"Mercedes Benz S220 w111",60000, ""},
  ["mgb"] = {"MGB GT",10000, ""},
  ["Nova"] = {"Chevrolet Nova  ",30000, ""},
  ["pstan48"] = {"Packard",50000, ""},
  ["rx3"] = {"Mazda RX3",20000, ""},
  ["s30"] = {"Nissan 240z",19500, ""},
  ["tbird"] = {"Ford Thunderbird",37000, ""},
  ["turbo33"] = {"Porsche turbo 930 ",111000, ""},
  ["vigero"] = {"Dodge Challanger ", 90000, ""},

  ["18velar"] = {"Range Rover Velar",60000, ""},
  ["amarok"] = {"VW Amarok ",40000, ""},
  ["bentayga17"] = {" Bentley Bentayga",170000, ""},
  ["bjxl"] = {" Kia Sportage",30000, ""},
  ["Cavalcade2"] = {"Audi q7",70000, ""},
  ["cayenne"] = {"Porsche Cayenne",95000, ""},
  ["fpacehm"] = {"Jaguar F Pace SVR",70000, ""},
  ["fx50s"] = {"Infinity FX50s",24000, ""},
  ["g65"] = {"Mercedes G65",300000, ""},
  ["g65amg"] = {"Mercedes G65 AMG",320000, ""},
  ["gmcs"] = {"GMC Sierra 1500 ",45000, ""},
  ["gmcyd"] = {"GMC Yukon Denali ",69000, ""},
  ["gmt900escalade"] = {"Cadilac Escalade ",79000, ""},
  ["jeep2012"] = {"Jeep 2012 ",43000, ""},
  ["jeepreneg"] = {"Jeep Renegade ",40000, ""},
  ["levante"] = {"Maserati Levante  ",86000, ""},
  ["nagviagtor"] = {"Lincoln Navigator",86000, ""},
  ["patriot"] = {"Hummer H1",80000, ""},
  ["q30"] = {"Infiniti q30",45000, ""},
  ["quashqai16"] = {"Nissan Quashqai",40000, ""},
  ["rrst"] = {"Range Rover Sport",81000, ""},
  ["santafe"] = {"Hyundai SantaFe",27000, ""},
  ["srt8"] = {"Jeep SRT8",70000, ""},
  ["stelvio"] = {"Alfa Romeo Stelvio",45000, ""},
  ["titan17"] = {"Nissan Titan",30000, ""},
  ["trailcat"] = {"Jeep Trailcat",60000, ""},
  ["trhawk"] = {"Jeep Grand Cherokee S",50000, ""},
  ["x6m"] = {"BMW x6 M",99000, ""},
  ["jukonxl"] = {"GMC Yukon XL",55000, ""},
    ["kangoo"] = {"Renault Kangoo  ",7000, ""},
  ["v250"] = {"Mercedes V250  ",60000, ""},
  ["720s"] = {"McLaren 720s",299000, ""},
  ["2019chiron"] = {"Bugatti Chiron",2998000, ""},
  ["amv19"] = {"Aston Martin Vantage 2019",150000, ""},
  ["arv10"] = {"Audi R8 V10",214000, ""},
  ["ast"] = {"Aston Martin Vanquish DB9",350000, ""},
  ["bdivo"] = {"Bugatti Divo",5800000, ""},
  ["comet2"] = {"Porsche 718 Cayman S",130000, ""},
  ["db9v"] = {"Aston Martin DB9V Cabrio",130000, ""},
  ["f430s"] = {"Ferrari F430 S",160000, ""},
  ["f812"] = {"Ferrari F812",360000, ""},
  ["fct"] = {"Ferrari Califronia",360000, ""},
  ["filthynsx"] = {"Acura NSX",157000, ""},
  ["gto"] = {"Ferrari GTO ",145000, ""},
  ["gtr"] = {"Nissan GTR ",185000, ""},
  ["i8"] = {"BMW I8 ",169900, ""},
  ["lhuracan"] = {"Lamborghini Huracan ",320000, ""},
  ["lp770"] = {"Lamborghini Centenario 770 ",1900000, ""},
  ["mp412c"] = {"McLaren MP4 12C  ",260000, ""},
  ["p1"] = {"McLaren P1",500000, ""},
  ["p911r"] = {"Porsche 911r",420000, ""},
  ["r8ppi"] = {"Audi R8 PPI",120000, ""},
  ["senna"] = {"McLaren Senna ",700000, ""},
  ["spyker"] = {" Spyker C8 ",200000, ""},
  ["tr22"] = {"Tesla Roadster ",200000, ""},
  ["4c"] = {"Alfa Romeo 4C",60000, ""},
  ["180sx"] = {"Nissan 180SX",6500, ""},
  ["370z"] = {"Nissan 370z",25000, ""},
  ["a45amg"] = {"Mercedes A45 AMG",60000,""},
  ["acr"] = {"Dodge Viper acr",120000, ""},
  ["180sx"] = {"Nissan 180SX",6500, ""},
  ["aqv"] = {"Alfa Romeo Giulia  ",45000, ""},
  ["audirs6tk"] = {"Audi RS6 TK ",100000, ""},
  ["audis8om"] = {"Audi S8",80000, ""},
  ["ben17"] = {"Bentley Continental GT",120000, ""},
  ["bmwm8"] = {"BMW M8",145000, ""},
  ["brz"] = {"Subaru BRZ",35000, ""},
  ["brzbn"] = {"Subaru BRZ v2",35500, ""},
  ["c7"] = {"Chevrolet Corvette (C7)",65000, ""},
  ["c8"] = {"Chevrolet Corvette (C8)",69000, ""},
  ["CATS"] = {"Cadilac CTS-V",60000, ""},
  ["cx75"] = {"Jaguar CX 75",60000, ""},
  ["e60"] = {"BMW M5 E60",6000, ""},
  ["evo9"] = {"MITSUBISHI LANCER EVO 9",24000, ""},
  ["f82"] = {"BMW M4 F82",75000, ""},
  ["f620"] = {"Maserati GranTurismo",78000, ""},
  ["f824slw"] = {"BMW M4 F82 SLW",78000, ""},
  ["fc3s"] = {"Mazda RX-7 FC3S",7500, ""},
  ["furoregt"] = {"Jaguar XKR-S GT",130000, ""},
  ["hondacivictr"] = {"Honda Type R",32888, ""},
  ["jackal"] = {"Subaru STi R",30000, ""},
  ["kiagt"] = {"Kia Stinger 2020",40000, ""},
  ["lc500"] = {"Lexus LC500",65000, ""},
  ["m2"] = {"BMW M2",60000, ""},
  ["m3"] = {"BMW M3",80000, ""},
  ["m6f13"] = {"BMW M6 F13",105000, ""},
  ["mb18"] = {"Mercedes Benz S63 AMG Cabrio",140000, ""},
  ["mgrantur2010"] = {"Maserati  GranTurismo  2010",50000, ""},
  ["miniroads"] = {"Mini Couper Roadester",15000, ""},
  ["models"] = {"Tesla Model S",90000, ""},
  ["p90d"] = {"Tesla Model P90 D",100000, ""},
  ["moss"] = {"Mercedes Benz SLR ",200000, ""},
  ["mustang19"] = {"Ford Mustang 19",50000, ""},
  ["rcf"] = {"Lexus RC F",65000, ""},
  ["rs6"] = {"Audi RS 6",90000, ""},
  ["rs6tk"] = {"Audi RS 6 TK",120000, ""},
  ["rs7"] = {"Audi RS 7",140000, ""},
  ["rs318"] = {"Audi RS 3 2018",70000, ""},
  ["rx8r"] = {"Mazda RX8 R",24000, ""},
  ["s5"] = {"Audi S5",65000, ""},
  ["skyline"] = {"Nissan Skyline",45000, ""},
  ["supra2"] = {"Toyota Supra",55000, ""},
  ["supraa90"] = {"Toyota Supra ",60000, ""},
  ["teslapd"] = {"Tesla PD-S1000 ",130000, ""},
  ["viper"] = {"Dodge Viper ",130000, ""},
  ["z4bmw"] = {"BMW Z4  ",60000, ""},
  ["zl12017"] = {"Chevrolet Camaro 2017 ",74000, ""},
},

  ["Cadet"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"cadet.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Officer"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"officer.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Sheriff"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"sheriff.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Detective"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"detective.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Sargent"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"sgt.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Commander"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"commander.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["Chiefs"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"chief.vehicle"}},
    ["police"] = {"Police Cruiser",0, "police"},
    ["police2"] = {"Dodge Sheriff",0, "police"},
    ["police3"] = {"Police3",0, "police"},
    ["police4"] = {"police4",0, "police"},
    ["policet"] = {"policet",0, "police"},
    ["pranger"] = {"Sheriff",0, "police"},
    ["sheriff2"] = {"Sheriff SUV",0, "police"},
    ["sheriff"] = {"2015 Sheriff",0, "police"},
  	["fbi"] = {"Unmarked",0, "police"},

  },
  ["FBI"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"fbi.vehicle"}},
    ["um1"] = {"UM TAHOE",0, "FBI"},
    ["um2"] = {"UM Crown Vic",0, "FBI"},
    ["um3"] = {"UM Charger",0, "FBI"},
    ["um4"] = {"UM Taurus",0, "FBI"},
    ["um5"] = {"UM Explorer",0, "FBI"},
    ["riot"] = {"RIOT",0, "FBI"}

  },
  ["emergency"] = {
    _config = {vtype="car",blipid=50,blipcolor=3,permissions={"emergency.vehicle"}},
    ["Ambulance"] = {"Ambulance",0, "emergency"},
	  ["fd1"] = {"Ford Explorer",0, "emergency"},
    ["firetruk"] = {"firetruk",0, "emergency"},
    ["fd2"] = {"Chevy Tahoe",0, "emergency"},
    ["fd4"] = {"Chevy Impala",0, "emergency"}
  },
  ["Police Helicopters"] = {
    _config = {vtype="car",blipid=43,blipcolor=38,radius=5.1,permissions={"police.vehicle"}},
    ["polmav"] = {"Maverick",0, "emergency"}
  },
   ["EMS Helicopters"] = {
    _config = {vtype="car",blipid=43,blipcolor=1,radius=5.1,permissions={"emergency.vehicle"}},
    ["supervolito2"] = {"EMS",0, "emergency"}
  },
  ["TAXI"] = {
    _config = {vtype="car",blipid=56,blipcolor=38,permissions={"taxi.vehicle"}},
    ["captaxi"] = {"CAP TAXI",0, ""},
    ["caravantaxi"] = {"Caravan TAXI",0, ""},
    ["priustaxi"] = {"Prius TAXI",0, ""},
    ["taxi2"] = {"VW TAXI",0, ""},
  },
   ["Mafia Garage"] = {
    _config = {vtype="car",blipid=50,blipcolor=3,permissions={"mafia.vehicle"}},
	["infernus"] = {"Infernus", 0, ""}, -- THIS IS JUST AN EXAMPLE , ADD MORE IF YOU WANT.
  },
  ["repair"] = {
    _config = {vtype="car",blipid=50,blipcolor=31,permissions={"repair.vehicle"}},
    ["towtruck2"] = {"towtruck2",0, "towtruck2"},
	["utillitruck3"] = {"Utility Truck",0, "utillitruck3"}
  },
  ["Medical Driver"] = {
    _config = {vtype="car",blipid=67,blipcolor=4,permissions={"medical.vehicle"}},
    ["pony2"] = {"Medical Weed Van",0, "pony2"}
  },
  ["TRUCKER"] = {
    _config = {vtype="car",blipid=67,blipcolor=4,permissions={"tirist.vehicle"}},
    ["hauler"] = {"Scania TRUCK",0, "Tir pentru jobul [TIRIST]"},
    ["phantom3"] = {"Phantom 3",0, "Tir pentru jobul [TIRIST]"}

  }
  
  
  
}

-- {garage_type,x,y,z}
cfg.garages = {

}

return cfg
