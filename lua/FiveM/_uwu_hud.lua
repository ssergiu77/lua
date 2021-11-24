RegisterNetEvent("output")
AddEventHandler("output", function(argument, argument2)
    hud = true
    while hud do
        Wait(0)
        DrawRect(0.930, 0.130, 0.150, 0.050, 0, 0, 0, 200)
        drawtxt("~b~Mana: ~w~"..argument.." ~g~RON" , 1, 1, 0.935, 0.115, 0.70, 255, 10, 10, 255)    
       -- drawtxt("💸" , 1, 1, 0.895, 0.115, 0.50, 255, 10, 10, 255)    

        DrawRect(0.930, 0.230, 0.150, 0.050, 0, 0, 0, 200)
        drawtxt("~b~Banca: ~w~"..argument2.." ~g~RON", 1, 1, 0.935, 0.215, 0.70, 255, 10, 10, 255)   
        --drawtxt("💰" , 1, 1, 0.895, 0.220, 0.50, 255, 10, 10, 255)   
    end                            
end) 

RegisterNetEvent("output2")
AddEventHandler("output2", function(argument, argument2)
    hud = false                         
end) 

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