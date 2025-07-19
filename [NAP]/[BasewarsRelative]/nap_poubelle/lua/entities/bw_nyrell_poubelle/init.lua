-- ///////////////////////
-- /// Initialization ///
-- /////////////////////
-- Hook to initialize the "searching cooldown" when player spawn
hook.Add("PlayerInitialSpawn", "InitializeStaffMode", function(player)
    player:SetNWFloat("cooldownBeforeSearch", 0)
    print("[POUBELLES] "..player:Name().." doit encore attendre "..player:GetNWFloat("cooldownBeforeSearch").."s avant de pouvoir fouiller une autre poubelle !")
end)

-- //////////////////////
-- /// BLogs section ///
-- ////////////////////
-- That's a module to add some logs (useless if you are NOT using "BLogs" addon)
local UseBillyLogs = BW_NYRELL.PoubelleConfig.UseBillyLogs
if UseBillyLogs then
    local MODULE = GAS.Logging:MODULE()

    MODULE.Category = "Poubelles"
    MODULE.Name = "Loot poubelles"
    MODULE.Colour = Color(255, 157, 0, 255)

    local function createTheLog(ply, loot, lootType)

        MODULE:Setup(function()
            MODULE:Hook("MakingLog_CustomName", "lootPoubelleLog", MODULE:Log("{1} a loot {2} {3} dans une poubelle", GAS.Logging:Highlight(ply), GAS.Logging:Highlight(loot), GAS.Logging:Highlight(lootType)))
        end)
        
        GAS.Logging:AddModule(MODULE)

    end

    GAS.Logging:AddModule(MODULE)
end

-- //////////////////
-- /// Main code ///
-- ////////////////
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Normal initilization of entity
function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetNWBool("HasBeenSearched", self.HasBeenSearched)
    self.lastInteract = 0

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

-- Manage to destroy Timer of a disconnected player
local function DisconnectedPlayer(steamid64)
    timer.Remove("CooldownTimer_"..steamid64)
end

-- Manage the player interactions
function ENT:Use(activator, caller)
    local currentTime = CurTime()
    if currentTime - self.lastInteract < 1 then
        return
    end

    self.lastInteract = currentTime

    if caller:GetNWFloat("cooldownBeforeSearch") <= 0 then

        if self:GetNWBool("HasBeenSearched") then
            net.Start("BWNYRELL_FoundSomthings_InTrash")
                net.WriteBool(true)
                net.WriteFloat(self:GetTimeRemaining())
                net.WriteBool(false)
                net.WriteString("Rien")
                net.WriteString("")
                net.WriteFloat(0)
                net.Send(caller)
            return
        end

        if IsValid(caller) and caller:IsPlayer() then
            net.Start("BWNYRELL_StartLoadingBar")
            net.WriteEntity(self)
            net.Send(caller)
        end
    
    else

        caller:ChatPrint("Vous devez attendre {red "..caller:GetNWFloat("cooldownBeforeSearch").."}s avant de fouiller une autre poubelle")

    end
end

-- Net message for loading bar
net.Receive("BWNYRELL_StopLoadingBar", function(len, ply)
    net.Start("BWNYRELL_StopLoadingBar")
    net.Send(ply)
end)

