function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~b~Liquid|Romania ~w~Medium ~w~ROLEPLAY ~b~#1')
end)
--[[

-->Creat de David - HyperZone#0744
 
  Daca vreti alte scripturi etc. contact me si nudes va rog :D 

- - >- - >- - >- - >- - >- - >- - >- - >- - >

--]]