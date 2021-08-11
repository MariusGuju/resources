--Settings--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_weap")
vRPCweap = Tunnel.getInterface("vRP_weap","vRP_weap")

vRPweap = {}
Tunnel.bindInterface("vRP_weap",vRPweap)
Proxy.addInterface("vRP_weap",vRPweap)


--[[
CREATE TABLE IF NOT EXISTS vrp_arme(
  user_id INTEGER,
  clasa VARCHAR(100),
  weapon VARCHAR(100),
  gloante INTEGER, 
  hash VARCHAR(100),
  componente VARCHAR(100),
  inventar INTEGER NOT NULL DEFAULT 0, 
  poateSaVanda INTEGER,
  PRIMARY KEY(user_id,hash)
)]]


--MySQL.createCommand("vRP/insert_arma","INSERT INTO vrp_arme (user_id,clasa,weapon,hash,gloante,componente,inventar,poateSaVanda) VALUES (@user_id,@clasa,@weapon,@hash,@gloante,@componente,@inventar,@poateSaVanda)")
--MySQL.createCommand("vRP/verifica_arme","SELECT * FROM vrp_arme WHERE user_id = @user_id")
--MySQL.createCommand("vRP/verifica_arme2","SELECT * FROM vrp_arme WHERE user_id = @user_id AND weapon = @weapon")
--MySQL.createCommand("vRP/puneArmaInInventar","UPDATE vrp_arme SET inventar = 1 WHERE user_id = @user_id AND hash = @hash")
--MySQL.createCommand("vRP/scoateArmaDinInventar","UPDATE vrp_arme SET inventar = 0 WHERE user_id = @user_id AND hash = @hash")
--MySQL.createCommand("vRP/verificaArma","SELECT * FROM vrp_arme WHERE user_id = @user_id AND weapon = @weapon")
--MySQL.createCommand("vRP/stergeToateArmele","DELETE FROM vrp_arme WHERE user_id = @user_id")
--MySQL.createCommand("vRP/stergeArmaSpecifica","DELETE FROM vrp_arme WHERE user_id = @user_id AND hash = @hash")
--MySQL.createCommand("vRP/get_weapon","SELECT weapon FROM vrp_arme WHERE user_id = @user_id AND weapon = @weapon")


function vRPweap.infoweap(source)
    local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
     exports.ghmattimysql:execute("SELECT * FROM vrp_arme WHERE user_id = @user_id", {['@user_id'] = user_id}, function (weapinfo)
        if #weapinfo > 0 then 
      vRPCweap.infoweap(source,{weapinfo})
        end
    end)

end
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    vRPweap.infoweap(source)
end)

RegisterCommand("arm", function(source)
    vRPweap.infoweap(source)
end)

