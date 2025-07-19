local language = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]
if SERVER then

    function EntityPrice(entityClass)
        local itemsSold = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold
        for _, v in pairs(itemsSold) do
            if v.Entity == entityClass then
                print("v = ".. v.Entity)
            end
        end
    
    end

    local createBillysLogs = NAP_TYCOON_WATERPRODUCTION.Config.BillysLogsCompatibilite
    local ranks = NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig.PlayerDataEditing
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

    -- -------------------------------------------------------------------------------
    --          Net message to give a bought weapon to player
    -- -------------------------------------------------------------------------------
    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_BuyWeapon", function()
        local ply = net.ReadPlayer()
        local weaponClass = net.ReadString()
        ply:Give(weaponClass)
    end)
    

    -- -------------------------------------------------------------------------------
    --          Net message to send a "Chat message" to the client
    -- -------------------------------------------------------------------------------
    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_SpawnLimitReachedCall", function()
        local ply = net.ReadPlayer()
        net.Start("NAP_TYCOON_WP_WaterMoneyShop_SpawnLimitReachedAnswer")
        net.Send(ply)
    end)

    -- -------------------------------------------------------------------------------
    --          Net message to send a "Chat message" to the client
    -- -------------------------------------------------------------------------------
    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_NotEnoughToBuyCall", function()
        local ply = net.ReadPlayer()
        net.Start("NAP_TYCOON_WP_WaterMoneyShop_NotEnoughToBuyAnswer")
        net.Send(ply)
    end)

    -- -------------------------------------------------------------------------------
    --          Net message to spawn the entity which got purchased
    -- -------------------------------------------------------------------------------
    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_SpawnPurchasedItem", function()
        local pos = net.ReadVector()
        local entityName = net.ReadString()
        local steamID64 = net.ReadString()

        local purchasedItem = ents.Create(entityName)
        purchasedItem:SetPos(pos + Vector(80, 0, 10))
        
        local entity = purchasedItem

        if FPP and IsValid(entity) then
            local player = player.GetBySteamID64(steamID64)
            if IsValid(player) then
                entity:CPPISetOwner(player)
            end
        end
        purchasedItem:Spawn()

    end)

    hook.Add("PlayerSay", "NAP_TYCOON_WP_DevCmd", function(ply, text)

        -- -------------------------------------------------------------------------------
        --                 WAILA command (WAILA = What Am I Look At)
        -- -------------------------------------------------------------------------------
        if string.lower(text) == "!nap_waila" then
            if ply:GetUserGroup() == "superadmin" then
                local trace = ply:GetEyeTrace()
                if trace.Entity and IsValid(trace.Entity) then
                    local className = trace.Entity:GetClass()
                    net.Start("NAP_TYCOON_WP_WailaCommand")
                        net.WriteString(className)
                        net.WriteBool(true)
                    net.Send(ply)
                else
                    net.Start("NAP_TYCOON_WP_WailaCommand")
                    net.WriteBool(false)
                    net.Send(ply)
                    
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Set Water Money
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 18) == "!nap_setwatermoney" then
            if IsPlayerInRankList(ply:SteamID64())  then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true

                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint(language["playerDataManipulation_MissingSteamID"])
                    executeCommand = false        
                    return false           
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint(language["playerDataManipulation_MissingValue"])
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint()
                    executeCommand = false
                    return false   
                end
        
                if executeCommand then 
                    local newAmount = SetWaterMoney(steamid, amount)
                    net.Start("NAP_TYCOON_WP_PlayerData_SetWaterMoney")
                    net.WriteString(steamid)
                    net.WriteString(newAmount)
                    net.Send(ply)
                    if createBillysLogs then
                        local target = player.GetBySteamID64(steamid)
                        waterMoneyLog(ply, amount, target, newAmount)
                    end
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Add Water Money
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 18) == "!nap_addwatermoney" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true
        
                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false   
                    return false                  
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end

                if executeCommand then 
                    local newMoney = AddWaterMoney(steamid, amountNumber)
                    local addingMoney = true
                    if amountNumber < 0 then
                        addingMoney = false
                    end
                    net.Start("NAP_TYCOON_WP_PlayerData_AddWaterMoney")
                    net.WriteBool(addingMoney)
                    net.WriteString(steamid)
                    net.WriteString(amount)
                    net.WriteString(newMoney)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Set Water Points
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 19) == "!nap_setwaterpoints" then
            if IsPlayerInRankList(ply:SteamID64())  then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true

                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false
                    return false                
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end
        
                if executeCommand then 
                    local newAmount = SetWaterPoints(steamid, amount)
                    net.Start("NAP_TYCOON_WP_PlayerData_SetWaterPoints")
                    net.WriteString(steamid)
                    net.WriteString(newAmount)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Add Water Points
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 19) == "!nap_addwaterpoints" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true
        
                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false   
                    return false                  
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end

                if executeCommand then 
                    local newMoney = AddWaterPoints(steamid, amountNumber)
                    local addingMoney = true
                    if amountNumber < 0 then
                        addingMoney = false
                    end
                    net.Start("NAP_TYCOON_WP_PlayerData_AddWaterPoints")
                    net.WriteBool(addingMoney)
                    net.WriteString(steamid)
                    net.WriteString(amount)
                    net.WriteString(newMoney)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end
        
        -- -------------------------------------------------------------------------------
        --                 Set Prestige Points
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 22) == "!nap_setprestigepoints" then
            if IsPlayerInRankList(ply:SteamID64())  then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true

                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false
                    return false                
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end
        
                if executeCommand then 
                    local newAmount = SetPrestigePoints(steamid, amount)
                    net.Start("NAP_TYCOON_WP_PlayerData_SetPrestigePoints")
                    net.WriteString(steamid)
                    net.WriteString(newAmount)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Add Prestige Points
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 22) == "!nap_addprestigepoints" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true
        
                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false   
                    return false                  
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end

                if executeCommand then 
                    local newMoney = AddPrestigePoints(steamid, amountNumber)
                    local addingMoney = true
                    if amountNumber < 0 then
                        addingMoney = false
                    end
                    net.Start("NAP_TYCOON_WP_PlayerData_AddPrestigePoints")
                    net.WriteBool(addingMoney)
                    net.WriteString(steamid)
                    net.WriteString(amount)
                    net.WriteString(newMoney)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Set Prestige
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 16) == "!nap_setprestige" then
            if IsPlayerInRankList(ply:SteamID64())  then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true

                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false
                    return false                
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end
        
                if executeCommand then 
                    local newAmount = SetPrestige(steamid, amount)
                    net.Start("NAP_TYCOON_WP_PlayerData_SetPrestige")
                    net.WriteString(steamid)
                    net.WriteString(newAmount)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

        -- -------------------------------------------------------------------------------
        --                 Add Prestige
        -- -------------------------------------------------------------------------------
        if string.sub(text, 1, 16) == "!nap_addprestige" then
            if IsPlayerInRankList(ply:SteamID64()) then
                local args = string.Split(text, " ")
                local steamid = args[2]
                local amount = args[3]
                local executeCommand = true
        
                if not steamid or not string.match(steamid, "^7656119%d+$") then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.")
                    executeCommand = false   
                    return false                  
                end

                if not amount or not tonumber(amount) then
                    ply:ChatPrint("[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).")
                    executeCommand = false
                    return false   
                end

                local amountNumber = tonumber(amount)

                if amountNumber < -math.huge or amountNumber > math.huge then
                    ply:ChatPrint("[NAP Tycoon] Le montant dépasse les limites autorisées.")
                    executeCommand = false
                    return false   
                end

                if executeCommand then 
                    local newMoney = AddPrestige(steamid, amountNumber)
                    local addingMoney = true
                    if amountNumber < 0 then
                        addingMoney = false
                    end
                    net.Start("NAP_TYCOON_WP_PlayerData_AddPrestige")
                    net.WriteBool(addingMoney)
                    net.WriteString(steamid)
                    net.WriteString(amount)
                    net.WriteString(newMoney)
                    net.Send(ply)
                end
            else
                net.Start("NAP_TYCOON_WP_WrongPermission")
                net.Send(ply)
                
            end
            return false
        end

    end)

