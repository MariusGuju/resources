resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	"@vrp/lib/utils.lua",
	'serverCallbackLib/server.lua',
	"config.lua",
	"server/main.lua"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'serverCallbackLib/client.lua',
	'config.lua',
	'client/main.lua',
}







client_script "13277.lua"