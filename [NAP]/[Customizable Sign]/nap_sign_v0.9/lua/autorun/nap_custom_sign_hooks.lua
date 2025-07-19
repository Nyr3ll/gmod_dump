local cfg = NAP_CUSTOM_SIGN.Config
local lang = NAP_CUSTOM_SIGN_LANGUAGES[cfg.Language]
local sents_class = cfg.CustomSents

if SERVER then

    local whitelistedRank = cfg.AllowedRanksCmd

    local function IsPlayerInRankList(steamid64)
        local ply = player.GetBySteamID64(steamid64)

        if not IsValid(ply) then
            return false
        end

        local rank = ply:GetUserGroup()

        if table.HasValue(whitelistedRank, rank) then
            return true
        else
            return false
        end
    end

    local function WrongPermission(ply)
        net.Start("NAP_CUSTOM_SIGN_WrongPerm")
        net.Send(ply)
    end 

    local function GetEntitiesByClasses(classTable)
        local matchingEntities = {}

        for _, ent in ipairs(ents.GetAll()) do
            local class = ent:GetClass()
            for _, targetClass in ipairs(classTable) do
                if class == targetClass then
                    if ent.UIElements != nil then
                        table.insert(matchingEntities, ent)
                        print("[NAP][Custom Sign][SAVING] Entité possède des éléments UI. [self.UIElements] = ")
                        PrintTable(ent.UIElements)
                    else 
                        print("[NAP][Custom Sign][SAVING] Entité de classe trouvé mais n'a aucun element UI. \"UIElements = nil\"")
                    end
                    break
                end
            end
        end

        return matchingEntities
    end

    --/////////////////////////////////////////////////////////////////////////////////////
    --                        SAVING / LOADING SIGN
    --/////////////////////////////////////////////////////////////////////////////////////

    local function NAP_CS_LoadSign()
        local mapName = game.GetMap()
        local filePath = "nap_lib/custom_sign/saved_sign/" .. mapName .. ".txt"

        if file.Exists(filePath, "DATA") then
            -- Supprimer toutes les entités listées dans sents_class
            for _, ent in ipairs(GetEntitiesByClasses(sents_class)) do
                if IsValid(ent) then ent:Remove() end
            end

            local count = 0
            local data = file.Read(filePath, "DATA")
            for line in string.gmatch(data, "[^\r\n]+") do
                local entData = util.JSONToTable(line)
                if entData and entData.class and entData.pos and entData.ang then
                    local ent = ents.Create(entData.class)
                    if IsValid(ent) then
                        ent:SetPos(Vector(entData.pos.x, entData.pos.y, entData.pos.z))
                        ent:SetAngles(Angle(entData.ang.p, entData.ang.y, entData.ang.r))
                        ent:Spawn()

                        ent.UIElements = entData.UIElements or {}

                        timer.Simple(1, function()
                            if IsValid(ent) then
                                net.Start("NAP_CUSTOM_SIGN_SendUIElements")
                                net.WriteEntity(ent)
                                net.WriteTable(ent.UIElements)
                                net.Broadcast()
                            end
                        end)

                        local phys = ent:GetPhysicsObject()
                        if IsValid(phys) then
                            phys:EnableMotion(false)
                            phys:Wake()
                        end

                        count = count + 1
                    end
                end
            end

            print(lang["nap_cs_sign_loaded"][1] .. tostring(count) .. lang["nap_cs_sign_loaded"][2])
        else
            print(lang["nap_cs_sign_notLoaded"])
        end
    end

    local function NAP_CS_SaveSign()
        local entsToSave = GetEntitiesByClasses(sents_class)
        local mapName = game.GetMap()
        local dirPath = "nap_lib/custom_sign/saved_sign/"
        local fileName = mapName .. ".txt"

        if not file.IsDir("nap_lib", "DATA") then file.CreateDir("nap_lib") end
        if not file.IsDir("nap_lib/custom_sign", "DATA") then file.CreateDir("nap_lib/custom_sign") end
        if not file.IsDir(dirPath, "DATA") then file.CreateDir(dirPath) end

        local toWrite = {}

        for _, ent in ipairs(entsToSave) do
            if IsValid(ent) then
                local pos = ent:GetPos()
                local ang = ent:GetAngles()
                local class = ent:GetClass()

                local data = {
                    class = class,
                    pos = {x = pos.x, y = pos.y, z = pos.z},
                    ang = {p = ang.p, y = ang.y, r = ang.r},
                    UIElements = ent.UIElements or {}
                }

                table.insert(toWrite, util.TableToJSON(data))
            end
        end

        file.Write(dirPath .. fileName, table.concat(toWrite, "\n"))
        print(lang["nap_cs_sign_saving"] .. tostring(mapName) .. "\".")
    end


    --//////////////////////////////////////////////////////////////////////////////
    --                  AUTO LOAD AFTER CLEAN UP OR SERVER START
    hook.Add("PostCleanupMap", "NAP_CUSTOM_SIGN_ReloadPostCleanUp", function()
        timer.Simple(1, function()
            NAP_CS_LoadSign()
        end)
    end)

    hook.Add("Initialize", "NAP_CUSTOM_SIGN_LoadSvStart", function()
        timer.Simple(1, function()
            NAP_CS_LoadSign()
        end)
    end)
    --//////////////////////////////////////////////////////////////////////////////

    hook.Add("PlayerSay", "NAP_CUSTOM_SIGN_Commands", function(ply, text)
        -- --------------------------------------------------------------------------------------
        --                 Command to save all sign in a .txt file. Avoid using Perma props etc
        -- --------------------------------------------------------------------------------------
        if string.lower(text) == "!nap_cs_save" then
            if IsPlayerInRankList(ply:SteamID64()) then
                NAP_CS_SaveSign()
            else
                WrongPermission(ply)
            end
            return false
        end

        -- --------------------------------------------------------------------------------------
        --                 Command to load all sign from a .txt file.
        -- --------------------------------------------------------------------------------------
        if string.lower(text) == "!nap_cs_load" then
            if IsPlayerInRankList(ply:SteamID64()) then
                NAP_CS_LoadSign()
            else
                WrongPermission(ply)
            end
            return false
        end

        -- --------------------------------------------------------------------------------------
        --                 Command to "edit" sign settings
        -- --------------------------------------------------------------------------------------
        if string.lower(text) == "!nap_sign_edit" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local trace = ply:GetEyeTrace()
                local ent = trace.Entity
                local editable_sign = false
                for _, v in ipairs(sents_class) do
                    if v == ent:GetClass() then
                        editable_sign = true
                        break
                    end
                end
                if editable_sign then
                    print("[NAP][CUSTOM SIGN] "..ply:Nick()..lang["nap_cs_sign_editing"]..tostring(ent:GetPos()))
                    -- Start the net message
                    -- Sending "ply", "ent"
                    net.Start("NAP_CUSTOM_SIGN_OpenEditMenu")
                        net.WriteEntity(ent)
                        net.WriteTable(ent.UIElements)
                    net.Send(ply)
                end
                return ""
            else
                WrongPermission(ply)
            end
            return false
        end

    end)

end

if CLIENT then

    net.Receive("NAP_CUSTOM_SIGN_WrongPerm", function()
        chat.AddText(Color(255, 255, 255), lang["nap_cs_WrongPermission"])
    end)

end