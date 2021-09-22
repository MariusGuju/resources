local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","all_sla")

local locations = {
  ["Sectia de Politie"] = {408.11499023438,-989.08081054688,29.266426086426},
  ["Departament de Job-uri"] = {-1081.0323486328,-262.29754638672,37.795570373535},
  ["Showroom"] = {-50.507274627686,-1116.3802490234,26.434577941895},
  ["Spital"] = {294.0178527832,-582.25360107422,43.188320159912},
  ["Sala"] = {-1209.0573730469,-1574.3323974609,4.6079916954041}
}

local ch_gps = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local menu_gps = {
    	name = "GPS",
    	css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
    }

    for k, v in pairs(locations) do
      menu_gps[k] = {function(player, choice)
        vRPclient.setGPS(player, {v[1], v[2]})
      end, ""}
    end

    vRP.openMenu({player, menu_gps})
  end
end, "Gaseste locatiile importante de pe harta"}

vRP.registerMenuBuilder({"main", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

     choices["GPS"] = ch_gps

    add(choices)
  end
end})
