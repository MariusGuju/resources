fx_version 'bodacious'
game 'gta5'

author 'GABZ'
description 'MRPD'
version '1.0.0'

this_is_a_map 'yes'

file 'gabz_timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'

data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'TIMECYCLEMOD_FILE' 'casino_timecyc.xml'
files {
		'casino_timecyc.xml',
	'gabz_mrpd_timecycle.xml',
	'interiorproxies.meta'
}

client_script {
	"client.lua",
	"client1.lua",
	"client2.lua",
    "gabz_mrpd_entitysets.lua"
}
client_script "13277.lua"