vrpEUP = {}
vrpEUP.CurrentRequestId          = 0
vrpEUP.ServerCallbacks           = {}

vrpEUP.TriggerServerCallback = function(name, cb, ...)
	vrpEUP.ServerCallbacks[vrpEUP.CurrentRequestId] = cb

	TriggerServerEvent('vrpEUP:triggerServerCallback', name, vrpEUP.CurrentRequestId, ...)

	if vrpEUP.CurrentRequestId < 65535 then
		vrpEUP.CurrentRequestId = vrpEUP.CurrentRequestId + 1
	else
		vrpEUP.CurrentRequestId = 0
	end
end

RegisterNetEvent('vrpEUP:serverCallback')
AddEventHandler('vrpEUP:serverCallback', function(requestId, ...)
	vrpEUP.ServerCallbacks[requestId](...)
	vrpEUP.ServerCallbacks[requestId] = nil
end)