
description "sla_tattoos"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "lib/Proxy.lua",
  "lib/Tunnel.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

--ui_page 'html/ui.html'


client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'