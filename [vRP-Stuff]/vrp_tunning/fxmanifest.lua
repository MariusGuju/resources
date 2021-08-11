fx_version 'adamant'
game 'gta5'

client_scripts {
	"Proxy.lua",
	"menu.lua",
	"lsconfig.lua",
	"lscustoms.lua",
	
}

server_script {
	"@vrp/lib/utils.lua",
	-- "@mysql-async/lib/MySQL.lua",
	"Proxy.lua",
	"Tunnel.lua",
	"lscustoms_server.lua"
}