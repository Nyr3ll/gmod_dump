NAP_LUCKYCARDS = NAP_LUCKYCARDS or {}
NAP_LUCKYCARDS.Config = NAP_LUCKYCARDS.Config or {}
NAP_LUCKYCARDS.Config.LuckyCard = NAP_LUCKYCARDS.Config.LuckyCard or {}


if SERVER then

    print("\n////////////////////////////////////////////////////////////////////////")
    print("///////////////////////       NAP LUCKY CARD       //////////////////////")
    print("////////////////////////         SERVER         ////////////////////////")
    print("///////////////////////////////////////////////////////////////////////\n")

    include("nap_luckycards/main_config.lua")
    AddCSLuaFile("nap_luckycards/main_config.lua")
    
    
    print("\n[NAP LUCKY CARD] [SERVER SIDE]")
    print("[NAP LUCKY CARD] [Including] [Config file] main_config.lua")
    print("[NAP LUCKY CARD] [Sending]   [Config file to client] main_config.lua")

    local p = "nap_luckycards/server/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP LUCKY CARD] [Loading] "..b)
        include(p..b)

    end

    print("\n[NAP LUCKY CARD] [SHARED SIDE]")

    local p = "nap_luckycards/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP LUCKY CARD] [Sending] "..b)
        print("[NAP LUCKY CARD] [Including] "..b)
        include(p..b)
        AddCSLuaFile(p..b)

    end

    print("\n[NAP LUCKY CARD] [CLIENT SIDE]")

    local p = "nap_luckycards/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do

        print("[NAP LUCKY CARD] [Sending] "..b)
        AddCSLuaFile(p..b)

    end

end

if CLIENT then

    MsgC(Color(255, 255, 255), "\n////////////////////////////////////////////////////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////       NAP LUCKY CARD       //////////////////////\n")
    MsgC(Color(255, 255, 255), "////////////////////////        CLIENT         /////////////////////////\n")
    MsgC(Color(255, 255, 255), "///////////////////////////////////////////////////////////////////////\n\n")

    include("nap_luckycards/main_config.lua")

    MsgC(Color(220, 16, 227, 255), "[NAP LUCKY CARD] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), "main_config.lua", "\n")

    local p = "nap_luckycards/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP LUCKY CARD] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_luckycards/shared/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP LUCKY CARD] ", Color(227, 181, 16, 255) ,"[Including] ",  Color(255,255,255,255), b, "\n")
        include(p..b)

    end

    local p = "nap_luckycards/client/"

    for _ ,b in pairs(file.Find(p.."*", "LUA")) do
        MsgC(Color(220, 16, 227, 255), "[NAP LUCKY CARD] ", Color(227, 181, 16, 255) ,"[Including] ", Color(255,255,255,255), b, "\n")
        include(p..b)

    end

end