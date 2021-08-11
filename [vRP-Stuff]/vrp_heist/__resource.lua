resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency {
    'vrp'
  }
client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'serverCallbackLib/client.lua',
    "config.lua",
    "client/client.lua",
    "client/goldjob.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	'serverCallbackLib/server.lua',
    "config.lua",
    "server/server.lua"
}