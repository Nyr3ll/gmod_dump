NAP_ALCH_DISASTER = NAP_ALCH_DISASTER or {}

NAP_ALCH_DISASTER.Config = NAP_ALCH_DISASTER.Config or {}

if SERVER then

    print("\n///////////////////////////////////////////////////////////////////////////")
    print("///////////////////////// NAP Alchemist Disaster /////////////////////////")
    print("////////////////////////         SERVER         /////////////////////////")
    print("////////////////////////////////////////////////////////////////////////\n")

    if not IsMounted("cstrike") then
        print("[NAP Alchemist Disaster][CSS][FR] Les CSS Content n'ont pas été détécte sur le serveur. Certains utilisateur pourraient rencontrer des problèmes liés aux textures de certains items !")
        print("[NAP Alchemist Disaster][CSS][ENG] CSS Content are not mounted on the server. Some users may encounter problems related to the textures of certain items !\n")
    else
        print("[NAP Alchemist Disaster][CSS][FR] Les CSS Content ont été détécte sur le serveur. Aucun problème visuel n'est à craindre !")
        print("[NAP Alchemist Disaster][CSS][ENG] CSS Content are mounted on the server. No visual problems are to be feared !\n")
    end

    if NAP_ALCH_DISASTER ~= nil then 
        print("[NAP Alchemist Disaster] [Variable Initialized] NAP_ALCH_DISASTER ") 
    end

    include("languages/alch_dis_languages.lua")
    AddCSLuaFile("languages/alch_dis_languages.lua")

    include("nap_alchemist_disaster/main_config.lua")
    AddCSLuaFile("nap_alchemist_disaster/main_config.lua")
    
    include("nap_alchemist_disaster/bones_list.lua")
    AddCSLuaFile("nap_alchemist_disaster/bones_list.lua")
    
    include("nap_alchemist_disaster/effects.lua")
    AddCSLuaFile("nap_alchemist_disaster/effects.lua")
    
    
    print("\n[NAP Alchemist Disaster] [SERVER SIDE]")

    print("[NAP Alchemist Disaster] [Including] [Languages file] alch_dis_languages.lua")
    print("[NAP Alchemist Disaster] [Including] [Config file] main_config.lua")
    print("[NAP Alchemist Disaster] [Including] [Config file] bones_list.lua")
    print("[NAP Alchemist Disaster] [Including] [Config file] effects.lua")
    
    print("[NAP Alchemist Disaster] [Sending] [Languages file] alch_dis_languages.lua")
    print("[NAP Alchemist Disaster] [Sending] [Config file] main_config.lua")
    print("[NAP Alchemist Disaster] [Sending] [Config file] bones_list.lua")
    print("[NAP Alchemist Disaster] [Sending] [Config file] effects.lua")

    local p = "nap_alchemist_disaster/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Alchemist Disaster] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Alchemist Disaster] [SHARED SIDE]")

    local p = "nap_alchemist_disaster/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Alchemist Disaster] [Sending] "..b)
        print("[NAP Alchemist Disaster] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Alchemist Disaster] [CLIENT SIDE]")

    local p = "nap_alchemist_disaster/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Alchemist Disaster] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n///////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////// NAP Alchemist Disaster /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////         CLIENT         /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////////////////////////////////////////////////////\n\n")

    if not IsMounted("cstrike") then
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(255, 0, 0), " n'ont pas été détecté", Color(255, 255, 255), ". Vous pourriez rencontrer ", Color(255, 0, 0), "des problèmes visuel ", Color(255, 255, 255), "avec certains objects de l'addon !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(255, 0, 0), "not mounted", Color(255, 255, 255), ". You may ", Color(255, 0, 0), "encounter visuals problems ", Color(255, 255, 255), " with some items of the addon !\n\n")
    else
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(0, 255, 0), " ont été détecté", Color(255, 255, 255), ". Vous ne devriez pas rencontrer des problèmes visuel !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(0, 255, 0), "mounted", Color(255, 255, 255), ". No visual problems are to be feared !\n\n")
    end 
    
    include("languages/alch_dis_languages.lua")
    include("nap_alchemist_disaster/main_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "alch_dis_languages.lua", "\n")
    MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")

    local p = "nap_alchemist_disaster/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_alchemist_disaster/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_alchemist_disaster/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Alchemist Disaster]", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end