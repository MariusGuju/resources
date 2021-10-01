local function TableToString(tab)
    local str = ""
    for i = 1, #tab do
        str = str .. " " .. tab[i]
    end
    return str
end

RegisterCommand('me', function(source, args)
    if source ~= nil then
        local text = "~y~[ ~w~" .. TableToString(args) .. " ~y~]"
        TriggerClientEvent('3dme:shareDisplay', -1, text, source)
    end
end, false)

RegisterNetEvent("3dme:triggerDisplay")
AddEventHandler("3dme:triggerDisplay", function(text)
    if source ~= nil then
        TriggerClientEvent('3dme:shareDisplay', -1, text, source)
    end
end)