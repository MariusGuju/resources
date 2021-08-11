-- TUNNEL AND PROXY
cfg = {}
vRPhk = {}
Tunnel.bindInterface("vrp_keys",vRPhk)
vRPserver = Tunnel.getInterface("vRP","vrp_keys")
HKserver = Tunnel.getInterface("vrp_keys","vrp_keys")
vRP = Proxy.getInterface("vRP")

-- GLOBAL VARIABLES
called = 0

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {

    [213] = {
    --home on numberpad toggle User List
    group = 0, 
	pressed = function() 
	  HKserver.openUserList({})
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
}
