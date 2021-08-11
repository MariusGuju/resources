vrpRob={}
vrpRob.ServerCallbacks={}


RegisterServerEvent('vrpRob:triggerServerCallback')
AddEventHandler('vrpRob:triggerServerCallback',function(a,b,...)
    local c=source

    vrpRob.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('vrpRob:serverCallback',c,b,...)end,...)
    end)
        
        
    
vrpRob.RegisterServerCallback = function(a,t)
    vrpRob.ServerCallbacks[a]=t 
end
                    
vrpRob.TriggerServerCallback = function(a,b,source,t,...)
    if vrpRob.ServerCallbacks[a]~=nil then 
        vrpRob.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end