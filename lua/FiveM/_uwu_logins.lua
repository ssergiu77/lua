RegisterServerEvent("_creare_user")
AddEventHandler("_creare_user", function(_usr, _psw)
	print("Server ARGS(USR): ", _usr)
	print("Server ARGS(PSW): ", _psw)
	local playerId = source
	local endpoint= GetPlayerEndpoint(playerId)
	exports["ghmattimysql"]:execute("CREATE TABLE IF NOT EXISTS _uwu_users (id INT AUTO_INCREMENT PRIMARY KEY, last_login VARCHAR(255), username VARCHAR(255), password VARCHAR(255), grad VARCHAR(255), factiune VARCHAR(255), job VARCHAR(255))")
	exports["ghmattimysql"]:execute("CREATE TABLE IF NOT EXISTS _uwu_identitate (id INT AUTO_INCREMENT PRIMARY KEY, nume VARCHAR(255), prenume VARCHAR(255), banca int(255), portofel int(255),skin VARCHAR(255), buletin INTEGER(50) NOT NULL default 0)")
	exports["ghmattimysql"]:execute("CREATE TABLE IF NOT EXISTS _uwu_vehs (id INT AUTO_INCREMENT PRIMARY KEY, veh_type varchar(255) NOT NULL DEFAULT 'default',vehicle_plate varchar(255) NOT NULL)")
	print("Check")
	exports["ghmattimysql"]:execute("SELECT last_login FROM _uwu_users WHERE last_login = @last_login", {

		['@last_login'] = endpoint

	}, function(rows, afectate)
		if #rows > 0 then
			TriggerClientEvent("return", playerId)
			print("\nAi deja cont pe acest server! \nIn caz ca ai uitat datele contului contacteaza un membru STAFF!\ndiscord.io/UWUDISCORD ")
		else
			exports["ghmattimysql"]:execute("INSERT IGNORE INTO _uwu_users (id, last_login, username, password, grad, factiune, job) VALUES (@id, @last_login, @username, @password, @grad, @factiune, @job)", {

				['@id'] = playerId,
				['@username'] = _usr,
				['@password'] = _psw,
				['@last_login'] = endpoint,
				['@grad'] = "Jucator",
				['@factiune'] = "Nimic",
				['@job'] = "Somer"
			
			}, function()

				print("Te-ai inregistrat cu succes")

			end)
		end
	end)
end)

RegisterServerEvent("_login_user")
AddEventHandler("_login_user", function(_usr, _psw)
	print("Server ARGS(USR): ", _usr)
	print("Server ARGS(PSW): ", _psw)
	local playerId = source
	exports["ghmattimysql"]:execute("SELECT username FROM _uwu_users WHERE username = @username", {

		['@username'] = _usr

	}, function(rows, afectate)
		if #rows > 0 then
			print("Te-ai logat cu succes")
		else
			print("Username sau parola gresita! Mai incearca")
			TriggerClientEvent("login_stop",playerId)
			Wait(2000)
			TriggerClientEvent("return", playerId)
		end
	end)
end)

RegisterServerEvent("_login_cc")
AddEventHandler("_login_cc", function(_cc)
	print("Server SKIN: ", _cc)
	local playerId = source
	local check = exports["ghmattimysql"]:execute("SELECT skin FROM _uwu_identitate WHERE skin = @skin", {['@skin'] = _cc}, function(rows, afectate)
		if #rows > 0 then
			if (rows[1].skin == _cc) then
				print(_cc)
			end
		end
	end)
end)

RegisterCommand("get", function(source, args)
    exports["ghmattimysql"]:execute("SELECT skin FROM _uwu_identitate", function(rows, afectate)
        TriggerClientEvent("output", source, rows[1].skin)  
    end)    
end)