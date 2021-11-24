a = true	b = false	c = false 

local _identitate = {
	{440.56, -981.28, 30.69},
	{-447.62, 6013.59, 31.72},
	{1853.56, 3687.80, 34.27}
}

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local _p_coord = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(_identitate) do 
			local _distanta = GetDistanceBetweenCoords(_p_coord.x, _p_coord.y, _p_coord.z, v[1], v[2], v[3], true)
			if _distanta < 3 then
				c_identitate_nume()
			end
		end
	end
end)

function c_identitate_nume(args, args2, args3)
	local _ped = GetPlayerPed(-1)
	local _p_coord = GetEntityCoords(_ped)
	for k,v in pairs(_identitate) do 
		local _distanta = GetDistanceBetweenCoords(_p_coord.x, _p_coord.y, _p_coord.z, v[1], v[2], v[3], true)
		if _distanta < 3 then
			Draw3DText(v[1],v[2],v[3]+1.5, "[ ~b~Identitate~w~ ]", 0.6)
			DrawMarker(2, v[1],v[2],v[3]+1 , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 63, 133, 191, 150, 0, 0, 0, 1, 0, 0, 0)
			if _distanta < 1 then 
				if IsControlJustPressed(0, 38) then
					TaskStartScenarioInPlace(_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)

					DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "Nume", "", "", "", 99)
					while a do
						DisableAllControlActions(0)
						HideHudAndRadarThisFrame()
						Citizen.Wait(256)
			
						if UpdateOnscreenKeyboard() == 1 then
							_usr = GetOnscreenKeyboardResult()
							
							args = _usr

							if string.len(args) > 3 then
								a = false
								b = true
								print("Nume :"..args) 


								DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "Prenume", "", "", "", 99)
								while b do
									DisableAllControlActions(0)
									HideHudAndRadarThisFrame()
									Citizen.Wait(256)

									if UpdateOnscreenKeyboard() == 1 then 
										_prn = GetOnscreenKeyboardResult()

										args2 = _prn 

										if string.len(args2) > 4 then
											b = false
											c = true
											print("Prenume :"..args2) 

											DisplayOnscreenKeyboard(0,"FMMC_KEY_TIP8", "", "DeadpoolMovie", "", "", "", 99)

											while c do
												DisableAllControlActions(0)
												HideHudAndRadarThisFrame()
												Citizen.Wait(256)

												if UpdateOnscreenKeyboard() == 1 then
													_skin_change = GetOnscreenKeyboardResult()

													args3 = _skin_change

													if string.len(args3) > 4 then
														c = false
														print("Skin :"..args3) 

														TriggerServerEvent("_creeare_identitate", args, args2, args3)
														_spawn_skin(args3)
														break
													else
														ClearPedTasks(_ped)
														print("Skin INVALID") 
														break
													end	
												end
											end
										else
											ClearPedTasks(_ped)
											print("Prenume prea scurt") 
											break
										end
									end
								end
							else
								ClearPedTasks(_ped)
								print("Nume prea scurt") 
								break
							end
						end
					end
				end
			end
		end
	end
end

function _spawn_skin(_skin)
	RequestModel(_skin)
	while not HasModelLoaded(_skin) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), _skin)
end

Citizen.CreateThread(function()
	Citizen.Wait(0)
	for i,v in pairs(_identitate) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip, 498)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 5)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("<FONT FACE='$Font5'><FONT COLOR='2DD5FF'>IDENTITATE")
		EndTextCommandSetBlipName(blip)
	end
end)

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