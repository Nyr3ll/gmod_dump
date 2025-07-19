local language = NAP_DEVTOOL_LANGUAGES[NAP_DEVTOOL.Config.Language]
if SERVER then

    local cfg = NAP_DEVTOOL.Config
    local debugRanks = cfg.AllowedRanksDebugCommands
    local teleporterRanks = cfg.AllowedRanksTpFeatures
    local traceRanks = cfg.AllowedRanksViewsFeatures
    local function IsPlayerInRankList(steamid64, ranks)
        local ply = player.GetBySteamID64(steamid64)

        if not IsValid(ply) then
            return false
        end

        local rank = ply:GetUserGroup()

        if table.HasValue(ranks, rank) then
            return true
        else
            return false
        end
    end

    local function WrongPermission(ply)
        net.Start("NAP_DEVTOOL_WrongPermission")
        net.Send(ply)
    end

    local function WailaAnswer(isValid, class, ply)
        net.Start("NAP_DEVTOOL_WailaCommand")
            net.WriteBool(isValid)
            net.WriteString(class)
        net.Send(ply)
    end

    net.Receive("NAP_DEVTOOL_TeleportAt", function()
        
        local ply = net.ReadEntity()
        local coords = net.ReadVector()
        local hasPermission = false
        if IsPlayerInRankList(ply:SteamID64(), teleporterRanks) then
            ply:SetPos(coords)
            hasPermission = true
        else
            print("\n[DEV TOOL][WARNING] "..ply:Name().." try to use a restricted feature without permission !")
        end
        
        net.Start("NAP_DEVTOOL_TeleportAt_ServerAnswer")
            net.WriteBool(hasPermission)
        net.Send(ply)
        
    end)

    hook.Add("PlayerSay", "HOOK_NAP_DEVTOOL_WailaCommand", function(ply, text)

        -- -------------------------------------------------------------------------------
        --                 WAILA command (WAILA = What Am I Look At)
        -- -------------------------------------------------------------------------------
        if string.lower(text) == "!waila" then
            if IsPlayerInRankList(ply:SteamID64(), debugRanks) then
                local trace = ply:GetEyeTrace()
                if trace.Entity and IsValid(trace.Entity) then
                    local className = trace.Entity:GetClass()
                    WailaAnswer(true, className, ply)
                else
                    WailaAnswer(false, "", ply)
                    
                end
            else
                WrongPermission(ply)
            end
            return false
        end
        
        -- -------------------------------------------------------------------------------
        --                 Model command to get the model of a props you are looking at
        -- -------------------------------------------------------------------------------
        if string.lower(text) == "!model" then
            if IsPlayerInRankList(ply:SteamID64(), debugRanks) then
                local trace = ply:GetEyeTrace()
                if trace.Entity and IsValid(trace.Entity) then
                    local className = trace.Entity:GetModel()
                    WailaAnswer(true, className, ply)
                else
                    WailaAnswer(false, "", ply)
                    
                end
            else
                WrongPermission(ply)
            end
            return false
        end
    end)

    hook.Add("PlayerInitialSpawn", "NAP_DEVTOOL_InitSpawn", function(ply)
        ply:SetNWBool("NAP_DEVTOOL_Coords", false)
        ply:SetNWBool("NAP_DEVTOOL_Traces", false)
    end)

end

if CLIENT then

    net.Receive("NAP_DEVTOOL_NotAcces", function()
        chat.AddText(Color(255, 255, 255), language["admincommand_NotAcces"])
    end)

    net.Receive("NAP_DEVTOOL_WrongPermission", function()
        local wrong_permission = language["wrong_permissions"]
        chat.AddText(Color(255, 255, 255), wrong_permission[1], Color(255, 0, 0), wrong_permission[2], Color(255, 255, 255), wrong_permission[3])
    end)

    net.Receive("NAP_DEVTOOL_WailaCommand", function()
        local goodArg = net.ReadBool()
        local className = net.ReadString()
        if goodArg then
            chat.AddText(Color(255, 255, 255), language["admincommand_wailaCommand"][1], Color(235, 183, 52), className, Color(255,255,255), language["admincommand_wailaCommand"][2])
        else
            chat.AddText(Color(255, 255, 255), language["admincommand_wailaCommand"][3], Color(255, 0, 0), language["admincommand_wailaCommand"][4], Color(255,255,255), language["admincommand_wailaCommand"][5])
        end

    end)
end