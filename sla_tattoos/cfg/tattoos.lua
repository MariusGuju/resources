
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
		_config = {blipcolor=75,blipcolor=49,title="Beach Tattoos"}, -- you can add permissions like on other vRP features
		["CLEAR"] = {">Clear Tattoos",500,""},
		["MP_Bea_M_Head_000"] = {"Head Tattoo 1",500,"<img src='https://i.imgur.com/JEZLJzZ.png' height='162' width='280' />"},
		["MP_Bea_M_Head_001"] = {"Head Tattoo 2",500,"<img src='https://i.imgur.com/wZUJBc9.png' height='162' width='280' />"},
		["MP_Bea_M_Head_002"] = {"Head Tattoo 3",500,"<img src='https://i.imgur.com/uoEvZje.png' height='162' width='280' />"},
		["MP_Bea_F_Neck_000"] = {"Neck Tattoo 1",500,"<img src='https://i.imgur.com/Kq6o4J8.png' height='162' width='280' />"},
		["MP_Bea_M_Neck_000"] = {"Neck Tattoo 2",500,"<img src='https://i.imgur.com/TgcH07D.png' height='162' width='280' />"},
		["MP_Bea_M_Neck_001"] = {"Neck Tattoo 3",500,"<img src='https://i.imgur.com/frS8LUC.png' height='162' width='280' />"},
		["MP_Bea_F_Back_000"] = {"Back Tattoo 1",500,"<img src='https://i.imgur.com/M4MPIhP.png' height='162' width='280' />"},
		["MP_Bea_F_Back_001"] = {"Back Tattoo 2",500,"<img src='https://i.imgur.com/JRWWa6f.png' height='162' width='280' />"},
		["MP_Bea_F_Back_002"] = {"Back Tattoo 3",500,"<img src='https://i.imgur.com/dIabU9z.png' height='162' width='280' />"},
		["MP_Bea_M_Back_000"] = {"Back Tattoo 4",500,"<img src='https://i.imgur.com/QtdCbdF.png' height='162' width='280' />"},
		["MP_Bea_F_Chest_000"] = {"Torso Tattoo 1",500,"<img src='https://i.imgur.com/3ULTaFj.png' height='162' width='280' />"},
		["MP_Bea_F_Chest_001"] = {"Torso Tattoo 2",500,"<img src='https://i.imgur.com/RHTq7yR.png' height='162' width='280' />"},
		["MP_Bea_F_Chest_002"] = {"Torso Tattoo 3",500,"<img src='https://i.imgur.com/NHgD6UD.png' height='162' width='280' />"},
		["MP_Bea_M_Chest_000"] = {"Torso Tattoo 4",500,"<img src='https://i.imgur.com/cWmHBat.png' height='162' width='280' />"},
		["MP_Bea_M_Chest_001"] = {"Torso Tattoo 5",500,"<img src='https://i.imgur.com/qVk7ibL.png' height='162' width='280' />"},
		["MP_Bea_F_Stom_000"] = {"Torso Tattoo 6",500,"<img src='https://i.imgur.com/JkRX0nl.png' height='162' width='280' />"},
		["MP_Bea_F_Stom_001"] = {"Torso Tattoo 7",500,"<img src='https://i.imgur.com/vQeKMMt.png' height='162' width='280' />"},
		["MP_Bea_F_Stom_002"] = {"Torso Tattoo 8",500,"<img src='https://i.imgur.com/7Y13Br9.png' height='162' width='280' />"},
		["MP_Bea_M_Stom_000"] = {"Torso Tattoo 9",500,"<img src='https://i.imgur.com/EEYbzCY.png' height='162' width='280' />"}, 
		["MP_Bea_M_Stom_001"] = {"Torso Tattoo 10",500,"<img src='https://i.imgur.com/j7XXT66.png' height='162' width='280' />"},
		["MP_Bea_F_RSide_000"] = {"Torso Tattoo 11",500,"<img src='https://i.imgur.com/nGmSvDG.png' height='162' width='280' />"},
		["MP_Bea_F_Should_000"] = {"Torso Tattoo 12",500,"<img src='https://i.imgur.com/RMmGcp6.png' height='162' width='280' />"},
		["MP_Bea_F_Should_001"] = {"Torso Tattoo 13",500,"<img src='https://i.imgur.com/O6QxW6k.png' height='162' width='280' />"},
		["MP_Bea_F_RArm_001"] = {"Right Arm Tattoo 1",500,"<img src='https://i.imgur.com/WCb7xz6.png' height='162' width='280' />"},
		["MP_Bea_M_RArm_001"] = {"Right Arm Tattoo 2",500,"<img src='https://i.imgur.com/UWKHQgF.png' height='162' width='280' />"},
		["MP_Bea_M_RArm_000"] = {"Right Arm Tattoo 3",500,"<img src='https://i.imgur.com/bL00JgF.png' height='162' width='280' />"},
		["MP_Bea_F_LArm_000"] = {"Left Arm Tattoo 1",500,"<img src='https://i.imgur.com/Kmwunbo.png' height='162' width='280' />"},
		["MP_Bea_F_LArm_001"] = {"Left Arm Tattoo 2",500,"<img src='https://i.imgur.com/D3FUiwn.png' height='162' width='280' />"},
		["MP_Bea_M_LArm_000"] = {"Left Arm Tattoo 3",500,"<img src='https://i.imgur.com/8OJnDIv.png' height='162' width='280' />"}, 
		["MP_Bea_M_Lleg_000"] = {"Left Leg Tattoo",500,"<img src='https://i.imgur.com/V3nlE87.png' height='162' width='280' />"},
		["MP_Bea_F_RLeg_000"] = {"Right Leg Tattoo",500,"<img src='https://i.imgur.com/cB43Ac5.png' height='162' width='280' />"}
	},
	
	["mphipster_overlays"] = {
		_config = {blipcolor=48,title="Hipster Tattoos"},
		["CLEAR"] = {">Clear Tattoos",500,""},
		["FM_Hip_M_Tat_000"] = {"Hipster Tattoo 1",500,"<img src='https://i.imgur.com/f9LK0l6.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_001"] = {"Hipster Tattoo 2",500,"<img src='https://i.imgur.com/F1zfvmn.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_002"] = {"Hipster Tattoo 3",500,"<img src='https://i.imgur.com/wgnyoev.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_003"] = {"Hipster Tattoo 4",500,"<img src='https://i.imgur.com/mdIBaz0.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_004"] = {"Hipster Tattoo 5",500,"<img src='https://i.imgur.com/5Q0qSMF.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_005"] = {"Hipster Tattoo 6",500,"<img src='https://i.imgur.com/duUGIlF.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_006"] = {"Hipster Tattoo 7",500,"<img src='https://i.imgur.com/zTy9Sqc.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_007"] = {"Hipster Tattoo 8",500,"<img src='https://i.imgur.com/8dVNKQy.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_008"] = {"Hipster Tattoo 9",500,"<img src='https://i.imgur.com/m7TJuSc.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_009"] = {"Hipster Tattoo 10",500,"<img src='https://i.imgur.com/nkSfWb6.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_010"] = {"Hipster Tattoo 11",500,"<img src='https://i.imgur.com/RQGKSFX.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_011"] = {"Hipster Tattoo 12",500,"<img src='https://i.imgur.com/QQ6GfLo.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_012"] = {"Hipster Tattoo 13",500,"<img src='https://i.imgur.com/jgkyyHO.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_013"] = {"Hipster Tattoo 14",500,"<img src='https://i.imgur.com/VfHs2kp.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_014"] = {"Hipster Tattoo 15",500,"<img src='https://i.imgur.com/BhRd7EX.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_015"] = {"Hipster Tattoo 16",500,"<img src='https://i.imgur.com/7JUWyQB.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_016"] = {"Hipster Tattoo 17",500,"<img src='https://i.imgur.com/zZRiwNY.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_017"] = {"Hipster Tattoo 18",500,"<img src='https://i.imgur.com/4CCiwf1.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_018"] = {"Hipster Tattoo 19",500,"<img src='https://i.imgur.com/bU0HpKi.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_019"] = {"Hipster Tattoo 20",500,"<img src='https://i.imgur.com/laK2XE1.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_020"] = {"Hipster Tattoo 21",500,"<img src='https://i.imgur.com/TEreZDU.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_021"] = {"Hipster Tattoo 22",500,"<img src='https://i.imgur.com/MaKnAgO.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_022"] = {"Hipster Tattoo 23",500,"<img src='https://i.imgur.com/6LWkczF.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_023"] = {"Hipster Tattoo 24",500,"<img src='https://i.imgur.com/lmx1a5u.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_024"] = {"Hipster Tattoo 25",500,"<img src='https://i.imgur.com/pyudE0r.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_025"] = {"Hipster Tattoo 26",500,"<img src='https://i.imgur.com/Q7PZWNC.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_026"] = {"Hipster Tattoo 27",500,"<img src='https://i.imgur.com/n39noko.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_027"] = {"Hipster Tattoo 28",500,"<img src='https://i.imgur.com/2c0o4iW.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_028"] = {"Hipster Tattoo 29",500,"<img src='https://i.imgur.com/3Mqn87g.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_029"] = {"Hipster Tattoo 30",500,"<img src='https://i.imgur.com/ki5BZ50.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_030"] = {"Hipster Tattoo 31",500,"<img src='https://i.imgur.com/s5G33dM.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_031"] = {"Hipster Tattoo 32",500,"<img src='https://i.imgur.com/kVKrJWB.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_032"] = {"Hipster Tattoo 33",500,"<img src='https://i.imgur.com/nncETKA.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_033"] = {"Hipster Tattoo 34",500,"<img src='https://i.imgur.com/SUNK8sp.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_034"] = {"Hipster Tattoo 35",500,"<img src='https://i.imgur.com/4uof4yH.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_035"] = {"Hipster Tattoo 36",500,"<img src='https://i.imgur.com/XZqvRP8.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_036"] = {"Hipster Tattoo 37",500,"<img src='https://i.imgur.com/9akWaBQ.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_037"] = {"Hipster Tattoo 38",500,"<img src='https://i.imgur.com/mdIBaz0.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_038"] = {"Hipster Tattoo 39",500,"<img src='https://i.imgur.com/x9LR0gl.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_039"] = {"Hipster Tattoo 40",500,"<img src='https://i.imgur.com/hz4Vrhn.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_040"] = {"Hipster Tattoo 41",500,"<img src='https://i.imgur.com/MwTUPhx.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_041"] = {"Hipster Tattoo 42",500,"<img src='https://i.imgur.com/9ClRa4b.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_042"] = {"Hipster Tattoo 43",500,"<img src='https://i.imgur.com/NaSJamm.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_043"] = {"Hipster Tattoo 44",500,"<img src='https://i.imgur.com/QWxL1op.png' height='162' width='280' />"}, 
		["FM_Hip_M_Tat_044"] = {"Hipster Tattoo 45",500,"<img src='https://i.imgur.com/Py2HXOb.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_045"] = {"Hipster Tattoo 46",500,"<img src='https://i.imgur.com/YWrJQyf.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_046"] = {"Hipster Tattoo 47",500,"<img src='https://i.imgur.com/AZvy2qz.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_047"] = {"Hipster Tattoo 48",500,"<img src='https://i.imgur.com/9g2Ixrs.png' height='162' width='280' />"},
		["FM_Hip_M_Tat_048"] = {"Hipster Tattoo 49",500,"i<mg src='https://i.imgur.com/olKLPNg.png' height='162' width='280' />"}
	},
}

-- list of tattooshops positions
cfg.shops = {
  {"mpbeach_overlays", 1322.645,-1651.976,52.275},
  {"mpbeach_overlays", -1153.676,-1425.68,4.954},
  {"mpbusiness_overlays", 349.139,180.467,103.587},
  {"mpbusiness_overlays", 1932.982,3731.929,32.854},
  {"mphipster_overlays", 322.453,180.851,103.586},
  {"mphipster_overlays", 1323.274,-1652.362,52.275}
}

return cfg
