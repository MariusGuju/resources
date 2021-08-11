eskClanuri={}
eskClanuri.ServerCallbacks={}


RegisterServerEvent('eskClanuri:triggerServerCallback')
AddEventHandler('eskClanuri:triggerServerCallback',function(a,b,...)
    local c=source

    eskClanuri.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('eskClanuri:serverCallback',c,b,...)end,...)
    end)
        
        
    
eskClanuri.RegisterServerCallback = function(a,t)
    eskClanuri.ServerCallbacks[a]=t 
end
                    
eskClanuri.TriggerServerCallback = function(a,b,source,t,...)
    if eskClanuri.ServerCallbacks[a]~=nil then 
        eskClanuri.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] nu exista')
    end 
end