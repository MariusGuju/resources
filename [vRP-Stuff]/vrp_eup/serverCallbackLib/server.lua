vrpEUP={}
vrpEUP.ServerCallbacks={}


RegisterServerEvent('vrpEUP:triggerServerCallback')
AddEventHandler('vrpEUP:triggerServerCallback',function(a,b,...)
    local c=source

    vrpEUP.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('vrpEUP:serverCallback',c,b,...)end,...)
    end)
        
        
    
vrpEUP.RegisterServerCallback = function(a,t)
    vrpEUP.ServerCallbacks[a]=t 
end
                    
vrpEUP.TriggerServerCallback = function(a,b,source,t,...)
    if vrpEUP.ServerCallbacks[a]~=nil then 
        vrpEUP.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end