NAP_TEMPLATE = NAP_TEMPLATE or {}

NAP_TEMPLATE.Config = NAP_TEMPLATE.Config or {}

NAP_TEMPLATE.Config.General = NAP_TEMPLATE.Config.General or {}

if SERVER then

    print("\n///////////////////////////////////////////////////////////////////////////")
    print("/////////////////////////      NAP Template      /////////////////////////")
    print("////////////////////////         SERVER         ////////////////////////")
    print("///////////////////////////////////////////////////////////////////////\n")

    if not IsMounted("cstrike") then
        print("[NAP Template][CSS][FR] Les CSS Content n'ont pas été détécte sur le serveur. Certains utilisateur pourraient rencontrer des problèmes liés aux textures de certains items !")
        print("[NAP Template][CSS][ENG] CSS Content are not mounted on the server. Some users may encounter problems related to the textures of certain items !\n")
    else
        print("[NAP Template][CSS][FR] Les CSS Content ont été détécte sur le serveur. Aucun problème visuel n'est à craindre.")
        print("[NAP Template][CSS][ENG] CSS Content are mounted on the server. No visual problems are to be feared.\n")
    end

    if NAP_TEMPLATE ~= nil then 
        print("[NAP Template] [Variable Initialized] NAP_TEMPLATE ") 
    end

    include("languages/template_languages.lua")
    AddCSLuaFile("languages/template_languages.lua")

    include("nap_template/main_config.lua")
    AddCSLuaFile("nap_template/main_config.lua")    

    include("nap_template/nap_template_sounds_config.lua")
    AddCSLuaFile("nap_template/nap_template_sounds_config.lua")
    
    print("\n[NAP Template] [SERVER SIDE]")
    print("[NAP Template] [Including] [Languages file] template_languages.lua")
    print("[NAP Template] [Including] [Config file] main_config.lua")
    print("[NAP Template] [Including] [Config file] nap_template_sounds_config.lua")

    print("[NAP Template] [Sending] [Languages file] template_languages.lua")
    print("[NAP Template] [Sending] [Config file to client] main_config.lua")
    print("[NAP Template] [Sending] [Config file] nap_template_sounds_config.lua")

    local p = "nap_template/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Template] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Template] [SHARED SIDE]")

    local p = "nap_template/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Template] [Sending] "..b)
        print("[NAP Template] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Template] [CLIENT SIDE]")

    local p = "nap_template/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Template] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n///////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "/////////////////////////      NAP Template      /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////        CLIENT          /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////////////////////////////////////////////////////\n\n")

    if not IsMounted("cstrike") then
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(255, 0, 0), " n'ont pas été détecté", Color(255, 255, 255), ". Vous pourriez rencontrer ", Color(255, 0, 0), "des problèmes visuel ", Color(255, 255, 255), "avec certains objects de l'addon !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(255, 0, 0), "not mounted", Color(255, 255, 255), ". You may ", Color(255, 0, 0), "encounter visuals problems ", Color(255, 255, 255), " with some items of the addon !\n\n")
    else
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(0, 255, 0), " ont été détecté", Color(255, 255, 255), ". Vous ne devriez pas rencontrer des problèmes visuel !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(0, 255, 0), "mounted", Color(255, 255, 255), ". No visual problems are to be feared. !\n\n")
    end 
    
    include("languages/template_languages.lua")
    include("nap_template/main_config.lua")
    include("nap_template/nap_template_sounds_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "template_languages.lua", "\n")
    MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")
     MsgC(Color(220, 16, 227, 255), "[NAP Chem Solution] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "sounds_config.lua", "\n")

    local p = "nap_template/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_template/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_template/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Template] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end