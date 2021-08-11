local cooldown = 300 

mhackingCallback = {}
showHelp = false
helpTimer = 0
helpCycle = 4000
hackeando = {}
perm = nil

function vRPeskJobsC.puneHEKERMENUL(lokatzii)
	Citizen.CreateThread(function()
		while true do
			Wait(200)
			local pos = GetEntityCoords(GetPlayerPed(-1))
			for k,v in pairs(lokatzii)do

				while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[1],v[2],v[3], true) <= 10.0 do
					Wait(0)
					DrawMarker(27, v[1], v[2], v[3]-0.9, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 100, 200, 100,255, 0, 0, 0,0)
					if  GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[1],v[2],v[3], true) <= 2.0  then
						if not hackeando[k] then
							DrawText3D(v[1], v[2], v[3], "~w~APASA ~g~[E] ~w~PENTRU ~r~a HEKERII~w~",255,255,255)
							if IsControlJustPressed(1, 38) then
								perm = nil
								TriggerServerEvent('start:hacker')
								while perm == nil do
									Wait(5)
								end
								if perm then
									TriggerEvent("mhacking:show")
									TriggerEvent("mhacking:start",7,35,mycb)
									hackeando[k] = cooldown
								end
							end
						else
							DrawText3D(v[1], v[2], v[3], "~w~ vei putea sa piratezi  in ~y~"..hackeando[k].." ~w~secunde.",255,255,255)
						end
					end
				end
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			for k,v in pairs(lokatzii)do
				if hackeando[k] then
					if hackeando[k] > 0 then
						hackeando[k] = hackeando[k] - 1
					else
						hackeando[k] = nil
					end
				end
			end
		end
	end)
end

RegisterNetEvent('start:hacker')
AddEventHandler('start:hacker', function(bool)
    perm = bool
end)


function mycb(success, timeremaining)
	if success then
		TriggerServerEvent("finish:hacker", success, timeremaining)
		TriggerEvent('mhacking:hide')
	else
		TriggerEvent('mhacking:hide')
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showHelp then
			if helpTimer > GetGameTimer() then
				showHelpText("APASA ~y~W,A,S,D~s~ PENTRU A MISCA TEXTELE SI  ~y~ESPAÇO~s~ PENTRU A LE PUNE")
			elseif helpTimer > GetGameTimer()-helpCycle then
				showHelpText("Use ~y~Setas do teclado~s~ e ~y~ENTER~s~ para o bloco da direita")
			else
				helpTimer = GetGameTimer()+helpCycle
			end
			if IsEntityDead(PlayerPedId()) then
				nuiMsg = {}
				nuiMsg.fail = true
				SendNUIMessage(nuiMsg)
			end
		end
	end
end)

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

AddEventHandler('mhacking:show', function()
    nuiMsg = {}
	nuiMsg.show = true
	SendNUIMessage(nuiMsg)
	SetNuiFocus(true, false)
end)

AddEventHandler('mhacking:hide', function()
    nuiMsg = {}
	nuiMsg.show = false
	SendNUIMessage(nuiMsg)
	SetNuiFocus(false, false)
	showHelp = false
end)

AddEventHandler('mhacking:start', function(solutionlength, duration, callback)
    mhackingCallback = callback
	nuiMsg = {}
	nuiMsg.s = solutionlength
	nuiMsg.d = duration
	nuiMsg.start = true
	SendNUIMessage(nuiMsg)
	showHelp = true
end)

AddEventHandler('mhacking:setmessage', function(msg)
    nuiMsg = {}
	nuiMsg.displayMsg = msg
	SendNUIMessage(nuiMsg)
end)

RegisterNUICallback('callback', function(data, cb)
	mhackingCallback(data.success, data.remainingtime)
    cb('ok')
end)

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--== NÃO ALTERAR ==--
--== NÃO ALTERAR ==--
seqSwitch = nil
seqRemaingingTime = 0

AddEventHandler('mhacking:seqstart', function(solutionlength, duration, callback)
	if type(solutionlength) ~= 'table' and type(duration) ~= 'table' then
		TriggerEvent('mhacking:show')
		TriggerEvent('mhacking:start', solutionlength, duration, mhackingSeqCallback)
		while seqSwitch == nil do
			Citizen.Wait(5)
		end
		TriggerEvent('mhacking:hide')
		callback(seqSwitch, seqRemaingingTime, true)
		seqRemaingingTime = 0
		seqSwitch = nil
		
	elseif type(solutionlength) == 'table' and type(duration) ~= 'table' then
		TriggerEvent('mhacking:show')
		seqRemaingingTime = duration
		for _, sollen in pairs(solutionlength) do
			TriggerEvent('mhacking:start', sollen, seqRemaingingTime, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			
			if next(solutionlength,_) == nil or seqRemaingingTime == 0 then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
		
	elseif type(solutionlength) ~= 'table' and type(duration) == 'table' then
		TriggerEvent('mhacking:show')
		for _, dur in pairs(duration) do
			TriggerEvent('mhacking:start', solutionlength, dur, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(duration,_) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
	
	elseif type(solutionlength) == 'table' and type(duration) == 'table' then
		local itrTbl = {}
		local solTblLen = 0
		local durTblLen = 0
		for _ in ipairs(solutionlength) do solTblLen = solTblLen + 1 end
		for _ in ipairs(duration) do durTblLen = durTblLen + 1 end
		itrTbl = duration
		if solTblLen > durTblLen then itrTbl = solutionlength end	
		TriggerEvent('mhacking:show')
		for idx in ipairs(itrTbl) do
			TriggerEvent('mhacking:start', solutionlength[idx], duration[idx], mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(itrTbl,idx) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
		
	end
end)

function mhackingSeqCallback(success, remainingtime)
	seqSwitch = success
	seqRemaingingTime = math.floor(remainingtime/1000.0 + 0.5)
end