NAP_TYCOON_WATERPRODUCTION = NAP_TYCOON_WATERPRODUCTION or {}

NAP_TYCOON_WATERPRODUCTION.Config = NAP_TYCOON_WATERPRODUCTION.Config or {}

NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig = NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig or {}
NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu or {}
NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop or {}

NAP_TYCOON_WATERPRODUCTION.Config.Entities = NAP_TYCOON_WATERPRODUCTION.Config.Entities or {}
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators  = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators or {}
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1 = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1 or {}
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2 = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2 or {}
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3 = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3 or {}
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney = NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney or {}

if SERVER then

    print("\n//////////////////////////////////////////////////////////////////////////////")
    print("///////////////////////// NAP Tycoon Water Production /////////////////////////")
    print("////////////////////////            SERVER           /////////////////////////")
    print("/////////////////////////////////////////////////////////////////////////////\n")

    if not IsMounted("cstrike") then
        print("[NAP Tycoon WP][CSS][FR] Les CSS Content n'ont pas été détécte sur le serveur. Certains utilisateur pourraient rencontrer des problèmes liés aux textures de certains items !")
        print("[NAP Tycoon WP][CSS][ENG] CSS Content are not mounted on the server. Some users may encounter problems related to the textures of certain items !\n")
    else
        print("[NAP Tycoon WP][CSS][FR] Les CSS Content ont été détécte sur le serveur. Aucun problème visuel n'est à craindre !")
        print("[NAP Tycoon WP][CSS][ENG] CSS Content are mounted on the server. No visual problems are to be feared !\n")
    end

    if NAP_TYCOON_WATERPRODUCTION ~= nil then 
        print("[NAP Tycoon WP] [Variable Initialized] NAP_TYCOON_WATERPRODUCTION ") 
    end

    include("languages/nap_wp_languages.lua")
    AddCSLuaFile("languages/nap_wp_languages.lua")

    include("nap_tycoon_wp/main_config.lua")
    AddCSLuaFile("nap_tycoon_wp/main_config.lua")    
    
    print("\n[NAP Tycoon WP] [SERVER SIDE]")
    print("[NAP Tycoon WP] [Including] [Languages file] nap_wp_languages.lua")
    print("[NAP Tycoon WP] [Including] [Config file] main_config.lua")
    print("[NAP Tycoon WP] [Sending] [Languages file] nap_wp_languages.lua")
    print("[NAP Tycoon WP] [Sending] [Config file] main_config.lua")

    local p = "nap_tycoon_wp/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Tycoon WP] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Tycoon WP] [SHARED SIDE]")

    local p = "nap_tycoon_wp/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Tycoon WP] [Sending] "..b)
        print("[NAP Tycoon WP] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Tycoon WP] [CLIENT SIDE]")

    local p = "nap_tycoon_wp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Tycoon WP] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n//////////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////// NAP Tycoon Water Production /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////            CLIENT           /////////////////////////\n")
    MsgC(Color(255, 255, 255), "/////////////////////////////////////////////////////////////////////////////\n\n")

    if not IsMounted("cstrike") then
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(255, 0, 0), " n'ont pas été détecté", Color(255, 255, 255), ". Vous pourriez rencontrer ", Color(255, 0, 0), "des problèmes visuel ", Color(255, 255, 255), "avec certains objects de l'addon !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(255, 0, 0), "not mounted", Color(255, 255, 255), ". You may ", Color(255, 0, 0), "encounter visuals problems ", Color(255, 255, 255), " with some items of the addon !\n\n")
    else
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[CSS][FR] ",  Color(255,255,255,255), "Les CSS Content ", Color(0, 255, 0), " ont été détecté", Color(255, 255, 255), ". Vous ne devriez pas rencontrer des problèmes visuel !\n")
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[CSS][ENG] ",  Color(255,255,255,255), "CSS Content are ", Color(0, 255, 0), "mounted", Color(255, 255, 255), ". No visual problems are to be feared !\n\n")
    end 
    
    include("languages/nap_wp_languages.lua")
    include("nap_tycoon_wp/main_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "nap_wp_languages.lua", "\n")
    MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")

    local p = "nap_tycoon_wp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_tycoon_wp/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_tycoon_wp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Tycoon WP]", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end