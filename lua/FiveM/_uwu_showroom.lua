uwustergeveh = {}

local deschise = false
local _audi_arata = false

local audi_nume = {
    {"t20", "T 20", 100},
    {"bullet", "Bullet", 1000},
    {"pony", "Pony", 1}
}

local audi_coord = {
    {635.8857421875,625.70532226563,128.91107177734},
    {634.71936035156,622.57489013672,128.91107177734}, 
    {633.56060791016,619.57238769531,128.91107177734}
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local _ped = GetPlayerPed(-1)
        local _p_coord = GetEntityCoords(_ped)
        if Vdist(GetEntityCoords(GetPlayerPed(-1)),631.18646240234,622.04052734375,128.91108703613) < 25.0 then
            DrawMarker(2,631.18646240234,622.04052734375,130.71108703613-0.5,0, 0, 0, 0, 0, 0, 0.2501,0.2501,0.2501,121,121,121,140,1,0,0,true)
              if Vdist(GetEntityCoords(GetPlayerPed(-1)),631.18646240234,622.04052734375,128.91108703613) < 3.0 then
                if not deschise then

                end
                if IsControlJustPressed(0, 38) then
                    _audi_arata = true
                    TriggerEvent("audi_sterge")
                    seteaza_masinile_audi_coord1()
                    deschise = not deschise
                    if not deschise then
                        uwu_sterge_bmw_veh()
                    end
                end
            end
        end
    end
end)
  
function seteaza_masinile_audi_coord1()

    for i,v in pairs(audi_nume) do
        RequestModel( v[1] )
        while ( not HasModelLoaded( v[1] ) ) do
            Citizen.Wait( 1 )
        end
        local vehicle = CreateVehicle(v[1], audi_coord[i][1],audi_coord[i][2],audi_coord[i][3], 70.0, false, false)
        table.insert(uwustergeveh, vehicle)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleColours(vehicle, 121, 121)
        RollDownWindow(vehicle, 0)
        RollDownWindow(vehicle, 1)
        SetVehicleEngineOn(vehicle,false,true,true)
        SetVehicleUndriveable(vehicle,true)
        FreezeEntityPosition(vehicle, true)
        SetVehicleNumberPlateText(vehicle, "HENTAI")
        TriggerEvent("audi_info",audi_coord[i][1],audi_coord[i][2],audi_coord[i][3]+0.2,vehicle,v[2],v[1],v[3])
    end
end

function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function uwu_sterge_bmw_veh()
    for i,v in pairs(uwustergeveh) do
        DeleteVehicle(v)
    end
    uwustergeveh = {}
end

function getVehicles()
    return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

RegisterNetEvent('audi_sterge')
AddEventHandler('audi_sterge', function()
    theVehicles = getVehicles()
    for veh in theVehicles do
        if DoesEntityExist(veh) and GetVehicleNumberPlateText(veh) == "VEHSHOP" then 
            if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
                Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( veh ) )
            end
        end
    end
end)

RegisterNetEvent("audi_info")
AddEventHandler("audi_info",function(x,y,z,veh,nume,vnume,pret)
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if _audi_arata then
                if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) < 25.0 then
                    DrawText3D(x,y,z+0.65, "Masina ~w~"..nume, 1.0, 1)
                    DrawText3D(x,y,z+0.55, "Pret ~w~"..pret.." $", 1.0, 1)
                    DrawMarker(36,x,y,z+0.3,0, 0, 0, 0, 0, 0, 0.2501,0.2501,0.2501,121,121,121,255,0,0,0,true)
                end
            end
                if IsPedInVehicle(GetPlayerPed(-1),veh,true) then
                    help("Apasa ~r~[E] ~w~pentru a cumpara masina!")
                    if IsControlJustPressed(0,51) then
                        TriggerServerEvent("buy_car", vnume, pret, "masina")
                    end
                end
                if Vdist(GetEntityCoords(GetPlayerPed(-1)),-44.827156066895,-1098.8873291016,26.422372817993) < 1.0 then
                    if IsControlJustPressed(0,51) then
                        break
                    end
                end
                if not deschise then
                    break
                end
            end
        end)
    end)

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour( 121,121,121,255 )
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

function help(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("output")
AddEventHandler("output", function(argument)
	spawn_vehicul_db(argument)
end) 

function spawn_vehicul_db(_vehicul)
    CreateVehicle(_vehicul, 633.56060791016,619.57238769531,128.91107177734, 70.0, false, false)
end