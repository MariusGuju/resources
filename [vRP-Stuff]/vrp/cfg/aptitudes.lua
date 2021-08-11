
local cfg = {}

-- exp notes:
-- levels are defined by the amount of xp
-- with a step of 5: 5|15|30|50|75 (by default)
-- total exp for a specific level, exp = step*lvl*(lvl+1)/2
-- level for a specific exp amount, lvl = (sqrt(1+8*exp/step)-1)/2

-- define groups of aptitudes
--- _title: title of the group
--- map of aptitude => {title,init_exp,max_exp}
---- max_exp: -1 for infinite exp
cfg.gaptitudes = {
  ["physical"] = {
    _title = "Physical",
    ["strength"] = {"Forta", 30, 275} -- required, level 3 to 6 (by default, can carry 10kg per level)
  },
  ["science"] = {
    _title = "Science",
    ["chemicals"] = {"Studiu Chimic", 0, -1}, -- example
    ["mathematics"] = {"Studiu Matematic", 0, -1} -- example
  },
  ["laboratory"] = {
    _title = "Laborator Droguri",
	["cocaine"] = {"Pentru procesare cocaina, ai nevoie de benzoilmetilecgonina, gaseste substanta din laborator .", 0, -1},
	["weed"] = {"Pentru procesare iarba, ai nevoie de seeds, gaseste semintele din laborator .", 0, -1},
	["lsd"] = {"Pentru procesare lsd, ai nevoie de Harness, gaseste substantele din laborator .", 0, -1}
  },
  ["hacker"] = {
    _title = "Studiu Programari Speciale",
	["logic"] = {"Logica si filosofia.", 0, -1},
	["c++"] = {"Limbaj C++ de programare.", 0, -1},
	["lua"] = {"Limbaj LUA de programare.", 0, -1},
	["hacking"] = {"Studii limbaje programare.", 0, -1}
  }
}

return cfg
