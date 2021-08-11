local tiempo = 4000 -- 1000 ms = 1s
local isTaz = false

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw) 
	TriggerEvent("SeatShuffle")
end, false)

local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then 
            --HideHudComponentThisFrame( 14 )
		end 
end 


local arme = {
	{"WEAPON_STUNGUN",0.01},
	{"WEAPON_FLAREGUN",0.02},
	{"WEAPON_SNSPISTOL",0.025},
	{"WEAPON_SNSPISTOL_MK2",0.025},
	{"WEAPON_PISTOL",0.025},
	{"WEAPON_PISTOL_MK2",0.03},
	{"WEAPON_APPISTOL",0.05},
	{"WEAPON_COMBATPISTOL",0.03},
	{"WEAPON_PISTOL50",0.05},
	{"WEAPON_HEAVYPISTOL",0.03},
	{"WEAPON_VINTAGEPISTOL",0.025},
	{"WEAPON_MARKSMANPISTOL",0.03},
	{"WEAPON_REVOLVER",0.045},
	{"WEAPON_REVOLVER_MK2",0.055},
	{"WEAPON_DOUBLEACTION",0.025},
	{"WEAPON_MICROSMG",0.035},
	{"WEAPON_COMBATPDW",0.045},
	{"WEAPON_SMG",0.045},
	{"WEAPON_SMG_MK2",0.055},
	{"WEAPON_ASSAULTSMG",0.050},
	{"WEAPON_MINISMG",0.035},
	{"WEAPON_MG",0.07},
	{"WEAPON_ASSAULTRIFLE",0.07},
	{"WEAPON_ASSAULTRIFLE_MK2",0.075},
	{"WEAPON_CARBINERIFLE",0.06},
	{"WEAPON_CARBINERIFLE_MK2",0.065},
	{'WEAPON_ADVANCEDRIFLE',0.06},
	{'WEAPON_SPECIALCARBINE',0.06},
	{'WEAPON_SPECIALCARBINE_MK2',0.075},
	{'WEAPON_PUMPSHOTGUN',0.07},
	{'WEAPON_PUMPSHOTGUN_MK2',0.085},
	{'WEAPON_ASSAULTSHOTGUN',0.12},
	{'WEAPON_HEAVYSHOTGUN',0.13},
	{'WEAPON_SNIPERRIFLE',0.2},
	{'WEAPON_HEAVYSNIPER',0.3},
	{'WEAPON_HEAVYSNIPER_MK2',0.35}
}

CreateThread(function()
	while true do
		Wait(100)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
			
		DisplayAmmoThisFrame(false)

		for k,v in pairs(arme) do
			while GetSelectedPedWeapon(GetPlayerPed( -1 )) == v[1] do
				Wait(0)
				if IsPedShooting(GetPlayerPed( -1 )) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', v[2])
				end
			end
		end
	end
end)

local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 0.1, -- AP PISTOL
	[2578377531] = 0.6, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.4, -- PUMP SHOTGUN
	[1432025498] = 0.4, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.7, -- HEAVY SNIPER
	[177293209] = 0.7, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[2009644972] = 0.25, -- SNS PISTOL MK2
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.35, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
  	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.65, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.3, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG		
}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)		
		if IsPedBeingStunned(GetPlayerPed(-1)) then			
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)			
		end		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)			
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)			
			SetTimecycleModifier("hud_def_desat_Trevor")			
			Wait(10000)			
      	SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end
			
		end
	end
end)

Citizen.CreateThread(function() 
	while true do 
		Wait(250)
		while IsPedInAnyVehicle(GetPlayerPed(-1), true) do
			Wait(0)
			local car = GetVehiclePedIsUsing(GetPlayerPed(-1))			
			if GetPedInVehicleSeat(car, -1) == GetPlayerPed(-1) then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			else
				SetPlayerCanDoDriveBy(PlayerId(), true)
			end
		end
	end
end)