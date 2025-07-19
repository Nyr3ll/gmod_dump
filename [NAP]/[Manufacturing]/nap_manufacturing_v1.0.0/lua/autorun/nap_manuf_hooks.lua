local language = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]
local ranks = NAP_MANUF.Config.Debug_AllowedRanksDebugCommands
entityWithEnergy = {

    "nap_manuf_compressor",
    "nap_manuf_energy_storage",
    "nap_manuf_generatort1",
}
entityWithWood = {
    "nap_manuf_generatort1",
}

local entityConsumerEnergy = entityWithEnergy
local entityConsumerWood = entityWithWood

function IsPlayerInRankList(steamid64)
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

if SERVER then

    local function NAP_MANUF_LoadTrees()
        local mapName = game.GetMap()
        local filePath = "nap_lib/manufacturing/savedTrees/" .. mapName .. ".txt"

        if file.Exists(filePath, "DATA") then
            for _, ent in ipairs(ents.FindByClass("nap_manuf_trees")) do
                if IsValid(ent) then ent:Remove() end
            end
            local count = 0
            local data = file.Read(filePath, "DATA")
            for line in string.gmatch(data, "[^\r\n]+") do
                local posStr, angStr = string.match(line, "([^;]+);([^;]+)")
                if posStr and angStr then
                    local x, y, z = posStr:match("([%d%-%.]+) ([%d%-%.]+) ([%d%-%.]+)")
                    local p, ya, r = angStr:match("([%d%-%.]+) ([%d%-%.]+) ([%d%-%.]+)")

                    local ent = ents.Create("nap_manuf_trees")
                    if IsValid(ent) then
                        ent:SetPos(Vector(tonumber(x), tonumber(y), tonumber(z)))
                        ent:SetAngles(Angle(tonumber(p), tonumber(ya), tonumber(r)))
                        ent:Spawn()
                        local phys = ent:GetPhysicsObject()
                        if IsValid(phys) then
                            phys:EnableMotion(false)
                            phys:Wake()
                        end
                        count = count + 1
                    end
                end
            end
            print(language["NAP_MANUF_Trees_TreeHasBeenLoaded"][1]..tostring(count)..language["NAP_MANUF_Trees_TreeHasBeenLoaded"][2])
        else
            print(language["NAP_MANUF_Trees_NoTreeToLoad"][1])
        end
        return
    end

    local function NAP_MANUF_SaveTrees()
        local entsToSave = ents.FindByClass("nap_manuf_trees")
        local mapName = game.GetMap()
        local dirPath = "nap_lib/manufacturing/savedTrees/"
        local fileName = mapName .. ".txt"

        if not file.IsDir("nap_lib", "DATA") then
            file.CreateDir("nap_lib")
        end
        if not file.IsDir("nap_lib/manufacturing", "DATA") then
            file.CreateDir("nap_lib/manufacturing")
        end
        if not file.IsDir("nap_lib/manufacturing/savedTrees", "DATA") then
            file.CreateDir("nap_lib/manufacturing/savedTrees")
        end

        local toWrite = {}

        for _, ent in ipairs(entsToSave) do
            if IsValid(ent) then
                local pos = ent:GetPos()
                local ang = ent:GetAngles()
                table.insert(toWrite, string.format("%f %f %f;%f %f %f", pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
            end
        end

        file.Write(dirPath .. fileName, table.concat(toWrite, "\n"))
        print(language["NAP_MANUF_Trees_TreeHasBeenSaved"][1].. mapName .. "\".")
    end

    hook.Add("PostCleanupMap", "NapLib_ReloadTreesAfterCleanup", function()
        timer.Simple(1, function()
            NAP_MANUF_LoadTrees()
        end)
    end)

    hook.Add("Initialize", "NapLib_LoadTreesOnServerStart", function()
        timer.Simple(1, function()
            NAP_MANUF_LoadTrees()
        end)
    end)

    local function WrongPermission(ply)
        net.Start("NAP_MANUF_WrongPermission")
        net.Send(ply)
    end

    local function WailaAnswer(isValid, class, ply)
        net.Start("NAP_MANUF_WailaCommand")
            net.WriteBool(isValid)
            net.WriteString(class)
        net.Send(ply)
    end

    -- -------------------------------------------------------------------------------
    --          Exemple edit something relative to a player (from client to server)
    -- -------------------------------------------------------------------------------
    /*
    net.Receive("NAP_MANUF_WaterMoneyShop_BuyWeapon", function()
        local ply = net.ReadPlayer()
        local weaponClass = net.ReadString()
        ply:Give(weaponClass)
    end)
    */

    -- -------------------------------------------------------------------------------
    --          Exemple send a chat message to client from server (Need the player target)
    -- -------------------------------------------------------------------------------
    /*
    net.Receive("NAP_MANUF_WaterMoneyShop_SpawnLimitReachedCall", function()
        local ply = net.ReadPlayer()
        net.Start("NAP_MANUF_WaterMoneyShop_SpawnLimitReachedAnswer")
        net.Send(ply)
    end)
    */
    

    hook.Add("PlayerSay", "NAP_MANUF_DebugCmd", function(ply, text)

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
        --                 DEBUG Command to define storedEnergy value of a machine
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 10) == "!setenergy" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local args = string.Split(text, " ")
                local amount = tonumber(args[2])
                local trace = ply:GetEyeTrace()

                local isValidEntity = false

                for k, v in pairs(entityConsumerEnergy) do
                    if trace.Entity:GetClass() == v then 
                        isValidEntity = true
                    end
                end

                if trace.Entity and IsValid(trace.Entity) and isValidEntity then
                    if amount > trace.Entity:Get_EnergyCapacity() then
                        amount = trace.Entity:Get_EnergyCapacity()
                    end
                    if amount < 0 then
                        amount = 0
                    end
                    trace.Entity:Set_EnergyStored(amount)
                else
                    WailaAnswer(false, "", ply)
                end
            else
                WrongPermission(ply)
            end
            return false
        end

        -- --------------------------------------------------------------------------------------
        --                 Command to save all trees in a .txt file. Avoid using Perma props etc
        -- --------------------------------------------------------------------------------------
        if string.lower(text) == "!nap_save_trees" then
            if IsPlayerInRankList(ply:SteamID64()) then
                NAP_MANUF_SaveTrees()
            else
                WrongPermission(ply)
            end
            return false
        end

        -- --------------------------------------------------------------------------------------
        --                 Command to save all trees in a .txt file. Avoid using Perma props etc
        -- --------------------------------------------------------------------------------------
        if string.lower(text) == "!nap_load_trees" then
            if IsPlayerInRankList(ply:SteamID64()) then
                NAP_MANUF_LoadTrees()
            else
                WrongPermission(ply)
            end
            return false
        end
    end)
end


if CLIENT then

    net.Receive("NAP_MANUF_WrongPermission", function()
        local wrong_permission = language["NAP_MANUF_Wrong_Permissions"]

        chat.AddText(Color(255, 255, 255), wrong_permission[1], Color(255, 0, 0), wrong_permission[2], Color(255, 255, 255), wrong_permission[3],Color(255, 0, 0), wrong_permission[4])
    end)

    net.Receive("NAP_MANUF_WailaCommand", function()
        local goodArg = net.ReadBool()
        local className = net.ReadString()
        local answer = language["NAP_MANUF_Waila_Result"]
        if goodArg then
            chat.AddText(Color(255, 255, 255), answer[1], Color(235, 183, 52), className, Color(255,255,255), answer[2])
        else
            chat.AddText(Color(255, 255, 255), answer[3], Color(255, 0, 0), answer[4], Color(255,255,255), answer[5])
        end

    end)

end