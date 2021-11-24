RegisterServerEvent("_adaugare")
AddEventHandler("_adaugare", function(banuti)
    local id = source
    exports["ghmattimysql"]:execute("SELECT portofel FROM _uwu_identitate WHERE id = @id", {

        ['@id'] = id

    }, function(rows, afectate)
        if #rows > 0 then
            if rows[1].portofel <= 0 or rows[1].portofel == 0 then 
                print("Nu ai destui bani")
            else
                exports["ghmattimysql"]:execute("UPDATE _uwu_identitate SET banca = (banca + @banca) WHERE id = '@id'", {

                    ['@banca'] = banuti, 
                    ['@id'] = id}
                    
                ,function()
                exports["ghmattimysql"]:execute("UPDATE _uwu_identitate SET portofel = (portofel - @banca) WHERE id = '@id'", {

                    ['@banca'] = banuti, 
                    ['@id'] = id}
                    
                ,function(rows, affected)
                    end)
                end)
            end
        end
    end)
end)

RegisterServerEvent("_scoatere")
AddEventHandler("_scoatere", function(banuti)
    local id = source
    exports["ghmattimysql"]:execute("SELECT banca FROM _uwu_identitate WHERE id = @id", {

        ['@id'] = id

    }, function(rows, afectate)
        if #rows > 0 then
            if rows[1].banca <= 0 or rows[1].banca == 0 then
                print("Nu ai destui bani")
            else
                exports["ghmattimysql"]:execute("UPDATE  _uwu_identitate SET portofel = (portofel + @banca) WHERE id = '@id'", {

                    ['@banca'] = banuti, 
                    ['@id'] = id}
                    
                ,function()
                exports["ghmattimysql"]:execute("UPDATE _uwu_identitate SET banca = (banca - @banca) WHERE id = '@id'", {

                    ['@banca'] = banuti, 
                    ['@id'] = id}
                    
                ,function(rows, affected)
                    end)
                end)
            end
        end
    end)
end)