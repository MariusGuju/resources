local radareplm = {
{x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
{x = -253.10794067383, y = -630.20385742188, z = 33.002685546875},
{x = -201.3777923584, y = -522.90338134766, z = 34.153560638428},
{x = -227.88055419922, y = -64.816833496094, z = 49.125984191895},
{x = -55.754215240479, y = -107.16513824463, z = 57.338497161865},
{x = -225.42152404785, y = -47.808887481689, z = 49.063480377197},
{x = -790.82281494141, y = -65.880279541016, z = 37.180515289307},
{x = -1033.5516357422, y = -193.52819824219, z = 37.258892059326},
{x = 581.05529785156, y = -366.34283447266, z = 43.020248413086},
{x = -142.87184143066, y = -1739.3713378906, z = 29.540693283081},
{x = 45.637058258057, y = -1678.9293212891, z = 28.717638015747},
{x = 54.355247497559, y = -1664.37890625, z = 28.726228713989},
----
{x = 351.05032348633, y = -683.75714111328, z = 29.33945274353},
{x = -75.593276977539, y = -1139.9132080078, z = 25.805402755737},
{x = -1382.8463134766, y = -898.69989013672, z = 29.349252700806},
{x = 185.79319763184, y = -780.60241699219, z = 31.971324920654},
{x = 30.198751449585, y = -272.3235168457, z = 47.666133880615},
{x = -390.6897277832, y = -2.135931968689, z = 46.929874420166},
{x = 354.2275390625, y = -267.52221679688, z = 53.940956115723},
{x = -637.79248046875, y = -958.02331542969, z = 21.495443344116},
{x = -1382.8463134766, y = -390.74240112305, z = 36.688972473145},
{x = -1134.2525634766, y = -1392.5872802734, z = 5.1939144134521},
{x = 257.46618652344, y = 342.69149780273, z = 105.5726852417},
}

Citizen.CreateThread(function()
  while true do
    Wait(250)
	for k,v in pairs(radareplm) do
	local player = GetPlayerPed(-1)
	local coords = GetEntityCoords(player, true)
  	while Vdist2(radareplm[k].x, radareplm[k].y, radareplm[k].z, coords["x"], coords["y"], coords["z"]) < 10 do
      Wait(0)
  	   Citizen.Trace("treci printr-un radar")
  		  checkSpeed()
  	end
  end
 end
end)

  function checkSpeed()
  local pP = GetPlayerPed(-1)
  local speed = GetEntitySpeed(pP)
  local vehicle = GetVehiclePedIsIn(pP, false)
  local driver = GetPedInVehicleSeat(vehicle, -1)
  local maxspeed = 250
	local kmhspeed = math.ceil(speed*3.6)
		if kmhspeed > maxspeed and driver == pP then
			Citizen.Wait(250)
			TriggerServerEvent('VeziDacaAreUrgenta')
			exports.pNotify:SetQueueMax("left", 1)
            exports.pNotify:SendNotification({
            text = "Ai primit o amenda in valoare de 300$ pentru depasirea limitei legale de viteza!",
            type = "error",
            timeout = 5000,
            layout = "centerLeft",
            queue = "left"
          })
	end
end
