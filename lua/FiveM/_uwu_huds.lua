RegisterCommand("s", function(source, args)
    local playerId = source
    exports["ghmattimysql"]:execute("SELECT * FROM _uwu_identitate",{}, 
    function(result)
        TriggerClientEvent("output", source, result[1].portofel, result[1].banca)  
    end)
end)

RegisterCommand("h", function(source, args)
    local playerId = source
    TriggerClientEvent("output2", source)  
end)

