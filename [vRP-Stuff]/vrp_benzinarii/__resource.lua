fx_version 'adamant'

game "gta5"


server_scripts {
	'@vrp/lib/utils.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}








client_script '@anticheat/54639.lua'