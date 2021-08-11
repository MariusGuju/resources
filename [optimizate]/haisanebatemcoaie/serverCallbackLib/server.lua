vrpPV={}
vrpPV.ServerCallbacks={}


RegisterServerEvent('vrpPV:triggerServerCallback')
AddEventHandler('vrpPV:triggerServerCallback',function(a,b,...)
    local c=source

    vrpPV.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('vrpPV:serverCallback',c,b,...)end,...)
    end)
        
        
    
vrpPV.RegisterServerCallback = function(a,t)
    vrpPV.ServerCallbacks[a]=t 
end
                    
vrpPV.TriggerServerCallback = function(a,b,source,t,...)
    if vrpPV.ServerCallbacks[a]~=nil then 
        vrpPV.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end