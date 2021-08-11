vRPrb = {}
Tunnel.bindInterface("vrp_rob",vRPrb)
vRPserver = Tunnel.getInterface("vRP","vrp_rob")
RBserver = Tunnel.getInterface("vrp_rob","vrp_rob")
vRP = Proxy.getInterface("vRP")

local PalavrasSenha = {
    "LASSOAPA",
    "AKQLABIS",
    "ARWZEWXY",
    "TRANCADO",
    "COAVCKIA",
    "CREAMPIE",
    "CREPADEFR"
}
local blockKeys = false
local scaleform = nil
local chanceshack = 5
local ClickReturn
local SorF = false
local Hacking = false
local UsandoComputador = false
local hackingBank = nil
local contador = 0
local RouboIniciado = false
local inRob = false
local bankID = nil
local robProgress = nil
local mesaj = ""

function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

Citizen.CreateThread(function()
	while true do
		for k, v in ipairs(Config.BankRobbery) do
			local x,y,z = table.unpack(v.Coods)
			local Coordenadas = GetEntityCoords(PlayerPedId())
			local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z, x,y,z, true)
			if Distancia < 6.0 then
				Opacidade = math.floor(255 - (Distancia * 40))
				TextoMarker(x,y,z+1.0, "APASA ~r~[ F ]~w~ PENTRU A INCEPE ROBUL", Opacidade)
					DrawMarker(Config.marker.idmarker, x,y,z, 0, 0, 0, 0, 0, 0, Config.marker.x1,Config.marker.y1,Config.marker.z1,Config.marker.r,Config.marker.g,Config.marker.b,Config.marker.a, Config.marker.pula, 0, 0, Config.marker.gira)
				    if contador == 0 then
					TextoMarker(x,y,z+0.7, '~r~UNITATE: '..v.BankName..'!', Opacidade)
                    if (IsControlJustPressed(1,49)) then

                        if not RouboIniciado then
                            vrpRob.TriggerServerCallback('verificaPD', function(infoPD)
                                if infoPD >= v.Cops then
                                    vrpRob.TriggerServerCallback('verificaIteme', function(cb)
                                        if cb then
                                            spawnBani()
                                            local message = '[DISPECERAT] JAF LA '..v.BankName..'!'
                                            TriggerServerEvent('vrp_rob:ChamadoPolicial', message, {x, y, z})
                                            SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                                            PlaySoundFromCoord(-1, "scanner_alarm_os", x,y,z, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
                                            RouboIniciado = true
                                            contador = v.contador
                                            startRob(k)
                                        end
                                    end,k)
                                else
                                    TriggerEvent('vrp_rob:helpTimed', 'Nu sunt destui politisti online', 50)
                                    RouboIniciado = false
                                end
                            end)
                        end
					end
				else
					TextoMarker(x,y,z+0.8, "[~p~"..mesaj.."~w~] ROB IN PROGRES LA BANCA ~r~".. contador .. " ~w~SECUNDE RAMASE", Opacidade)
                    
				end
			end
        end
        Citizen.Wait(1)
    end
end)

function startRob(bankID)
    inRob = true
    robProgress = bankID
    for k, v in ipairs(Config.BankRobbery) do
        if robProgress == k then
            mesaj = v.BankName
        end
    end
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if contador > 0 then
			contador = contador - 1
        end
        if contador == 0 then
            RouboIniciado = false
            inRob = true
            robProgress = nil
        end
	end
end)

