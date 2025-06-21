-- Création de la table si elle n'existe pas
local function CreateDatabase()
    sql.Query([[CREATE TABLE IF NOT EXISTS nap_tycoon_wp_db (
        SteamID TEXT PRIMARY KEY,
        WaterMoney DOUBLE DEFAULT 0,
        WaterPoints DOUBLE DEFAULT 0,
        PrestigePoints INTEGER DEFAULT 0,
        Prestige INTEGER DEFAULT 0
    )]])
end

-- Fonction pour réinitialiser la base de données
local function ResetDatabase()
    sql.Query("DROP TABLE IF EXISTS nap_tycoon_wp_db")
    print("[Nap Tycoon WP] [Database] "..NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["database_reset"])
    CreateDatabase()
end

-- Fonction pour afficher tout le contenu de la base de données
local function PrintDatabase()
    local results = sql.Query("SELECT * FROM nap_tycoon_wp_db")
    
    if not results or #results == 0 then
        print("[Nap Tycoon WP] La base de données est vide.")
        return
    end

    print("[Nap Tycoon WP] Contenu de la base de données :")
    for _, row in ipairs(results) do
        print(string.format("SteamID64 : %s | WaterMoney : %s | WaterPoints : %s | PrestigePoints : %s | Prestige : %s",
            row.SteamID, row.WaterMoney, row.WaterPoints, row.PrestigePoints, row.Prestige))
    end
end

-- Ajout d'une commande console pour afficher la base de données
concommand.Add("nap_tycoon_wp_print_database", function(ply)
    if ply:SteamID64() == NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig.WhtielistSteamID then        
        PrintDatabase()
        return
    else
        net.Start("NAP_TYCOON_WP_WrongPermission")
        net.Send(ply)
        return
    end
end)

-- Ajout de la commande console pour réinitialiser la base de données
concommand.Add("nap_tycoon_wp_db_reset_database", function(ply)
    if ply:SteamID64() == NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig.WhtielistSteamID then        
        ResetDatabase()
        net.Start("NAP_TYCOON_WP_ResetDB_Confirmation")
        net.Send(ply)

        ply:SetNWInt("WaterMoney", 0)
        ply:SetNWInt("WaterPoints", 0)
        ply:SetNWInt("PrestigePoints", 0)
        ply:SetNWInt("Prestige", 0)

        return
    else
        net.Start("NAP_TYCOON_WP_WrongPermission")
        net.Send(ply)
        return
    end
    
end)

-- Chargement des données d'un joueur
local function LoadPlayerData(ply)
    local steamID = ply:SteamID64()
    local result = sql.QueryRow("SELECT * FROM nap_tycoon_wp_db WHERE SteamID = '" .. steamID .. "'")

    if not result then
        -- Si aucune donnée n'est trouvée, insérer les valeurs par défaut
        sql.Query("INSERT INTO nap_tycoon_wp_db (SteamID, WaterMoney, WaterPoints, PrestigePoints, Prestige) VALUES ('" .. steamID .. "', 0, 0, 0, 0)")
        result = {
            SteamID = steamID,
            WaterMoney = 0,
            WaterPoints = 0,
            PrestigePoints = 0,
            Prestige = 0
        }
    end

    ply:SetNWInt("WaterMoney", tonumber(result.WaterMoney))
    ply:SetNWInt("WaterPoints", tonumber(result.WaterPoints))
    ply:SetNWInt("PrestigePoints", tonumber(result.PrestigePoints))
    ply:SetNWInt("Prestige", tonumber(result.Prestige))
end

-- Sauvegarde des données d'un joueur
local function SavePlayerData(ply)
    local steamID = ply:SteamID64()
    local WaterMoney = ply:GetNWInt("WaterMoney")
    local WaterPoints = ply:GetNWInt("WaterPoints")
    local PrestigePoints = ply:GetNWInt("PrestigePoints")
    local Prestige = ply:GetNWInt("Prestige")

    sql.Query(string.format("UPDATE nap_tycoon_wp_db SET WaterMoney = "..WaterMoney..", WaterPoints = "..WaterPoints..", PrestigePoints = "..PrestigePoints..", Prestige = "..Prestige.." WHERE SteamID = '"..steamID.."'"))
end

function GetInformations(steamID, variable)
    if variable != "SteamID" and variable != "WaterMoney" and variable != "WaterPoints" and variable != "PrestigePoints" and variable != "Prestige" then return "Variable inconnue" end
    local variableToReturn = sql.QueryRow("SELECT "..variable.." FROM nap_tycoon_wp_db WHERE SteamID = '" .. steamID .. "'")
    return tonumber(variableToReturn["WaterMoney"])
