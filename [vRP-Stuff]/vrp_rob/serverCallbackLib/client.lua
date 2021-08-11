vrpRob = {}
vrpRob.CurrentRequestId          = 0
vrpRob.ServerCallbacks           = {}

vrpRob.TriggerServerCallback = function(name, cb, ...)
	vrpRob.ServerCallbacks[vrpRob.CurrentRequestId] = cb

	TriggerServerEvent('vrpRob:triggerServerCallback', name, vrpRob.CurrentRequestId, ...)

	if vrpRob.CurrentRequestId < 65535 then
		vrpRob.CurrentRequestId = vrpRob.CurrentRequestId + 1
	else
		vrpRob.CurrentRequestId = 0
	end
end

RegisterNetEvent('vrpRob:serverCallback')
AddEventHandler('vrpRob:serverCallback', function(requestId, ...)
	vrpRob.ServerCallbacks[requestId](...)
	vrpRob.ServerCallbacks[requestId] = nil
end)