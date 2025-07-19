local language = NAP_ALCH_DISASTER_LANG[NAP_ALCH_DISASTER_LANG.Language]
if SERVER then
    local ranks = NAP_ALCH_DISASTER.Config.DebugCommandRank
    local function IsPlayerInRankList(steamid64)
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
        net.Start("NAP_ALCH_DISASTER_WrongPermission")
        net.Send(ply)
    end

    local function WailaAnswer(isValid, class, ply)
        net.Start("NAP_ALCH_DISASTER_WailaCommand")
            net.WriteBool(isValid)
            net.WriteString(class)
        net.Send(ply)
    end

    local function ManipulateBoneScale(ply, table)
        local HEAD = table["Head"]
        local NECK = table["Neck"]
        local TORSO = table["Torso"]
        local R_Arm = table["RightArm"]
        local L_Arm = table["LeftArm"]
        local R_Leg = table["RightLeg"]
        local L_Leg = table["LeftLeg"]

        for _, v in pairs(HEAD.Bones) do
            local modifier = HEAD.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(NECK.Bones) do
            local modifier = NECK.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(TORSO.Bones) do
            local modifier = TORSO.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(R_Arm.Bones) do
            local modifier = R_Arm.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(L_Arm.Bones) do
            local modifier = L_Arm.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(R_Leg.Bones) do
            local modifier = R_Leg.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end

        for _, v in pairs(L_Leg.Bones) do
            local modifier = L_Leg.SizeModifier
            local boneID = ply:LookupBone(v)
            if boneID then
                ply:ManipulateBoneScale(boneID, Vector(modifier.x, modifier.y, modifier.z))
            end
        end
    end

    hook.Add("PlayerSay", "NAP_ALCH_DISASTER_DebugCmd", function(ply, text)

        -- -------------------------------------------------------------------------------
        --                 WAILA command (WAILA = What Am I Look At)
        -- -------------------------------------------------------------------------------
        if string.lower(text) == "!waila" then
            if IsPlayerInRankList(ply:SteamID64()) then
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
            if IsPlayerInRankList(ply:SteamID64()) then
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
        -- -------------------------------------------------------------------------------
        --                 TEST PROPOTION
        -- -------------------------------------------------------------------------------        
        if string.lower(text) == "!applybonemanip" then
            if IsPlayerInRankList(ply:SteamID64()) then
                -- This command was created to "test" effects on a player.
                -- If you want to select a effect please refer to "lua\nap_alchemist_disaster\effects.lua"
                -- If you want to test a other effect you can modify "BigHead" by a other effect name.
                -- Effects are not "stackable", each effect are removing the previous one.
                -- List of effect created until now :
                --      BigHead
                --      InflateArms
                --      RunnerLegs
                ManipulateBoneScale(ply, NAP_ALCH_DISASTER_EFFECTS["RunnerLegs"]["BodyModifiers"])
            else
                WrongPermission(ply)
            end
            return false
        end

        if string.lower(text) == "!bones" then
            for boneID = 0, ply:GetBoneCount() - 1 do
                local boneName = ply:GetBoneName(boneID)
                print(boneID .. " = " .. boneName)
            end
            return false
        end

        if string.lower(text) == "!material" then
            PrintTable(ply:GetMaterials())
            return false
        end

    end)
end


if CLIENT then

    net.Receive("NAP_ALCH_DISASTER_WrongPermission", function()
        local wrong_permission = language["NAP_AD_Wrong_Permissions"]

        chat.AddText(Color(255, 255, 255), wrong_permission[1], Color(255, 0, 0), wrong_permission[2], Color(255, 255, 255), wrong_permission[3],Color(255, 0, 0), wrong_permission[4])
    end)

    net.Receive("NAP_ALCH_DISASTER_WailaCommand", function()
        local goodArg = net.ReadBool()
        local className = net.ReadString()
        local answer = language["NAP_AD_Waila_Result"]
        if goodArg then
            chat.AddText(Color(255, 255, 255), answer[1], Color(235, 183, 52), className, Color(255,255,255), answer[2])
        else
            chat.AddText(Color(255, 255, 255), answer[3], Color(255, 0, 0), answer[4], Color(255,255,255), answer[5])
        end

    end)

end