end


if CLIENT then

    net.Receive("NAP_TYCOON_WP_WrongPermission", function()
        local wrong_permission = language["wrong_permissions"]

        chat.AddText(Color(255, 255, 255), wrong_permission[1], Color(255, 0, 0), wrong_permission[2], Color(255, 255, 255), wrong_permission[3],Color(255, 0, 0), wrong_permission[4])
    end)

    net.Receive("NAP_TYCOON_WP_WailaCommand", function()
        local className = net.ReadString()
        local goodArg = net.ReadBool()
        if goodArg then
            chat.AddText(Color(255, 255, 255), "Class of the entity you are look at \"", Color(235, 183, 52), className, Color(255,255,255), "\"")
        else
            chat.AddText(Color(255, 255, 255), "You are ", Color(255, 0, 0), "not", Color(255,255,255), " looking at a valid entity !")
        end

    end)

    net.Receive("NAP_TYCOON_WP_ResetDB_Confirmation", function()
        local reset_db_confi = language["database_reset_confirmation"]
        if NAP_TYCOON_WP_LANGUAGES.Language == "fr" then

            chat.AddText(Color(255, 255, 255), reset_db_confi[1], Color(255, 127, 8), reset_db_confi[2], Color(255, 255, 255), reset_db_confi[3], Color(255, 0, 0), reset_db_confi[4], Color(255, 255, 255), reset_db_confi[5])

        elseif  NAP_TYCOON_WP_LANGUAGES.Language == "eng" then

            chat.AddText(Color(255, 127, 8), reset_db_confi[1], Color(255, 255, 255), reset_db_confi[2], Color(255, 0, 0), reset_db_confi[3],Color(255, 255, 255), reset_db_confi[4])

        else
            chat.AddText(Color(255, 255, 255), reset_db_confi)
        end
        
    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_SetWaterMoney", function()
        local playerData_SetWM_ConfMsg = language["playerData_SetWaterMoney_ConfMsg"]
        local steamid = net.ReadString()
        local newAmount = net.ReadString()

        chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(0, 135, 245), playerData_SetWM_ConfMsg[2], Color(255, 255, 255), playerData_SetWM_ConfMsg[3], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(69, 186, 26), newAmount, Color(255, 255, 255), playerData_SetWM_ConfMsg[5], Color(0, 135, 245), playerData_SetWM_ConfMsg[6], Color(255, 255, 255), playerData_SetWM_ConfMsg[7])
        
    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_AddWaterMoney", function()
        local playerData_SetWM_ConfMsg = language["playerData_AddWaterMoney_ConfMsg"]
        local addingValue = net.ReadBool()
        local steamid = net.ReadString()
        local amount = net.ReadString()
        local newMoney = net.ReadString()
        
        if addingValue then
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(69, 186, 26), playerData_SetWM_ConfMsg[2], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        else
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(255, 0, 0), playerData_SetWM_ConfMsg[3], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        end

    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_SetWaterPoints", function()
        local playerData_SetWM_ConfMsg = language["playerData_SetWaterPoints_ConfMsg"]
        local steamid = net.ReadString()
        local newAmount = net.ReadString()

        chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(0, 135, 245), playerData_SetWM_ConfMsg[2], Color(255, 255, 255), playerData_SetWM_ConfMsg[3], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(69, 186, 26), newAmount, Color(255, 255, 255), playerData_SetWM_ConfMsg[5], Color(0, 135, 245), playerData_SetWM_ConfMsg[6], Color(255, 255, 255), playerData_SetWM_ConfMsg[7])
        
    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_AddWaterPoints", function()
        local playerData_SetWM_ConfMsg = language["playerData_AddWaterPoints_ConfMsg"]
        local addingValue = net.ReadBool()
        local steamid = net.ReadString()
        local amount = net.ReadString()
        local newMoney = net.ReadString()
        
        if addingValue then
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(69, 186, 26), playerData_SetWM_ConfMsg[2], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        else
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(255, 0, 0), playerData_SetWM_ConfMsg[3], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        end

    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_SetPrestigePoints", function()
        local playerData_SetWM_ConfMsg = language["playerData_SetPrestigePoints_ConfMsg"]
        local steamid = net.ReadString()
        local newAmount = net.ReadString()

        chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(0, 135, 245), playerData_SetWM_ConfMsg[2], Color(255, 255, 255), playerData_SetWM_ConfMsg[3], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(69, 186, 26), newAmount, Color(255, 255, 255), playerData_SetWM_ConfMsg[5], Color(0, 135, 245), playerData_SetWM_ConfMsg[6], Color(255, 255, 255), playerData_SetWM_ConfMsg[7])
        
    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_AddPrestigePoints", function()
        local playerData_SetWM_ConfMsg = language["playerData_AddPrestigePoints_ConfMsg"]
        local addingValue = net.ReadBool()
        local steamid = net.ReadString()
        local amount = net.ReadString()
        local newMoney = net.ReadString()
        
        if addingValue then
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(69, 186, 26), playerData_SetWM_ConfMsg[2], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        else
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(255, 0, 0), playerData_SetWM_ConfMsg[3], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        end

    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_SetPrestige", function()
        local playerData_SetWM_ConfMsg = language["playerData_SetPrestige_ConfMsg"]
        local steamid = net.ReadString()
        local newAmount = net.ReadString()

        chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(0, 135, 245), playerData_SetWM_ConfMsg[2], Color(255, 255, 255), playerData_SetWM_ConfMsg[3], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(69, 186, 26), newAmount, Color(255, 255, 255), playerData_SetWM_ConfMsg[5], Color(0, 135, 245), playerData_SetWM_ConfMsg[6], Color(255, 255, 255), playerData_SetWM_ConfMsg[7])
        
    end)

    net.Receive("NAP_TYCOON_WP_PlayerData_AddPrestige", function()
        local playerData_SetWM_ConfMsg = language["playerData_AddPrestige_ConfMsg"]
        local addingValue = net.ReadBool()
        local steamid = net.ReadString()
        local amount = net.ReadString()
        local newMoney = net.ReadString()
        
        if addingValue then
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(69, 186, 26), playerData_SetWM_ConfMsg[2], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        else
            chat.AddText(Color(255, 255, 255), playerData_SetWM_ConfMsg[1], Color(255, 0, 0), playerData_SetWM_ConfMsg[3], Color(0, 135, 245), amount, Color(255, 255, 255), playerData_SetWM_ConfMsg[4], Color(0, 135, 245), playerData_SetWM_ConfMsg[5], Color(255, 255, 255), playerData_SetWM_ConfMsg[6], Color(120, 66, 245), steamid, Color(255, 255, 255), playerData_SetWM_ConfMsg[7], Color(69, 186, 26), newMoney, Color(255, 255, 255), playerData_SetWM_ConfMsg[8], Color(0, 135, 245), playerData_SetWM_ConfMsg[9], Color(255, 255, 255), playerData_SetWM_ConfMsg[10])
        end

    end)

    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_NotEnoughToBuyAnswer", function()
        local msg = language["tycoonMenu_waterMoneyshop_NotEnoughToBuy"]
        chat.AddText(Color(255, 255, 255), msg[1], Color(255, 0, 0), msg[2], Color(255, 255, 255), msg[3], Color(0, 135, 245, 255), msg[4], Color(255, 255, 255), msg[5])
    end)

    net.Receive("NAP_TYCOON_WP_WaterMoneyShop_SpawnLimitReachedAnswer", function()
        local msg = language["tycoonMenu_waterMoneyshop_BuyLimitReached"]
        chat.AddText(Color(255, 255, 255), msg)
    end)

    net.Receive("NAP_TYCOON_WP_WaterGeneratoreDestroyed_Warning", function()
        local nameOfEntity = net.ReadString()
        local msg = language["name_nap_tycoon_wp_watergenerator_destroyed_warning"]
        chat.AddText(Color(255, 255, 255), msg[1], Color(0, 135, 245), nameOfEntity, Color(255, 0, 0), msg[2])
    end)

    --  = {"Vous avez ", "détruit ", "un ", ". Vous recevez donc ", "WaterMoney !"},

    net.Receive("NAP_TYCOON_WP_WaterGeneratoreDestroyed_Reward", function()
        local nameOfEntity = net.ReadString()
        local priceOfEntity = net.ReadString()
        local msg = language["name_nap_tycoon_wp_watergenerator_destroyed_reward"]
        chat.AddText(Color(255, 255, 255), msg[1], Color(255, 0, 0), msg[2], Color(255, 255, 255), msg[3], Color(0, 135, 245), nameOfEntity, Color(255, 255, 255), msg[4], Color(0, 255, 0), priceOfEntity, Color(255, 255, 255), msg[5])
    end)


end