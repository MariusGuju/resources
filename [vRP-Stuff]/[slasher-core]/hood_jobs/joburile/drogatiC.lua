locatiiDrogatiInterior = {
    {"Intrare ~g~Weed~w~", -1001.3587036133,4847.46484375,275.00680541992, 1065.7521972656,-3183.4450683594,-39.163501739502},
    {"Iesire ~g~Weed~w~", 1065.7521972656,-3183.4450683594,-39.163501739502, -1001.3587036133,4847.46484375,275.00680541992},
    {"Intrare ~b~Meth~w~",1334.6708984375,4306.8315429688,38.083736419678, 997.31677246094,-3200.7314453125,-36.398731231689},
    {"Iesire ~b~Meth", 997.31677246094,-3200.7314453125,-36.398731231689 , 1334.6708984375,4306.8315429688,38.083736419678},
    {"Intrare Cocaine",1470.0858154297,6550.2421875,14.904127120972, 1088.6813964844,-3187.8427734375,-38.993488311768},
	{"Iesire Cocaine",1088.6813964844,-3187.8427734375,-38.993488311768,1470.0858154297,6550.2421875,14.904127120972},
	{"Intrare Elicopter",332.5090637207,-595.43756103516,43.284023284912, 338.62551879883,-583.78765869141,74.165580749512},     --- SPITAL
	{"Iesire Elicopter",338.62551879883,-583.78765869141,74.165580749512,332.5090637207,-595.43756103516,43.284023284912}    --- SPITAL
}


stopCocaFMM = false
stopTragerePeNasuc = false

Citizen.CreateThread(function()
	while true do
		Wait(500)
		for k,v in pairs (locatiiDrogatiInterior) do
			while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), v[2],v[3],v[4], true) <= 2.5 do
				Wait(0)
				DrawText3D(v[2],v[3],v[4], "~w~[E] "..v[1], 1.0)
				if IsControlJustPressed(0, 38) then
					teleport(v[5],v[6],v[7])
				end
			end
		end
	end
end)

droga = {
	["erva"] = {
		gather = false,
		processing = false,
	},	
	["metanfetamina"] = {
		gather = false,
		processing = false,
	},	
	["coca"] = {
		gather_1 = false,
		gather_2 = false,
		gather_3 = false,
		gather_4 = false,
		gather_5 = false,
		gather_6 = false,
		processing = false,
	},
}

function weed_gather()
	local animdict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
	--Request
	RequestAnimDict(animdict)
	
	local netScene = NetworkCreateSynchronisedScene(1057.3350830078,-3197.880859375,-39.139472961426 - 1, 0,0,90.0, 2, false, false, 1065353216, 0, 1.3)
	local ped = PlayerPedId()
	NetworkAddPedToSynchronisedScene(ped, netScene, animdict, "weed_crouch_checkingleaves_idle_01_inspector", 1.5, -4.0, 1, 16, 1148846080, 0)
	
	FreezeEntityPosition(ped, true)
	
	NetworkStartSynchronisedScene(netScene)
	Citizen.Wait(15000)
	NetworkStopSynchronisedScene(netScene)
	
	FreezeEntityPosition(ped, false)
	TriggerServerEvent("vrp_drug:apanhar_erva_finish")
