NAP_CUSTOM_SIGN = NAP_CUSTOM_SIGN or {}
NAP_CUSTOM_SIGN.Config = NAP_CUSTOM_SIGN.Config or {}

if SERVER then

    print("\n/////////////////////////////////////////////////////////////////////////////")
    print("///////////////////////      NAP Custom Sign      //////////////////////////")
    print("//////////////////////           SERVER           /////////////////////////")
    print("//////////////////////////////////////////////////////////////////////////\n")

    if not IsMounted("cstrike") then
        print("[NAP Custom Sign][CSS][FR] Les CSS Content n'ont pas été détécte sur le serveur. Certains utilisateur pourraient rencontrer des problèmes liés aux textures de certains items !")
        print("[NAP Custom Sign][CSS][ENG] CSS Content are not mounted on the server. Some users may encounter problems related to the textures of certain items !\n")
    else
        print("[NAP Custom Sign][CSS][FR] Les CSS Content ont été détécte sur le serveur. Aucun problème visuel n'est à craindre.")
        print("[NAP Custom Sign][CSS][ENG] CSS Content are mounted on the server. No visual problems are to be feared.\n")
    end

    if NAP_CUSTOM_SIGN ~= nil then 
        print("[NAP Custom Sign] [Variable Initialized] NAP_CUSTOM_SIGN ") 
    end

    include("languages/custom_sign_languages.lua")
    AddCSLuaFile("languages/custom_sign_languages.lua")

    include("nap_custom_sign/main_config.lua")
    AddCSLuaFile("nap_custom_sign/main_config.lua")    
    
    print("\n[NAP Custom Sign] [SERVER SIDE]")
    print("[NAP Custom Sign] [Including] [Languages file] custom_sign_languages.lua")
    print("[NAP Custom Sign] [Including] [Config file] main_config.lua")

    print("[NAP Custom Sign] [Sending] [Languages file] custom_sign_languages.lua")
    print("[NAP Custom Sign] [Sending] [Config file to client] main_config.lua")

    local p = "nap_custom_sign/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Custom Sign] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Custom Sign] [SHARED SIDE]")

    local p = "nap_custom_sign/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Custom Sign] [Sending] "..b)
        print("[NAP Custom Sign] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Custom Sign] [CLIENT SIDE]")

    local p = "nap_custom_sign/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Custom Sign] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n/////////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////      NAP Custom Sign       /////////////////////////\n")
    MsgC(Color(255, 255, 255), "//////////////////////           CLIENT           /////////////////////////\n")
    MsgC(Color(255, 255, 255), "//////////////////////////////////////////////////////////////////////////\n\n")

    if not IsMounted("cstrike") then
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(255, 0, 0), " n'ont pas été détecté", Color(255, 255, 255), ". Vous pourriez rencontrer ", Color(255, 0, 0), "des problèmes visuel ", Color(255, 255, 255), "avec certains objects de l'addon !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(255, 0, 0), "not mounted", Color(255, 255, 255), ". You may ", Color(255, 0, 0), "encounter visuals problems ", Color(255, 255, 255), " with some items of the addon !\n\n")
    else
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(0, 255, 0), " ont été détecté", Color(255, 255, 255), ". Vous ne devriez pas rencontrer des problèmes visuel !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(0, 255, 0), "mounted", Color(255, 255, 255), ". No visual problems are to be feared. !\n\n")
    end 
    
    include("languages/custom_sign_languages.lua")
    include("nap_custom_sign/main_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "custom_sign_languages.lua", "\n")
    MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")

    local p = "nap_custom_sign/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_custom_sign/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_custom_sign/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Custom Sign] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end