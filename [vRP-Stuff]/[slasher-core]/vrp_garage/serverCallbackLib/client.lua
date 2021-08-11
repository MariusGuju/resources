eskCase = {}
eskCase.CurrentRequestId          = 0
eskCase.ServerCallbacks           = {}

eskCase.TriggerServerCallback = function(name, cb, ...)
	eskCase.ServerCallbacks[eskCase.CurrentRequestId] = cb

	TriggerServerEvent('eskCase:triggerServerCallback', name, eskCase.CurrentRequestId, ...)

	if eskCase.CurrentRequestId < 65535 then
		eskCase.CurrentRequestId = eskCase.CurrentRequestId + 1
	else
		eskCase.CurrentRequestId = 0
	end
end

RegisterNetEvent('eskCase:serverCallback')
AddEventHandler('eskCase:serverCallback', function(requestId, ...)
	eskCase.ServerCallbacks[requestId](...)
	eskCase.ServerCallbacks[requestId] = nil
end)