local arme = {
    -- "Melee" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei
    
    { name = "Melee", 20,9,'WEAPON_KNUCKLE', 'Knuckle Dusters', "user.arme"},
    { name = "Melee", 50,7,'WEAPON_SWITCHBLADE', 'Switchblade', "user.arme"},
    { name = "Melee", 30,1,'WEAPON_KNIFE', 'Knife', "user.arme"},
    --{ name = "Melee", 43,1,'WEAPON_NIGHTSTICK', 'Nightstick', "user.arme"},
    { name = "Melee", 10,3,'WEAPON_HAMMER', 'Hammer', "user.arme"},
    { name = "Melee", 50,2,'WEAPON_BAT', 'Katana', "user.arme"},
    { name = "Melee", 50,5,'WEAPON_GOLFCLUB', 'Golf Club', "user.arme"},
    { name = "Melee", 55,6,'WEAPON_CROWBAR', 'Crowbar', "user.arme"},
    { name = "Melee", 50,8,'WEAPON_HATCHET', 'Hatchet', "user.arme"},
    --{ name = "Melee", 77,1,'WEAPON_POOLCUE', 'Pool Cue', "user.arme"},
    { name = "Melee", 50,5,'WEAPON_WRENCH', 'Wrench', "user.arme"},
    { name = "Melee", 30,12,'WEAPON_FLASHLIGHT', 'Flashlight', "user.arme"},
    { name = "Melee", 30,11,'WEAPON_BOTTLE', 'Broken Bottle', "user.arme"},
    { name = "Melee", 50,9,'WEAPON_DAGGER', 'Bowie Knife', "user.arme"},
    { name = "Melee", 20,19,'WEAPON_MACHETE', 'Machete', "user.arme"},
    { name = "Melee", 40,15,'WEAPON_BATTLEAXE', 'Battle Axe', "user.arme"},
    --{ name = "Melee", 100,1,'WEAPON_SNOWBALL', 'Snowball', "user.arme"},

    -- "Pistols" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    { name = "Pistols", 1500,9,'WEAPON_PISTOL', 'Pistol', "user.arme"},
    --{ name = "Pistols", 2000,14,'WEAPON_PISTOL_MK2', 'Pistol MKII', "user.arme"},
    { name = "Pistols", 1500,9,'WEAPON_COMBATPISTOL', 'Combat Pistol', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_MACHINEPISTOL', 'Machine Pistol', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_APPISTOL', 'Automatic Pistol', "user.arme"},
    { name = "Pistols", 1700,9,'WEAPON_PISTOL50', 'Pistol .50', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_REVOLVER', 'Revolver', "user.arme"},
    --{ name = "Pistols", 100,1,'WEAPON_REVOLVER_MK2', 'Revolver MKII', "user.arme"},
    --{ name = "Pistols", 100,1,'WEAPON_VINTAGEPISTOL', 'Vintage Pistol', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_SNSPISTOL', 'SNS Pistol', "user.arme"},
    --{ name = "Pistols", 1500,7,'WEAPON_SNSPISTOL_MK2', 'SNS Pistol MKII', "user.arme"},
   -- { name = "Pistols", 100,1,'WEAPON_MARKSMANPISTOL', 'Marksman Pistol', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_HEAVYPISTOL', 'Heavy Pistol', "user.arme"},
    --{ name = "Pistols", 100,1,'WEAPON_FLAREGUN', 'Flare Gun', "user.arme"},
    --{ name = "Pistols", 100,1,'WEAPON_STUNGUN', 'Taser', "user.arme"},
    --{ name = "Pistols", 100,2,'WEAPON_DOUBLEACTION', 'Double-Action Revolver', "user.arme"},

    --"SMGs" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    { name = "SMGs", 3000,22,'WEAPON_MICROSMG', 'Micro SMG', "user.arme"},
    { name = "SMGs", 4000,27,'WEAPON_SMG', 'SMG', "user.arme"},
   -- { name = "SMGs", 1000000,10,'WEAPON_SMG_MK2', 'SMG MKII', "user.arme"},
    --{ name = "SMGs", 100,1,'WEAPON_ASSAULTSMG', 'Assault SMG', "user.arme"},
    { name = "SMGs", 3500,15,'WEAPON_MINISMG', 'Mini SMG', "user.arme"},
    --{ name = "SMGs", 100,1,'WEAPON_COMBATPDW', 'Combat PDW', "user.arme"},

    --"MGs" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    -- { name = "MGs", 100,1,'WEAPON_MG', 'MG', "user.arme"},
    --{ name = "MGs", 100,1,'WEAPON_COMBATMG', 'Combat MG', "user.arme"},
    --{ name = "MGs", 100,1,'WEAPON_COMBATMG_MK2', 'Combat MG MKII', "user.arme"},
    --{ name = "MGs", 100,1,'WEAPON_GUSENBERG', 'Gusenberg', "user.arme"},

     --"Shotguns" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    { name = "Shotguns", 2500,26,'WEAPON_PUMPSHOTGUN', 'Pump Shotgun', "user.arme"},
    --{ name = "Shotguns", 2500,26,'WEAPON_PUMPSHOTGUN_MK2', 'Pump Shotgun MKII', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_HEAVYSHOTGUN', 'Heavy Shotgun', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_SAWNOFFSHOTGUN', 'Sawn-off Shotgun', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_BULLPUPSHOTGUN', 'Bullpup Shotgun', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_AUTOSHOTGUN', 'Sweeper', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_DBSHOTGUN', 'Double-Barreled Shotgun', "user.arme"},
    --{ name = "Shotguns", 100,1,'WEAPON_MUSKET', 'Musket', "user.arme"},

    --"Assault Rifles" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    { name = "Assault Rifles", 6000,24,'WEAPON_ASSAULTRIFLE', 'Assault Rifle', "user.arme"},
    --{ name = "Assault Rifles", 7500,30,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle MKII', "user.arme"},
    { name = "Assault Rifles", 6000,24,'WEAPON_CARBINERIFLE', 'Carbine Rifle', "user.arme"},
    --{ name = "Assault Rifles", 7500,30,'WEAPON_CARBINERIFLE_MK2', 'Carbine Rifle MKII', "user.arme"},
    --{ name = "Assault Rifles", 100,1,'WEAPON_ADVANCEDRIFLE', 'Advanced Rifle', "user.arme"},
    --{ name = "Assault Rifles", 100,1,'WEAPON_COMPACTRIFLE', 'Compact Rifle', "user.arme"},
    --{ name = "Assault Rifles", 100,1,'WEAPON_SPECIALCARBINE', 'Special Carbine', "user.arme"},
   -- { name = "Assault Rifles", 100,1,'WEAPON_SPECIALCARBINE_MK2', 'Special Carbine MKII', "user.arme"},
    --{ name = "Assault Rifles", 100,1,'WEAPON_BULLPUPRIFLE', 'Bullpup Rifle', "user.arme"},
    --{ name = "Assault Rifles", 100,1,'WEAPON_BULLPUPRIFLE_MK2', 'Bullpup Rifle MKII', "user.arme"},

    -- "Sniper Rifles" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    --{ name = "Sniper Rifles", 100,1,'WEAPON_SNIPERRIFLE', 'Sniper Rifle', "user.arme"},
   -- { name = "Sniper Rifles", 100,1,'WEAPON_HEAVYSNIPER', 'Heavy Sniper Rifle', "user.arme"},
  -- { name = "Sniper Rifles", 99999999999,50,'WEAPON_HEAVYSNIPER_MK2', 'Heavy Sniper Rifle MKII', "user.arme"},
   --{ name = "Sniper Rifles", 100,1,'WEAPON_MARKSMANRIFLE', 'Marksman Rifle', "user.arme"},
    --{ name = "Sniper Rifles", 100,1,'WEAPON_MARKSMANRIFLE_MK2', 'Marksman Rifle MKII', "user.arme"},

    -- "Throwables" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    --{ name = "Throwables", 100000,4,'WEAPON_GRENADE', 'Frag Grenade', "user.arme"},
    --{ name = "Throwables", 100,1,'WEAPON_STICKYBOMB', 'Sticky Bombs', "user.arme"},
    --{ name = "Throwables", 100,1,'WEAPON_SMOKEGRENADE', 'Smoke Grenade', "user.arme"},
    --{ name = "Throwables", 100,1,'WEAPON_BZGAS', 'BZ Gas', "user.arme"},
    --{ name = "Throwables", 900,10,'WEAPON_MOLOTOV', 'Molotov Cocktail', "user.arme"},
    --{ name = "Throwables", 100,1,'WEAPON_PIPEBOMB', 'Pipebomb', "user.arme"},
    --{ name = "Throwables", 100,1,'WEAPON_PROXMINE', 'Proximity Mine', "user.arme"},

    -- "Accessories" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei

    { name = "Accessories", 300,1,'WEAPON_FIREEXTINGUISHER', 'Fire Extinguisher'},
    --{ name = "Accessories", 100,1,'WEAPON_FIREWORK', 'Firework Launcher', "user.arme"},
    { name = "Accessories", 100,1,'WEAPON_PETROLCAN', 'Jerry Can', "user.arme"},
    --{ name = "Accessories", 100,1,'WEAPON_FLARE', 'Flare', "user.arme"},
    { name = "Accessories", 1000,6,'GADGET_PARACHUTE', 'Parachute', "user.arme"},

--[[
 --"Mafia" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei, v[5] = permisiunea
  { name = "Mafia", 0,0,'WEAPON_PISTOL', 'Pistol',"mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_REVOLVER_MK2', 'Revolver', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_PETROLCAN', 'Petrol',"mafia.arme"},    
  { name = "Mafia", 0,0,'WEAPON_KNUCKLE', 'Knuckle', "mafia.arme"},    
  { name = "Mafia", 0,0,'WEAPON_KNIFE', 'Cutit', "mafia.arme"},    
  { name = "Mafia", 0,0,'WEAPON_DAGGER', 'Dagger', "mafia.arme"},  
  { name = "Mafia", 0,0,'WEAPON_HAMMER', 'Hammer', "mafia.arme"},      
  { name = "Mafia", 0,0,'WEAPON_FLASHLIGHT', 'Flashlight', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_MUSKET', 'Musket', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_CROWBAR', 'CrowBar', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_GOLFCLUB', 'Crosa', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_SWITCHBLADE', 'Lama', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_MACHETE', 'Macheta', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2', "mafia.arme"},
  { name = "Mafia", 0,0,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk2', "mafia.arme"},
  { name = "Mafia", 0,0,'GADGET_PARACHUTE', 'Parasuta', "mafia.arme"},
  

  --[[{ name = "Mafia Ciorapel", 0,0,'WEAPON_PISTOL', 'Pistol',"mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_REVOLVER_MK2', 'Revolver', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_PETROLCAN', 'Petrol',"mafiepepsy.arme"},    
  { name = "Mafia Ciorapel", 0,0,'WEAPON_KNUCKLE', 'Knuckle', "mafiepepsy.arme"},    
  { name = "Mafia Ciorapel", 0,0,'WEAPON_KNIFE', 'Cutit', "mafiepepsy.arme"},    
  { name = "Mafia Ciorapel", 0,0,'WEAPON_DAGGER', 'Dagger', "mafiepepsy.arme"},  
  { name = "Mafia Ciorapel", 0,0,'WEAPON_HAMMER', 'Hammer', "mafiepepsy.arme"},      
  { name = "Mafia Ciorapel", 0,0,'WEAPON_FLASHLIGHT', 'Flashlight', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_MUSKET', 'Musket', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_CROWBAR', 'CrowBar', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_GOLFCLUB', 'Crosa', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_SWITCHBLADE', 'Lama', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_MACHETE', 'Macheta', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk2', "mafiepepsy.arme"},
  { name = "Mafia Ciorapel", 0,0,'GADGET_PARACHUTE', 'Parasuta', "mafiepepsy.arme"},

  { name = "Hitman", 0,0,'WEAPON_PISTOL', 'Pistol',"armamenthitman.acces"},
  { name = "Hitman", 0,0,'WEAPON_REVOLVER_MK2', 'Revolver', "armamenthitman.acces"},  
  { name = "Hitman", 0,0,'WEAPON_KNIFE', 'Cutit', "armamenthitman.acces"},    
  { name = "Hitman", 0,0,'WEAPON_HAMMER', 'Hammer', "armamenthitman.acces"},      
  { name = "Hitman", 0,0,'WEAPON_FLASHLIGHT', 'Flashlight', "armamenthitman.acces"},
  { name = "Hitman", 0,0,'WEAPON_CROWBAR', 'CrowBar', "armamenthitman.acces"},
  { name = "Hitman", 0,0,'WEAPON_MACHETE', 'Macheta', "armamenthitman.acces"},
  { name = "Hitman", 0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2', "armamenthitman.acces"},
  { name = "Hitman", 0,0,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk2', "armamenthitman.acces"},
  { name = "Hitman", 100,1,'WEAPON_HEAVYSNIPER', 'Heavy Sniper Rifle', "armamenthitman.acces"},

  
    -- "BCCO-SIAS" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei, v[5] = permisiunea
    { name = "BCCO-SIAS", 0,0,'WEAPON_PISTOL_MK2', 'Pistol MKII',"bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_APPISTOL', 'Ap Pistol', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_SMG', 'SMG',"bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_COMBATPDW', 'Combat PDW', "bcco.arme"},      
    { name = "BCCO-SIAS", 0,0,'WEAPON_HEAVYSNIPER_MK2', 'HeavySniper Mk2', "bcco.arme"},    
    { name = "BCCO-SIAS", 0,0,'WEAPON_CARBINERIFLE_MK2', 'CARBINERIFLE MK2', "bcco.arme"},    
    { name = "BCCO-SIAS", 0,0,'WEAPON_FLARE', 'Flare', "bcco.arme"},  
    { name = "BCCO-SIAS", 0,0,'WEAPON_HEAVYSHOTGUN', 'Heavy Shotgun', "bcco.arme"},       
    { name = "BCCO-SIAS", 0,0,'WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_FLASHLIGHT', 'Fleshlight', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_FLAREGUN', 'Flare Gun', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_STUNGUN', 'Stung Gun', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'GADGET_PARACHUTE', 'Parasuta', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_SMOKEGRENADE', 'Smoke Grenade', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_NIGHTSTICK', 'Nelu', "bcco.arme"},
    { name = "BCCO-SIAS", 0,0,'WEAPON_SWITCHBLADE', 'Lama', "bcco.arme"},

 -- "Cadet&officer" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei, v[5] = permisiunea
 { name = "Cadet&Agent", 0,0,'WEAPON_COMBATPISTOL', 'Combat Pistol',"agent.arme"},
 { name = "Cadet&Agent", 0,0,'WEAPON_STUNGUN', 'Tazer', "agent.arme"},
 { name = "Cadet&Agent", 0,0,'WEAPON_NIGHTSTICK', 'Baston',"agent.arme"},
 { name = "Cadet&Agent", 0,0,'WEAPON_FLASHLIGHT', 'Lanterna', "agent.arme"},    
 { name = "Cadet&Agent", 0,0,'WEAPON_PUMPSHOTGUN', 'Pump Shotgun', "agent.arme"},    
 { name = "Cadet&Agent", 0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2', "agent.arme"},  
 { name = "Cadet&Agent", 0,0,'WEAPON_VINTAGEPISTOL', 'Pistol Radar', "agent.arme"},    
 

 -- "Commander-Chief" v.name, v[1] - PRET, v[2] - LEVEL, v[3] - HASH, v[4] = Numele Armei, v[5] = permisiunea
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_COMBATPISTOL', 'Pistol',"ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_STUNGUN', 'Tazer', "ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_NIGHTSTICK', 'Baston',"ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_FLASHLIGHT', 'Lanterna', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_PUMPSHOTGUN', 'Pump Shotgun', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_SMOKEGRENADE', 'Smoke Grenade', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_FLAREGUN', 'Flare Gun', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_ADVANCEDRIFLE', 'Advenced Rifle', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_APPISTOL', 'Ap Pistol', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_CARBINERIFLE', 'Carabine', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_HEAVYSNIPER_MK2', 'HeavySniper MKII', "ins.arme"},      
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_CARBINERIFLE_MK2', 'CARBINERIFLE MK2', "ins.arme"},  
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_VINTAGEPISTOL', 'Radar', "ins.arme"},    
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_PISTOL_MK2', 'Pistol MKII',"ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'GADGET_PARACHUTE', 'Parasuta', "ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2', "ins.arme"},
 { name = "Sub-Inspector-Comisar", 0,0,'Armor', 'Vesta Anti-Glont', "ins.arme"},  
 { name = "Sub-Inspector-Comisar", 0,0,'WEAPON_SWITCHBLADE', 'Lama', "ins.arme"},
 --]]
}

informatii = {}

RegisterServerEvent('infoCont')
AddEventHandler('infoCont',function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
    informatiiCont(user_id)
end)

function informatiiCont(user_id,info)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local baniimei = vRP.getMoney({user_id})
    exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
        lvlmeu = rows[1].level
        vRPCweap.informatii(user_id, {lvlmeu,baniimei})
    end)

end

RegisterServerEvent('stergeToateArmele')
AddEventHandler('stergeToateArmele',function()
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    exports.ghmattimysql:execute("DELETE FROM vrp_arme WHERE user_id = @user_id", {
        ['@user_id'] = user_id
    }, function (rows)
    end)
end)

RegisterServerEvent('stergeArmaSpecifica')
AddEventHandler('stergeArmaSpecifica',function(armaSpecifica,armaModel,pretArmaVanzare)
    --print(armaSpecifica,armaModel)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
       exports.ghmattimysql:execute("SELECT * FROM vrp_arme WHERE user_id = @user_id AND hash = @hash", {['@user_id'] = user_id, ['@hash'] = armaModel}, function (rows)
            if rows[1].poateSaVanda == 1 then
                vRP.giveMoney({user_id,pretArmaVanzare})
                exports.ghmattimysql:execute("DELETE FROM vrp_arme WHERE user_id = @user_id AND hash = @hash", {
                    ['@user_id'] = user_id, 
                    ['@hash'] = armaModel
                }, function (rows)
                end)
                
                TriggerClientEvent('stergeArmaSpecificade',player,armaSpecifica,armaModel)
                vRPclient.notify(player,{"Ai vandut arma cu succes pe ~g~"..pretArmaVanzare})
            else
                vRPclient.notify(player,{"Ai vandut arma cu ~g~succes ~w~dar ~r~nu ai primit bani~w~ pentru ca e cumparata de la factiune"})
                --MySQL.execute("vRP/stergeArmaSpecifica", {user_id = user_id, weapon = armaSpecifica})
                exports.ghmattimysql:execute("DELETE FROM vrp_arme WHERE user_id = @user_id AND hash = @hash", {
                    ['@user_id'] = user_id, 
                    ['@hash'] = armaSpecifica
                }, function (rows)
                end)

                TriggerClientEvent('stergeArmaSpecificade',player,armaSpecifica,armaModel)
            end
        end)

end)


RegisterServerEvent('plateste')
AddEventHandler('plateste',function(pret)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.tryFullPayment({user_id,pret}) then
    end
end)


RegisterServerEvent('cumpara')
AddEventHandler('cumpara',function(pretul,armaNume,armaModel,clasa,gloante,levelul,grupa)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    for k,v in pairs (arme) do
        local numeleArmei = v.name
        local armaP = v[1]
        local armaL = v[2]
        local hashArma = v[3]
        if hashArma == armaModel and numeleArmei == clasa then
            if pretul == armaP then
                exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id=@user_id", {['@user_id'] = user_id}, function (rows)
                    if armaL == levelul then
                        if rows[1].level >= levelul then 
                            if vRP.hasPermission({user_id,grupa}) then
                                if vRP.tryFullPayment({user_id,pretul}) then
                                    exports.ghmattimysql:execute("SELECT weapon FROM vrp_arme WHERE user_id = @user_id AND weapon = @weapon", {['@user_id'] = user_id, ['@weapon'] = armaNume}, function (rows)
                                        if #rows > 0 then
                                            vRPclient.notify(player,{"Ai deja arma asta cumparata"})
                                        else
                                            exports.ghmattimysql:execute("INSERT INTO vrp_arme (user_id,clasa,weapon,hash,gloante,componente,inventar,poateSaVanda) VALUES (@user_id,@clasa,@weapon,@hash,@gloante,@componente,@inventar,@poateSaVanda)", {
                                                ['@user_id'] = user_id, 
                                                ['@clasa'] = clasa,
                                                ['@weapon'] = armaNume,
                                                ['@hash'] = armaModel,
                                                ['@gloante'] = gloante,
                                                ['@componente'] = 0,
                                                ['@inventar'] = 0,
                                                ['@poateSaVanda'] = 1
                                            }, function (rows)
                                            end)

                                            TriggerClientEvent('daiArma',player,armaModel,gloante)
                                        end
                                    end)

                                else
                                    vRPclient.notify(player,{"Nu ai destui bani pentru aceasta arma."})
                                end
                            else
                                vRPclient.notify(player,{"Nu ai grupa pentru arma!"}) 
                            end
                        else
                            vRPclient.notify(player,{"Nu ai level necesar pentru aceasta arma."})
                        end
                    else
                        vRP.kick1337({user_id,"Cheat Engine(MODIFICARE LEVEL LA ARMA "..armaNume.."). U lil shit. N-ai cum s-o dai aici frate-miu cu cacaturile astea."})
                        TriggerClientEvent('mesajPeChat',-1, '^1[ANTI-CHEAT-ENGINE]',{255,0,0},"ID: [^1"..user_id.."^7] a modificat levelul la [^4"..armaNume.."^7]")
                        TriggerClientEvent('mesajPeChat',-1, '^1[ANTI-CHEAT-ENGINE]',{255,0,0},"Level Original: ^2"..armaL.."^7 | Modificare: ^2"..levelul) 
                       
                    end
                end)
            else
                vRP.kick1337({user_id,"Cheat Engine(MODIFICARE DE BANI LA ARMA "..armaNume.."). U lil shit. N-ai cum s-o dai aici frate-miu cu cacaturile astea."})
                TriggerClientEvent('mesajPeChat',-1, '^1[ANTI-CHEAT-ENGINE]',{255,0,0},"ID: [^1"..user_id.."^7] a modificat pretul la [^4"..armaNume.."^7]")
                TriggerClientEvent('mesajPeChat',-1, '^1[ANTI-CHEAT-ENGINE]',{255,0,0},"Pret Original: ^2$"..armaP.."^7 | Modificare: ^2$"..pretul)
               
            end
        end
    end
end)


--MySQL.createCommand("vRP/update_arma_atasamente","UPDATE vrp_arme SET componente = @componente WHERE user_id = @user_id AND hash = @hash")
--MySQL.createCommand("vRP/selecteaza_arma_atasamente","SELECT * FROM vrp_arme WHERE user_id = @user_id AND hash = @hash")

RegisterServerEvent('atasamentArma')
AddEventHandler('atasamentArma',function(armaModel,armaModelAt,armaNumeAt)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    exports.ghmattimysql:execute("SELECT * FROM vrp_arme WHERE user_id = @user_id AND hash = @hash", {['@user_id'] = user_id, ['@hash'] = armaModel}, function (rows)
        if #rows > 0 then
          if rows[1].componente ~= nil then
              componenteleActuale = rows[1].componente
              if componenteleActuale == 0 then
                  compUpd = armaModelAt
              else
                  compUpd = armaModelAt..","..componenteleActuale
                  exports.ghmattimysql:execute("UPDATE vrp_arme SET componente = @componente WHERE user_id = @user_id AND hash = @hash", {
                      ['@user_id'] = user_id, 
                      ['@hash'] = armaModel,
                      ['@componente'] = compUpd
                  }, function (rows)
                  end)
                      
              end
          end 
        end  
    end)
end)


RegisterServerEvent('updateArma')
AddEventHandler('updateArma',function(armaNabHash,gloanteUpdate)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    exports.ghmattimysql:execute("UPDATE vrp_arme SET gloante = @gloante WHERE user_id = @user_id AND hash = @hash", {
        ['@user_id'] = user_id, 
        ['@hash'] = armaNabHash,
        ['@gloante'] = gloanteUpdate
    }, function (rows)
    end)
end)

RegisterServerEvent('updateGloanteArmaFull')
AddEventHandler('updateGloanteArmaFull',function(armaModel,pretGloanteFull)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.tryFullPayment({user_id,pretGloanteFull}) then
        gloantefull = 250
        exports.ghmattimysql:execute("UPDATE vrp_arme SET gloante = @gloante WHERE user_id = @user_id AND hash = @hash", {
            ['@user_id'] = user_id, 
            ['@hash'] = armaModel,
            ['@gloante'] = gloantefull
        }, function (rows)
        end)
        TriggerClientEvent('daiGloanteFull',player,armaModel,gloantefull)
    else
        vRPclient.notify(player,{"Saracia dracu, n-ai ~g~$"..pretGloanteFull.."~w~ sa cumperi gloante la arme"})
    end
end)

RegisterServerEvent('updateGloanteX')
AddEventHandler('updateGloanteX',function(armaModel,gloantenevoiase,pretGloanteX)
  local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.tryFullPayment({user_id,pretGloanteX}) then
        exports.ghmattimysql:execute("UPDATE vrp_arme SET gloante = @gloante WHERE user_id = @user_id AND hash = @hash", {
            ['@user_id'] = user_id, 
            ['@hash'] = armaModel,
            ['@gloante'] = gloantenevoiase
        }, function (rows)
        end)

        TriggerClientEvent('daiGloanteLaArma',player,armaModel,gloantenevoiase)
    else
        vRPclient.notify(player,{"Saracia dracu, n-ai ~g~$"..pretGloanteX.."~w~ sa cumperi gloante la arme"})
    end
end)