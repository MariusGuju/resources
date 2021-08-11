eskClanuri = {}
eskClanuri.CurrentRequestId          = 0
eskClanuri.ServerCallbacks           = {}

eskClanuri.TriggerServerCallback = function(name, cb, ...)
	eskClanuri.ServerCallbacks[eskClanuri.CurrentRequestId] = cb

	TriggerServerEvent('eskClanuri:triggerServerCallback', name, eskClanuri.CurrentRequestId, ...)

	if eskClanuri.CurrentRequestId < 65535 then
		eskClanuri.CurrentRequestId = eskClanuri.CurrentRequestId + 1
	else
		eskClanuri.CurrentRequestId = 0
	end
end

RegisterNetEvent('eskClanuri:serverCallback')
AddEventHandler('eskClanuri:serverCallback', function(requestId, ...)
	eskClanuri.ServerCallbacks[requestId](...)
	eskClanuri.ServerCallbacks[requestId] = nil
end)