end
function weed_process()
	local animdict = "anim@amb@business@weed@weed_sorting_seated@"
	
	--Request
	RequestModel("bkr_prop_weed_bud_02b")
	RequestModel("bkr_prop_weed_bucket_open_01a")
	RequestAnimDict(animdict)
	
	local netScene_1 = NetworkCreateSynchronisedScene(1038.382,-3206.001,-39.12312, 0,0,-90.0, 2, false, false, 1065353216, 0, 1.3)
	local netScene_2 = NetworkCreateSynchronisedScene(1038.382,-3206.001,-39.12312, 0,0,-90.0, 2, false, false, 1065353216, 0, 1.3)
	local netScene_3 = NetworkCreateSynchronisedScene(1038.382,-3206.001,-39.12312, 0,0,-90.0, 2, false, false, 1065353216, 0, 1.3)
	local ped = PlayerPedId()

	NetworkAddPedToSynchronisedScene(ped, netScene_1, animdict, "sorter_left_sort_v3_sorter01", 0.0, -4.0, 1, 16, 1148846080, 0)
			
	--Props
	local drug_1 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_1, netScene_3, animdict, "sorter_left_sort_v3_weedbud02b", 4.0, -8.0, 1)	
	local drug_2 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_2, netScene_3, animdict, "sorter_left_sort_v3_weedbud02b^1", 4.0, -8.0, 1)	
	local drug_3 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_3, netScene_3, animdict, "sorter_left_sort_v3_weedbud02b^2", 4.0, -8.0, 1)		
	local drug_4 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_4, netScene_2, animdict, "sorter_left_sort_v3_weedbud02b^3", 4.0, -8.0, 1)		
	local drug_5 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_5, netScene_2, animdict, "sorter_left_sort_v3_weedbud02b^4", 4.0, -8.0, 1)		
	local drug_6 = CreateObject(GetHashKey("bkr_prop_weed_bud_02b"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(drug_6, netScene_2, animdict, "sorter_left_sort_v3_weedbud02b^5", 4.0, -8.0, 1)	
	
	local bucket = CreateObject(GetHashKey("bkr_prop_weed_bucket_open_01a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(bucket, netScene_1, animdict, "sorter_left_sort_v3_bucket01a", 4.0, -8.0, 1)
	
	FreezeEntityPosition(ped, true)
	
	NetworkStartSynchronisedScene(netScene_1)
	NetworkStartSynchronisedScene(netScene_2)
	NetworkStartSynchronisedScene(netScene_3)
	Citizen.Wait(24000)
	NetworkStopSynchronisedScene(netScene_3)
	NetworkStopSynchronisedScene(netScene_2)
	NetworkStopSynchronisedScene(netScene_1)
	
	DeleteEntity(drug_1)
	DeleteEntity(drug_2)
	DeleteEntity(drug_3)
	DeleteEntity(drug_4)
	DeleteEntity(drug_5)
	DeleteEntity(drug_6)
	DeleteEntity(bucket)
	
	FreezeEntityPosition(ped, false)
	TaskGoStraightToCoord(ped, 1039.7818603516,-3204.5256347656,-38.165534973145, 0.025, 5000, 0.0, 0.05)
	TriggerServerEvent("vrp_drug:processar_erva_finish")
end
function meth_gather()
	local animdict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
	--Requests
	RequestModel("bkr_prop_meth_sacid")
	RequestModel("bkr_prop_meth_ammonia")
	RequestAnimDict(animdict)
	local ped = PlayerPedId()
	local netScene = NetworkCreateSynchronisedScene(1010.6734008789,-3198.4880664063,-38.930,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	
	--Ped
	NetworkAddPedToSynchronisedScene(ped, netScene, animdict, "chemical_pour_short_cooker", 0.0, -4.0, 1, 16, 1148846080, 0)
	
	--Props
	local sacid = CreateObject(GetHashKey("bkr_prop_meth_sacid"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(sacid, netScene, animdict, "chemical_pour_short_sacid", 4.0, -8.0, 1)
	
	local sodium = CreateObject(GetHashKey("bkr_prop_meth_ammonia"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(sodium, netScene, animdict, "chemical_pour_short_ammonia", 4.0, -8.0, 1)	
	
	FreezeEntityPosition(ped, true)
	
	--Start
	NetworkStartSynchronisedScene(netScene)
	Citizen.Wait(55000)
	NetworkStopSynchronisedScene(netScene)
	
	DeleteEntity(sacid)
	DeleteEntity(sodium)
	FreezeEntityPosition(ped, false)
	stopTragerePeNasuc = false
	TriggerServerEvent("vrp_drug:apanhar_metanfetamina_finish")
end
function meth_process()
	stopTragerePeNasuc = false
	local animdict = "anim@amb@business@meth@meth_smash_weight_check@"
	--Requests
	RequestModel("bkr_prop_meth_bigbag_03a")
	RequestModel("bkr_prop_meth_bigbag_04a")
	RequestModel("bkr_prop_meth_openbag_01a")
	RequestModel("bkr_prop_coke_scale_01")
	RequestModel("bkr_prop_meth_openbag_02")
	RequestAnimDict(animdict)
	local ped = PlayerPedId()
	local netScene_1 = NetworkCreateSynchronisedScene(1007.1284179688 + 0.10,-3196.5971679688 + 0.05,-38.993167877197 - 1,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	local netScene_2 = NetworkCreateSynchronisedScene(1007.1284179688 + 0.10,-3196.5971679688 + 0.05,-38.993167877197 - 1,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	local netScene_3 = NetworkCreateSynchronisedScene(1007.1284179688 + 0.10,-3196.5971679688 + 0.05,-38.993167877197 - 1,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	
	--Ped
	NetworkAddPedToSynchronisedScene(ped, netScene_1, animdict, "break_weigh_char01", 0.0, -4.0, 1, 16, 1148846080, 0)
	
	--Props
		
	local saco_1 = CreateObject(GetHashKey("bkr_prop_meth_openbag_02"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(saco_1, netScene_1, animdict, "break_weigh_methbag01", 4.0, -8.0, 1)		
	
	local saco_2 = CreateObject(GetHashKey("bkr_prop_meth_openbag_02"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(saco_2, netScene_1, animdict, "break_weigh_methbag01^1", 4.0, -8.0, 1)
	
	local scoop_1 = CreateObject(GetHashKey("bkr_prop_meth_scoop_01a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(scoop_1, netScene_1, animdict, "break_weigh_scoop", 4.0, -8.0, 1)	
	
	local saco_3 = CreateObject(GetHashKey("bkr_prop_meth_openbag_02"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(saco_3, netScene_2, animdict, "break_weigh_methbag01^2", 4.0, -8.0, 1)		
	
	local saco_4 = CreateObject(GetHashKey("bkr_prop_meth_openbag_02"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(saco_4, netScene_2, animdict, "break_weigh_methbag01^3", 4.0, -8.0, 1)			
	
	local scale = CreateObject(GetHashKey("bkr_prop_coke_scale_01"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(scale, netScene_3, animdict, "break_weigh_scale", 4.0, -8.0, 1)		
	
	local caixa_1 = CreateObject(GetHashKey("bkr_prop_meth_bigbag_03a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(caixa_1, netScene_3, animdict, "break_weigh_box01^1", 4.0, -8.0, 1)	
	
	local caixa_2 = CreateObject(GetHashKey("bkr_prop_meth_bigbag_04a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(caixa_2, netScene_3, animdict, "break_weigh_box01", 4.0, -8.0, 1)	
	
	FreezeEntityPosition(ped, false)
	
	--Start
	NetworkStartSynchronisedScene(netScene_1)
	NetworkStartSynchronisedScene(netScene_2)
	NetworkStartSynchronisedScene(netScene_3)
	Citizen.Wait(20500)
	NetworkStopSynchronisedScene(netScene_3)
	NetworkStopSynchronisedScene(netScene_2)
	NetworkStopSynchronisedScene(netScene_1)
	
	DeleteEntity(caixa_1)
	DeleteEntity(caixa_2)
	DeleteEntity(saco_1)
	DeleteEntity(saco_2)
	DeleteEntity(saco_3)
	DeleteEntity(saco_4)
	DeleteEntity(scoop_1)
	DeleteEntity(scale)
	FreezeEntityPosition(ped, false)
	TriggerServerEvent("vrp_drug:processar_metanfetamina_finish")
end
function coke_gather(x,y,z,heading,gather)
	local animdict = "anim@amb@business@coc@coc_unpack_cut_left@"
	--Requests
	RequestModel("bkr_prop_coke_bakingsoda_o")
	RequestModel("prop_cs_credit_card")
	RequestAnimDict(animdict)
	local ped = PlayerPedId()
	local netScene_1 = NetworkCreateSynchronisedScene(x,y,z,0.0,0.0,heading, 2, false, false, 1065353216, 0, 1.3)
	
	--Ped
	NetworkAddPedToSynchronisedScene(ped, netScene_1, animdict, "coke_cut_coccutter", 0.0, -4.0, 1, 16, 1148846080, 0)
	
	--Props
	local bakingsoda = CreateObject(GetHashKey("bkr_prop_coke_bakingsoda_o"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(bakingsoda, netScene_1, animdict, "coke_cut_bakingsoda", 4.0, -8.0, 1)
	
	local card_1 = CreateObject(GetHashKey("prop_cs_credit_card"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(card_1, netScene_1, animdict, "coke_cut_creditcard", 4.0, -8.0, 1)	
	
	local card_2 = CreateObject(GetHashKey("prop_cs_credit_card"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(card_2, netScene_1, animdict, "coke_cut_creditcard^1", 4.0, -8.0, 1)	
	
	
	FreezeEntityPosition(ped, false)
	
	--Start
	NetworkStartSynchronisedScene(netScene_1)
	Citizen.Wait(13000)
	NetworkStopSynchronisedScene(netScene_1)
	
	DeleteEntity(bakingsoda)
	DeleteEntity(card_1)
	DeleteEntity(card_2)
	FreezeEntityPosition(ped, false)
	stopCocaFMM = false
	TriggerServerEvent("vrp_drug:apanhar_cocaina_finish",gather)
end
function coke_process()
	local animdict = "anim@amb@business@coc@coc_packing@"
	--Request
	RequestModel("bkr_prop_coke_mold_02a")
	RequestModel("bkr_prop_coke_fullmetalbowl_02")
	RequestModel("bkr_prop_coke_fullscoop_01a")
	RequestModel("bkr_prop_coke_cutblock_01")
	RequestModel("bkr_prop_coke_press_01aa")
	RequestAnimDict(animdict)

	local ped = PlayerPedId()
	local netScene_1 = NetworkCreateSynchronisedScene(1101.1472167969 + 0.9,-3198.7270507813,-38.993465423584 - 0.5,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	local netScene_2 = NetworkCreateSynchronisedScene(1101.1472167969 + 0.9,-3198.7270507813,-38.993465423584 - 0.5,0.0,0.0,0.0, 2, false, false, 1065353216, 0, 1.3)
	
	NetworkAddPedToSynchronisedScene(ped, netScene_1, animdict, "full_cycle_basicmould_v1_pressoperator", 0.0, -4.0, 1, 16, 1148846080, 0)
	
	local mold = CreateObject(GetHashKey("bkr_prop_coke_mold_02a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(mold, netScene_1, animdict, "full_cycle_basicmould_v1_cocmold", 4.0, -8.0, 1)
	
	local bowl = CreateObject(GetHashKey("bkr_prop_coke_fullmetalbowl_02"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(bowl, netScene_2, animdict, "full_cycle_basicmould_v1_cocbowl", 4.0, -8.0, 1)	
	
	local block = CreateObject(GetHashKey("bkr_prop_coke_cutblock_01"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(block, netScene_1, animdict, "full_cycle_basicmould_v1_cocblock", 4.0, -8.0, 1)	
	
	local scoop = CreateObject(GetHashKey("bkr_prop_coke_fullscoop_01a"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(scoop, netScene_1, animdict, "full_cycle_basicmould_v1_scoop", 4.0, -8.0, 1)	
	
	local press = CreateObject(GetHashKey("bkr_prop_coke_press_01aa"), 0,0,0, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(press, netScene_2, animdict, "full_cycle_basicmould_v1_cocpress", 4.0, -8.0, 1)	
	
	FreezeEntityPosition(ped, true)
	
	NetworkStartSynchronisedScene(netScene_1)
	NetworkStartSynchronisedScene(netScene_2)
	Citizen.Wait(25000)
	NetworkStopSynchronisedScene(netScene_2)
	NetworkStopSynchronisedScene(netScene_1)
	
	DeleteEntity(mold)
	DeleteEntity(bowl)
	DeleteEntity(scoop)
	DeleteEntity(press)
	DeleteEntity(block)
	FreezeEntityPosition(ped, false)
	TriggerServerEvent("vrp_drug:processar_cocaina_finish")
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerpos = GetEntityCoords(GetPlayerPed(-1), true)
		--Erva
			--Apanha
			if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1057.4609375,-3197.1853027344,-39.131523132324) < 1.0)and droga["erva"].gather == false then
				DrawText3D(1057.4609375,-3197.1853027344,-39.131523132324, "~b~[E] Culege Iarba", 0.5)
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("vrp_drug:apanhar_erva")
				end
			end
			--Processamento
			if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1038.3719482422,-3205.75390625,-37.283737182617) < 2.5)and droga["erva"].processing == false then
				DrawText3D(1038.3719482422,-3205.75390625,-37.283737182617, "~b~[E] Procesare Iarba", 0.5)
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("vrp_drug:processar_erva")
				end
			end
		--Metafetamina
			--Apanha

				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1005.7506103516,-3200.3068847656,-38.519317626953) < 1.0)and droga["metanfetamina"].gather == false then
					DrawText3D(1005.7506103516,-3200.3068847656,-38.519317626953, "~b~[E] Faceti metamfetamina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_metanfetamina")
					end
				end
				--Processamento
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1012.1347045898,-3194.8645019531,-38.9931640625) < 1.0)and droga["metanfetamina"].processing == false then
					DrawText3D(1012.1347045898,-3194.8645019531,-38.9931640625, "~b~[E] Ambalarea metamfetaminei", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:processar_metanfetamina")
					end
				end

		
		--Cocaina
			--Apanha
			if stopCocaFMM == false then
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1095.2523193359,-3196.6638183594,-38.993473052979) < 1.0) and droga["coca"].gather_1 == false then
					DrawText3D(1095.2523193359,-3196.6638183594,-38.993473052979, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 + 6.7,-3194.828125 - 1.5,-38.993469238281 - 0.65,180.0, 1)
					end
				end	
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1093.0297851563,-3196.8151855469,-38.993473052979) < 1.0) and droga["coca"].gather_2 == false then
					DrawText3D(1093.0297851563,-3196.8151855469,-38.993473052979, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 + 4.5,-3194.828125 - 1.5,-38.993469238281 - 0.65,180.0, 2)
					end
				end			
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1090.3753662109,-3196.6557617188,-38.993473052979) < 1.0) and droga["coca"].gather_3 == false then
					DrawText3D(1090.3753662109,-3196.6557617188,-38.993473052979, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 + 1.7,-3194.828125 - 1.5,-38.993469238281 - 0.65,180.0, 3)
					end
				end			
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1090.3765869141,-3194.8898925781,-38.993465423584) < 1.0) and droga["coca"].gather_4 == false then
					DrawText3D(1090.3765869141,-3194.8898925781,-38.993465423584, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 - 2.0,-3194.828125 - 0.4,-38.993469238281 - 0.65,0.0, 4)
					end
				end			
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1093.0084228516,-3194.9108886719,-38.993473052979) < 1.0) and droga["coca"].gather_5 == false then
					DrawText3D(1093.0084228516,-3194.9108886719,-38.993473052979, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 + 0.5,-3194.828125 - 0.4,-38.993469238281 - 0.65,0.0, 5)
					end
				end			
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1095.3453369141,-3194.8823242188,-38.993465423584) < 1.0) and droga["coca"].gather_6 == false then
					DrawText3D(1095.3453369141,-3194.8823242188,-38.993465423584, "~b~[E] Ia cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:apanhar_cocaina",1090.5065917969 + 3.0,-3194.828125 - 0.4,-38.993469238281 - 0.65,0.0, 6)
					end
				end
				--Processamento
				if(Vdist(playerpos.x, playerpos.y, playerpos.z, 1101.1104736328,-3198.619140625,-38.993473052979) < 1.0)and droga["coca"].processing == false then
					DrawText3D(1101.1104736328,-3198.619140625,-38.993473052979, "~b~[E] Pachet Cocaina", 0.5)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("vrp_drug:processar_cocaina")
					end
				end
			end
		--FIM
	end
end)
--Text
function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
--Events
RegisterNetEvent('vrp_drug:apanhar_erva_c')
AddEventHandler('vrp_drug:apanhar_erva_c', function()
	weed_gather()
end)
RegisterNetEvent('vrp_drug:processar_erva_c')
AddEventHandler('vrp_drug:processar_erva_c', function()
	weed_process()
end)
RegisterNetEvent('vrp_drug:apanhar_cocaina_c')
AddEventHandler('vrp_drug:apanhar_cocaina_c', function(x,y,z,heading,gather)
		stopCocaFMM = true
	coke_gather(x,y,z,heading,gather)
end)
RegisterNetEvent('vrp_drug:processar_cocaina_c')
AddEventHandler('vrp_drug:processar_cocaina_c', function()
	coke_process()
end)
RegisterNetEvent('vrp_drug:apanhar_metanfetamina_c')
AddEventHandler('vrp_drug:apanhar_metanfetamina_c', function()
	meth_gather()
end)
RegisterNetEvent('vrp_drug:processar_metanfetamina_c')
AddEventHandler('vrp_drug:processar_metanfetamina_c', function()
	meth_process()
end)
RegisterNetEvent('vrp_drug:updatelist')
AddEventHandler('vrp_drug:updatelist', function(lista)
	droga = lista
end)

local plmLocatii = {}
local plmLocatiiStash = {}
local itemdeVanzare = nil
local infoSelling = nil
blips = {}
function vRPeskJobsC.duDroguri(locatii,item)
	plmLocatii = locatii
	itemdeVanzare = item
	infoSelling = true
    for k,v in pairs (locatii) do
        local blip = AddBlipForCoord(v[2],v[3],v[4])
        SetBlipSprite(blip, 66)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vinde Droguri') 
		EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
	end
end

function vRPeskJobsC.duDroguriStash(locatiiStash,item)
	plmLocatiiStash = locatiiStash
	itemdeVanzare = item
	infoSelling = true
	for k,v in pairs (locatiiStash) do
        local blip = AddBlipForCoord(v[2],v[3],v[4])
        SetBlipSprite(blip, 66)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vinde Droguri') 
		EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
	end
end

function vRPeskJobsC.stopSelling()
	infoSelling = nil
	for j,p in pairs (blips) do
		RemoveBlip(p)
	end
	table.remove(blips)
end

Citizen.CreateThread(function()
	while true do
		Wait(200)
		
			for k,v in pairs (plmLocatii) do
				if infoSelling ~= nil then
					while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 3.0 do
						DrawMarker(26, v[2],v[3],v[4] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 1.0 then
							local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a vinde ~b~"..itemdeVanzare
							HelpText(text)
							if(IsControlJustReleased(1, 51))then
								if v.status == false then
									vRPSeskJobs.checkDrugs({itemdeVanzare})
									v.status = true
								end

							end
						end
						Wait(0)
					end
				end
			end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(200)
		
			for k,v in pairs (plmLocatiiStash) do
				if infoSelling ~= nil then
					while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 3.0 do
						DrawMarker(26, v[2],v[3],v[4] -0.5 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,255,255, 100, 0, 0, 0, 1, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4], true) <= 1.0 then
							local text = "~w~Apasa ~INPUT_CONTEXT~ pentru a vinde ~b~"..itemdeVanzare
							HelpText(text)
							if(IsControlJustReleased(1, 51))then
								if v.status == false then
									vRPSeskJobs.checkDrugs({itemdeVanzare})
									v.status = true
								end

							end
						end
						Wait(0)
					end
				end
			end
	end
end)