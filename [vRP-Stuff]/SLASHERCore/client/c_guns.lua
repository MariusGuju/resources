
vRPweapC = {}


local xnWeapons = xnWeapons or {
    interiorIDs = {
        [153857] = true,
        [200961] = true,
		[140289] = {
			weaponRotationOffset = 135.0,
		},
        [180481] = true,
        [168193] = true,
        [164609] = {
			weaponRotationOffset = 150.0,
		},
        [175617] = true,
        [176385] = true,
		[178689] = true,
		[137729] = {
			additionalOffset = 			vec(8.3,-6.5,0.0),
			additionalCameraOffset = 	vec(8.3,-6.0,0.0),
			additionalCameraPoint = 	vec(1.0,-0.91,0.0),
			additionalWeaponOffset =	vec(0.0,0.5,0.0),
			weaponRotationOffset = 		-60.0,
		},
		[248065] = {
			additionalOffset = 			vec(-10.0,3.0,0.0),
			additionalCameraOffset = 	vec(-9.5,3.0,0.0),
			additionalCameraPoint = 	vec(-1.0,0.4,0.0),
			additionalWeaponOffset =	vec(0.4,0.0,0.0),
		},
    },
    closeMenuNextFrame = false,
    weaponClasses = {},
}
function IsAmmunationOpen()
	return (string.find(tostring(JayMenu.CurrentMenu() or ""), "xnweapons") or string.find(tostring(JayMenu.CurrentMenu() or ""), "xnw_"))
end

tabelaArme = {}
function vRPweapC.infoweap(weapinfo)
tabelaArme = weapinfo
end

function vRPweapC.informatii(lvlmeu,baniimei)
	levelactual = lvlmeu
	baniact = baniimei
	--print(levelactual,baniact)
end




