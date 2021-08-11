

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 1000 )
    end
end 

RegisterNetEvent( 'KneelHU' )
AddEventHandler( 'KneelHU', function()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end     
    end
end )

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)


local arrst	= false
local arest_on = false		
 
local animatie3 = 'mp_arrest_paired'
local animatie2 = 'cop_p2_back_left'
local animatie1 = 'crook_p2_back_left'



RegisterNetEvent('slasher:aresteazanabu')
AddEventHandler('slasher:aresteazanabu', function(target)     
	arest_on = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(animatie3)

	while not HasAnimDictLoaded(animatie3) do
		Citizen.Wait(1000)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, animatie3, animatie1, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	arest_on = false
end) 


RegisterNetEvent('slasher:aresteaza')
AddEventHandler('slasher:aresteaza', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(animatie3)

	while not HasAnimDictLoaded(animatie3) do
		Citizen.Wait(1000)
	end

	TaskPlayAnim(playerPed, animatie3, animatie2, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	arrst = false

end)