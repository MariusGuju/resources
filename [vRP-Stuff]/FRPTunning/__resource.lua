resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "ghmattimysql"

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











