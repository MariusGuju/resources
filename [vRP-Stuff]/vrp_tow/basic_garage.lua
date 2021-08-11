-- vrp/client/basic_garage.lua

function tvRP.isPlayerInSpecificVehicle(theVehicle)
	local playerPed = GetPlayerPed(-1)
	local theCar = GetHashKey(theVehicle)
	if IsPedInModel(playerPed, theCar) then
		return true
	else
		return false
	end
end