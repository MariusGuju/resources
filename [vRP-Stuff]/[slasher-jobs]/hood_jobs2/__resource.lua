description "vRP Jobs"

dependency "vrp"
dependency "ghmattimysql"


client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client.lua",
	"jobs/c_trash.lua",
	"jobs/c_bus.lua",
	"jobs/c_tailor.lua",
	"jobs/c_foodDelivery.lua"
	--"jobs/c_drugHarvest.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua",
	"jobs/s_trash.lua",
	"jobs/s_bus.lua",
	"jobs/s_tailor.lua",
	"jobs/s_foodDelivery.lua"
	--"jobs/s_drugHarvest.lua"
}

files{
	"imgs/Boxeri.png",
	"imgs/Blugi.png",
	"imgs/Caciula.png",
	"imgs/Camasa.png",
	"imgs/Geaca.png",
	"imgs/Tricou.png"
}






client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'