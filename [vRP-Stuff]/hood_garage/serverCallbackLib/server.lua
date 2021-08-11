eskCase={}
eskCase.ServerCallbacks={}


RegisterServerEvent('eskCase:triggerServerCallback')
AddEventHandler('eskCase:triggerServerCallback',function(a,b,...)
    local c=source

    eskCase.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('eskCase:serverCallback',c,b,...)end,...)
    end)
        
        
    
eskCase.RegisterServerCallback = function(a,t)
    eskCase.ServerCallbacks[a]=t 
end
                    
eskCase.TriggerServerCallback = function(a,b,source,t,...)
    if eskCase.ServerCallbacks[a]~=nil then 
        eskCase.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] nu exista')
    end 
end