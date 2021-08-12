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
SetDiscordAppId(831533382009094175)-- Discord RICH ID
SetDiscordRichPresenceAsset('liquid_logo') -- IMAGEM PNG ARQUIVO
SetDiscordRichPresenceAssetText('Liquid Romania RolePlay') -- PNG DESCRI��O 1 TEXTO
SetDiscordRichPresenceAssetSmall('liquid_logo')
SetDiscordRichPresenceAssetSmallText('discord.io/LiquidRR') 
SetDiscordRichPresenceAction(0, "Server Discord", "https://discord.gg/sAeykumGkV")
SetDiscordRichPresenceAction(1, "JOIN FIVEM", "fivem://connect/cfx.re/")
SetRichPresence("[ID:" ..user_id.."] - [Nume:"..name.. "] -[Job:" .. faction .. "]- |" .. #players .."/512")

end)
