if SERVER then

    print("\n////////////////////////////////////////////////////////////////////////")
    print("/////////////////////////       BUYING XP       /////////////////////////")
    print("////////////////////////         SERVER         ////////////////////////")
    print("///////////////////////////////////////////////////////////////////////\n")

    include("bw_menu_achat_xp/main_config.lua")
    AddCSLuaFile("bw_menu_achat_xp/main_config.lua")
    
    
    print("\n[NAP Buying XP] [SERVER SIDE]")
    print("[NAP Buying XP] [Including] [Config file] main_config.lua")
    print("[NAP Buying XP] [Sending]   [Config file to client] main_config.lua")

    local p = "bw_menu_achat_xp/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Buying XP] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP Buying XP] [SHARED SIDE]")

    local p = "bw_menu_achat_xp/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Buying XP] [Sending] "..b)
        print("[NAP Buying XP] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP Buying XP] [CLIENT SIDE]")

    local p = "bw_menu_achat_xp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP Buying XP] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "/////////////////////////       BUYING XP       /////////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////        CLIENT         /////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////////////////////////////////////////////////////\n\n")

    include("bw_menu_achat_xp/main_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP Buying XP] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")

    local p = "bw_menu_achat_xp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Buying XP] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "bw_menu_achat_xp/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Buying XP] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "bw_menu_achat_xp/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP Buying XP] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end