
local cfg = {}

-- list of weapons for sale
-- for the native name, see the tattoos folder, the native names of the tattoos is in the files with the native name of the it's shop
-- create groups like for the garage config
-- [native_tattoo_name] = {display_name,price,description}

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)
-- https://wiki.gtanet.work/index.php?title=Blips
-- https://wiki.fivem.net/wiki/Controls

cfg.tattoos = {
	["mpbeach_overlays"] = { -- native store name
		_config = {blipid=75,blipcolor=48,title="Beach Tattoos"}, -- you can add permissions like on other vRP features
		["CLEAR"] = {">Clear Tattoos",45,""},
		["MP_Bea_M_Head_000"] = {"Head Tattoo 1",45,""},
		["MP_Bea_M_Head_001"] = {"Head Tattoo 2",45,""},
		["MP_Bea_M_Head_002"] = {"Head Tattoo 3",45,""},
		["MP_Bea_F_Neck_000"] = {"Neck Tattoo 1",45,""},
		["MP_Bea_M_Neck_000"] = {"Neck Tattoo 2",45,""},
		["MP_Bea_M_Neck_001"] = {"Neck Tattoo 3",45,""},
		["MP_Bea_F_Back_000"] = {"Back Tattoo 1",45,""},
		["MP_Bea_F_Back_001"] = {"Back Tattoo 2",45,""},
		["MP_Bea_F_Back_002"] = {"Back Tattoo 3",45,""},
		["MP_Bea_M_Back_000"] = {"Back Tattoo 4",45,""},
		["MP_Bea_F_Chest_000"] = {"Torso Tattoo 1",45,""},
		["MP_Bea_F_Chest_001"] = {"Torso Tattoo 2",45,""},
		["MP_Bea_F_Chest_002"] = {"Torso Tattoo 3",45,""},
		["MP_Bea_M_Chest_000"] = {"Torso Tattoo 4",45,""},
		["MP_Bea_M_Chest_001"] = {"Torso Tattoo 5",45,""},
		["MP_Bea_F_Stom_000"] = {"Torso Tattoo 6",45,""},
		["MP_Bea_F_Stom_001"] = {"Torso Tattoo 7",45,""},
		["MP_Bea_F_Stom_002"] = {"Torso Tattoo 8",45,""},
		["MP_Bea_M_Stom_000"] = {"Torso Tattoo 9",45,""}, 
		["MP_Bea_M_Stom_001"] = {"Torso Tattoo 10",45,""},
		["MP_Bea_F_RSide_000"] = {"Torso Tattoo 11",45,""},
		["MP_Bea_F_Should_000"] = {"Torso Tattoo 12",45,""},
		["MP_Bea_F_Should_001"] = {"Torso Tattoo 13",45,""},
		["MP_Bea_F_RArm_001"] = {"Right Arm Tattoo 1",45,""},
		["MP_Bea_M_RArm_001"] = {"Right Arm Tattoo 2",45,""},
		["MP_Bea_M_RArm_000"] = {"Right Arm Tattoo 3",45,""},
		["MP_Bea_F_LArm_000"] = {"Left Arm Tattoo 1",45,""},
		["MP_Bea_F_LArm_001"] = {"Left Arm Tattoo 2",45,""},
		["MP_Bea_M_LArm_000"] = {"Left Arm Tattoo 3",45,""}, 
		["MP_Bea_M_Lleg_000"] = {"Left Leg Tattoo",45,""},
		["MP_Bea_F_RLeg_000"] = {"Right Leg Tattoo",45,""}
	},
	["mpbusiness_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="Business Tattoos"},
		["CLEAR"] = {">Clear Tattoos",45,""},
		["MP_Buis_M_Neck_000"] = {"Neck Tattoo 1",45,""},
		["MP_Buis_M_Neck_001"] = {"Neck Tattoo 2",45,""},
		["MP_Buis_M_Neck_002"] = {"Neck Tattoo 3",45,""},
		["MP_Buis_M_Neck_003"] = {"Neck Tattoo 4",45,""},
		["MP_Buis_M_LeftArm_000"] = {"Left Arm Tattoo 1",45,""},
		["MP_Buis_M_LeftArm_001"] = {"Left Arm Tattoo 2",45,""},
		["MP_Buis_M_RightArm_000"] = {"Right Arm Tattoo 1",45,""},
		["MP_Buis_M_RightArm_001"] = {"Right Arm Tattoo 2",45,""},
		["MP_Buis_M_Stomach_000"] = {"Stomach Tattoo 1",45,""},
		["MP_Buis_M_Chest_000"] = {"Chest Tattoo 1",45,""},
		["MP_Buis_M_Chest_001"] = {"Chest Tattoo 2",45,""},
		["MP_Buis_M_Back_000"] = {"Back Tattoo 1",45,""},
		["MP_Buis_F_Chest_000"] = {"Chest Tattoo 3",45,""},
		["MP_Buis_F_Chest_001"] = {"Chest Tattoo 4",45,""},
		["MP_Buis_F_Chest_002"] = {"Chest Tattoo 5",45,""},
		["MP_Buis_F_Stom_000"] = {"Stomach Tattoo 2",45,""},
		["MP_Buis_F_Stom_001"] = {"Stomach Tattoo 3",45,""},
		["MP_Buis_F_Stom_002"] = {"Stomach Tattoo 4",45,""},
		["MP_Buis_F_Back_000"] = {"Back Tattoo 2",45,""},
		["MP_Buis_F_Back_001"] = {"Back Tattoo 3",45,""},
		["MP_Buis_F_Neck_000"] = {"Neck Tattoo 5",45,""},
		["MP_Buis_F_Neck_001"] = {"Neck Tattoo 6",45,""},
		["MP_Buis_F_RArm_000"] = {"Right Arm Tattoo 3",45,""},
		["MP_Buis_F_LArm_000"] = {"Left Arm Tattoo 3",45,""},
		["MP_Buis_F_LLeg_000"] = {"Left Leg Tattoo",45,""},
		["MP_Buis_F_RLeg_000"] = {"Right Leg Tattoo",45,""}

	},

	["mphipster_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="Hipster Tattoos"},
		["CLEAR"] = {">Clear Tattoos",45,""},
		["FM_Hip_M_Tat_000"] = {"Hipster Tattoo 1",45,""},
		["FM_Hip_M_Tat_001"] = {"Hipster Tattoo 2",45,""},
		["FM_Hip_M_Tat_002"] = {"Hipster Tattoo 3",45,""},
		["FM_Hip_M_Tat_003"] = {"Hipster Tattoo 4",45,""},
		["FM_Hip_M_Tat_004"] = {"Hipster Tattoo 5",45,""},
		["FM_Hip_M_Tat_005"] = {"Hipster Tattoo 6",45,""},
		["FM_Hip_M_Tat_006"] = {"Hipster Tattoo 7",45,""},
		["FM_Hip_M_Tat_007"] = {"Hipster Tattoo 8",45,""},
		["FM_Hip_M_Tat_008"] = {"Hipster Tattoo 9",45,""},
		["FM_Hip_M_Tat_009"] = {"Hipster Tattoo 10",45,""},
		["FM_Hip_M_Tat_010"] = {"Hipster Tattoo 11",45,""},
		["FM_Hip_M_Tat_011"] = {"Hipster Tattoo 12",45,""},
		["FM_Hip_M_Tat_012"] = {"Hipster Tattoo 13",45,""},
		["FM_Hip_M_Tat_013"] = {"Hipster Tattoo 14",45,""},
		["FM_Hip_M_Tat_014"] = {"Hipster Tattoo 15",45,""},
		["FM_Hip_M_Tat_015"] = {"Hipster Tattoo 16",45,""},
		["FM_Hip_M_Tat_016"] = {"Hipster Tattoo 17",45,""},
		["FM_Hip_M_Tat_017"] = {"Hipster Tattoo 18",45,""},
		["FM_Hip_M_Tat_018"] = {"Hipster Tattoo 19",45,""},
		["FM_Hip_M_Tat_019"] = {"Hipster Tattoo 20",45,""},
		["FM_Hip_M_Tat_020"] = {"Hipster Tattoo 21",45,""},
		["FM_Hip_M_Tat_021"] = {"Hipster Tattoo 22",45,""},
		["FM_Hip_M_Tat_022"] = {"Hipster Tattoo 23",45,""},
		["FM_Hip_M_Tat_023"] = {"Hipster Tattoo 24",45,""},
		["FM_Hip_M_Tat_024"] = {"Hipster Tattoo 25",45,""},
		["FM_Hip_M_Tat_025"] = {"Hipster Tattoo 26",45,""},
		["FM_Hip_M_Tat_026"] = {"Hipster Tattoo 27",45,""},
		["FM_Hip_M_Tat_027"] = {"Hipster Tattoo 28",45,""},
		["FM_Hip_M_Tat_028"] = {"Hipster Tattoo 29",45,""},
		["FM_Hip_M_Tat_029"] = {"Hipster Tattoo 30",45,""},
		["FM_Hip_M_Tat_030"] = {"Hipster Tattoo 31",45,""},
		["FM_Hip_M_Tat_031"] = {"Hipster Tattoo 32",45,""},
		["FM_Hip_M_Tat_032"] = {"Hipster Tattoo 33",45,""},
		["FM_Hip_M_Tat_033"] = {"Hipster Tattoo 34",45,""},
		["FM_Hip_M_Tat_034"] = {"Hipster Tattoo 35",45,""},
		["FM_Hip_M_Tat_035"] = {"Hipster Tattoo 36",45,""},
		["FM_Hip_M_Tat_036"] = {"Hipster Tattoo 37",45,""},
		["FM_Hip_M_Tat_037"] = {"Hipster Tattoo 38",45,""},
		["FM_Hip_M_Tat_038"] = {"Hipster Tattoo 39",45,""},
		["FM_Hip_M_Tat_039"] = {"Hipster Tattoo 40",45,""},
		["FM_Hip_M_Tat_040"] = {"Hipster Tattoo 41",45,""},
		["FM_Hip_M_Tat_041"] = {"Hipster Tattoo 42",45,""},
		["FM_Hip_M_Tat_042"] = {"Hipster Tattoo 43",45,""},
		["FM_Hip_M_Tat_043"] = {"Hipster Tattoo 44",45,""}, 
		["FM_Hip_M_Tat_044"] = {"Hipster Tattoo 45",45,""},
		["FM_Hip_M_Tat_045"] = {"Hipster Tattoo 46",45,""},
		["FM_Hip_M_Tat_046"] = {"Hipster Tattoo 47",45,""},
		["FM_Hip_M_Tat_047"] = {"Hipster Tattoo 48",45,""},
		["FM_Hip_M_Tat_048"] = {"Hipster Tattoo 49",45,""}
	},
}

-- list of tattooshops positions
cfg.shops = {
  {"mpbeach_overlays", 1322.645,-1651.976,52.275},
  {"mpbeach_overlays", -1153.676,-1425.68,4.954},
  {"mpbusiness_overlays", 322.139,180.467,103.587},
  {"mpbusiness_overlays", -3170.071,1075.059,20.829},
  {"mphipster_overlays", 1864.633,3747.738,33.032},
  {"mphipster_overlays", -293.713,6200.04,31.487}
}

return cfg
