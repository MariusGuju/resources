resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_script {
	'lib/Proxy.lua',
	'lib/Tunnel.lua',
	'client.lua'
  }
   
  server_script {
	'@vrp/lib/utils.lua',
	"server.lua"
  }

ui_page('html/index.html')
files({
	"html/script.js",
	"html/jquery.min.js",
	"html/jquery-ui.min.js",
	"html/styles.css",
	"html/img/*.svg",
	"html/index.html",
})

--https://discord.gg/Ay94eGpqNg VR TEAM : ALDOB#0001