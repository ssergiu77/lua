RegisterServerEvent("_p_paine")
AddEventHandler("_p_paine", function(banuti, amount)
    print(banuti)
    print(amount)
    local id = source
        exports["ghmattimysql"]:execute("UPDATE _uwu_identitate SET portofel = (portofel - @portofel) WHERE id = '@id'", {

            ['@portofel'] = banuti, 
            ['@id'] = id}
            
        ,function()
    end)
end)

