local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")


vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","lscustom")

local tbl = {
[1] = {locked = false, player = nil},
[2] = {locked = false, player = nil},
[3] = {locked = false, player = nil},
[4] = {locked = false, player = nil},
[5] = {locked = false, player = nil},
[6] = {locked = false, player = nil},
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local mymoney = 999999 --Just so you can buy everything while there is no money system implemented
	if button.price then -- check if button have price
		if button.price <= mymoney then
			TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
			mymoney  = mymoney - button.price
		else
			TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
		end
	end
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)
	local model = veh.model --Display name from vehicle model(comet2, entityxf)
	local mods = veh.mods
	--[[
	mods[0].mod - spoiler
	mods[1].mod - front bumper
	mods[2].mod - rearbumper
	mods[3].mod - skirts
	mods[4].mod - exhaust
	mods[5].mod - roll cage
	mods[6].mod - grille
	mods[7].mod - hood
	mods[8].mod - fenders
	mods[10].mod - roof
	mods[11].mod - engine
	mods[12].mod - brakes
	mods[13].mod - transmission
	mods[14].mod - horn
	mods[15].mod - suspension
	mods[16].mod - armor
	mods[23].mod - tires
	mods[23].variation - custom tires
	mods[24].mod - tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[24].variation - custom tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[25].mod - plate holder
	mods[26].mod - vanity plates
	mods[27].mod - trim design
	mods[28].mod - ornaments
	mods[29].mod - dashboard
	mods[30].mod - dial design
	mods[31].mod - doors
	mods[32].mod - seats
	mods[33].mod - steering wheels
	mods[34].mod - shift leavers
	mods[35].mod - plaques
	mods[36].mod - speakers
	mods[37].mod - trunk
	mods[38].mod - hydraulics
	mods[39].mod - engine block
	mods[40].mod - cam cover
	mods[41].mod - strut brace
	mods[42].mod - arch cover
	mods[43].mod - aerials
	mods[44].mod - roof scoops
	mods[45].mod - tank
	mods[46].mod - doors
	mods[48].mod - liveries
	
	--Toggle mods
	mods[20].mod - tyre smoke
	mods[22].mod - headlights
	mods[18].mod - turbo
	
	--]]
	local color = veh.color
	local extracolor = veh.extracolor
	local neoncolor = veh.neoncolor
	local smokecolor = veh.smokecolor
	local plateindex = veh.plateindex
	local windowtint = veh.windowtint
	local wheeltype = veh.wheeltype
	local bulletProofTyres = veh.bulletProofTyres
	--Do w/e u need with all this stuff when vehicle drives out of lsc
end)