local globalWeaponTable = {
    {
		name = "Melee",
        {"user.arme",20,9,'WEAPON_KNUCKLE', 'Knuckle Dusters' },
        {"user.arme",50,7,'WEAPON_SWITCHBLADE', 'Switchblade' },
        {"user.arme",30,1,'WEAPON_KNIFE', 'Knife' },
        --{"user.arme",43,1,'WEAPON_NIGHTSTICK', 'Nightstick' },
        {"user.arme",10,3,'WEAPON_HAMMER', 'Hammer' },
        {"user.arme",50,2,'WEAPON_BAT', 'Katana' },
        {"user.arme",50,5,'WEAPON_GOLFCLUB', 'Golf Club' },
        {"user.arme",55,6,'WEAPON_CROWBAR', 'Crowbar' },
        {"user.arme",50,8,'WEAPON_HATCHET', 'Hatchet' },
       -- {"user.arme",77,1,'WEAPON_POOLCUE', 'Pool Cue' },
        {"user.arme",50,5,'WEAPON_WRENCH', 'Wrench' },
        {"user.arme",30,12,'WEAPON_FLASHLIGHT', 'Flashlight' },
        {"user.arme",30,11,'WEAPON_BOTTLE', 'Broken Bottle' },
        {"user.arme",50,9,'WEAPON_DAGGER', 'Bowie Knife' },
        {"user.arme",20,19,'WEAPON_MACHETE', 'Machete' },
        {"user.arme",40,15,'WEAPON_BATTLEAXE', 'Battle Axe' },
        --{"user.arme",100,1,'WEAPON_SNOWBALL', 'Snowball' },
    },
    {
        name = "Pistols",
        {"user.arme",1500,9,'WEAPON_PISTOL', 'Pistol' },
        --{"user.arme",2000,14,'WEAPON_PISTOL_MK2', 'Pistol MKII' },
        {"user.arme",1500,9,'WEAPON_COMBATPISTOL', 'Combat Pistol' },
        --{"user.arme",100,2,'WEAPON_MACHINEPISTOL', 'Machine Pistol' },
        --{"user.arme",100,2,'WEAPON_APPISTOL', 'Automatic Pistol' },
        {"user.arme",1700,9,'WEAPON_PISTOL50', 'Pistol .50' },
        --{"user.arme",100,2,'WEAPON_REVOLVER', 'Revolver' },
        --{"user.arme",100,1,'WEAPON_REVOLVER_MK2', 'Revolver MKII' },
        --{"user.arme",100,1,'WEAPON_VINTAGEPISTOL', 'Vintage Pistol' },
       --{"user.arme",50000,2,'WEAPON_SNSPISTOL', 'SNS Pistol' },
        --{"user.arme",1500,7,'WEAPON_SNSPISTOL_MK2', 'SNS Pistol MKII' },
       -- {"user.arme",100,1,'WEAPON_MARKSMANPISTOL', 'Marksman Pistol' },
       -- {"user.arme",100,2,'WEAPON_HEAVYPISTOL', 'Heavy Pistol' },
        --{"user.arme",100,1,'WEAPON_FLAREGUN', 'Flare Gun' },
        --{"user.arme",100,1,'WEAPON_STUNGUN', 'Taser' },
        --{"user.arme",100,2,'WEAPON_DOUBLEACTION', 'Double-Action Revolver' },
    },
    {
        name = "SMGs",
        {"user.arme",3000,22,'WEAPON_MICROSMG', 'Micro SMG' },
        {"user.arme",4000,27,'WEAPON_SMG', 'SMG' },
      --  {"user.arme",500000,7,'WEAPON_SMG_MK2', 'SMG MKII' },
        --{"user.arme",100,1,'WEAPON_ASSAULTSMG', 'Assault SMG' },
        {"user.arme",3500,15,'WEAPON_MINISMG', 'Mini SMG' },
        --{"user.arme",300000,10,'WEAPON_COMBATPDW', 'Combat PDW' },
    },
    --[[{
        name = "MGs",
        --{"user.arme",500000,10,'WEAPON_MG', 'MG' },
        --{"user.arme",100,1,'WEAPON_COMBATMG', 'Combat MG' },
        --{"user.arme",100,1,'WEAPON_COMBATMG_MK2', 'Combat MG MKII' },
        --{"user.arme",100,1,'WEAPON_GUSENBERG', 'Gusenberg' },
    },]]
    {
        name = "Shotguns",
        {"user.arme",2500,26,'WEAPON_PUMPSHOTGUN', 'Pump Shotgun' },
        --{"user.arme",2500,26,'WEAPON_PUMPSHOTGUN_MK2', 'Pump Shotgun MKII' },
        --{"user.arme",100,1,'WEAPON_HEAVYSHOTGUN', 'Heavy Shotgun' },
        --{"user.arme",100,1,'WEAPON_SAWNOFFSHOTGUN', 'Sawn-off Shotgun' },
        --{"user.arme",100,1,'WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun' },
        --{"user.arme",100,1,'WEAPON_BULLPUPSHOTGUN', 'Bullpup Shotgun' },
        --{"user.arme",100,1,'WEAPON_AUTOSHOTGUN', 'Sweeper' },
        --{"user.arme",100,1,'WEAPON_DBSHOTGUN', 'Double-Barreled Shotgun' },
        --{"user.arme",900000,1,'WEAPON_MUSKET', 'Musket' },
    },
    {
        name = "Assault Rifles",
        {"user.arme",6000,24,'WEAPON_ASSAULTRIFLE', 'Assault Rifle' },
        --{"user.arme",7500,30,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle MKII' },
        {"user.arme",6000,24,'WEAPON_CARBINERIFLE', 'Carbine Rifle' },
        --{"user.arme",7500,30,'WEAPON_CARBINERIFLE_MK2', 'Carbine Rifle MKII' },
        --{"user.arme",100,1,'WEAPON_ADVANCEDRIFLE', 'Advanced Rifle' },
        --{"user.arme",100,1,'WEAPON_COMPACTRIFLE', 'Compact Rifle' },
        --{"user.arme",100,1,'WEAPON_SPECIALCARBINE', 'Special Carbine' },
        --{"user.arme",100,1,'WEAPON_SPECIALCARBINE_MK2', 'Special Carbine MKII' },
        --{"user.arme",100,1,'WEAPON_BULLPUPRIFLE', 'Bullpup Rifle' },
        --{"user.arme",100,1,'WEAPON_BULLPUPRIFLE_MK2', 'Bullpup Rifle MKII' },
    },
    --[[{
        name = "Sniper Rifles",
        --{"user.arme",100,1,'WEAPON_SNIPERRIFLE', 'Sniper Rifle' },
        --{"user.arme",100,1,'WEAPON_HEAVYSNIPER', 'Heavy Sniper Rifle' },
      --  {"user.arme",999999999,10,'WEAPON_HEAVYSNIPER_MK2', 'Heavy Sniper Rifle MKII' },
        --{"user.arme",100,1,'WEAPON_MARKSMANRIFLE', 'Marksman Rifle' },
        --{"user.arme",100,1,'WEAPON_MARKSMANRIFLE_MK2', 'Marksman Rifle MKII' },
    },]]
    --[[{
        name = "Throwables",
       -- {"user.arme",100000,4,'WEAPON_GRENADE', 'Frag Grenade', {noTint = true} },
       -- {"user.arme",100,1,'WEAPON_STICKYBOMB', 'Sticky Bombs', {noTint = true} },
        --{"user.arme",100,1,'WEAPON_SMOKEGRENADE', 'Smoke Grenade', {noTint = true} },
      --  {"user.arme",100,1,'WEAPON_BZGAS', 'BZ Gas', {noTint = true} },
        {"user.arme",9000,10,'WEAPON_MOLOTOV', 'Molotov Cocktail', {noTint = true} },
        --{"user.arme",100,1,'WEAPON_PIPEBOMB', 'Pipebomb', {noTint = true} },
        --{"user.arme",100,1,'WEAPON_PROXMINE', 'Proximity Mine', {noTint = true} },
    },]]
    {
        name = "Accessories",
        {"user.arme",300,1,'WEAPON_FIREEXTINGUISHER', 'Fire Extinguisher', {noAmmo = true, noTint = true} },
        --{"user.arme",100,1,'WEAPON_FIREWORK', 'Firework Launcher', {noTint = true} },
        {"user.arme",100,1,'WEAPON_PETROLCAN', 'Jerry Can', {noTint = true} },
		--{"user.arme",100,1,'WEAPON_FLARE', 'Flare', {noTint = true} },
		{"user.arme",1000,6,'GADGET_PARACHUTE', 'Parachute', {noPreview = true, noTint = true, noAmmo = true} },
	},
	
		--[[{

			name = "Mafia",
			{"mafia.arme",0,0,'WEAPON_PISTOL', 'Pistol' },
			{"mafia.arme",0,0,'WEAPON_REVOLVER_MK2', 'Revolver Mk2' },
			{"mafia.arme",0,0,'WEAPON_PETROLCAN', 'Petrol' },
			{"mafia.arme",0,0,'WEAPON_KNUCKLE', 'Knuckle' },
			{"mafia.arme",0,0,'WEAPON_KNIFE', 'Knife' },
			{"mafia.arme",0,0,'WEAPON_DAGGER', 'Dagger' },
			{"mafia.arme",0,0,'WEAPON_HAMMER', 'Hammer'},
			{"mafia.arme",0,0,'WEAPON_FLASHLIGHT', 'Flashlight' },
			{"mafia.arme",0,0,'WEAPON_MUSKET', 'Musket' },
			{"mafia.arme",0,0,'WEAPON_CROWBAR', 'CrowBar' },
			{"mafia.arme",0,0,'WEAPON_GOLFCLUB', 'Crosa' },
			{"mafia.arme",0,0,'WEAPON_SWITCHBLADE', 'Lama' },
			{"mafia.arme",0,0,'WEAPON_MACHETE', 'Macheta' },
			{"mafia.arme",0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2' },
			{"mafia.arme",0,0,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk2' },	
			{"mafia.arme",0,0,'GADGET_PARACHUTE', 'Parachute', {noPreview = true, noTint = true, noAmmo = true} },
	
		},
		
		{

			name = "Hitman",
			{"armamenthitman.acces",0,0,'WEAPON_PISTOL', 'Pistol' },
			{"armamenthitman.acces",0,0,'WEAPON_REVOLVER_MK2', 'Revolver Mk2' },
			{"armamenthitman.acces",0,0,'WEAPON_PETROLCAN', 'Petrol' },
			{"armamenthitman.acces",0,0,'WEAPON_KNIFE', 'Cutit' },
			{"armamenthitman.acces",0,0,'WEAPON_HAMMER', 'Hammer'},
			{"armamenthitman.acces",0,0,'WEAPON_FLASHLIGHT', 'Flashlight' },
			{"armamenthitman.acces",0,0,'WEAPON_CROWBAR', 'CrowBar' },
			{"armamenthitman.acces",0,0,'WEAPON_SWITCHBLADE', 'Lama' },
			{"armamenthitman.acces",0,0,'WEAPON_MACHETE', 'Macheta' },
			{"armamenthitman.acces",0,0,'WEAPON_PUMPSHOTGUN_MK2', 'Shotgun Mk2' },
			{"armamenthitman.acces",0,0,'WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk2', },
			{"armamenthitman.acces",0,0,'WEAPON_HEAVYSNIPER', 'Heavy Sniper Rifle' },				
			{"armamenthitman.acces",0,0,'GADGET_PARACHUTE', 'Parachute', {noPreview = true, noTint = true, noAmmo = true} },
	
		}]]
	}


local globalAttachmentTable = {  
	-- Putting these at the top makes them work properly as they need to be applied to the weapon first before other attachments
	{ "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_CARBINERIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_MICROSMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_SNIPERRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_PISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_PISTOL50_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_APPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_HEAVYPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_SMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },
	{ "COMPONENT_MARKSMANRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish" },

	--[[{ "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_MG_COMBATMG_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_BULLPUPRIFLE_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_MG_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER", "Lowrider Finish" },
	{ "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER", "Lowrider Finish" },

	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_COMBATMG_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SMG_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_PISTOL_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_PISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_ASSAULTSHOTGUN_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_HEAVYSHOTGUN_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_PISTOL50_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_COMBATPISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_APPISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_COMBATPDW_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SNSPISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SNSPISTOL_MK2_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_ASSAULTRIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_COMBATMG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_MG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_ASSAULTSMG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_GUSENBERG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_MICROSMG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_BULLPUPRIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_COMPACTRIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_HEAVYPISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_VINTAGEPISTOL_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_CARBINERIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_ADVANCEDRIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_MARKSMANRIFLE_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SMG_CLIP_02", "Extended Magazine" },
	{ "COMPONENT_SPECIALCARBINE_CLIP_02", "Extended Magazine" },

	{ "COMPONENT_SPECIALCARBINE_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_COMPACTRIFLE_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_COMBATPDW_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_ASSAULTRIFLE_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_HEAVYSHOTGUN_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_CARBINERIFLE_CLIP_03", "Drum Magazine" },
	{ "COMPONENT_SMG_CLIP_03", "Drum Magazine" },]]

	--[[
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_PISTOL_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_PISTOL_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_PISTOL_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_PISTOL_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_PUMPSHOTGUN_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT", "Hollowpoint Rounds" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE", "Explosive Rounds" },

	{ "COMPONENT_SNSPISTOL_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT", "Hollowpoint Rounds" },
	{ "COMPONENT_SNSPISTOL_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_REVOLVER_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT", "Hollowpoint Rounds" },
	{ "COMPONENT_REVOLVER_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_SMG_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_SMG_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_SMG_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_SMG_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_COMBATMG_MK2_CLIP_TRACER", "Tracer Rounds" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_TRACER", "Tracer Rounds" },

	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY", "Incendiary Rounds" },

	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },
	{ "COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING", "Armor Piercing Rounds" },

	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },
	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },
	{ "COMPONENT_COMBATMG_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ", "Full Metal Jacket Rounds" },

	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE", "Explosive Rounds" },
--]]
	{ "COMPONENT_AT_PI_FLSH_02", "Flashlight" },
	{ "COMPONENT_AT_AR_FLSH	", "Flashlight" },
	{ "COMPONENT_AT_PI_FLSH", "Flashlight" },
	{ "COMPONENT_AT_AR_FLSH", "Flashlight" },
	{ "COMPONENT_AT_PI_FLSH_03", "Flashlight" },

	{ "COMPONENT_AT_PI_SUPP", "Suppressor" },
	{ "COMPONENT_AT_PI_SUPP_02", "Suppressor" },
	{ "COMPONENT_AT_AR_SUPP", "Suppressor" },
	{ "COMPONENT_AT_AR_SUPP_02", "Suppressor" },
	{ "COMPONENT_AT_SR_SUPP", "Suppressor" },
	{ "COMPONENT_AT_SR_SUPP_03", "Suppressor" },

	--[[{ "COMPONENT_AT_PI_COMP", "Compensator" },
	{ "COMPONENT_AT_PI_COMP_02", "Compensator" },
	{ "COMPONENT_AT_PI_COMP_03", "Compensator" },
	{ "COMPONENT_AT_MRFL_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_MRFL_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_SR_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_BP_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_BP_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_SC_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_SC_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_AR_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_SB_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_CR_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_MG_BARREL_01", "Barrel Attachment 1" },
	{ "COMPONENT_AT_MG_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_CR_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_SR_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_SB_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_AR_BARREL_02", "Barrel Attachment 2" },
	{ "COMPONENT_AT_MUZZLE_01", "Muzzle Attachment 1" },
	{ "COMPONENT_AT_MUZZLE_02", "Muzzle Attachment 2" },
	{ "COMPONENT_AT_MUZZLE_03", "Muzzle Attachment 3" },
	{ "COMPONENT_AT_MUZZLE_04", "Muzzle Attachment 4" },
	{ "COMPONENT_AT_MUZZLE_05", "Muzzle Attachment 5" },
	{ "COMPONENT_AT_MUZZLE_06", "Muzzle Attachment 6" },
	{ "COMPONENT_AT_MUZZLE_07", "Muzzle Attachment 7" },]]

	{ "COMPONENT_AT_AR_AFGRIP", "Grip" },
	{ "COMPONENT_AT_AR_AFGRIP_02", "Grip" },

	--[[{ "COMPONENT_AT_PI_RAIL", "Holographic Sight" },
	{ "COMPONENT_AT_SCOPE_MACRO_MK2", "Holographic Sight" },
	{ "COMPONENT_AT_PI_RAIL_02", "Holographic Sight" },
	{ "COMPONENT_AT_SIGHTS_SMG", "Holographic Sight" },
	{ "COMPONENT_AT_SIGHTS", "Holographic Sight" },

	{ "COMPONENT_AT_SCOPE_SMALL", "Scope Small" },
	{ "COMPONENT_AT_SCOPE_SMALL_02", "Scope Small" },

	{ "COMPONENT_AT_SCOPE_MACRO_02", "Scope" },
	{ "COMPONENT_AT_SCOPE_SMALL_02", "Scope" },
	{ "COMPONENT_AT_SCOPE_MACRO", "Scope" },
	{ "COMPONENT_AT_SCOPE_MEDIUM", "Scope" },
	{ "COMPONENT_AT_SCOPE_LARGE", "Scope" },
	{ "COMPONENT_AT_SCOPE_SMALL", "Scope" },

	{ "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2", "2x Scope" },
	{ "COMPONENT_AT_SCOPE_SMALL_MK2", "2x Scope" },

	{ "COMPONENT_AT_SCOPE_SMALL_SMG_MK2", "4x Scope" },
	{ "COMPONENT_AT_SCOPE_MEDIUM_MK2", "4x Scope" },

	{ "COMPONENT_AT_SCOPE_MAX", "Advanced Scope" },
	{ "COMPONENT_AT_SCOPE_LARGE", "Scope Large" },
	{ "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2", "Scope Large" },
	{ "COMPONENT_AT_SCOPE_LARGE_MK2", "8x Scope" },

	{ "COMPONENT_AT_SCOPE_NV", "Nightvision Scope" },
	{ "COMPONENT_AT_SCOPE_THERMAL", "Thermal Scope" },

	--{ "COMPONENT_KNUCKLE_VARMOD_PLAYER", "Default Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_LOVE", "Love Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_DOLLAR", "Dollar Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_VAGOS", "Vagos Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_HATE", "Hate Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_DIAMOND", "Diamond Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_PIMP", "Pimp Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_KING", "King Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_BALLAS", "Ballas Skin" },
	{ "COMPONENT_KNUCKLE_VARMOD_BASE", "Base Skin" },
	{ "COMPONENT_SWITCHBLADE_VARMOD_VAR1", "Default Skin" },
	{ "COMPONENT_SWITCHBLADE_VARMOD_VAR2", "Variant 2 Skin" },
	--{ "COMPONENT_SWITCHBLADE_VARMOD_BASE", "Base Skin" },

	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_IND_01", "American Camo" },

	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01", "American Camo" },

	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01", "American Camo" },

	{ "COMPONENT_REVOLVER_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_REVOLVER_MK2_CAMO_IND_01", "American Camo" },

	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01", "American Camo" },

	{ "COMPONENT_PISTOL_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_SMG_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_COMBATMG_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO", "Camo 1" },
	{ "COMPONENT_PISTOL_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_SMG_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_02", "Camo 2" },
	{ "COMPONENT_PISTOL_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_SMG_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_03", "Camo 3" },
	{ "COMPONENT_PISTOL_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_SMG_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_04", "Camo 4" },
	{ "COMPONENT_PISTOL_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_SMG_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_05", "Camo 5" },
	{ "COMPONENT_PISTOL_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_SMG_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_06", "Camo 6" },
	{ "COMPONENT_PISTOL_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_SMG_MK2_CAMO_07", "Camo 7" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_PISTOL_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_SMG_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_08", "Camo 8" },
	{ "COMPONENT_PISTOL_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_SMG_MK2_CAMO_09", "Camo 9" },
	{ "COMPONENT_PISTOL_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_SMG_MK2_CAMO_10", "Camo 10" },
	{ "COMPONENT_PISTOL_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_SMG_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_COMBATMG_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01", "American Camo" },
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01", "American Camo" },]]
}
local globalTintTable = {
	mk1 = {
		{ 1, "Green Tint" },
		{ 2, "Gold Tint" },
		{ 3, "Pink Tint" },
		{ 4, "Army Tint" },
		{ 5, "LSPD Tint" },
		{ 6, "Orange Tint" },
		{ 7, "Platinum Tint" },
	},
	mk2 = {
		{ 1, "Classic Gray Tint" },
		{ 2, "Classic TwoTone Tint" },
		{ 3, "Classic White Tint" },
		{ 4, "Classic Beige Tint" },
		{ 5, "Classic Green Tint" },
		{ 6, "Classic Blue Tint" },
		{ 7, "Classic Earth Tint" },
		{ 8, "Classic Brown And Black Tint" },
		{ 9, "Red Contrast Tint" },
		{ 10, "Blue Contrast Tint" },
		{ 11, "Yellow Contrast Tint" },
		{ 12, "Orange Contrast Tint" },
		{ 13, "Bold Pink Tint" },
		{ 14, "Bold Purple And Yellow Tint" },
		{ 15, "Bold Orange Tint" },
		{ 16, "Bold Green And Purple Tint" },
		{ 17, "Bold Red Features Tint" },
		{ 18, "Bold Green Features Tint" },
		{ 19, "Bold Cyan Features Tint" },
		{ 20, "Bold Yellow Features Tint" },
		{ 21, "Bold Red And White Tint" },
		{ 22, "Bold Blue And White Tint" },
		{ 23, "Metallic Gold Tint" },
		{ 24, "Metallic Platinum Tint" },
		{ 25, "Metallic Gray And Lilac Tint" },
		{ 26, "Metallic Purple And Lime Tint" },
		{ 27, "Metallic Red Tint" },
		{ 28, "Metallic Green Tint" },
		{ 29, "Metallic Blue Tint" },
		{ 30, "Metallic White And Aqua Tint" },
		{ 31, "Metallic Red And Yellow" },
	}
}
for ci,wepTable in pairs(globalWeaponTable) do
    local className = wepTable.name
    xnWeapons.weaponClasses[ci] = {
        name = className,
        weapons = {},
    }
    local classWepTable = xnWeapons.weaponClasses[ci].weapons
	for wi,weaponObject in ipairs(wepTable) do
		if weaponObject[6] then
			classWepTable[wi] = weaponObject[6]
			classWepTable[wi].name = weaponObject[5]
			classWepTable[wi].model = weaponObject[4]
			classWepTable[wi].level = weaponObject[3]
			classWepTable[wi].pret = weaponObject[2]
			classWepTable[wi].grp = weaponObject[1]
			classWepTable[wi].attachments = {}
		else
			classWepTable[wi] = {
				name = weaponObject[5],
				model = weaponObject[4],
				level = weaponObject[3],
				pret = weaponObject[2],
				grp = weaponObject[1],
				attachments = {},
			}
		end
        local wep = classWepTable[wi]
        for _,attachmentObject in ipairs(globalAttachmentTable) do
            if DoesWeaponTakeWeaponComponent(weaponObject[4], attachmentObject[1]) then
                wep.attachments[#wep.attachments+1] = {
                    name = attachmentObject[2],
                    model = attachmentObject[1]
                }
            end
        end
		wep.clipSize = wep.clipSize or GetWeaponClipSize(weaponObject[4])
		wep.isMK2 = wep.isMK2 or (string.find(weaponObject[4], "_MK2") ~= nil)
    end
end
-- We do this once so that we don't run like 500 tests a tick on weapons and all the information is easily available to the menu

for intID, interior in pairs(xnWeapons.interiorIDs) do
	local additionalOffset = vec(0,0,0)	
	if type(interior) == "table" then
		additionalOffset = interior.additionalOffset or additionalOffset
	end
	
	local locationCoords = GetOffsetFromInteriorInWorldCoords(intID, (1.0),4.7,1.0) + additionalOffset
end


function textOpenMagazin(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


-- LOOP-ul magic de la intrarea in magazin.
Citizen.CreateThread(function()
    local radius = 1.0  
    local waitForPlayerToLeave = true

	while true do Citizen.Wait(1)
		local locatiamea = GetEntityCoords(GetPlayerPed(-1))
		if GetInteriorFromEntity(GetPlayerPed(-1)) ~= 0 and xnWeapons.interiorIDs[GetInteriorFromEntity(GetPlayerPed(-1))] then
			local interiorID = GetInteriorFromEntity(GetPlayerPed(-1))
			local additionalOffset = vec(0,0,0)
			if type(xnWeapons.interiorIDs[interiorID]) == "table" then
				additionalOffset = xnWeapons.interiorIDs[interiorID].additionalOffset or additionalOffset
			end

            for i = 1,3 do
				--if not IsAmmunationOpen() then

						--DrawMarker(22,GetOffsetFromInteriorInWorldCoords(interiorID, (2.0-i),6.0,1.0) + additionalOffset, 0, 0, 0, 0, 0, 0, -0.8001, -0.8001, -0.8001, 168, 104, 40, 255, true, 0, 0, true)
						--infoMesaj( GetOffsetFromInteriorInWorldCoords(interiorID, (2.0-i),6.0,1.0) + additionalOffset, "~w~Cumpara Arme" )

						if (Vdist2(GetOffsetFromInteriorInWorldCoords(interiorID, (2.0-i),6.0,1.0) + additionalOffset, GetEntityCoords(PlayerPedId()))^2 <= radius^2) then
					
							if  waitForPlayerToLeave then
		
								textOpenMagazin("Apasa ~INPUT_CONTEXT~ pentru a deschide magazinul de arme")
								EndTextCommandDisplayHelp(0, 0, true, -1)
								
								if IsControlJustReleased(0, 51) then
									TriggerServerEvent('infoCont')

									SetPlayerControl(PlayerId(), false)

									local additionalCameraOffset = vec(0,0,0)
									local additionalCameraPoint = vec(0,0,0)
									if type(xnWeapons.interiorIDs[interiorID]) == "table" then
										additionalCameraOffset = xnWeapons.interiorIDs[interiorID].additionalCameraOffset or additionalCameraOffset
										additionalCameraPoint = xnWeapons.interiorIDs[interiorID].additionalCameraPoint or additionalCameraPoint
									end
									
									xnWeapons.currentMenuCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA")
									local cam = xnWeapons.currentMenuCamera
									SetCamCoord(cam, GetOffsetFromInteriorInWorldCoords(interiorID, 3.25,6.5,2.0) + additionalCameraOffset)
									PointCamAtCoord(cam, GetOffsetFromInteriorInWorldCoords(interiorID, 5.0,6.5,2.0) + additionalCameraOffset + additionalCameraPoint)

									SetCamActive(cam, true)
									RenderScriptCams(true, 1, 600, 300, 0)

									Citizen.Wait(1000)

									JayMenu.OpenMenu("xnweapons")

									waitForPlayerToLeave = true
								end
							end
					--	else
							--if waitForPlayerToLeave then waitForPlayerToLeave = false end
					--	end
					--end
				end
			end
			additionalOffset = nil
			interiorID = nil
		end
    end
end)

local function IsWeaponMK2(weaponModel)
    return string.find(weaponModel, "_MK2")
end
local function DoesPlayerOwnWeapon(weaponModel)
    return HasPedGotWeapon(GetPlayerPed(-1), weaponModel, 0)
end


local function DoesPlayerWeaponHaveComponent(weaponModel, componentModel)
    return (DoesPlayerOwnWeapon(weaponModel) and HasPedGotWeaponComponent(GetPlayerPed(-1), weaponModel, componentModel) or false)
end

local function IsPlayerWeaponTintActive(weaponModel, tint)
	return (tint == GetPedWeaponTintIndex(GetPlayerPed(-1), weaponModel))
end

Citizen.CreateThread(function()
	function CreateFakeWeaponObject(weapon, keepOldWeapon)
		if weapon.noPreview then
			if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
			xnWeapons.fakeWeaponObject = false
			return false 
		end

		local weaponWorldModel = GetWeapontypeModel(weapon.model)
		RequestModel(weaponWorldModel)
		while not HasModelLoaded(weaponWorldModel) do Citizen.Wait(0) end
		
		local interiorID = GetInteriorFromEntity(GetPlayerPed(-1))
		local rotationOffset = 0.0
		local additionalOffset = vec(0,0,0)
		local additionalWeaponOffset = vec(0,0,0)
		if type(xnWeapons.interiorIDs[interiorID]) == "table" then
			rotationOffset = xnWeapons.interiorIDs[interiorID].weaponRotationOffset or 0.0
			additionalOffset = xnWeapons.interiorIDs[interiorID].additionalOffset or additionalOffset
			additionalWeaponOffset = xnWeapons.interiorIDs[interiorID].additionalWeaponOffset or additionalWeaponOffset
		end
		local extraAdditionalWeaponOffset = weapon.offset or vec(0,0,0)

		local fakeWeaponCoords = (GetOffsetFromInteriorInWorldCoords(interiorID, 4.0,6.25,2.0) + additionalOffset) + additionalWeaponOffset + extraAdditionalWeaponOffset
		local fakeWeapon = CreateWeaponObject(weapon.model, weapon.clipSize*3, fakeWeaponCoords, true, 0.0)
		SetEntityAlpha(fakeWeapon, 0)
		SetEntityHeading(fakeWeapon, (GetCamRot(GetRenderingCam(), 1).z - 180)+rotationOffset)
		SetEntityCoordsNoOffset(fakeWeapon, fakeWeaponCoords)

		for i,attach in ipairs(weapon.attachments) do
			if DoesPlayerWeaponHaveComponent(weapon.model, attach.model) then
				GiveWeaponComponentToWeaponObject(fakeWeapon, attach.model)
			end
		end
		if DoesPlayerOwnWeapon(weapon.model) then SetWeaponObjectTintIndex(fakeWeapon, GetPedWeaponTintIndex(GetPlayerPed(-1), weapon.model)) end

		if not keepOldWeapon then
			SetEntityAlpha(fakeWeapon, 255)
			if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
			xnWeapons.fakeWeaponObject = fakeWeapon
		end

		return fakeWeapon
	end
end)

local currentTempWeapon = false
local tempWeaponLocked = false
local function SetTempWeapon(weapon)		
	if (not currentTempWeapon and weapon) or currentTempWeapon ~= weapon.model then
		currentTempWeapon = weapon
		if weapon == false then
			if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
		else
			if not tempWeaponLocked then
				tempWeaponLocked = true
				Citizen.CreateThread(function()
					CreateFakeWeaponObject(weapon)
					currentTempWeapon = weapon.model
					tempWeaponLocked = false
				end)
			end
		end
	end
end

local currentTempWeaponConfig = {
	component = false,
	tint = false,
}
local function SetTempWeaponConfig(weapon, component, tint)
	Citizen.CreateThread(function()
		if currentTempWeaponConfig.component ~= component or currentTempWeaponConfig.tint ~= tint then
			currentTempWeaponConfig = {
				component = component,
				tint = tint,
			}
			local fakeWeapon = CreateFakeWeaponObject(weapon, true)
			Citizen.Wait(1)
			if currentTempWeaponConfig.component then
				local attachWorldModel = GetWeaponComponentTypeModel(currentTempWeaponConfig.component)
				RequestModel(attachWorldModel)
				while not HasModelLoaded(attachWorldModel) do Citizen.Wait(0) end
				GiveWeaponComponentToWeaponObject(fakeWeapon, currentTempWeaponConfig.component)
			end
			if currentTempWeaponConfig.tint then
				SetWeaponObjectTintIndex(fakeWeapon, currentTempWeaponConfig.tint)
			else
				SetWeaponObjectTintIndex(fakeWeapon, GetPedWeaponTintIndex(GetPlayerPed(-1), weapon.model))
			end
			
			-- Wait until we have assigned all the attachments and shit before we actually override the current weapon preview
			SetEntityAlpha(fakeWeapon, 255)
			if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
			xnWeapons.fakeWeaponObject = fakeWeapon
		end
	end)
end

local function GiveWeapon(weaponhash, weaponammo)
    GiveWeaponToPed(GetPlayerPed(-1), weaponhash, weaponammo, false, true)
	SetPedAmmoByType(GetPlayerPed(-1), GetPedAmmoTypeFromWeapon_2(GetPlayerPed(-1), weaponhash), weaponammo)
end

local function GiveAmmo(weaponHash, ammo)
    AddAmmoToPed(GetPlayerPed(-1), weaponHash, ammo)
end

local function GiveMaxAmmo(weaponHash)
	local gotMaxAmmo, maxAmmo = GetMaxAmmo(GetPlayerPed(-1), weaponHash)
	if not gotMaxAmmo then maxAmmo = 99999 end
	SetAmmoInClip(GetPlayerPed(-1), weaponHash, GetWeaponClipSize(weaponHash))
    AddAmmoToPed(GetPlayerPed(-1), weaponHash, maxAmmo) 
end

local function RemoveWeapon(weaponhash)
    RemoveWeaponFromPed(GetPlayerPed(-1), weaponhash)
end

local function GiveComponent(weaponname, componentname, weapon)
	GiveWeaponComponentToPed(GetPlayerPed(-1), weaponname, componentname)
	CreateFakeWeaponObject(weapon)
end

local function RemoveComponent(weaponname, componentname, weapon)
	RemoveWeaponComponentFromPed(GetPlayerPed(-1), weaponname, componentname)
	CreateFakeWeaponObject(weapon)
end

local function SetPlayerWeaponTint(weaponname, tint, weapon)
	SetPedWeaponTintIndex(GetPlayerPed(-1), weaponname, tint)
	CreateFakeWeaponObject(weapon)
end

-- Weapon Saving
local weaponsCanSave = false -- prevent weapons from saving before they are loaded
Citizen.CreateThread(function()
	while GetIsLoadingScreenActive() and not PlayerPedId() do Citizen.Wait(0) end

	if GetConvar("xnw_enableWeaponSaving", true) then
		local loadedWeapons = json.decode(GetResourceKvpString("xnAmmunation:weapons") or "[]")
		for i,weapon in ipairs(loadedWeapons) do
			GiveWeaponToPed(GetPlayerPed(-1), weapon.model, 0, false, true)
			for i,attach in ipairs(weapon.attachments) do
				GiveWeaponComponentToPed(GetPlayerPed(-1), weapon.model, attach.model)
			end
			SetPedWeaponTintIndex(GetPlayerPed(-1), weapon.model, weapon.tint)
			GiveAmmo(weapon.model, weapon.ammo)
		end
		SetPedCurrentWeaponVisible(PlayerPedId(), false, true)
		weaponsCanSave = true
	end
end)

local function SaveWeapons()
	if GetConvar("xnw_enableWeaponSaving", true) then
		local currentWeapons = {}

		for i,class in ipairs(xnWeapons.weaponClasses) do
			for i,weapon in ipairs(class.weapons) do
				if DoesPlayerOwnWeapon(weapon.model) then -- Construct weapons for saving
					local savedweapon = {
						model = weapon.model,
						tint = GetPedWeaponTintIndex(GetPlayerPed(-1), weapon.model),
						ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon.model),
						attachments = {},
					}
					for i,attach in ipairs(weapon.attachments) do
						if DoesPlayerWeaponHaveComponent(weapon.model, attach.model) then
							savedweapon.attachments[#savedweapon.attachments+1] = attach
						end
					end

					currentWeapons[#currentWeapons+1] = savedweapon
				end
			end
		end
		SetResourceKvp("xnAmmunation:weapons", json.encode(currentWeapons))

	end
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		if weaponsCanSave then
			SaveWeapons()
		end
	end
end)


local function ReleaseWeaponModels()
	for ci,wepTable in pairs(globalWeaponTable) do
		for wi,weaponObject in ipairs(wepTable) do
			if weaponObject[3] and HasModelLoaded(GetWeapontypeModel(weaponObject[3])) then
				SetModelAsNoLongerNeeded(GetWeapontypeModel(weaponObject[3]))
				--print("released "..GetWeapontypeModel(weaponObject[1]))
			end
		end
	end
end


function plateste(pret)
	TriggerServerEvent("plateste",pret)
end


Citizen.CreateThread(function()
    JayMenu.CreateMenu("xnweapons", "Ammunation", function()
		SetPlayerControl(PlayerId(), true)
		SetCamActive(cam, false)
		RenderScriptCams(false, 1, 600, 300, 300)
		if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
		SetPedDropsWeaponsWhenDead(GetPlayerPed(-1), false)
		SaveWeapons() -- Once they exit the store, save their inventory
		ReleaseWeaponModels()
        return true
    end)
	JayMenu.SetSubTitle('xnweapons', "Weapons")

	JayMenu.CreateSubMenu("xnweapons_removeall_confirm","xnweapons","Esti sigur?")

    for i,class in ipairs(xnWeapons.weaponClasses) do -- Create all menus for all weapons programatically
		JayMenu.CreateSubMenu("xnw_"..class.name, "xnweapons", class.name, function() 
			if DoesEntityExist(xnWeapons.fakeWeaponObject) then DeleteObject(xnWeapons.fakeWeaponObject) end
			return true
		end)

        for i,weapon in ipairs(class.weapons) do
			JayMenu.CreateSubMenu("xnw_"..class.name.."_"..weapon.model, "xnw_"..class.name, weapon.name, function() 
				SetTempWeaponConfig(weapon, false, false)
				return true
			end)
        end
	end
	
	while true do Citizen.Wait(0)
		if IsAmmunationOpen() then
			if JayMenu.IsMenuOpened('xnweapons') then
				for i,class in ipairs(xnWeapons.weaponClasses) do
					JayMenu.MenuButton(class.name, "xnw_"..class.name)
				end
				
				JayMenu.MenuButton("~r~Sterge toate armele", "xnweapons_removeall_confirm")
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened('xnweapons_removeall_confirm') then
				if JayMenu.Button("Nu") then JayMenu.SwitchMenu("xnweapons")
				elseif JayMenu.Button("~r~Da") then
					for i,class in ipairs(xnWeapons.weaponClasses) do
						for i,weapon in ipairs(class.weapons) do
							if DoesPlayerOwnWeapon(weapon.model) then
								RemoveWeapon(weapon.model)
								TriggerServerEvent('stergeToateArmele')
								vRP.notify({"Ai aruncat toate armele!"})
							end
						end
					end
					SaveWeapons()
					JayMenu.SwitchMenu("xnweapons")
				end
				JayMenu.Display()
			end



			for i,class in ipairs(xnWeapons.weaponClasses) do
				if JayMenu.IsMenuOpened("xnw_"..class.name) then
					for i,weapon in ipairs(class.weapons) do

						if DoesPlayerOwnWeapon(weapon.model) then
							local clicked, hovered = JayMenu.SpriteMenuButton(weapon.name, "commonmenu", "shop_gunclub_icon_a", "shop_gunclub_icon_b", "xnw_"..class.name.."_"..weapon.model)
							if clicked then
								SetCurrentPedWeapon(GetPlayerPed(-1), weapon.model, true)
								CreateFakeWeaponObject(weapon)
							elseif hovered then
								SetTempWeapon(weapon)
							end
						else
							pretul = weapon.pret
							levelul = weapon.level
							armaNume = weapon.name
							armaModel = weapon.model
							clasa = class.name
							gloante = weapon.clipSize
							grupa = weapon.grp
								local clicked, hovered = JayMenu.Button(armaNume.."~b~(L "..levelul..")~w~", pretul)
								if clicked then
									--if levelactual >= levelul and baniact >= pretul then
										TriggerServerEvent('cumpara',pretul,armaNume,armaModel,clasa,gloante,levelul,grupa)
										--GiveWeapon(weapon.model, weapon.clipSize*3)
										SetCurrentPedWeapon(GetPlayerPed(-1), weapon.model, true)
										CreateFakeWeaponObject(weapon)
										--vRP.notify({"Ai cumparat cu succes ~b~"..armaNume})
										--JayMenu.SwitchMenu("xnw_"..class.name.."_"..weapon.model)
									--else
										--vRP.notify({"A aparut o eroare in cumpararea ~b~"..arma})
									--end
								elseif hovered then
									SetTempWeapon(weapon)
								end
						end

					end
					JayMenu.Display()
				end


				for i,weapon in ipairs(class.weapons) do
					if JayMenu.IsMenuOpened("xnw_"..class.name.."_"..weapon.model) then
						pretArmaVanzare = weapon.pret/2
						pretGloanteX = weapon.clipSize*1.5
						gloantenevoiase = weapon.clipSize
						pretGloanteFull = 20
						armaModel = weapon.model
						if JayMenu.Button("~r~Vinde Arma ~g~"..tonumber(pretArmaVanzare)) then
							armaNumepecifica = weapon.name
							TriggerServerEvent('stergearmaNumepecifica',armaNumepecifica,armaModel,pretArmaVanzare)
							--RemoveWeapon(weapon.model)
							JayMenu.SwitchMenu("xnw_"..class.name)
						end
						if not weapon.noAmmo then
							if JayMenu.Button(weapon.clipSize.."x Gloante", "~g~$"..pretGloanteX) then
									GiveAmmo(weapon.model, weapon.clipSize)
									--plateste(pretGloanteX)
									TriggerServerEvent('updateGloanteX',armaModel,gloantenevoiase,pretGloanteX)
							end
							if JayMenu.Button("Reincarca Arma", "~g~$ "..pretGloanteX) then
									GiveMaxAmmo(weapon.model)
									--plateste(pretGloanteFull)
									TriggerServerEvent('updateGloanteArmaFull',armaModel,pretGloanteFull)
							end
						end
						for i,attachment in ipairs(weapon.attachments) do			
							if DoesPlayerWeaponHaveComponent(weapon.model, attachment.model) then -- If equipped show the gun icon, else show a tick because they "own" the attachment already
								local clicked, hovered = JayMenu.SpriteButton(attachment.name, "commonmenu", "shop_gunclub_icon_a", "shop_gunclub_icon_b")
								if clicked then
									RemoveComponent(weapon.model, attachment.model, weapon)
								elseif hovered then
									SetTempWeaponConfig(weapon, false, false)
								end
							else
								local clicked, hovered = JayMenu.SpriteButton(attachment.name, "commonmenu", "shop_tick_icon")
								if clicked then
									armaNumeAt = attachment.name
									armaModelAt = attachment.model
									armaModel = weapon.model
									TriggerServerEvent('atasamentArma',armaModel,armaModelAt,armaNumeAt)
									GiveComponent(weapon.model, attachment.model, weapon)
								elseif hovered then
									SetTempWeaponConfig(weapon, attachment.model, false)
								end
							end
						end
						

						JayMenu.Display()
						DisplayAmmoThisFrame(true)
					end
				end
			end

			if xnWeapons.closeMenuNextFrame then
				xnWeapons.closeMenuNextFrame = false
				JayMenu.CloseMenu()
			end
		end
    end
end)

SetPlayerControl(PlayerId(), true)
RenderScriptCams(false, 0, 0, 0, 0)

RegisterNetEvent('daiArma')
AddEventHandler('daiArma',function(hhh3,glonturile)
	GiveWeapon(hhh3,glonturile)
end)

RegisterNetEvent('daiGloanteFull')
AddEventHandler('daiGloanteFull',function(armaModel,gloantefull)
	--print(armaModel,gloantefull)
	GiveMaxAmmo(armaModel)
end)
RegisterNetEvent('daiGloanteLaArma')
AddEventHandler('daiGloanteLaArma',function(armaModel,gloantenevoiase)
	--print(armaModel,gloantenevoiase)
	GiveAmmo(armaModel, gloantenevoiase)
end)

RegisterNetEvent('stergearmaNumepecificade')
AddEventHandler('stergearmaNumepecificade',function(armaNumepecifica,armaModel)
	RemoveWeapon(armaModel)
end)



function string:split( inSplitPattern, outResults )
	if not outResults then
	  outResults = { }
	end
	local theStart = 1
	local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	while theSplitStart do
	  table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
	  theStart = theSplitEnd + 1
	  theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	end
	table.insert( outResults, string.sub( self, theStart ) )
	return outResults
end

function weaponComponent(weaponHash, component)
	if HasPedGotWeapon(PlayerPedId(), GetHashKey(weaponHash), false) then
		GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(weaponHash), GetHashKey(component))
	 end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		for k,v in pairs (tabelaArme) do
			idUser = v.user_id
			clasaArmei = v.clasa
			armaNabului = v.weapon
			armaNabHash = v.hash
			glonturile = v.gloante
			atasamentili = v.atasamente
			gloanteUpdate = GetAmmoInPedWeapon(GetPlayerPed(-1),armaNabHash)
			--print(armaNabHash,gloanteUpdate)
			TriggerServerEvent('updateArma',armaNabHash,gloanteUpdate)
		end
	end
end)