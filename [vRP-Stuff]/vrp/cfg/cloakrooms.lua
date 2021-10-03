
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local surgery_male = { model = "mp_m_freemode_01" }
local SkinDorian = { model = "Salvador Dali"}
local surgery_female = { model = "mp_f_freemode_01" }
local emergency_male = { model = "s_m_m_paramedic_01" }
local emergency_female = { model = "s_f_y_paramedic_01" }
local sheriff_male = { model = "s_m_y_sheriff_01"} --sheriff barbat
local sheriff_female = { model = "s_f_y_sheriff_01"} -- sheriff femeie
local cadet_male = { model = "s_m_m_Armoured_02"} -- cadet
local officer_male = { model = "s_m_m_prisguard_01"} -- ofiteri
local cop_female = { model = "s_f_y_cop_01"} -- politist femeie
local sergeant_male = { model = "s_m_y_cop_01"}   -- sergent male
local detective_male = { model = "s_m_m_CIASec_01"} --detective
local fbi_mascat = { model = "s_m_y_ranger_01"} -- mascat fbi
--s_f_y_scrubs_01
--mp_m_freemode_01
--mp_f_freemode_01
--s_m_y_BlackOps_01

for i=0,19 do
  surgery_female[i] = {0,0}
  surgery_male[i] = {0,0}
end

-- cloakroom types (_config, map of name => customization)
--- _config:
---- permissions (optional)
---- not_uniform (optional): if true, the cloakroom will take effect directly on the player, not as a uniform you can remove
cfg.cloakroom_types = {
  ["SkinDorian"] = {
    _config = { permissions = {"casa.masini"} },
    ["Costum"] = SkinDorian
},
["surgery"] = {
  _config = { not_uniform = true },
  ["Male"] = surgery_male,
  ["Female"] = surgery_female
}
}

cfg.cloakrooms = {
  {"surgery",1849.7425,3686.5759,34.2670},----first spawn change skin
  {"surgery",75.3451766967773,-1392.86596679688,29.3761329650879},---skinsshops
  {"surgery",-700.089477539063,-151.570571899414,37.4151458740234},
  {"surgery",-170.416717529297,-296.563873291016,39.7332878112793},
  {"surgery",425.61181640625,-806.519897460938,29.4911422729492},
  {"surgery",-822.166687011719,-1073.58020019531,11.3281087875366},
  {"surgery",-1186.25744628906,-771.20166015625,17.3308639526367},
  {"surgery",-1450.98388671875,-238.164260864258,49.8105850219727},
  {"surgery",4.44537162780762,6512.244140625,31.8778476715088},
  {"surgery",1693.91735839844,4822.66162109375,42.0631141662598},
  {"surgery",118.071769714355,-224.893646240234,54.5578384399414},
  {"surgery",620.459167480469,2766.82641601563,42.0881042480469},
  {"surgery",1196.89221191406,2710.220703125,38.2226066589355},
  {"surgery",-3178.01000976563,1043.21044921875,20.8632164001465},
  {"surgery",971.62805175781,-98.674873352051,74.846046447754},
  {"SkinDorian",-554.41082763672,-227.53968811035,38.166954040527},
  {"surgery",-1101.15161132813,2710.8203125,19.1078643798828}
}

return cfg
