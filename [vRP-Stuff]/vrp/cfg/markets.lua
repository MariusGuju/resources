
local cfg = {}

-- define market types like garages and weapons
-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the market)

cfg.market_types = {
  ["24/7"] = {
    _config = {blipid=52, blipcolor=2},

    -- list itemid => price
    -- Drinks
    ["milk"] = 4,
    ["water"] = 1,
    ["coffee"] = 5,
    ["tea"] = 5,
    ["icetea"] = 4,
    ["orangejuice"] = 8,
    ["cocacola"] = 3,
    ["redbull"] = 7,
    ["lemonade"] = 5,
    ["vodka"] = 15,
  --
    --24/7
    ["bread"] = 3,
    ["donut"] = 2,
    ["tacos"] = 12,
    ["sandwich"] = 10,
    ["kebab"] = 12,
    ["pdonut"] = 3,
  },
  ["MCDONALDS"] = {
    _config = {blipid=124, blipcolor=60},
    ["McChicken"] = 15,
    ["McPuisor"] = 17,
    ["McNuggets"] = 22,
    ["BigMac"] = 23,
    ["Cheeseburger"] = 22,
    ["cartofimici"] = 6,
    ["cartofimedi"] = 8,
    ["cartofimari"] = 10,
    ["salata"] = 20,
    ["coffee"] = 5,
    ["cocacola"] = 3,

  },
  ["PIZZERIE"] = {
    _config = {blipid=136, blipcolor=1},
    ["Margherita"] = 18,
    ["Capricciosa"] = 20,
    ["Diavola"] = 22,
    ["Formaggi"] = 25,
    ["Stagioni"] = 28,
    ["Vegetariana"] = 27,
    ["Spaghete"] = 25,
    ["coffee"] = 5,
    ["cocacola"] = 3,
    ["lemonade"] = 5,

  },
  ["emergencyloadout"] = {
    _config = {blipid=487, blipcolor=1, permissions={"emergency.market"}},
    ["medkit"] = 0
  },
  ["plantation"] = {
    _config = {blipid=473, blipcolor=4, permissions={"drugseller.market"}},
    ["seeds"] = 50,
    ["benzoilmetilecgonina"] = 65,
    ["harness"] = 80
  },
  ["tools"] = {
    _config = {blipid=402, blipcolor=47, permissions={"repair.market"}},
    ["repairkit"] = 50
  },
  ["General"] = {
    _config = {blipid=402, blipcolor=47},
    ["mapa"] = 10,
  },
  ["TOOLBOX"] = {
    _config = {blipid=175, blipcolor=47, permissions = {"police.jail"}},
    ["radio"] = 0,
    ["body_armor"] = 0,
  },
  ["Vesta"] = {
    _config = {permissions = {"siciliana.masini"}},
    ["body_armor"] = 0,
  },
  ["Vesta2"] = {
    _config = {permissions = {"marchi.masina"}},
    ["body_armor"] = 0,
  },
  ["Siciliana"] = {
    _config = {permissions = {"siciliana.masini"}},
    ["iarba"] = 0,
    ["cocaina"] = 0,
    ["metanfetamina"] = 0, 
  },
  ["DroguriFree"] = {
    _config = {permissions = {"marchi.masina"}},
    ["iarba"] = 0,
    ["cocaina"] = 0,
    ["metanfetamina"] = 0, 
  },
  ["LosVagos"] = {
  _config = {permissions = {"vagos.masini"}},
    ["cocaina"] = 150
  },
  ["SacraCoronaUnita"] = {
    _config = {permissions = {"scu.masini"}},
    ["iarba"] = 70
  },
  ["Rusa"] = {
    _config = {permissions = {"rusal.masini"}},
    ["metanfetamina"] = 75
  },
  ["Unelte"] = {
    _config = {blipid=402, blipcolor=47, permissions = {"lockpick.magazin"}},
    ["lockpick"] = 500,
  },

  ['Laptop Hacking'] = {
    _config = {blipid = 521 , blipcolor = 1},
    ['laptophacking'] = 2000
  },
  ['Set Chimie Droguri'] = {
    _config = {blipid = 499 , blipcolor = 4},
    ['chem_set'] = 350
  },
  ["Magazin Scafandru"] = {
    _config = {blipid=410, blipcolor=18},
    ["rod"] = 50,
    ["bait"] = 10,
    ["scubagear"] = 750,
    ["uwtorch"] = 250
  },
}

