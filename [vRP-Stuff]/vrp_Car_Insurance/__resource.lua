ui_page 'html/ui.html'

autor 'Naifen Lua'

dependency 'vrp'

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

client_script {
	'client.lua',
	'GUI.lua'
}