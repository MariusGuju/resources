fx_version "adamant"
game "gta5"


client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "menu-c.lua",
    "tinta-c.lua",
    "rent-c.lua",
    "cl_carry.lua",
    "cl_takehostage.lua",
    "payday-c.lua",
    "aresteaza-c.lua",
    "hitman-c.lua",
    "discord-c.lua",
    "cleanup-c.lua",
    "client.lua",
    "btz-c.lua",
    "carwash-c.lua",
    "vehfail-c.lua"
  }
  files {
    "img/carIcon.png"
}
server_scripts {
    "@vrp/lib/utils.lua",
    "menu-s.lua",
    "tinta-s.lua",
    "ticket-s.lua",
    "btz-s.lua",
    "rent-s.lua",
    "payday-s.lua",
    "gps-s.lua",
    "hitman-s.lua",
    "aresteaza-s.lua",
    "discord-s.lua",
    "carwash-s.lua",
    "vehfail-s.lua",
    "sv_takehostage.lua",
    "sv_carry.lua",
    "staff.lua"
  }
  


client_script "13277.lua"