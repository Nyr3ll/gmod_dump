-- //////////////////////////////////////////////////////////////////////////////
--
--                  Here is the most important config part
--
--    Take note, certain configurations need a server reboot to be applied
--
-- //////////////////////////////////////////////////////////////////////////////
-- 
-- DEBUG Commands (Only available by "NAP_MANUF.Config.Debug_AllowedRanksDebugCommands" ranks AND if you have set "NAP_MANUF.Config.DebugMod" to true)
-- !nap_ad_sc_setCapacity <value>       Change the "MaxCapacity" of a "Storage Crate" (only until the crate got removed)
-- !nap_ad_debug_menu                   Open the menu base UI
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 


-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
-- //////////////////////////////////////////////////////////////////////////////
-- -------------------------------------------------------------------------------
--                 GENERAL CONFIG (Gamemode, language, debug_mod, ...)
-- -------------------------------------------------------------------------------

-- Can be set to "true" or "false". Only show some information on screen, console, ...
NAP_MANUF.Config.DebugMod = "true"

-- Define the language
-- Available languages : "fr", "eng"
NAP_MANUF_LANG.Language = "fr"


-- List of "ulx" rank that are allowed to use DEBUG COMMAND such as "!bones", "!applyBoneManip", "!nap_waila"
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
NAP_MANUF.Config.Debug_AllowedRanksDebugCommands = {"superadmin", "admin"}
NAP_MANUF.Config.Debug_OpenMenuUICommand = "!nap_debug_menu"

-- ##### TO DO
-- If you purchased "Billy's Logs" you can turn this on "true" to get some extra logs for this addon
-- Billy's logs addon : https://www.gmodstore.com/market/view/billys-logs
NAP_MANUF.Config.BillysLogsCompatibilite = false

--[[          YOUTUBE BUTTON          ]]
-- If you don't have Youtube channel for your server you can change the button text for whatever you want
NAP_MANUF.Config.YoutubeChannelButton = "Youtube channel"
-- You can put your Youtube Channel if you made one for the server else you can put any other link (relative to the text button right above)
NAP_MANUF.Config.YoutubeChannelLink = "https://www.youtube.com/"

--[[          DISCORD BUTTON          ]]
-- If you don't have Discord for your server you can change the button text for whatever you want
NAP_MANUF.Config.DiscordButtonButton = "Discord"
-- You cna put your Discord link if you made one for the server else you can put any other link (relative to the text button right above)
NAP_MANUF.Config.DiscordLink = "https://discord.com/"

-- -------------------------------------------------------------------------------
--                      VGUI General Config (Colors, menu visual, ...)
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
--                      Tools config
-- -------------------------------------------------------------------------------

NAP_MANUF.Config.Axe_CanDamageToPlayer = false
NAP_MANUF.Config.Axe_DamageToPlayer = 0
NAP_MANUF.Config.Axe_DamageToTree = 20


-- -------------------------------------------------------------------------------
--                      Enities configuration
-- -------------------------------------------------------------------------------


NAP_MANUF.Config.GeneratorT1_ProcessTime = 50
NAP_MANUF.Config.GeneratorT1_MaxEnergyCapacity = 1000
NAP_MANUF.Config.GeneratorT1_EnergyProduction = 100
NAP_MANUF.Config.GeneratorT1_MaxWoodCapacity = 150
NAP_MANUF.Config.GeneratorT1_WoodConsumption = 1 -- Consumption per sec

NAP_MANUF.Config.EnergyStorage_MaxEnergyCapacity = 5000

NAP_MANUF.Config.DebugBaseItem_ProductDespawnAfterTime = true
NAP_MANUF.Config.DebugBaseItem_ProcessTime = 20
NAP_MANUF.Config.DebugBaseItem_BaseCost = 1000
NAP_MANUF.Config.DebugBaseItem_MaxEnergyCapacity = 1000
NAP_MANUF.Config.DebugBaseItem_EnergyConsumption = 4   -- (Unit of power used per second)

NAP_MANUF.Config.Compressor_ProductDespawnAfterTime = true
NAP_MANUF.Config.Compressor_ProcessTime = 20
NAP_MANUF.Config.Compressor_BaseCost = 1000
NAP_MANUF.Config.Compressor_MaxEnergyCapacity = 1000
NAP_MANUF.Config.Compressor_EnergyConsumption = 4   -- (Unit of power used per second)

NAP_MANUF.Config.MotorOil_DefaultValue = 500
NAP_MANUF.Config.Tree_Health = 20               -- Determine how many hit you have to make with the axe to harvest the tree
NAP_MANUF.Config.Tree_TimeBeforeRespawn = 10    -- Time in second
NAP_MANUF.Config.WoodLog_DefaultSellPrice = 20  -- Dollar (No use for now)
NAP_MANUF.Config.WoodLog_DefaultBurnValue = 2   -- Use to fill Generators


-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
NAP_MANUF.Config.CollisionType = {
    ["DebugBaseItem"] = 0,
    ["Compressor"] = 0,
    ["MotorOil"] = 0,
    ["Tree"] = 0,
    ["WoodLog"] = 0,
    ["EnergyStorage"] = 0,
    ["GeneratorT1"] = 0,
}

NAP_MANUF.Config.WhitelistedTreeModel = {

    {
        ModelOfTree = "models/props/de_inferno/tree_small.mdl",
        ModelOfTheLog = {"models/props_docks/channelmarker02b_chunk01c.mdl"},
    },
    {
        ModelOfTree = "models/props/de_inferno/tree_large.mdl",
        ModelOfTheLog = {"models/props_docks/channelmarker02b_chunk01c.mdl"},
    },
    {
        ModelOfTree = "models/props_foliage/tree_springers_01a.mdl",
        ModelOfTheLog = {"models/props_docks/channelmarker02b_chunk01d.mdl", "models/props_docks/channelmarker_gib01.mdl"},
    },
    {
        ModelOfTree = "models/props_foliage/tree_springers_01a-lod.mdl",
        ModelOfTheLog = {"models/props_docks/channelmarker02b_chunk01d.mdl", "models/props_docks/channelmarker_gib01.mdl"},
    },
    {
        ModelOfTree = "models/props_foliage/tree_poplar_01.mdl",
        ModelOfTheLog = {"models/props_docks/channelmarker02b_chunk01d.mdl", "models/props_docks/channelmarker_gib01.mdl"},
    },
}