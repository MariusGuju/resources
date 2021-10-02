
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        RestorePlayerStamina(PlayerId(), 1.0) -- stamina infinita
         -- These natives has to be called every frame.
        SetPedDensityMultiplierThisFrame(0.0)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)

        -- wantedul gta5
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
          SetPlayerWantedLevel(PlayerId(), 0, false)
          SetPlayerWantedLevelNow(PlayerId(), false)
         end

         -- armele sa le stearga
         RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
         RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
         RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
         -- HUDUL DE LA STRAZI SI MASINI
         HideHudComponentThisFrame(1)  -- Wanted Stars
         HideHudComponentThisFrame(3)  -- Cash
         HideHudComponentThisFrame(4)  -- MP Cash
         HideHudComponentThisFrame(6)  -- Vehicle Name
         HideHudComponentThisFrame(7)  -- Area Name
         HideHudComponentThisFrame(8)  -- Vehicle Class
         HideHudComponentThisFrame(9)  -- Street Name
         HideHudComponentThisFrame(13) -- Cash Change
         HideHudComponentThisFrame(17) -- Save Game
         HideHudComponentThisFrame(20) -- Weapon Stats
    end
end)
