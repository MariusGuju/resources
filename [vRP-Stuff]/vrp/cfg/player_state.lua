
local cfg = {}

-- define the first spawn position/radius of the player (very first spawn on the server, or after death)
cfg.spawn_enabled = true -- set to false to disable the feature
cfg.spawn_position = {-1634.333984375,181.71659851074,61.757873535156}
cfg.spawn_death = {-1634.333984375,181.71659851074,61.757873535156} -- x,y,z for death location
cfg.spawn_radius = 1

-- customization set when spawning for the first time
-- see https://wiki.fivem.net/wiki/Peds
-- mp_m_freemode_01 (male)
-- mp_f_freemode_01 (female)
cfg.default_customization = {
  model = "mp_m_freemode_01" 
}

-- init default ped parts
for i=0,19 do
  cfg.default_customization[i] = {0,0}
  cfg.default_customization[0] = {42,0,2}
  cfg.default_customization[2] = {2,0,2}
  cfg.default_customization[4] = {42,0,2}
  cfg.default_customization[6] = {16,0,2}
  cfg.default_customization[8] = {57,0,2}
  cfg.default_customization[11] = {80,0,2}
end

cfg.clear_phone_directory_on_death = false
cfg.lose_aptitudes_on_death = false

return cfg
 -- {1151.2432861328,-1526.7790527344,34.843448638916}