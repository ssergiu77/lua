login_usr = true

RegisterNetEvent("login_stop")
AddEventHandler("login_stop",function()
    login_usr = not login_usr
end)

register_usr = true

Citizen.CreateThread(function()
	while register_usr do
		Wait(0)
		_uwu_register()
	end
end)

RegisterNetEvent("return")
AddEventHandler("return", function()
	_uwu_login()
end)

function _uwu_register(source, args, args2)
	if (register_usr) then
		local _usr_spawn = PlayerPedId()
		local x_, _y_, _z = table.unpack(GetEntityCoords(PlayerPedId()))

		DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "Username", "", "", 99)
		while register_usr do
			DisableAllControlActions(0)
			HideHudAndRadarThisFrame()
			Citizen.Wait(256)

			if UpdateOnscreenKeyboard() == 1 then
			_usr = GetOnscreenKeyboardResult()

			args = _usr
	
			DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "Parola", "", "", 99)
			while true do

				DisableAllControlActions(0)
				HideHudAndRadarThisFrame()
				Citizen.Wait(256)

				if UpdateOnscreenKeyboard() == 1 then 
					_psw = GetOnscreenKeyboardResult()

					args2 = _psw

					TriggerServerEvent("_creare_user", args, args2)
					_tp_player()
					register_usr = false
					break
					end
				end
			end
		end
	end
end

function _uwu_login(source, args, args2)
	while (login_usr) do
		local _usr_spawn = PlayerPedId()
		local x_, _y_, _z = table.unpack(GetEntityCoords(PlayerPedId()))

		DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "Username", "", "", 99)
		while login_usr do
			DisableAllControlActions(0)
			HideHudAndRadarThisFrame()
			Citizen.Wait(256)

			if UpdateOnscreenKeyboard() == 1 then
			_usr = GetOnscreenKeyboardResult()

			args = _usr
			
			DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "Parola", "", "", 99)
			while true do

				DisableAllControlActions(0)
				HideHudAndRadarThisFrame()
				Citizen.Wait(256)

				if UpdateOnscreenKeyboard() == 1 then 
					_psw = GetOnscreenKeyboardResult()

					args2 = _psw

					TriggerServerEvent("_login_user", args, args2)

					_tp_player()
					login_usr = false
					break
					end
				end
			end
		end
	end
end

function _tp_player()
	SetEntityCoords(GetPlayerPed(-1), -266.07498168945,-961.10437011719,31.223129272461, -266.07498168945,-961.10437011719,31.223129272461, true)
end

RegisterNetEvent("output")
AddEventHandler("output", function(argument)
	_spawn_skin(argument)
end) 

function _spawn_skin(_skin)
	RequestModel(_skin)
	while not HasModelLoaded(_skin) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), _skin)
end