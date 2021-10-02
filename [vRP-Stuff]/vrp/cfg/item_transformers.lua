
local cfg = {}

-- define static item transformers
-- see https://github.com/ImagicTheCat/vRP to understand the item transformer concept/definition

cfg.item_transformers = {
  -- example of harvest item transformer
    {
    name="Fishing", -- menu name
    permissions = {"mission.delivery.fish"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=743.19586181641,y=3895.3967285156,z=30.5, 
    radius=3, height=1.5, -- area
    recipes = {
      ["Catch some Catfish"] = { -- action name
        description="Trying to catch some Catfish", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["catfish"] = 1
        }
      },
      ["Catch some Bass"] = { -- action name
        description="Trying to catch some Bass", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["bass"] = 1
        }
      }
    }
  },
       {
    name="Trash Collector", -- menu name
    permissions = {"mission.collect.trash"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=757.75939941406,y=-1403.1365966796,z=26.532499313354,    --- 757.75939941406,-1403.1365966796,26.532499313354
    radius=3, height=1.5, -- area
    recipes = {
      ["Gather Trash"] = { -- action name
        description="Gathering Trash...", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["trash"] = 2
        }
      }
    }
  },
      {
    name="Weapons Smuggler", -- menu name
    permissions = {"mission.weapons.smuggler"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=1117.9967041016,y=-1998.3148193359,z=35.439407348633,     --- 606.3648071289,-3093.0698242188,6.0692582130432
    radius=3, height=1.5, -- area
    recipes = {
      ["Gather AK's"] = { -- action name
        description="Grabbing AK's", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["AK47"] = 1
        }
      },
      ["Gather M4A1"] = { -- action name
        description="Grabbing M4's", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["M4A1"] = 1
        }
      }
    }
  },
      {
    name="Medical Transport", -- menu name
    permissions = {"mission.delivery.medical"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=2213.0520019531,y=5577.5981445313,z=53.795757293701,
    radius=3, height=1.5, -- area
    recipes = {
      ["Gather Medical Weed"] = { -- action name
        description="Gathering Medical Weed", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["Medical Weed"] = 1
        }
      }
	 }
  },
   {
    name="UPS", -- menu name
    permissions = {"harvest.parcels"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=76.495727539063,y=-27.030916213989,z=68.562599182129,
    radius=3, height=1.5, -- area
    recipes = {
      ["Gather Parcels"] = { -- action name
        description="Gathering Parcels", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["parcels"] = 1
        }
      }
	 }
  },
 -- {
    -- name="Santa's Workshop", -- menu name
    -- permissions = {"harvest.presents"}, -- you can add permissions
    -- r=0,g=125,b=255, -- color
    -- max_units=100000,
    -- units_per_minute=2,
    -- x=2213.0520019531,y=5577.5981445313,z=53.795757293701, -- UPDATE THIS
    -- radius=3, height=1.5, -- area
    -- recipes = {
      -- ["Gather Presents"] = { -- action name
        -- description="Gathering Presents", -- action description
        -- in_money=0, -- money taken per unit
        -- out_money=0, -- money earned per unit
        -- reagents={}, -- items taken per unit
        -- products={ -- items given per unit
          -- ["Presents"] = 1
        -- }
      -- }
	 -- }
  -- },
  {
    name="Water bottles/tacos tree", -- menu name
    -- permissions = {"harvest.water_bottle_tacos"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=-1692.6646728516,y=-1086.3079833984,z=13.152559280396, -- pos
    radius=5, height=1.5, -- area
    recipes = {
      ["Harvest water"] = { -- action name
        description="Harvest some water bottles.", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["water"] = 1
        }
      },
      ["Harvest tacos"] = { -- action name
        description="Harvest some tacos.", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["tacos"] = 1
        }
      }
    }
    --, onstart = function(player,recipe) end, -- optional start callback
    -- onstep = function(player,recipe) end, -- optional step callback
    -- onstop = function(player,recipe) end -- optional stop callback
  },
  {
    name="Hacker", -- menu name
	permissions = {"hacker.credit_cards"}, -- you can add permissions
    r=255,g=125,b=0, -- color
    max_units=20,
    units_per_minute=4,
    x=1275.5522460938,y=-1710.7652587891,z=54.771457672119, --- 569.61779785156,-3126.7106933594,18.768608093262
    radius=2, height=1.0, -- area   
    recipes = {
      ["hacking"] = { -- action name
        description="Fura Carduri De Credit.", -- action description
        in_money= 40000, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={
		["credit"] = 1,
		["dirty_money"] = 1
		}, -- items given per unit
        aptitudes={ -- optional
          ["hacker.hacking"] = 0.1 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },

  {
    name="Transforma In Bani", -- menu name
	permissions = {"hacker.credit_cards"}, -- you can add permissions
    r=255,g=125,b=0, -- color
    max_units=10,
    units_per_minute=4,
    
    x=1271.6812744141,y=-1711.8430175781,z=54.771434783936,   --- -11.529201507568,-599.06646728516,79.430198669434
    radius=2, height=1.0, -- area
    recipes = {
      ["Fura Bani"] = { -- action name
        description="Fura Bani de pe Carduri", -- action description
        in_money= 0, -- money taken per unit
        out_money= 0, -- money earned per unit
        reagents={
		["credit"] = 1
		}, -- items taken per unit
        products={
          ["dirty_money"] = 40000
		}, -- items given per unit
        aptitudes={}
      }
    }
  },
  {
    name="Spalare Bani 90%%", -- Name
    -- permission = "harvest.water_bottle", -- you can add a permission
    r=0,g=200,b=0, -- colours 1743.8870849609,-1622.9973144531,112.57803344727
    max_units=10000,
    units_per_minute=10000,
    x=1743.8870849609,y=-1622.9973144531,z=112.57803344727,
    radius=2, height=1.5, -- area do radius
    recipes = {
      ["Title"] = {
        description="Money Laudering", --
        in_money=0, -- 
        out_money=900, -- 
        reagents={
          ["dirty_money"] = 1000 --Necessary
        },
        products={}, 
      }
    }
  },
  {
    name="Collect Cargo", -- menu name
	permissions = {"mission.pilot.cargo"}, -- you can add permissions
    r=255,g=125,b=0, -- color
    max_units=100000,
    units_per_minute=100000,
    x=1618.9204101563,y=3227.7058105469,z=40.411529541016,
    radius=2, height=1.0, -- area
    recipes = {
      ["Cargo"] = { -- action name
       description="Collecting Cargo...", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={
		["cargo"] = 1
		}, -- items given per unit
        aptitudes={} -- optional
      }
    }
  },
 -- {
   -- name="Robbery Bank", -- menu name
   -- r=255,g=125,b=0, -- color
   -- max_units=600,
   -- units_per_minute=1,
   -- x=265.94982910156,y=213.54983520508,z=101.68338775635,
   -- radius=2, height=1.0, -- area
   -- recipes = {
     -- ["Bank Money"] = { -- action name
      -- description="get the money.", -- action description
       -- in_money=0, -- money taken per unit
       -- out_money=0, -- money earned per unit
      --  reagents={}, -- items taken per unit
      --  products={
	--	["dirty_money"] = 0
	--	}, -- items given per unit
       -- aptitudes={} -- optional
     -- }
   -- }
 -- },

 {
  name="Combina Cocaina", -- menu name
permissions = {"harvest.coca"}, -- you can add permissions
  r=0,g=255,b=0, -- color
  max_units=100000,
  units_per_minute=100000,
  x=1100.8002929688,y=-3198.654296875,z=-38.993476867676,
  radius=1.1, height=1.5, -- area
  recipes = {
    ["cocaine"] = { -- action name
      description="make cocaine", -- action description
      in_money=130, -- money taken per unit
      out_money=0, -- money earned per unit
        reagents={ -- items taken per unit
          ["benzoilmetilecgonina"] = 2,
          ["water"] = 1
        },
          products={ -- items given per unit
            ["cocaine"] = 1
          },
            aptitudes={ -- optional
              ["laboratory.cocaine"] = 0.1, -- "group.aptitude", give 1 exp per unit
              ["science.chemicals"] = 0.1
            }
        }
      },
  },

  {
    name="Combina Iarba", -- menu name
  permissions = {"harvest.weed"}, -- you can add permissions
    r=0,g=255,b=0, -- color
    max_units=100000,
    units_per_minute=100000,
    x=1039.2347412109,y=-3205.3173828125,z=-38.166515350342,  -- 1039.2347412109,-3205.3173828125,-38.166515350342
    radius=1.1, height=1.5, -- area
    recipes = {
      ["weed"] = { -- action name
        description="make weed", -- action description
        in_money=60, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={ -- items taken per unit
          ["seeds"] = 1,
          ["water"] = 1
        },
        products={ -- items given per unit
          ["iarba"] = 1
        },
        aptitudes={ -- optional
          ["laboratory.weed"] = 0.1, -- "group.aptitude", give 1 exp per unit
          ["science.chemicals"] = 0.1
        }
      },
        },
    },

    {
      name="Combina LSD", -- menu name
    permissions = {"harvest.lsd"}, -- you can add permissions
      r=0,g=255,b=0, -- color
      max_units=100000,
      units_per_minute=100000,
      x=1012.201171875,y=-3194.9438476563,z=-38.9931640625, --   1012.201171875,-3194.9438476563,-38.9931640625
      radius=1.1, height=1.5, -- area
      recipes = {
        ["lsd"] = { -- action name
        description="make lsd", -- action description
        in_money=60, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={ -- items taken per unit
          ["harness"] = 1,
          ["water"] = 1
        },
        products={ -- items given per unit
          ["lsd"] = 1
        },
        aptitudes={ -- optional
          ["laboratory.lsd"] = 0.1, -- "group.aptitude", give 1 exp per unit
          ["science.chemicals"] = 0.1
        }
      }
          },
      }


}

-- define transformers randomly placed on the map
cfg.hidden_transformers = {
  ["weed field"] = {
    def = {
      name="Weed field", -- menu name
      permissions = {"harvest.weed"}, -- you can add permissions
      r=0,g=200,b=0, -- color
      max_units=100000,
      units_per_minute=100000,
      x=0,y=0,z=0, -- pos
      radius=5, height=1.5, -- area
      recipes = {
        ["Farmeaza niste seminte"] = { -- action name
          description="Seminte pentru cannabis", -- action description
          in_money=0, -- money taken per unit
          out_money=0, -- money earned per unit
          reagents={}, -- items taken per unit
          products={ -- items given per unit
            ["seeds"] = 1
          }
        }
      }
    },
    positions = {
      {1057.400390625,-3203.7651367188,-39.1330909729}
    }
  },
  ["cocaine dealer"] = {
    def = {
      name="Cocaine Dealer", -- menu name
      permissions = {"harvest.coca"}, -- you can add permissions
      r=0,g=200,b=0, -- color
      max_units=100000,
      units_per_minute=100000,
      x=0,y=0,z=0, -- pos
      radius=5, height=1.5, -- area
      recipes = {
        ["Farmeaza Benzo"] = { -- action name
          description="Farmeaza niste coca, drogatule.", -- action description
          in_money=0, -- money taken per unit
          out_money=0, -- money earned per unit
          reagents={}, -- items taken per unit
          products={ -- items given per unit
            ["benzoilmetilecgonina"] = 1
          }
        }
      }
    },
    positions = {
      {1095.4763183594,-3196.6689453125,-38.993476867676}
    }
  },
  ["lsd bar"] = {
    def = {
      name="LSD Bar", -- menu name
      permissions = {"harvest.lsd"}, -- you can add permissions
      r=0,g=200,b=0, -- color
      max_units=100000,
      units_per_minute=100000,
      x=0,y=0,z=0, -- pos
      radius=5, height=1.5, -- area
      recipes = {
        ["Farmeaza Harness"] = { -- action name
          description="Farmeaza niste LSD, drogatule.", -- action description
          in_money=0, -- money taken per unit
          out_money=0, -- money earned per unit
          reagents={}, -- items taken per unit
          products={ -- items given per unit
      			["harness"] = 1
          }
        }
      }
    },
    positions = {
      {1012.201171875,-3194.9438476563,-38.9931640625}
    }
  },
  ["ems"] = {
    def = {
      name="Medical Report", -- menu name
      permissions = {"admin.tickets"}, -- you can add permissions
      r=0,g=200,b=0, -- color
      max_units=100000,
      units_per_minute=100000,
      x=0,y=0,z=0, -- pos
      radius=5, height=1.5, -- area
      recipes = {
        ["Write Report"] = { -- action name
          description="Writing Report...", -- action description
          in_money=0, -- money taken per unit
          out_money=100, -- money earned per unit
          reagents={
            ["credit"] = 1
          }, -- items taken per unit
          products={ -- items given per unit
            ["ems_report"] = 1
          }
        }
      }
    },
    positions = {
      {-272.08700561523,27.639623641968,54.752536773682},
      {465.04064941406,3569.1174316406,33.238555908203},
      {-1145.8566894531,4939.5083007813,222.2686920166}
    }
  }
}

-- time in minutes before hidden transformers are relocated (min is 5 minutes)
cfg.hidden_transformer_duration = 5*24*60 -- 5 days

-- configure the information reseller (can sell hidden transformers positions)
--[[cfg.informer = {
  infos = {
  ["weed field"] = 50000,
	["cocaine dealer"] = 50000,
	["lsd bar"] = 50000
  },
  positions = {
    {1057.400390625,-3203.7651367188,-39.1330909729},
    {1095.4763183594,-3196.6689453125,-38.993476867676},
  	{1002.926574707,-3200.0930175781,-38.9931640625}
  },
  interval = 60, -- interval in minutes for the reseller respawn
  duration = 10, -- duration in minutes of the sawned reseller
  blipid = 133,
  blipcolor = 2
}--]]

return cfg
