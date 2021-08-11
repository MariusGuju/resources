
local cfg = {}

-- PCs positions
cfg.pcs = {
  {1853.21, 3689.51, 34.2671},
  {451.82669067383,-999.02301025391,30.689514160156}
}

-- vehicle tracking configuration
cfg.trackveh = {
  min_time = 300, -- min time in seconds
  max_time = 600, -- max time in seconds
  service = "police",  -- service to alert when the tracking is successful
  "SWAT",
  "sheriff",
  "highway",
  "trafficguard",
  "Chief",
  "Commander",
  "Lieutenant",
  "Detective",
  "Sergeant",
  "Deputy",
  "Bounty",
  "Dispatch"
}

-- wanted display
cfg.wanted = {
  blipid = 458,
  blipcolor = 38,
  service = "police",
  "SWAT",
  "sheriff",
  "highway",
  "trafficguard",
  "Chief",
  "Dispatch",
  "Commander",
  "Lieutenant",
  "Detective",
  "Deputy",
  "Bounty",
  "Sergeant"
}

-- illegal items (seize)
cfg.seizable_items = {
  "dirty_money",
  "cocaine",
  "lsd",
  "seeds",
  "harness",
  "credit",
  "weed",
  "M4A1",
  "AK47",
  "fake_id",
  "driver",
  "iarba",
  "lsd",
  "cocaine",
  "drug_cansativa",
  "drug_cocaalka",
  "drug_unprocpcp",
  "drug_lyseracid",
  "iarba",
  "stack_iarba",
  "cocaina",
  "stack_cocaina",
  "metanfetamina",
  "stack_metanfetamina"
}

-- jails {x,y,z,radius}
cfg.jails = {
  {477.99496459961,-1014.0191040039,26.273151397705,2.1},
  {481.42581176758,-1014.7197265625,26.310781478882,2.1},
  {486.51278686523,-1013.9373168945,26.273149490356,2.1},
  {481.42581176758,-1014.7197265625,26.310781478882,2.1},
  {485.47750854492,-1005.7587890625,26.273260116577,2.1}
}

-- fines
-- map of name -> money
cfg.fines = {
  ["Insult"] = 100,
  ["Speeding"] = 250,
  ["Red Light"] = 250,
  ["Stealing"] = 1000,
  ["Credit Cards - Per Card"] = 1000,
  ["Drugs - Per Drug"] = 2000,
  ["Dirty Money - Per $1000"] = 1500,
  ["Organized crime (low)"] = 10000,
  ["Organized crime (medium)"] = 25000,
  ["Organized crime (high)"] = 50000
}

return cfg
