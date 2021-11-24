
--Sistem maked by Uwu Hentai#4312

--Uwu Hentai GITHUB - https://github.com/UwuHentai

RegisterServerEvent("buy_car")
AddEventHandler("buy_car",function(vname,price,veh_type)

  local playerId = source  
  local plate = "B "..generateNumarInmatriculare("DDDDDD")

    exports["ghmattimysql"]:execute("SELECT veh_type FROM _uwu_vehs WHERE veh_type = @veh_type", {

        ['@veh_type'] = vname

    }, function(rows, afectate)
        if #rows > 0 then
            print("\nAi deja aceasta masina")
        else
            print(price)
            print("Ai cumparat masina cu succes")
            exports["ghmattimysql"]:execute("INSERT IGNORE INTO _uwu_vehs (id, veh_type, vehicle_plate) VALUES(@id, @veh_type, @vehicle_plate)", {
    
                ['@id'] = playerId,
                ['@veh_type'] = vname,
                ['@vehicle_plate'] = plate
        
            }, function(rows, affected)
            end)
        end
	end)
end)


function generateNumarInmatriculare(format) 
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i=1,#format do
    local char = string.sub(format, i,i)
    if char == "D" then number = number..string.char(zbyte+math.random(0,9))
    elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
    else number = number..char end
  end

  return number
end

RegisterCommand("getcar", function(source, args)
    exports["ghmattimysql"]:execute("SELECT veh_type FROM _uwu_vehs", function(rows, afectate)
        TriggerClientEvent("output", source, rows[1].veh_type)  
    end)    
end)