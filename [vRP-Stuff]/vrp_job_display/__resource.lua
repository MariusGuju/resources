
description "vRP job display"
--ui_page "ui/index.html"

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

client_script '@anticheat/54639.lua'