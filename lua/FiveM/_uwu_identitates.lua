RegisterServerEvent("_creeare_identitate")
AddEventHandler("_creeare_identitate", function(_nume, _prenume, _skin)
	local playerId = source
	local endpoint = GetPlayerEndpoint(playerId)
	print("DONE")
	exports["ghmattimysql"]:execute("SELECT buletin FROM _uwu_identitate WHERE buletin = @buletin", {

		['@buletin'] = "1"

	}, function(rows, afectate)
		if #rows > 0 then
			print("Ai deja buletin!")
		else
			exports["ghmattimysql"]:execute("INSERT IGNORE INTO _uwu_identitate(id, nume, prenume, banca, portofel,skin, buletin) VALUES (@id, @nume, @prenume, @banca, @portofel, @skin, @buletin)", {

				['@id'] = playerId,
				['@nume'] = _nume,
				['@prenume'] = _prenume,
				['@skin'] = _skin,
				['@banca'] = 1000,
				['@portofel'] = 2000,
				['@buletin'] = "1"
			
			}, function()
				
				print("Server NUME:".._nume)
				print("Server PRENUME:".._prenume)
				print("Server SKIN:".._skin)

			end)
		end
	end)
end)