function TextoMarker(x,y,z, text, Opacidade)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then
        SetTextScale(0.54, 0.54)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        
        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end
        
        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end

        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(1) -- 5-Merryweather | 4-PC | 3-City os LS | 2-Humane Labdavizin | 1-Pacific Standart
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("Ia vezi ma desktopul")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("Ia vezi ma desktopul")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Deconectar")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(chanceshack)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(chanceshack)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()
        

        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    --UsandoComputador = true
    while true do
        Citizen.Wait(0)
        if UsandoComputador then
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasScaleformMovieLoaded(scaleform) and UsandoComputador then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
                --print("ProgramID: "..ProgramID)
                if ProgramID == 83 and not Hacking then
                    chanceshack = 5
                    
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(chanceshack)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()
                    
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(PalavrasSenha[math.random(#PalavrasSenha)])
                    PopScaleformMovieFunctionVoid()

                    Hacking = true
                elseif ProgramID == 82 and not Hacking then
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 87 then
                    chanceshack = chanceshack - 1
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(chanceshack)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif Hacking and ProgramID == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(0)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    SorF = false    
                    local v = Config.BankRobbery[hackingBank]
                    TriggerServerEvent('vrp_rob:setDoorFreezeStatus', hackingBank, #v.Doors, false)
                    PlaySoundFromCoord(-1, "scanner_alarm_os", v.Doors[#v.Doors].Coords.x, v.Doors[#v.Doors].Coords.y, v.Doors[#v.Doors].Coords.z, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
                    mHacking = false
					local message = ' A avut loc o încălcare a datelor '.. v.BankName ..' și bolta bancă a fost deschisă!'
					TriggerServerEvent('vrp_rob:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
                    ClearPedTasks(PlayerPedId())
                elseif ProgramID == 6 then
                    UsandoComputador = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
                
                if Hacking then
                    PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
                    if chanceshack <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        ClearPedTasks(PlayerPedId())
                        local v = Config.BankRobbery[hackingBank]
                        local message = 'O persoană anonimă a încercat să încalce sistemul'..v.BankName ..''
						TriggerServerEvent('vrp_rob:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                        mHacking = false
                    end
                end
            end
        else
            Wait(250)
        end
    end
end)

local mHacking = false

function USBSuccess(success, timeremaining)
    if success then
        blockKeys = false
        TriggerEvent('mhacking:hide')
        scaleform = Initialize("HACKING_PC")
        UsandoComputador = true
    else
        TriggerEvent('mhacking:hide')
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        local v = Config.BankRobbery[hackingBank]
		local message = 'Uma pessoa tentou infringir o sistema do '..v.BankName ..''
		TriggerServerEvent('vrp_rob:ChamadoPolicial', message, {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
        blockKeys = false
        mHacking = false
    end
end

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Hacking.Coords, true) <= 2.0 and v.Doors[#v.Doors].Frozen and not mHacking then
                local allowed = false
                if #v.Doors > 3 then
                    if not v.Doors[#v.Doors - 3].Frozen then
                        allowed = true
                    end
                else
                    allowed = true
                end
                if allowed then
                    if RouboIniciado then
                        TriggerEvent('vrp_rob:helpTimed', 'Apasa ~INPUT_CONTEXT~ pentru a da hack '..v.BankName, 25)
                        if IsControlPressed(0, 38) then
                        local police = 5
                            while police == nil do
                                Wait(5)
                            end

                                mHacking = true
                                blockKeys = true
                                TriggerEvent('mhacking:hide')
                                FreezeEntityPosition(PlayerPedId(), true)
                                RequestAnimDict('anim@heists@ornate_bank@hack')
                                while not HasAnimDictLoaded('anim@heists@ornate_bank@hack') do
                                    Wait(10)
                                end
                                TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 8.0, -1, 1, 0, false, false, false)
                                hackingBank = k
                                TriggerEvent("mhacking:show")
                                TriggerEvent("mhacking:start", 3, 60, USBSuccess)

                        end
                    end
                end
                Wait(10)
            end
        end
        Wait(100)
    end
end)

local soundid = nil

RegisterNetEvent('vrp_rob:updateMoney')
AddEventHandler('vrp_rob:updateMoney', function(bank, money)
    Config.BankRobbery[bank].Money.Amount = money
end)

local moneyPile = {}

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    while true do
        rememberMoneyTable = moneyPile
        moneyPile = {}
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local Moneycaixa = nil 

			local Moneycaixa = RBserver.getBox(k)

            while Moneycaixa == nil do 
                Wait(0)
            end
            v.Money.Box = Moneycaixa

            local model = GetHashKey(v.Money.Box)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end

            local object = CreateObject(model, v.Money.BoxPosition, false, false)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            table.insert(moneyPile, {Object = object})
            for i = 1, #rememberMoneyTable do
                DeleteEntity(rememberMoneyTable[i].Object)
            end
        end
        Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    while acabouspawn do
        rememberMoneyTable = moneyPile
        moneyPile = {}
        Carrinholocal = {}
        for k, v in pairs(Config.BankRobbery) do
        for j = 1, #Config.BankRobbery[k].Carrinhos do
            local s = Config.BankRobbery[k].Carrinhos[j]
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local Moneycaixa = nil 
			local Moneycaixa = RBserver.getBox(k)
            while Moneycaixa == nil do 
                Wait(0)
            end
            v.Money.Box = Moneycaixa
            local model = GetHashKey(v.Money.Box)
            loadModel(model)
            local object = CreateObject(model, v.Money.BoxPosition, false, false)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            table.insert(moneyPile, {Object = object})
            for i = 1, #rememberMoneyTable do
                DeleteEntity(rememberMoneyTable[i].Object)
            end
            local Carrinhohash = GetHashKey('hei_prop_hei_cash_trolly_01')
            loadModel(Carrinhohash)
            CarrinhoMoney = CreateObject(Carrinhohash, s.Coords, true, true, true)
            table.insert(Carrinholocal, CarrinhoMoney)
            PlaceObjectOnGroundProperly(CarrinhoMoney)
            SetEntityRotation(CarrinhoMoney, 0, 0, s.Heading, 2)
            FreezeEntityPosition(CarrinhoMoney, true)
            SetEntityAsMissionEntity(CarrinhoMoney, true, true)
            acabouspawn = false
        end
        end
        Wait(5000)
    end
end)

--[[
Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    local fakeTimer = 500
    local bag = false
    while true do
        fakeTimer = fakeTimer + 1
        if fakeTimer >= 500 then
            bag = true
            fakeTimer = 0
        end
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 1.5 and not v.Doors[#v.Doors].Frozen then
                if v.Money.Amount > 0 then
                --if v.Money.Amount > 0 and true then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('Apasa ~INPUT_CONTEXT~ pentru a obtine banii')
                    EndTextCommandDisplayHelp(0, false, true, -1)
                    if IsControlPressed(0, 38) then
						local police = 5
                        while police == nil do
                            Wait(5)
                        end

                            TaskClearLookAt(player)
                            TaskLookAtCoord(player, v.Money.BoxPosition, 1000, 0, 2)
                            Wait(500)
                            local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                            SetCamCoord(cam, v.Money.Cam.Coords.x, v.Money.Cam.Coords.y, v.Money.Cam.Coords.z)
                            SetCamRot(cam, v.Money.Cam.Rotation.rx, v.Money.Cam.Rotation.ry, v.Money.Cam.Rotation.rz, v.Money.Cam.Rotation.r)
                            RenderScriptCams(1, 0, 0, 1, 1)
                            SetCamActive(cam, true)

                            --SetEntityCoords(player, v.Money.Coords)
                            --SetEntityHeading(player, v.Money.Heading)

                            blockKeys = true
                            local cash_hash = GetHashKey("hei_prop_heist_cash_pile")
                            RequestModel(cash_hash)
                            while not HasModelLoaded(cash_hash) do
                                Wait(0)
                            end

                            RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
                            while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
                                Wait(10)
                            end
                            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "intro", 8.0, -8.0, -1, 1, 0, false, false, false)

                            Wait(1000)

                            local bagHash = GetHashKey('p_ld_heist_bag_s_pro_o')
                            RequestModel(bagHash)
                            while not HasModelLoaded(bagHash) do
                                Wait(0)
                            end
                            local bagProp = CreateObject(bagHash, coords, true, false)
                            SetEntityAsMissionEntity(bagProp, true, true)
                            local bagIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                            AttachEntityToEntity(bagProp, PlayerPedId(), bagIndex, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                            local cashPile = CreateObject(cash_hash, 0, 0, 0, true, false)
                            SetEntityAsMissionEntity(cashPile, true, true)
                            local boneIndex = GetPedBoneIndex(PlayerPedId(), 18905)
                            while v.Money.Amount > 0 do
                                Wait(150)
                                TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
                                AddTextComponentSubstringPlayerName('Apasa ~INPUT_JUMP~ pentru a obtine banii')
                                Wait(350)
                                TriggerServerEvent('vrp_rob:takeMoney', k)
                                AttachEntityToEntity(cashPile, PlayerPedId(), boneIndex, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
                                Wait(500)
                                DetachEntity(cashPile, false, false)
                                SetEntityCoords(cashPile, 0, 0, 0)
                                if IsDisabledControlPressed(0, 22) then
                                    break
                                end
                            end
                            RenderScriptCams(false, false, 0, true, false)
                            DestroyCam(cam, false)
                            TaskClearLookAt(player)
                            DeleteEntity(cashPile)
                            DeleteEntity(bagProp)
                            SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                            ClearPedTasks(player)
                            blockKeys = false
                            for i = 1, #rememberMoneyTable do
                                DeleteEntity(rememberMoneyTable[i].Object)
                            end

                    end
                end
            end
        end
        Wait(0)
    end
end)
--]]

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 2.0 then
                local position = v.Money.BoxPosition
                DrawText3D(position.x, position.y, position.z + 0.5 , '~g~$'.. v.Money.Amount .. '', 0.8)
            else
                Wait(250)
            end
        end
        Wait(0)
    end
end)

local state = 0
local inMission = false
local ped = {}
local currentDrillAnim = 'drill_straight_idle'

RegisterNetEvent('vrp_rob:getTimeCl')
AddEventHandler('vrp_rob:getTimeCl', function(x)
    if x then
        state = 1
    else
        state = 0
    end
end)

local weldedDoors = {}

RegisterNetEvent('vrp_rob:setDoorFreezeStatusCl')
AddEventHandler('vrp_rob:setDoorFreezeStatusCl', function(bank, door, status)
    Config.BankRobbery[bank].Doors[door].Frozen = status
end)

RegisterNetEvent('vrp_rob:safeLooted')
AddEventHandler('vrp_rob:safeLooted', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
end)

RegisterNetEvent('vrp_rob:helpTimed')
AddEventHandler('vrp_rob:helpTimed', function(text, time)
    local faketimer = time
    while faketimer >= 0 do
        faketimer = faketimer - 1
        Wait(0)
        BeginTextCommandDisplayHelp('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end)

local quebrandotudo = false
local termitacolocando = false
local furadeiraentity = nil
local thermalentity = nil

Citizen.CreateThread(function()
    while true do
        Wait(250)
        for i = 1, #Config.BankRobbery do
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                local d = v.Doors[j]
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if GetDistanceBetweenCoords(coords, d.Coords, true) <= 2.5 and d.Frozen and RouboIniciado then
                    if true then
                        while GetDistanceBetweenCoords(GetEntityCoords(player), d.Coords, true) <= 2.5 and d.Frozen and not d.Hacking do
                            local allowed = false
                            if j == 1 then
                                allowed = true
                            else
                                if j ~= #v.Doors then
                                    if not v.Doors[j-1].Frozen then
                                        allowed = true
                                    else
                                        allowed = false
                                    end
                                else
                                    allowed = true
                                end
                            end
                            Wait(50)
                            if allowed then
                                TriggerEvent('vrp_rob:helpTimed', 'Apasa ~INPUT_CONTEXT~ pentru a planta C4', 50)
                                if IsControlPressed(0, 38) then
									local police = 5
                                    while police == nil do
                                        Wait(5)
                                    end

                                    if j == 1 or j == 2 then
                                        --if RBserver.getitem("c4") then
                                            if true then
                                        ClearPedTasks(player)
                                        SetEntityCoords(player, d.WeldPosition.C)
                                        SetEntityHeading(player, d.WeldPosition.H)
                                        local thermal_hash = GetHashKey("hei_prop_heist_thermite_flash")
                                        RequestModel(thermal_hash)
                                        while not HasModelLoaded(thermal_hash) do
                                            Wait(0)
                                        end
                                        thermalentity = CreateObject(thermal_hash, d.WeldPosition.C, false, true)
                                        SetEntityAsMissionEntity(thermal, true, true)
                                        local boneIndexf = GetPedBoneIndex(PlayerPedId(), 28422)
                                        termitacolocando = true
                                        Wait(500)
                                        AttachEntityToEntity(thermalentity, PlayerPedId(), boneIndexf, 0.0, 0.0, 0.0, 180.0, 180.0, 0, 1, 1, 0, 1, 1, 1)
                                       
                                        RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
                                        while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do
                                            Wait(10)
                                        end
                                        --if not IsEntityPlayingAnim(PlayerPedId(), 'weapons@heavy@minigun', "idle_2_aim_right_med", 3) then
                                            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 8.0, 8.0, -1, 1, 0, false, false, false)
                                        --end
                                        Wait(8000)
                                        DeleteEntity(thermalentity)
                                        blockKeys = true
                                        local explodicao = true
                                        ClearPedTasks(player) 
                                        blockKeys = false
                                        if explodicao then
                                            Wait(4000)
                                            TriggerServerEvent('vrp_rob:setDoorFreezeStatus', i, j, false)
                                        end
                                        thermalentity = nil
                                        termitacolocando = false
                                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0.5)
                                        Wait(50)
                                    else
                                        vRP.notify("Você não possui uma C4!")  
                                    end
                                    else
                                    if police >= 2 then -- aici pui item
                                        ClearPedTasks(player)
                                        SetEntityCoords(player, d.WeldPosition.C)
                                        SetEntityHeading(player, d.WeldPosition.H)
                                        local furadeira_hash = GetHashKey("prop_tool_consaw")
                                        RequestModel(furadeira_hash)
                                        while not HasModelLoaded(furadeira_hash) do
                                            Wait(0)
                                        end
                                        furadeiraentity = CreateObject(furadeira_hash, d.WeldPosition.C+30, true, false)
                                        SetEntityAsMissionEntity(furadeira, true, true)
                                        local boneIndexf = GetPedBoneIndex(PlayerPedId(), 28422)
                                        Wait(500)
                                        AttachEntityToEntity(furadeiraentity, PlayerPedId(), boneIndexf, 0.095, 0.0, 0.0, 270.0, 170.0, 0.0, 1, 1, 0, 1, 0, 1)
                                        quebrandotudo = true
                                        blockKeys = true
                                        local welded = true
                                        for i = 1, 700 do --LOOP
                                            local xp,yp,zp = table.unpack(d.Coords)
                                            Textinho3D(xp,yp,zp,'~r~' .. string.format("%0.1f", i/7) .. '% \n\n~w~[~b~SPACE~w~] ~r~pentru a anula', d.Time)
                                            if IsDisabledControlPressed(0, 22) then
                                                ClearPedTasks(player)
                                                blockKeys = false
                                                welded = false
                                                quebrandotudo = false
                                                DeleteEntity(furadeiraentity)
                                                furadeiraentity = nil
                                                break
                                            end
                                        end
                                        ClearPedTasks(player)
                                        blockKeys = false
                                        --print(welded)
                                        if welded then
                                            TriggerServerEvent('vrp_rob:setDoorFreezeStatus', i, j, false)
                                        end
                                        DeleteEntity(furadeiraentity)
                                        furadeiraentity = nil
                                        quebrandotudo = false
                                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0.5)
                                        Wait(50)
                                    else
                                        vRP.notify("")
                                    end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(0)
    end
    Wait(250)
    for i = 1, #Config.BankRobbery do
        for j = 1, #Config.BankRobbery[i].Doors do
            TriggerServerEvent('vrp_rob:getDoorFreezeStatus', i, j)
        end
    end
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                Wait(0)
                local d = v.Doors[j]
                local door = GetClosestObjectOfType(d.Coords, 2.0, GetHashKey(d.Object), false, 0, 0)
                if door ~= nil then
                    if not d.Frozen then
                        if d.OpenHeading ~= nil then
                            SetEntityHeading(door, d.OpenHeading)
                        end
                    end
                    FreezeEntityPosition(door, d.Frozen)
                    if d.Frozen then
                        SetEntityHeading(door, d.Heading)
                    end
                end
            end
        end
        Wait(250)
    end
end)

local drilling = false
local finishedDrilling = false
local speed = 0.0
local temperature = 0.0
local depth = 0.1
local position = 0.0
local drillEntity = {}
local playSound = true

RegisterNetEvent('vrp_rob:deleteDrillCl')
AddEventHandler('vrp_rob:deleteDrillCl', function(coords)
    local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
    SetEntityAsMissionEntity(jackham, true, true)
    DeleteEntity(jackham)
end)

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        FreezeEntityPosition(player, false)
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Safes do
                Wait(0)
                local s = Config.BankRobbery[i].Safes[j]
                if not s.Looted then
                        if GetDistanceBetweenCoords(coords, s.Coords, true) <= 1.0 and not Config.BankRobbery[i].Doors[#Config.BankRobbery[i].Doors].Frozen then
                            TriggerEvent('vrp_rob:helpTimed', 'Apasa ~INPUT_CONTEXT~ pentru a da burghiu', 5)
                            if IsControlPressed(0, 38) then
								local police = 5
                                while police == nil do
                                    Wait(5)
                                end
                                if police >= Config.BankRobbery[i].Cops then
                                    --if RBserver.getitem("furadeira") then
                                        TriggerServerEvent('vrp_rob:toggleSafe', i, j, true)
                                        FreezeEntityPosition(player, true)
                                        SetPedCurrentWeaponVisible(player, false, true, 0, 0)
                                        SetEntityCoords(player, s.Coords)
                                        SetEntityHeading(player, s.Heading)
                                        drilling = true
                                        speed = 0.0
                                        temperature = 0.0
                                        depth = 0.1
                                        position = 0.0

                                        local drill_hash = GetHashKey("hei_prop_heist_drill")
                                        RequestModel(drill_hash)
                                        while not HasModelLoaded(drill_hash) do
                                            Wait(0)
                                        end
                                        drillEntity = CreateObject(drill_hash, Config.DrillSpawns[#Config.DrillSpawns] +20, true, false)
                                        SetEntityAsMissionEntity(drill, true, true)
                                        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                                        Wait(500)
                                        AttachEntityToEntity(drillEntity, PlayerPedId(), boneIndex, 0.125, 0.0, -0.05, 100.0, 300.0, 135.0, true, true, false, true, 1, true)

                                        if soundid ~= nil then
                                            StopSound(soundid)
                                            ReleaseSoundId(soundid)
                                        end
                                                    
                                        soundid = GetSoundId()
                                        LoadStream("HEIST_FLEECA_DRILL", "DRILL")
                                        RequestScriptAudioBank("HEIST_FLEECA_DRILL_2", 1)
                                        PlaySoundFromEntity(soundid, "Drill", drillEntity, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0)

                                        local ped_hash = -39239064
                                        RequestModel(ped_hash)
                                        while not HasModelLoaded(ped_hash) do
                                            Wait(5)
                                        end
                                        local soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                                        FreezeEntityPosition(soundPed, true)
                                        SetEntityVisible(soundPed, false)
                                        TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                        SetEntityInvincible(soundPed, true)
                                        SetEntityAsMissionEntity(soundPed, true, true)
                                        SetPedHearingRange(soundPed, 0.0)
                                        SetPedSeeingRange(soundPed, 0.0)
                                        SetPedAlertness(soundPed, 0.0)
                                        SetPedFleeAttributes(soundPed, 0, 0)
                                        SetBlockingOfNonTemporaryEvents(soundPed, true)
                                        SetPedCombatAttributes(soundPed, 46, true)
                                        SetPedFleeAttributes(soundPed, 0, 0)

                                        blockKeys = true

                                        local camFrom = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                        local camFromInfo = s.Cam.From
                                        local camToInfo = s.Cam.To
                                        SetCamCoord(camFrom, camFromInfo.x, camFromInfo.y, camFromInfo.z)
                                        SetCamRot(camFrom, camFromInfo.rx, camFromInfo.ry, camFromInfo.rz, camFromInfo.r)
                                        RenderScriptCams(1, 0, 0, 1, 1)

                                        local camTo = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                        SetCamCoord(camTo, camToInfo.x, camToInfo.y, camToInfo.z)
                                        SetCamRot(camTo, camToInfo.rx, camToInfo.ry, camToInfo.rz, camToInfo.r)
                                        RenderScriptCams(1, 0, 0, 1, 1)
                                        local firstcam = 'camTo'
                                        local active = SetCamActive(camFrom, true) 

                                        while drilling do
                                            Wait(100)
                                            if not playSound or speed <= 0.1 then
                                                DeleteEntity(soundPed)
                                                TriggerServerEvent('vrp_rob:deleteDrill', coords)
                                            else
                                                if not DoesEntityExist(soundPed) then
                                                    RequestModel(ped_hash)
                                                    while not HasModelLoaded(ped_hash) do
                                                        Wait(5)
                                                    end
                                                    soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                                                    FreezeEntityPosition(soundPed, true)
                                                    SetEntityVisible(soundPed, false)
                                                    TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                                    -- gör så peden inte flyr etc
                                                    SetEntityInvincible(soundPed, true)
                                                    SetEntityAsMissionEntity(soundPed, true, true)
                                                    SetPedHearingRange(soundPed, 0.0)
                                                    SetPedSeeingRange(soundPed, 0.0)
                                                    SetPedAlertness(soundPed, 0.0)
                                                    SetPedFleeAttributes(soundPed, 0, 0)
                                                    SetBlockingOfNonTemporaryEvents(soundPed, true)
                                                    SetPedCombatAttributes(soundPed, 46, true)
                                                    SetPedFleeAttributes(soundPed, 0, 0)

                                                end
                                            end
                                            if IsDisabledControlPressed(0, 22) then
                                                drilling = false
                                                Wait(250)
                                                ClearPedTasks(player)
                                                break
                                            end
                                        end
                                        if finishedDrilling then
                                            --print('Success')
                                            TriggerServerEvent('vrp_rob:lootSafe', i, j)
                                        else
                                            TriggerServerEvent('vrp_rob:toggleSafe', i, j, false)
                                            --print('Failure')
                                        end
                                        blockKeys = false
                                        ClearPedTasks(player)
                                        RenderScriptCams(false, false, 0, true, false)
                                        DestroyCam(active, false)

                                        Wait(100)

                                        drilling = false
                                        finishedDrilling = false
                                        speed = 0.0
                                        temperature = 0.0
                                        depth = 0.1
                                        position = 0.0

                                        Wait(100)

                                        DeleteEntity(drillEntity)
                                        FreezeEntityPosition(player, false)

                                        Wait(100)

                                        DeleteEntity(soundPed)
                                        local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
                                        SetEntityAsMissionEntity(jackham, true, true)
                                        DeleteEntity(jackham)
                                        drillEntity = {}
                                   -- else
                                   --     vRP.notify("Você não possui uma furadeira!")
                                    --end    
                                else
									vRP.notify("Nu sunt destui politisti on!")
                                end
                            end
                        end
                end
            end
        end
        Wait(0)
    end
end)

local heading = {
    [1] = 352,
}

local scaleform = {}

function drillScaleform()
    scaleform = RequestScaleformMovie("DRILLING")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

Citizen.CreateThread(function()
    while true do
        while drilling do
            local text = '~INPUT_CELLPHONE_UP~ Da-i burghiu \n~INPUT_CELLPHONE_DOWN~ Scoate burghiu\n~INPUT_JUMP~ Opreste!'
			AddTextEntry("vrp_rob_drill_info_text", text)
			DisplayHelpTextThisFrame("vrp_rob_drill_info_text", false)

            drillScaleform()
            Wait(0)
            BeginScaleformMovieMethod(scaleform, "SET_SPEED")
            PushScaleformMovieMethodParameterFloat(speed)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_HOLE_DEPTH")
            PushScaleformMovieMethodParameterFloat(depth)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
            PushScaleformMovieMethodParameterFloat(position)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
            PushScaleformMovieMethodParameterFloat(temperature)
            EndScaleformMovieMethod()
        end
        Wait(250)
    end
end)

local particleLooped = nil

Citizen.CreateThread(function()
    while true do
        if drilling then
            if depth-position >= 0 then
                currentDrillAnim = 'drill_straight_idle'
            end
            RequestAnimDict('anim@heists@fleeca_bank@drilling')
            while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                Wait(10)
            end
            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 8.0, 8.0, -1, 17, 1, false, false, false)
            end
        end
        Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
        if quebrandotudo then
            RequestAnimDict('weapons@heavy@minigun')
            while not HasAnimDictLoaded('weapons@heavy@minigun') do
                Wait(10)
            end
            if not IsEntityPlayingAnim(PlayerPedId(), 'weapons@heavy@minigun', "idle_2_aim_right_med", 3) then
                TaskPlayAnim(PlayerPedId(), 'weapons@heavy@minigun', "idle_2_aim_right_med", 1.0, -1, -1, 50, 0, 0, 0, 0)
                local cdr = GetEntityCoords(furadeiraentity)

                RequestNamedPtfxAsset("des_fib_floor")
                while not HasNamedPtfxAssetLoaded("des_fib_floor") do
                    Wait(10)
                end
                Wait(1000)
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "saw", 0.8)
                while quebrandotudo do
                UseParticleFxAssetNextCall("des_fib_floor")
                local pp1 = StartNetworkedParticleFxNonLoopedAtCoord("ent_ray_fbi5a_ramp_metal_imp", cdr, 0.0, 0.0, 0.0, 3.0, false, false, true, 0)
                UseParticleFxAssetNextCall("des_fib_floor")
                local pp1 = StartNetworkedParticleFxNonLoopedAtCoord("ent_ray_fbi5a_ramp_fragment", cdr, 0.0, 0.0, 0.0, 1.1, false, false, true, 0)
                Citizen.Wait(500)
                end
            end
        end
        Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
        if termitacolocando then
            Wait(5000)
            local cdr1 = GetEntityCoords(thermalentity)
            local xt,yt,zt = table.unpack(cdr1)
            RequestNamedPtfxAsset("scr_ornate_heist")
            while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
                Wait(10)
            end
            Wait(1000)
            --TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "saw", 0.8)
            while termitacolocando do
            UseParticleFxAssetNextCall("scr_ornate_heist")
            local pp1 = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", xt,yt+0.99,zt+0.01, 0.0, 0.0, 0.0, 1.0, false, false, true, 0)
            --SetParticleFxLoopedEvolution(pp1, "scr_heist_ornate_thermal_burn", 0.5, 0)
            Citizen.Wait(2000)
            StopParticleFxLooped(pp1)
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('vrp_rob:particleTimer')
AddEventHandler('vrp_rob:particleTimer', function(time)
    Wait(time)
    StopParticleFxLooped(particleLooped)
    particleLooped = nil
end)

Citizen.CreateThread(function()
    while true do
        Wait(750)
        if drilling then
            while drilling do
                Wait(0)
                if IsDisabledControlPressed(0, 172) and not finishedDrilling then
                    if temperature < 1.0 then
                        RequestAnimDict('anim@heists@fleeca_bank@drilling')
                        while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                            Wait(10)
                        end
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_start', 8.0, 8.0, -1, 17, 1, false, false, false)
                        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)
                        while IsDisabledControlPressed(0, 172) and temperature < 1.0 do
                            drilling = true
                            if speed < 0.7 then
                                speed = speed + (math.random(1, 5)/100)
                            end
                            if depth-position >= 0 then
                                position = position + ((math.random(1, 5)/1000)+(speed/10))
                                currentDrillAnim = 'drill_straight_idle'
                                playSound = false
                            else
                                local randomDepth = math.random(1, 5)/1000
                                depth = depth + randomDepth
                                position = position + randomDepth
                                temperature = temperature + 0.02
                                playSound = true

                                currentDrillAnim = 'drill_straight_start'

                                local c = GetEntityCoords(drillEntity)
                            end
                            if depth >= 0.9 then
                                drilling = false
                                finishedDrilling = true
                                break
                            end
                            Wait(100)
                        end
                        if temperature >= 1.0 then
                            playSound = false
                            local c = GetEntityCoords(drillEntity)
                            RequestNamedPtfxAsset("core")
                            while not HasNamedPtfxAssetLoaded("core") do
                                Wait(0)
                            end
                            UseParticleFxAssetNextCall("core")
                            particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                            SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)

                            for i = 1, 100 do
                                if speed > 0 then
                                    speed = speed - 0.01
                                end
                                if temperature > 0 then
                                    temperature = temperature - 0.01
                                end
                                if position > 0 then
                                    position = position - 0.01
                                end
                                if temperature <= 0.2 then
                                    break   
                                end
                                Wait(250)
                            end
                            playSound = true
                            TriggerEvent('vrp_rob:particleTimer', 750)
                        end
                    else
                        playSound = false
                        local c = GetEntityCoords(drillEntity)
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Wait(0)
                        end
                        UseParticleFxAssetNextCall("core")
                        particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                        SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)
                        for i = 1, 100 do
                            if speed > 0 then
                                speed = speed - 0.01
                            end
                            if temperature > 0 then
                                temperature = temperature - 0.01
                            end
                            if position > 0 then
                                position = position - 0.005
                            end
                            if temperature <= 0.2 then
                                break   
                            end
                            Wait(250)
                        end
                        playSound = true
                        TriggerEvent('vrp_rob:particleTimer', 750)
                    end
                elseif IsDisabledControlPressed(0, 173) then
                    playSound = false
                    position = position - 0.015
                    temperature = temperature - 0.015
                    speed = speed - 0.015
                    Wait(50)
                else
                    if speed > 0.0 then
                        speed = speed - 0.01
                        Wait(50)
                    end
                    if temperature > 0.0 then
                        temperature = temperature - 0.01
                        Wait(50)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if blockKeys then
            DisableAllControlActions(0)
			DisableAllControlActions(1)
			DisableAllControlActions(2)
			DisableAllControlActions(3)
			DisableAllControlActions(4)
			DisableAllControlActions(5)
			DisableAllControlActions(6)
			DisableAllControlActions(7)
			DisableAllControlActions(8)
			DisableAllControlActions(9)
			DisableAllControlActions(10)
			DisableAllControlActions(11)
			DisableAllControlActions(12)
			DisableAllControlActions(13)
			DisableAllControlActions(14)
			DisableAllControlActions(15)
			DisableAllControlActions(16)
			DisableAllControlActions(17)
			DisableAllControlActions(18)
			DisableAllControlActions(19)
			DisableAllControlActions(20)
			DisableAllControlActions(21)
			DisableAllControlActions(22)
			DisableAllControlActions(23)
			DisableAllControlActions(24)
			DisableAllControlActions(25)
			DisableAllControlActions(26)
			DisableAllControlActions(27)
			--DisableAllControlActions(28)
			DisableAllControlActions(29)
			DisableAllControlActions(30)
            DisableAllControlActions(31)
            Wait(0)
        else
            Wait(250)
        end
    end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,155)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function Textinho3D(x,y,z,text,time)
	local timesdone = 0
    while timesdone <= time/10 do
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 155)
        SetTextEdge(1, 0, 0, 0, 250)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 41, 41, 68)
		Wait(0)
		timesdone = timesdone + 1
	end
end

function drawSub(text,font,centre,x,y,scale,r,g,b,a, time)
	local timesdone = 0
    while timesdone <= time/10 do
        drawTxt(text, font, centre, x, y, scale, r, g, b, a)
		Wait(0)
		timesdone = timesdone + 1
	end
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 230
    DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end


function spawnBani()
    RequestModel("hei_prop_hei_cash_trolly_01")
    RequestModel("ch_prop_gold_trolly_01a")
    Citizen.Wait(100)
    Trolley1 = CreateObject(269934519, 257.44, 215.07, 100.68, 1, 0, 0)
    Trolley2 = CreateObject(269934519, 262.34, 213.28, 100.68, 1, 0, 0)
    Trolley3 = CreateObject(269934519, 263.45, 216.05, 100.68, 1, 0, 0)
    Trolley4 = CreateObject(2007413986, 266.02, 215.34, 100.68, 1, 0, 0)
    Trolley5 = CreateObject(881130828, 265.11, 212.05, 100.68, 1, 0, 0)
    local heading = GetEntityHeading(Trolley3)
    local heading2 = GetEntityHeading(Trolley4)

    SetEntityHeading(Trolley3, heading + 150)
    SetEntityHeading(Trolley4, heading2 + 150)
end




enablesupersilent = false -- coming soon (or not)...
enablextras = true -- enable gold and diamond looting (yay!) [needs utk_ornateprops]
disableinput = false -- don't change anything else unless you know what you are doing
hackfinish = false
initiator = false
stage0break = false
stage1break = false
stage2break = false
stage4break = false
stagelootbreak = false
startloot = true
grabber= false

checks = {
    hack1 = false,
    hack2 = false,
    thermal1 = false,
    thermal2 = false,
    id1 = false,
    id2 = false,
    idfound = false,
    grab1 = false,
    grab2 = false,
    grab3 = false,
    grab4 = false,
    grab5 = false
}

text = { -- Texts
        loudstart = "[~r~E~w~] Start ~g~LOUD~w~ bank heist",
        silentstart = "[~r~E~w~] Start ~g~SILENT~w~ bank heist",
        usecard = "[~r~E~w~] Use ID Card",
        usethermal = "[~r~E~w~] Use Thermal Charge",
        usehack = "[~r~E~w~] Hack Security Panel",
        uselockpick = "[~r~E~w~] Use Lockpick",
        usesearch = "[~r~E~w~] Search",
        lootcash= "[~r~E~w~] Fura banii si ia droguri",
        lootgold = "[~r~E~w~] Fura aurul si cumpara cocaina",
        lootdia = "[~r~E~w~] Fura diamantele si da-i la nevasta-ta",
        card = "Using ID Card",
        thermal = "Planting Thermal Charge",
        burning = "Melting The Lock",
        lockpick = "Picking The Lock",
        using = "Panel Processing",
        used = "Process complete.",
        stage = "completed.",
        search = "Searching",
        hacking = "Hacking",
        melted = "Door lock melted.",
        hacked = "Hack completed.",
        unlocked = "Door unlocked.",
        nothing = "Found nothing.",
        found = "You found the ID Card.",
        time = "Remaining: "
    }

cash1 = {x = 257.40, y = 215.15, z = 101.68}
cash2 = {x = 262.32, y = 213.31, z = 101.68}
cash3 = {x = 263.54, y = 216.23, z = 101.68}
gold = {x = 266.36, y = 215.31, z = 101.68}
dia = {x = 265.11, y = 212.05, z = 101.68}

function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end
Citizen.CreateThread(function()
        while true do

            if startloot  and robProgress then
                local coords = GetEntityCoords(PlayerPedId())

                if not checks.grab1 then
                    local dst1 = GetDistanceBetweenCoords(coords, cash1.x, cash1.y, cash1.z, true)

                    if dst1 <= 4 then
                        DrawText3D(cash1.x, cash1.y, cash1.z, text.lootcash, 0.40)
                        if dst1 < 1 and IsControlJustReleased(0, 38) then
                            checks.grab1 = true
                            Loot(1)
                        end
                    end
                end
                if not checks.grab2 then
                    local dst2 = GetDistanceBetweenCoords(coords, cash2.x, cash2.y, cash2.z, true)

                    if dst2 <= 4 then
                        DrawText3D(cash2.x, cash2.y, cash2.z, text.lootcash, 0.40)
                        if dst2 < 1 and IsControlJustReleased(0, 38) then
                            checks.grab2 = true
                            Loot(2)
                        end
                    end
                end
                if not checks.grab3 then
                    local dst3 = GetDistanceBetweenCoords(coords, cash3.x, cash3.y, cash3.z, true)

                    if dst3 <= 4 then
                        DrawText3D(cash3.x, cash3.y, cash3.z, text.lootcash, 0.40)
                        if dst3 < 1 and IsControlJustReleased(0, 38) then
                            checks.grab3 = true
                            Loot(3)
                        end
                    end
                end
                if stagelootbreak then
                    return
                end
            end
            Citizen.Wait(1)
        end
end)


function Loot(currentgrab)
    Grab2clear = false
    Grab3clear = false
    grabber = true
    Trolley = nil
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    if currentgrab == 1 then
        Trolley = GetClosestObjectOfType(257.44, 215.07, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 2 then
        Trolley = GetClosestObjectOfType(262.34, 213.28, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 3 then
        Trolley = GetClosestObjectOfType(263.45, 216.05, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 4 then
        Trolley = GetClosestObjectOfType(266.02, 215.34, 100.68, 1.0, 2007413986, false, false, false)
        model = "ch_prop_gold_bar_01a"
    elseif currentgrab == 5 then
        Trolley = GetClosestObjectOfType(265.11, 212.05, 100.68, 1.0, 881130828, false, false, false)
        model = "ch_prop_vault_dimaondbox_01a"
    end
	local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Citizen.Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        if currentgrab < 4 then
                            TriggerServerEvent("iaBani")
                        elseif currentgrab == 4 then
                            TriggerServerEvent("utk_oh:rewardGold")
                        elseif currentgrab == 5 then
                            TriggerServerEvent("utk_oh:rewardDia")
                        end
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
    local emptyobj = 769923921

    if currentgrab == 4 or currentgrab == 5 then
        emptyobj = 2714348429
    end
	if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
    while not NetworkHasControlOfEntity(Trolley) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(Trolley)
	end
	GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(Grab1)
	Citizen.Wait(1500)
	CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        while not NetworkHasControlOfEntity(Trolley) do
            Citizen.Wait(1)
            NetworkRequestControlOfEntity(Trolley)
        end
        DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(1)
            DeleteObject(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
    end
	Citizen.Wait(1800)
	if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
	SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end