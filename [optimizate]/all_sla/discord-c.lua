players = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		players = {}
		for i = 0,255 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("vRP:Discord")
		Citizen.Wait(5000)
	end
end)

RegisterNetEvent('vRP:Discord-rich')
AddEventHandler('vRP:Discord-rich', function(user_id, faction, name)
SetDiscordAppId(865896936807858226)-- Discord RICH ID
SetDiscordRichPresenceAsset('logo') -- IMAGEM PNG ARQUIVO
SetDiscordRichPresenceAssetText('NorbSiMaruServer Community') -- PNG DESCRI��O 1 TEXTO
SetDiscordRichPresenceAssetSmall('logo')
SetDiscordRichPresenceAssetSmallText('discord.gg/NorbSiMaruServer') 
SetDiscordRichPresenceAction(0, "Server Discord", "https://discord.gg/NorbSiMaruServer")
SetDiscordRichPresenceAction(1, "JOIN FIVEM", "fivem://connect/cfx.re/")
--SetRichPresence("[ID:" ..user_id.."] - [Nume:"..name.. "] - ".. #players .. "/32 - [Job:" .. faction .. "]" )
SetRichPresence("[ID:" ..user_id.."] - [Nume:"..name.. "] -[Job:" .. faction .. "]- |" .. #players .."/32")

end)
