AddEventHandler('playerConnecting', function()
	TriggerClientEvent('showNotification', -1,"~b~[~w~Liquid|Romania~b~]~b~".. GetPlayerName(source).."~w~ a aterizat in oras.")
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('showNotification', -1,"~b~[~w~Liquid|Romania~b~]~y~".. GetPlayerName(source).."~w~ a decolat din oras :(.")
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
		reason = 2
	end
	if reason == 0 then
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ S-a sinucis. ")
	elseif reason == 1 then
		TriggerClientEvent('showNotification', -1,"~o~".. killer .. "~w~ l-a omorat pe ~o~"..GetPlayerName(source).."~w~.")
	else
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ a murit.")
	end
end)