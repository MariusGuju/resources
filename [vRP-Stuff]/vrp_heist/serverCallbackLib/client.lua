vrpGold = {}
vrpGold.CurrentRequestId          = 0
vrpGold.ServerCallbacks           = {}

vrpGold.TriggerServerCallback = function(name, cb, ...)
	vrpGold.ServerCallbacks[vrpGold.CurrentRequestId] = cb

	TriggerServerEvent('vrpGold:triggerServerCallback', name, vrpGold.CurrentRequestId, ...)

	if vrpGold.CurrentRequestId < 65535 then
		vrpGold.CurrentRequestId = vrpGold.CurrentRequestId + 1
	else
		vrpGold.CurrentRequestId = 0
	end
end

RegisterNetEvent('vrpGold:serverCallback')
AddEventHandler('vrpGold:serverCallback', function(requestId, ...)
	vrpGold.ServerCallbacks[requestId](...)
	vrpGold.ServerCallbacks[requestId] = nil
end)