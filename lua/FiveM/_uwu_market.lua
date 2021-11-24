local meniu = false

RegisterNetEvent("meniu")
AddEventHandler("meniu",function()
    meniu = not meniu
end)

local _markets = {
    {25.87, -1346.40, 29.50},
    {-1223.02, -907.15, 12.33},
    {-47.52,-1756.85,29.42},
    {1163.53,-323.54,69.20},
    {374.19,327.50,103.56},
    {2555.35,382.16,108.62},
    {-1486.76,-379.55,40.16},
    {-707.40,-913.68,19.21}
}

_mancare = {
    "~o~Paine",
    "~b~Apa"
}

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local _p_coord = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(_markets) do 
			local _distanta = GetDistanceBetweenCoords(_p_coord.x, _p_coord.y, _p_coord.z, v[1], v[2], v[3], true)
			if _distanta < 3 then
				_deschide_magazin()
			end
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(0)
	for i,v in pairs(_markets) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.95)
		SetBlipColour(blip, 3)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("<FONT FACE='$Font5'><FONT COLOR='2DD5FF'>LISTA [ MAGAZINE ]")
		EndTextCommandSetBlipName(blip)
	end
end)

function _deschide_magazin()
    local _ped = GetPlayerPed()
    local _p_coord = GetEntityCoords(_ped)
    for k,v in pairs(_markets) do
        local _distanta = GetDistanceBetweenCoords(_p_coord.x, _p_coord.y, _p_coord.z, v[1], v[2], v[3], true)
        if _distanta < 3 then
			Draw3DText(v[1],v[2],v[3]+1.5, "[ ~o~Magazin~w~ ]", 0.6)
			DrawMarker(2, v[1],v[2],v[3]+1 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 191, 131, 63, 150, 0, 0, 0, 1, 0, 0, 0)
            _arata_text("Apasa ~INPUT_CONTEXT~ pentru a deschide magazinul!")
            if _distanta < 1 then
                if IsControlJustPressed(0, 38) then
                    meniu = not meniu 
                end
                if meniu then
                    _controls()
                    DrawRect(0.500, 0.500, 0.500, 0.500, 0, 0, 0, 200)
                    drawtxt(_mancare[1] , 1, 1, 0.310, 0.400, 0.60, 255, 10, 10, 255)
                    drawtxt(_mancare[2], 1, 1, 0.400, 0.400, 0.60, 255, 10, 10, 255)

                    if isCursorInPosition(0.330, 0.400, 0.050, 0.050) and IsControlJustPressed(0, 18) then
                        meniu = false

		                DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "0", "", "", "", 3)
                        while true do
                            DisableAllControlActions(0)
                            HideHudAndRadarThisFrame()
                            Citizen.Wait(256)

                            if UpdateOnscreenKeyboard() == 1 then
                                args2 = GetOnscreenKeyboardResult()
                                args = args2*2
                                TriggerServerEvent('_p_paine', args, args2)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

function _controls()
    ShowCursorThisFrame()
    DisableControlAction(0,24,true)
    DisableControlAction(0,47,true)
    DisableControlAction(0,58,true)
    DisableControlAction(0,263,true)
    DisableControlAction(0,264,true)
    DisableControlAction(0,257,true)
    DisableControlAction(0,140,true)
    DisableControlAction(0,141,true)
    DisableControlAction(0,142,true)
    DisableControlAction(0,143,true)
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true)
end

function isCursorInPosition(x, y, width, height)
    local sx, sy = 1920, 1080
    local cx, cy = GetNuiCursorPosition()
    local cx, cy = (cx / sx), (cy / sy)

    local width = width / 2
    local height = height / 2

    if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
        return true
    else
        return false
    end
end

function drawtxt(text,font,centre,x,y,scale,r,g,b,a)
    y = y - 0.010
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(1.0*scale, 2.1*scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(""..text)
        DrawText(_x,_y)
    end
end

function _arata_text(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end