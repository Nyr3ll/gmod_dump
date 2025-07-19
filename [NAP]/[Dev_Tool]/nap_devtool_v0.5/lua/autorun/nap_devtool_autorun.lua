NAP_DEVTOOL = NAP_DEVTOOL or {}

NAP_DEVTOOL.Config = NAP_DEVTOOL.Config or {}

NAP_DEVTOOL.Config.General = NAP_DEVTOOL.Config.General or {}

if SERVER then

    print("\n///////////////////////////////////////////////////////////////////////////")
    print("/////////////////////////      NAP Dev tool      /////////////////////////")
    print("////////////////////////         SERVER         ////////////////////////")
    print("///////////////////////////////////////////////////////////////////////\n")

    if not IsMounted("cstrike") then
        print("[NAP Dev tool][CSS][FR] Les CSS Content n'ont pas été détécte sur le serveur. Certains utilisateur pourraient rencontrer des problèmes liés aux textures de certains items !")
        print("[NAP Dev tool][CSS][ENG] CSS Content are not mounted on the server. Some users may encounter problems related to the textures of certain items !\n")
    else
        print("[NAP Dev tool][CSS][FR] Les CSS Content ont été détécte sur le serveur. Aucun problème visuel n'est à craindre.")
        print("[NAP Dev tool][CSS][ENG] CSS Content are mounted on the server. No visual problems are to be feared.\n")
    end

    if NAP_DEVTOOL ~= nil then 
        print("[NAP Dev tool] [Variable Initialized] NAP_DEVTOOL ") 
    end

    include("languages/dev_tool_languages.lua")
    AddCSLuaFile("languages/dev_tool_languages.lua")

    include("nap_dev_tool/main_config.lua")
    AddCSLuaFile("nap_dev_tool/main_config.lua")    

    include("nap_dev_tool/nap_dev_tool_sounds_config.lua")
    AddCSLuaFile("nap_dev_tool/nap_dev_tool_sounds_config.lua")
    
    print("\n[NAP Dev tool] [SERVER SIDE]")
    print("[NAP Dev tool] [Including] [Languages file] dev_tool_languages.lua")
    print("[NAP Dev tool] [Including] [Config file] main_config.lua")
    print("[NAP Dev tool] [Including] [Config file] nap_dev_tool_sounds_config.lua")

    print("[NAP Dev tool] [Sending] [Languages file] dev_tool_languages.lua")
    print("[NAP Dev tool] [Sending] [Config file to client] main_config.lua")
    print("[NAP Dev tool] [Sending] [Config file] nap_dev_tool_sounds_config.lua")

    local p = "nap_dev_tool/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Dev tool] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Dev tool] [SHARED SIDE]")

    local p = "nap_dev_tool/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Dev tool] [Sending] "..b)
        print("[NAP Dev tool] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Dev tool] [CLIENT SIDE]")

    local p = "nap_dev_tool/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Dev tool] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n///////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "/////////////////////////      NAP Dev tool      /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////        CLIENT          /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////////////////////////////////////////////////////\n\n")

    if not IsMounted("cstrike") then
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(255, 0, 0), " n'ont pas été détecté", Color(255, 255, 255), ". Vous pourriez rencontrer ", Color(255, 0, 0), "des problèmes visuel ", Color(255, 255, 255), "avec certains objects de l'addon !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(255, 0, 0), "not mounted", Color(255, 255, 255), ". You may ", Color(255, 0, 0), "encounter visuals problems ", Color(255, 255, 255), " with some items of the addon !\n\n")
    else
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(0, 255, 0), " ont été détecté", Color(255, 255, 255), ". Vous ne devriez pas rencontrer des problèmes visuel !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(0, 255, 0), "mounted", Color(255, 255, 255), ". No visual problems are to be feared. !\n\n")
    end 
    
    include("languages/dev_tool_languages.lua")
    include("nap_dev_tool/main_config.lua")
    include("nap_dev_tool/nap_dev_tool_sounds_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "dev_tool_languages.lua", "\n")
    MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")
     MsgC(Color(220, 16, 227, 255), "[NAP Chem Solution] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "sounds_config.lua", "\n")

    local p = "nap_dev_tool/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_dev_tool/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_dev_tool/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Dev tool] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end