-- list of markets {type,x,y,z}

cfg.markets = {
  {"24/7",1686.8103027344,2521.6452636719,-120.84987640381},
  {"24/7",128.1410369873, -1286.1120605469, 29.281036376953},
  {"24/7",-47.522762298584,-1756.85717773438,29.4210109710693},
  {"24/7",-1093.6384277344,-834.19561767578,23.038414001465},
  {"24/7",25.7454013824463,-1345.26232910156,29.4970207214355}, 
  {"24/7",1135.57678222656,-981.78125,46.4157981872559}, 
  {"24/7",1163.53820800781,-323.541320800781,69.2050552368164}, 
  {"24/7",374.190032958984,327.506713867188,103.566368103027}, 
  {"24/7",2555.35766601563,382.16845703125,108.622947692871},
  {"24/7",-1034.6748046875,-2740.904296875,20.169256210328}, 
  {"24/7",2676.76733398438,3281.57788085938,55.2411231994629}, 
  {"24/7",1960.50793457031,3741.84008789063,32.3437385559082},
  {"24/7",1393.23828125,3605.171875,34.9809303283691}, 
  {"24/7",1166.18151855469,2709.35327148438,38.15771484375}, 
  {"24/7",547.987609863281,2669.7568359375,42.1565132141113},
  {"SacraCoronaUnita",1044.5306396484,-3194.9362792969,-38.158042907715},
  {"LosVagos",1099.9973144531,-3193.2082519531,-38.993419647217}, 
  {"24/7",1698.30737304688,4924.37939453125,42.0636749267578}, 
  {"24/7",1729.54443359375,6415.76513671875,35.0372200012207}, 
  {"24/7",-3243.9013671875,1001.40405273438,12.8307056427002}, 
  {"24/7",-2967.8818359375,390.78662109375,15.0433149337769}, 
  {"24/7",-3041.17456054688,585.166198730469,7.90893363952637}, 
  {"24/7",-1820.55725097656,792.770568847656,138.113250732422}, 
  {"24/7",-1486.76574707031,-379.553985595703,40.163387298584}, 
  {"24/7",-1223.18127441406,-907.385681152344,12.3263463973999}, 
  {"24/7",-707.408996582031,-913.681701660156,19.2155857086182},
  {"MCDONALDS",133.25836181641,-1067.916015625,29.254781723022}, 
  {"PIZZERIE",282.17794799805,-973.78021240234,29.870487213135}, 
  {"emergencyloadout",306.55838012695,-595.11810302734,43.284019470215},
  {"plantation",1789.86682128906,3896.16943359375,34.3892250061035},
  {"tools",962.46301269531,-105.45156097412,74.363571166992},
  {"Rusa",1004.3895874023,-3194.7509765625,-38.993125915527},
  {"Unelte",29.440313339234,-1770.2590332032,29.607358932496},
  {"Siciliana",-1516.2911376953,126.10202789307,50.052478790283},
  {"TOOLBOX",480.66552734375,-995.27288818359,30.689643859863},
  {"Vesta",-1519.6807861328,115.76454162598,50.052471160889},
  {"Vesta2",-2679.5244140625,1324.9381103516,144.25773620605},
  {"DroguriFree",-2676.7058105469,1336.171875,144.25775146484 },
  --{"Magazin Scafandru",}
  {"Set Chimie Droguri",-145.59104919434,-1430.1009521484,30.919494628906}
--
}

return cfg
