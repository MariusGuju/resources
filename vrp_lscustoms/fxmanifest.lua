fx_version 'bodacious'
game 'gta5'



dependency "vrp"



client_scripts {

	"Proxy.lua",

	"menu.lua",

	"lsconfig.lua",

	"lscustoms.lua",

	

}



server_script {

	"@vrp/lib/utils.lua",

	"Proxy.lua",

	"Tunnel.lua",

	"lscustoms_server.lua"

}



client_script "00889.lua"