-- Net message when searching is completed by a player
net.Receive("BWNYRELL_FinishLoading", function(len, ply)

    ply:SetNWFloat("cooldownBeforeSearch", BW_NYRELL.PoubelleConfig.CooldownPerPlayer)

    timer.Create("CooldownTimer_"..ply:SteamID64(), 1, BW_NYRELL.PoubelleConfig.CooldownPerPlayer, function()
        if not ply:IsPlayer() then return DisconnectedPlayer(ply:SteamID64()) end
        ply:SetNWFloat("cooldownBeforeSearch", ply:GetNWFloat("cooldownBeforeSearch") - 1)
        --print("--------------------------------------------------\n> DEBUG POUBELLE\n> Nom du cooldowntimer : \"CooldownTimer_"..ply:SteamID64().."\"\n> Temps restant : "..ply:GetNWFloat("cooldownBeforeSearch").."\n--------------------------------------------------")
        if ply:GetNWFloat("cooldownBeforeSearch") <= 0 then
            print("[POUBELLES] "..ply:Name().." peut maintenant fouiller une poubelle")
        end
    end)

    local entity = net.ReadEntity()
    if not IsValid(entity) then return end

    if entity:GetNWBool("HasBeenSearched") then
        net.Start("BWNYRELL_FoundSomthings_InTrash")
            net.WriteBool(true)
            net.WriteFloat(entity:GetTimeRemaining())
            net.WriteBool(false)
            net.WriteString("Rien")
            net.WriteString("")
            net.WriteFloat(0)
            net.Send(ply)
        return
    end

    entity:SetNWBool("HasBeenSearched", true)
    entity:SetModel(entity.OpenedModel)

    -- Manage the loot to give to the player.
    -- Configurable in "nap_poubelle/lua/autorun/config"
    local loots = entity.Loots
    if loots then
        local chance = math.random(1, 100)

        if chance <= 90 then
            local lootTypeChoosen = math.random(1, 100)
            local typeOfLoot = "Rien"
            local thingFound = "Rien"
            local percentageOfAncienValue = 0

            if lootTypeChoosen >= 0 and lootTypeChoosen <= BW_NYRELL.PoubelleConfig.Percentage["Money"] then
                typeOfLoot = "Money"
                local moneyOwnedLot = math.random(1, 100)
                local moneyOwnedValue = 0

                if moneyOwnedLot >= 0 and moneyOwnedLot <= BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] then
                    moneyOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][2]
                elseif moneyOwnedLot > BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] and moneyOwnedLot <= (BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] + BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][1]) then
                    moneyOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][2]
                elseif moneyOwnedLot > (BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] + BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][1]) and moneyOwnedLot <= 100 then
                    moneyOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][3][2]
                end

                percentageOfAncienValue = moneyOwnedValue
                local actualMoney = ply:GetMoney()
                if actualMoney <= 0 then
                    ply:GiveMoney(BW_NYRELL.PoubelleConfig.DefaultMoney)
                    thingFound = tostring(BW_NYRELL.PoubelleConfig.DefaultMoney)
                else
                    ply:GiveMoney(actualMoney * moneyOwnedValue)
                    thingFound = tostring(math.Round(actualMoney * moneyOwnedValue, 0))
                end

                print(tostring(ply:Name().." a trouvé "..thingFound.." $ dans une poubelle. Il doit attendre "..ply:GetNWFloat("cooldownBeforeSearch").."s avant de pouvoir fouiller une autre poubelle."))
                if UseBillyLogs then
                    createTheLog(ply:Name(), thingFound, "$")
                end
            elseif lootTypeChoosen > BW_NYRELL.PoubelleConfig.Percentage["Money"] and lootTypeChoosen <= (BW_NYRELL.PoubelleConfig.Percentage["Exp"] + BW_NYRELL.PoubelleConfig.Percentage["Money"]) then
                typeOfLoot = "Exp"
                local expOwnedLot = math.random(1, 100)
                local expOwnedValue = 0

                if expOwnedLot >= 0 and expOwnedLot <= BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] then
                    expOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][2]
                elseif expOwnedLot > BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] and expOwnedLot <= (BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] + BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][1]) then
                    expOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][2]
                elseif expOwnedLot > (BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][1][1] + BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][2][1]) and expOwnedLot <= 100 then
                    expOwnedValue = BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][3][2]
                end

                percentageOfAncienValue = expOwnedValue
                local nextLevel = ply:GetXPNextLevel()
                ply:AddXP(nextLevel * expOwnedValue)
                thingFound = tostring(math.Round(nextLevel * expOwnedValue, 0))

                print(tostring(ply:Name().." a trouvé "..thingFound.." xp dans une poubelle. Il doit attendre "..ply:GetNWFloat("cooldownBeforeSearch").."s avant de pouvoir fouiller une autre poubelle."))
                if UseBillyLogs then
                    createTheLog(ply:Name(), thingFound, "xp")
                end

            elseif lootTypeChoosen > (BW_NYRELL.PoubelleConfig.Percentage["Exp"] + BW_NYRELL.PoubelleConfig.Percentage["Money"]) and lootTypeChoosen <= 100 then
                typeOfLoot = "Weapon"
                local weaponLooted = math.random(1, #BW_NYRELL.PoubelleConfig.Loots[typeOfLoot])
                local weaponInfo = weapons.Get(BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][weaponLooted])
                ply:Give(BW_NYRELL.PoubelleConfig.Loots[typeOfLoot][weaponLooted])
                thingFound = tostring(weaponInfo.PrintName)

                print(tostring(ply:Name().." a trouvé "..thingFound.." dans une poubelle. Il doit attendre "..ply:GetNWFloat("cooldownBeforeSearch").."s avant de pouvoir fouiller une autre poubelle."))
                if UseBillyLogs then
                    createTheLog(ply:Name(), thingFound, "")
                end
            end

            net.Start("BWNYRELL_FoundSomthings_InTrash")
            net.WriteBool(false)
            net.WriteFloat(0)
            net.WriteBool(true)
            net.WriteString(thingFound)
            net.WriteString(typeOfLoot)
            net.WriteFloat(percentageOfAncienValue)
            net.Send(ply)
        else
            net.Start("BWNYRELL_FoundSomthings_InTrash")
            net.WriteBool(false)
            net.WriteFloat(0)
            net.WriteBool(false)
            net.WriteString("Rien")
            net.Send(ply)
        end

        entity:SetTimeRemaining(entity.CooldownAfterSearch)

        timer.Create("CooldownTimer_"..entity:EntIndex(), 1, entity.CooldownAfterSearch, function()
            if not IsValid(entity) then return end
            entity:SetTimeRemaining(entity:GetTimeRemaining() - 1)
        end)

        timer.Simple(entity.CooldownAfterSearch, function()
            if IsValid(entity) then
                entity:SetNWBool("HasBeenSearched", false)
                entity:SetModel(entity.Model)
                entity:SetTimeRemaining(entity.CooldownAfterSearch)
            end
        end)
    end
end)

function ENT:OnRemove()
    timer.Remove("CooldownTimer_"..self:EntIndex())
end