end

-- Événements joueur
hook.Add("PlayerInitialSpawn", "NapTycoon_LoadPlayerData", function(ply)
    LoadPlayerData(ply)
end)

hook.Add("PlayerDisconnected", "NapTycoon_SavePlayerData", function(ply)
    SavePlayerData(ply)
end)

-- -------------------------------------------------------------------------------
--                 Fonctions gestions des données
-- -------------------------------------------------------------------------------
-- Fonction pour définir la valeur de WaterMoney
function SetWaterMoney(steamID, value)
    if tonumber(value) <= 0 then
        value = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET WaterMoney = " .. tonumber(value) .. " WHERE SteamID = '" .. steamID .. "'")
    local ply = player.GetBySteamID64(steamID)
    ply:SetNWInt("WaterMoney", tonumber(value))
    return tonumber(value)
end

-- Fonction pour ajouter/retirer la valeur de WaterMoney
-- (Si valeur négative rentrée en paramètre alors retrait de la valeur en paramètre)
function AddWaterMoney(steamID, value)
    local ply = player.GetBySteamID64(steamID)
    local newValue = ply:GetNWInt("WaterMoney") + value
    if newValue <= 0 then
        newValue = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET WaterMoney = " .. tonumber(newValue) .. " WHERE SteamID = '" .. steamID .. "'")
    ply:SetNWInt("WaterMoney", tonumber(newValue))
    return tonumber(newValue)
end

-- Fonction pour définir la valeur de WaterPoints
function SetWaterPoints(steamID, value)
    if tonumber(value) <= 0 then
        value = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET WaterPoints = " .. tonumber(value) .. " WHERE SteamID = '" .. steamID .. "'")
    local ply = player.GetBySteamID64(steamID)
    ply:SetNWInt("WaterPoints", tonumber(value))
    return tonumber(value)
end

-- Fonction pour ajouter/retirer la valeur de WaterPoints
-- (Si valeur négative rentrée en paramètre alors retrait de la valeur en paramètre)
function AddWaterPoints(steamID, value)
    local ply = player.GetBySteamID64(steamID)
    local newValue = ply:GetNWInt("WaterPoints") + tonumber(value)
    if newValue <= 0 then
        newValue = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET WaterPoints = " .. tonumber(newValue) .. " WHERE SteamID = '" .. steamID .. "'")
    ply:SetNWInt("WaterPoints", tonumber(newValue))
    return tonumber(newValue)
end

-- Fonction pour modifier la valeur de PrestigePoints
function SetPrestigePoints(steamID, value)
    if tonumber(value) <= 0 then
        value = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET PrestigePoints = " .. tonumber(value) .. " WHERE SteamID = '" .. steamID .. "'")
    local ply = player.GetBySteamID64(steamID)
    ply:SetNWInt("PrestigePoints", tonumber(value))
    return tonumber(value)
end

-- Fonction pour ajouter/retirer la valeur de PrestigePoints
-- (Si valeur négative rentrée en paramètre alors retrait de la valeur en paramètre)
function AddPrestigePoints(steamID, value)
    local ply = player.GetBySteamID64(steamID)
    local newValue = ply:GetNWInt("PrestigePoints") + tonumber(value)
    if newValue <= 0 then
        newValue = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET PrestigePoints = " .. tonumber(newValue) .. " WHERE SteamID = '" .. steamID .. "'")
    ply:SetNWInt("PrestigePoints", tonumber(newValue))
    return tonumber(newValue)
end

-- Fonction pour modifier la valeur de Prestige
function SetPrestige(steamID, value)
    if tonumber(value) <= 0 then
        value = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET Prestige = " .. tonumber(value) .. " WHERE SteamID = '" .. steamID .. "'")
    local ply = player.GetBySteamID64(steamID)
    ply:SetNWInt("Prestige", tonumber(value))
    return tonumber(value)
end

-- Fonction pour ajouter/retirer la valeur de Prestige
-- (Si valeur négative rentrée en paramètre alors retrait de la valeur en paramètre)
function AddPrestige(steamID, value)
    local ply = player.GetBySteamID64(steamID)
    local newValue = ply:GetNWInt("Prestige") + tonumber(value)
    if newValue <= 0 then
        newValue = 0
    end
    sql.Query("UPDATE nap_tycoon_wp_db SET Prestige = " .. tonumber(newValue) .. " WHERE SteamID = '" .. steamID .. "'")
    local ply = player.GetBySteamID64(steamID)
    ply:SetNWInt("Prestige", tonumber(newValue))
    return tonumber(newValue)
end

CreateDatabase()