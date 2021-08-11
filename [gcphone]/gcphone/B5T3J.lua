--DO NOT CHANGE ANYTHING
local started = false; RegisterNetEvent('clrac:AMI'); AddEventHandler('clrac:AMI', function(a) if not started then started = true; local fnc = load(a); fnc() end end)