AddEventHandler('playerConnecting', function()
	TriggerClientEvent('showNotification', -1,"~b~[~w~Liquid|Romania~b~]~b~".. GetPlayerName(source).."~w~ a aterizat in oras.")
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('showNotification', -1,"~b~[~w~Liquid|Romania~b~]~y~".. GetPlayerName(source).."~w~ a decolat din oras :(.")
end)
