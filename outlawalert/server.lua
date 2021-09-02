RegisterServerEvent('thiefInProgress')
AddEventHandler('thiefInProgress', function(street1, street2, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~ATTACK La Magazin de catre un | ~w~"..sex.." ~g~INTRE STRAZIILE ~w~"..street1.."~g~ SI ~w~"..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~ATTACK La Magazin ~w~"..veh.." ~r~De catre un(o)~w~"..sex.." ~r~INTRE STRAZIILE ~g~"..street1.."~r~ SI ~g~"..street2)
	end
end)

RegisterServerEvent('thiefInProgressS1')
AddEventHandler('thiefInProgressS1', function(street1, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~ATTACK La Magazin de catre un | ~w~"..sex.." ~r~LA ~g~"..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~ATTACK La Magazin | ~g~"..veh.." ~r~De catre un(o) | ~w~"..sex.." ~r~at ~g~"..street1)
	end
end)

RegisterServerEvent('thiefInProgressPos')
AddEventHandler('thiefInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('thiefPlace', -1, tx, ty, tz)
end)
