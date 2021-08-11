--Convertida Vrpex FoxOak
function TchatGetMessageChannel (channel, cb)
    exports.ghmattimysql:execute("SELECT * FROM phone_app_chat WHERE channel = @channel ORDER BY time DESC LIMIT 100", { 
        ['@channel'] = channel
    }, cb)
end

function TchatAddMessage (channel, message)

  exports.ghmattimysql:execute("INSERT INTO phone_app_chat (`channel`, `message`) VALUES(@channel, @message);",{
    ['@channel'] = channel,
    ['@message'] = message
  })
  local response = exports.ghmattimysql:executeSync("SELECT * from phone_app_chat WHERE `id` = (SELECT LAST_INSERT_ID());" , {})
  TriggerClientEvent('gcPhone:tchat_receive', -1, response[1])

end


RegisterServerEvent('gcPhone:tchat_channel')
AddEventHandler('gcPhone:tchat_channel', function(channel)
  local sourcePlayer = tonumber(source)
  TchatGetMessageChannel(channel, function (messages)
    TriggerClientEvent('gcPhone:tchat_channel', sourcePlayer, channel, messages)
  end)
end)

RegisterServerEvent('gcPhone:tchat_addMessage')
AddEventHandler('gcPhone:tchat_addMessage', function(channel, message)
  TchatAddMessage(channel, message)
end)