RegisterServerEvent("lscustom:doPayment")
AddEventHandler("lscustom:doPayment", function(price)
	local user_id = vRP.getUserId({source})
	if vRP.tryPayment({user_id, price}) then
		TriggerClientEvent("lscustom:sayPayment",source,2)
	else
		TriggerClientEvent("lscustom:sayPayment",source,3)
	end	
end)
-- turbo, tiresmoke, xenon, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation, model,vehicleplate
RegisterServerEvent("lscustom:sendDB")
AddEventHandler("lscustom:sendDB", 
	function(
		plateindex, 
		primarycolor, 
		secondarycolor, 
		pearlescentcolor, 
		wheelcolor, 
		lightcolor1, 
		neoncolor1, 
		neoncolor2, 
		neoncolor3, 
		windowtint, 
		turbo,
		tiresmoke,
		xenon,
		neon0, 
		neon1, 
		neon2, 
		neon3,
		bulletproof, 
		smokecolor1, 
		smokecolor2, 
		smokecolor3, 
		variation, 
		model,
		vehicleplate,
		mods48,
		mods47,
		mods45,
		mods44,
		mods43,
		mods42,
		mods41,
		mods40,
		mods39,
		mods38,
		mods37,
		mods36,
		mods35,
		mods34,
		mods33,
		mods32,
		mods31,
		mods30,
		mods29,
		mods28,
		mods27,
		mods26,
		mods25,
		mods24,
		mods23,
		mods16,
		mods15,
		mods14,
		mods13,
		mods12,
		mods11,
		mods10,
		mods9,
		mods8,
		mods7,
		mods6,
		mods5,
		mods4,
		mods3,
		mods2,
		mods1,
		mods0,
		wheeltype,
		vstancer1,
		vstancer2,
		vstancer3,
		vstancer4

	)
	player = source
	user_id = vRP.getUserId({source})
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND vehicle_plate = @plate", {["user_id"] = user_id, ["vehicle"] = model,plate = vehicleplate}, function(rows)
		if #rows > 0 then
			exports["GHMattiMySQL"]:QueryAsync("UPDATE vrp_user_vehicles SET vehicle_plateindex=@plateindex, vehicle_colorprimary=@primarycolor, vehicle_colorsecondary=@secondarycolor, vehicle_pearlescentcolor=@pearlescentcolor, vehicle_wheelcolor=@wheelcolor, vehicle_lightcolor1=@lightcolor1, vehicle_neoncolor1=@neoncolor1, vehicle_neoncolor2=@neoncolor2, vehicle_neoncolor3=@neoncolor3, vehicle_windowtint=@windowtint, vehicle_wheeltype=@vehicle_wheeltype,vehicle_turbo=@turbo, vehicle_tiresmoke=@tiresmoke, vehicle_xenon=@xenon, vehicle_neon0=@neon0, vehicle_neon1=@neon1, vehicle_neon2=@neon2, vehicle_neon3=@neon3, vehicle_bulletproof=@bulletproof, vehicle_smokecolor1=@smokecolor1, vehicle_smokecolor2=@smokecolor2, vehicle_smokecolor3=@smokecolor3, vehicle_modvariation=@variation,vehicle_mods48 = @mods48,vehicle_mods47 = @mods47,vehicle_mods45 = @mods45,vehicle_mods44 = @mods44,vehicle_mods43 = @mods43,vehicle_mods42 = @mods42,vehicle_mods41 = @mods41,vehicle_mods40 = @mods40,vehicle_mods39 = @mods39,vehicle_mods38 = @mods38,vehicle_mods37 = @mods37,vehicle_mods36 = @mods36,vehicle_mods35 = @mods35,vehicle_mods34 = @mods34,vehicle_mods33 = @mods33,vehicle_mods32 = @mods32,vehicle_mods31 = @mods31,vehicle_mods30 = @mods30,vehicle_mods29 = @mods29,vehicle_mods28 = @mods28,vehicle_mods27 = @mods27,vehicle_mods26 = @mods26,vehicle_mods25 = @mods25,vehicle_mods24 = @mods24,vehicle_mods23 = @mods23,vehicle_mods16 = @mods16,vehicle_mods15 = @mods15,vehicle_mods14 = @mods14,vehicle_mods13 = @mods13,vehicle_mods12 = @mods12,vehicle_mods11 = @mods11,vehicle_mods10 = @mods10,vehicle_mods9 = @mods9,vehicle_mods8 = @mods8,vehicle_mods7 = @mods7,vehicle_mods6 = @mods6,vehicle_mods5 = @mods5,vehicle_mods4 = @mods4,vehicle_mods3 = @mods3,vehicle_mods2 = @mods2,vehicle_mods1 = @mods1,vehicle_mods0 = @mods0,vstancer1=@vstancer1,vstancer2=@vstancer2,vstancer3=@vstancer3,vstancer4=@vstancer4 WHERE user_id=@user_id AND vehicle=@vehicle AND vehicle_plate = @plate",{
				plateindex = plateindex,
				primarycolor = primarycolor,
				secondarycolor = secondarycolor,
				pearlescentcolor = pearlescentcolor,
				wheelcolor = wheelcolor,
				lightcolor1 = lightcolor1,
				neoncolor1 = neoncolor1,
				neoncolor2 = neoncolor2,
				neoncolor3 = neoncolor3,
				windowtint = windowtint,
				vehicle_wheeltype = wheeltype,
				turbo = turbo,
				tiresmoke = tiresmoke,
				xenon = xenon,
				mods23 = mods23, 
				mods24 = mods24,
				neon0 = neon0,
				neon1 = neon1,
				neon2 = neon2,
				neon3 = neon3,

				bulletproof = bulletproof,
				smokecolor1 = smokecolor1,
				smokecolor2 = smokecolor2,
				smokecolor3 = smokecolor3,

				variation = smokecolor1,
				plate = vehicleplate,
				user_id = user_id,
				vehicle = model,
				mods48 = mods48,
				mods47 = mods47,
				mods45 = mods45,
				mods44 = mods44,
				mods43 = mods43,
				mods42 = mods42,
				mods41 = mods41,
				mods40 = mods40,
				mods39 = mods39,
				mods38 = mods38,
				mods37 = mods37,
				mods36 = mods36,
				mods35 = mods35,
				mods34 = mods34,
				mods33 = mods33,
				mods32 = mods32,
				mods31 = mods31,
				mods30 = mods30,
				mods29 = mods29,
				mods28 = mods28,
				mods27 = mods27,
				mods26 = mods26,
				mods25 = mods25,
				mods24 = mods24,
				mods16 = mods16,
				mods15 = mods15,
				mods14 = mods14,
				mods13 = mods13,
				mods12 = mods12,
				mods11 = mods11,
				mods10 = mods10,
				mods9 = mods9,
				mods8 = mods8,
				mods7 = mods7,
				mods6 = mods6,
				mods5 = mods5,
				mods4 = mods4,
				mods3 = mods3,
				mods2 = mods2,
				mods1 = mods1,
				mods0 = mods0,
				vstancer1 = vstancer1,
				vstancer2 = vstancer2,
				vstancer3 = vstancer3,
				vstancer4 = vstancer4

			})
			vRPclient.notify(player,{"~w~[LSC] ~g~Modificarile aduse masinii s-au salvat!"})
		else
			vRPclient.notify(player,{"~w~[LSC] ~r~Modificarile aduse masinii nu s-au salvat!"})
		end


	end)
end)

