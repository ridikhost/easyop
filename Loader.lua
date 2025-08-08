if getgenv().EasyOP and getgenv().EasyOP.Debug then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ridikhost/easyop/refs/heads/dev/EasyOP.lua'))()
else
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ridikhost/easyop/refs/heads/main/EasyOP.lua'))()
end
