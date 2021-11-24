local meniu = false

local adaugare = true
local scoate = true

local _atms = {	
    {33.232, -1347.849, 29.497},
    {129.216, -1292.347, 29.269},
    {287.645, -1282.646, 29.659},
    {289.012, -1256.545, 29.440},
    {295.839, -895.640, 29.217},
    {-302.408, -829.945, 32.417},
    {5.134, -919.949, 29.557},
    {937.814, -941.209, 44.410},
    {1077.692, -775.796, 58.218},
    {1139.018, -469.886, 66.789},
    {1168.975, -457.241, 66.641},
    {1153.884, -326.540, 69.245},
    {381.2827, 323.2518, 103.270},
    {-164.568, 233.5066, 94.919},
    {-1409.39, -99.2603, 52.473},
    {-2072.41, -316.959, 13.345},
    {-1305.40, -706.240, 25.352},
    {-538.225, -854.423, 29.234},
    {-711.156, -818.958, 23.768},
    {-717.614, -915.880, 19.268},
    {-526.566, -1222.90, 18.434},
    {-256.831, -719.646, 33.444},
    {-203.548, -861.588, 30.205},
    {112.4102, -776.162, 31.427},
    {112.9290, -818.710, 31.386},
    {119.9000, -883.826, 31.191},
    {-846.304, -340.402, 38.687},
    {-56.1935, -1752.53, 29.452},
    {-261.692, -2012.64, 30.121},
    {-273.001, -2025.60, 30.197},
    {24.589, -946.056, 29.357},
    {-254.112, -692.483, 33.616},
    {-1570.197, -546.651, 34.955},
    {-1415.909, -211.825, 46.500},
    {-1430.112, -211.014, 46.500},
    {147.64, -1035.78, 29.34},
    {146.03, -1035.17, 29.34}
}

Citizen.CreateThread(function()
	while true do
		Wait(0)
		_bancomat()
	end
end)


function _bancomat()
    local _ped = GetPlayerPed(-1)
    local _p_coord = GetEntityCoords(_ped)

    for k,v in pairs(_atms) do
        local _distanta = GetDistanceBetweenCoords(_p_coord.x, _p_coord.y, _p_coord.z, v[1], v[2], v[3], true)
        if _distanta < 3 then
            Draw3DText(v[1],v[2],v[3]+1.5, "[ ~g~Bancomat~w~ ]", 0.4)
            DrawMarker(2, v[1],v[2],v[3]+1 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 70, 191, 63, 150, 0, 0, 0, 1, 0, 0, 0)
            if _distanta < 1 then 
                if IsControlJustPressed(0, 38) then
                    meniu = not meniu
                end
                if meniu then
                    _controls()
                    DrawRect(0.550, 0.400, 0.100, 0.100, 0, 0, 0, 200)
                    drawtxt("~y~Adauga" , 1, 1, 0.550, 0.385, 0.80, 255, 10, 10, 255)

                    DrawRect(0.40, 0.400, 0.100, 0.100, 0, 0, 0, 200)
                    drawtxt("~b~Scoate" , 1, 1, 0.400, 0.385, 0.80, 255, 10, 10, 255)

                    if isCursorInPosition(0.400, 0.385, 0.050, 0.050) and IsControlJustPressed(0, 18) then
                        if (scoate) then 
                            TaskStartScenarioInPlace(_ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)
                            DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "0", "", "", 99)
                            while scoate do
                                DrawRect(0.500, 0.330, 0.200, 0.100, 0, 0, 0, 200)
                                drawtxt("~b~VAL MAX: ~w~UNLIMITED ~g~RON" , 1, 1, 0.500, 0.315, 0.80, 255, 10, 10, 255)                                
                                
                                DrawRect(0.500, 0.700, 0.200, 0.100, 0, 0, 0, 200)
                                drawtxt("~b~VAL MIN: ~w~0 ~g~RON" , 1, 1, 0.500, 0.685, 0.80, 255, 10, 10, 255)
                                DisableAllControlActions(0)
                                Citizen.Wait(0)
                                if UpdateOnscreenKeyboard() == 1 then 
                                    _scoate = GetOnscreenKeyboardResult()

                                    args2 = _scoate

                                    Wait(2000)
                                    ClearPedTasks(_ped)
                                    TriggerServerEvent("_scoatere", args2)
                                    meniu = false
                                    break
                                end
                            end
                        end
                    end
                    if isCursorInPosition(0.550, 0.400, 0.050, 0.050) and IsControlJustPressed(0, 18) then
                        if (adaugare) then 
                            TaskStartScenarioInPlace(_ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)
                            DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "0", "", "", 99)
                            while adaugare do
                                DrawRect(0.500, 0.330, 0.200, 0.100, 0, 0, 0, 200)
                                drawtxt("~b~VAL MAX: ~w~UNLIMITED ~g~RON" , 1, 1, 0.500, 0.315, 0.80, 255, 10, 10, 255)                                
                                
                                DrawRect(0.500, 0.700, 0.200, 0.100, 0, 0, 0, 200)
                                drawtxt("~b~VAL MIN: ~w~0 ~g~RON" , 1, 1, 0.500, 0.685, 0.80, 255, 10, 10, 255)

                                DisableAllControlActions(0)
                                Citizen.Wait(0)
                                if UpdateOnscreenKeyboard() == 1 then 
                                    _adauga = GetOnscreenKeyboardResult()

                                    args = _adauga

                                    Wait(2000)
                                    ClearPedTasks(_ped)
                                    TriggerServerEvent("_adaugare", args)
                                    meniu = false
                                    break
                                end 
                            end
                        end
                    end
                end
            end 
        end
    end
end

Citizen.CreateThread(function()
	Citizen.Wait(0)
	for i,v in pairs(_atms) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip, 272)
		SetBlipScale(blip, 0.60)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("<FONT FACE='$Font5'><FONT COLOR='2DD5FF'>LISTA [ ATM-URI ]")
		EndTextCommandSetBlipName(blip)
	end
end)

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