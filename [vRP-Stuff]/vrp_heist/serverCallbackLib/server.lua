vrpGold={}
vrpGold.ServerCallbacks={}


RegisterServerEvent('vrpGold:triggerServerCallback')
AddEventHandler('vrpGold:triggerServerCallback',function(a,b,...)
    local c=source

    vrpGold.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('vrpGold:serverCallback',c,b,...)end,...)
    end)
        
        
    
vrpGold.RegisterServerCallback = function(a,t)
    vrpGold.ServerCallbacks[a]=t 
end
                    
vrpGold.TriggerServerCallback = function(a,b,source,t,...)
    if vrpGold.ServerCallbacks[a]~=nil then 
        vrpGold.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end