
local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {	  	  
  ["emsloadout"] = {
    _config = {blipid=446,blipcolor=74, permissions = {"ems.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
   	["WEAPON_FLAREGUN"] = {"Flare Gun",0,0,""},
  	["WEAPON_FLASHLIGHT"] = {"Flashlight",0,0,""},
    ["WEAPON_FLARE"] = {"Flare",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Nighstick",0,0,""},
  	["WEAPON_STUNGUN"] = {"Tazer",0,0,""}
   },

   ["Mafioti"] = {
    _config = {blipid=0,blipcolor=0, permissions = {"mafiot.chat"}},
    ["WEAPON_PISTOL"] = {"Pistol",750,0,""},
   	["WEAPON_ASSAULTRIFLE"] = {"AK-47",3000,0,""},
    ["WEAPON_MICROSMG"] = {"Micro SMG",1500,0,""},
    ["WEAPON_SMG"] = {"SMG",2000,0,""},
  	["WEAPON_CARBINERIFLE"] = {"M4A4",3000,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shotgun",1250,0,""}
   },
   ["Mafioti Avansati"] = {
    _config = {blipid=0,blipcolor=0, permissions = {"mafiot.chat"}},
    ["WEAPON_PISTOL"] = {"Pistol",750,0,""},
   	["WEAPON_ASSAULTRIFLE"] = {"AK-47",3000,0,""},
    ["WEAPON_MICROSMG"] = {"Micro SMG",1500,0,""},
    ["WEAPON_SMG"] = {"SMG",2000,0,""},
  	["WEAPON_CARBINERIFLE"] = {"M4A4",3000,0,""},
    ["WEAPON_SNIPERRIFLE"] = {"Sniper",3000,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shotgun",1250,0,""}
   },
   ["Traficant Loadout"] = {
    _config = {permissions = {"traficant.acces"}},
    ["WEAPON_PISTOL"] = {"Pistol",750,0,""},
   	["WEAPON_ASSAULTRIFLE"] = {"AK-47",3000,0,""},
    ["WEAPON_MICROSMG"] = {"Micro SMG",1500,0,""},
    ["WEAPON_SMG"] = {"SMG",2000,0,""},
  	["WEAPON_CARBINERIFLE"] = {"M4A4",3000,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shotgun",1250,0,""}
   }
}
-- list of gunshops positions

cfg.gunshops = {
  {"emsloadout", 232.89363098145,-1368.3338623047,39.534381866455}, -- spawn hospital
  --{"emsloadout", 1837.8341064453,3671.3837890625,34.276763916016}, -- sandy shores
  {"emsloadout", 301.45581054688,-599.69610595703,43.284030914307}, -- paleto
  {"Mafioti Avansati", -1866.4425048828,2065.2578125,135.43461608887},--Rusa
  {"Mafioti", -2679.0439453125,1328.2001953125,140.8814239502},--sinalo
  {"Mafioti",-58.006217956543,981.96087646484,234.57720947266},--SCU
	{"Mafioti Avansati",-1500.0819091797,835.70678710938,178.703125},--LOSVAGOS
	{"Mafioti",928.86853027344,-2531.2199707031,28.302663803101},--Peaky Blinders
	{"Mafioti Avansati",-1520.4920654297,109.66164398193,50.027324676514},--Siciliana
	{"emsloadout",-2679.5251464844,1328.3400878906,144.25773620605}, 
  {"Traficant Loadout", -246.91954040527,6330.349609375,32.42618560791} -- paleto
  --{"test2", -246.91954040527,6330.349609375,32.42618560791}, -- paleto
  --{"test3", -246.91954040527,6330.349609375,32.42618560791}, -- paleto
}

return cfg
