
description "vRP Bank Robberies by Lee Fall - Edited by Dino&BigUnit"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}




client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'