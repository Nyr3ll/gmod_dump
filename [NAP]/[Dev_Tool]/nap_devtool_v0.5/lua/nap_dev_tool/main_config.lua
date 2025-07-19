-- //////////////////////////////////////////////////////////////////////////////
--
--                  Here is the most important config part
--
--    Take note, certain configurations need a server reboot to be applied
-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
-- //////////////////////////////////////////////////////////////////////////////


-- -------------------------------------------------------------------------------
--                 GENERAL CONFIG (Gamemode, language, debug_mod)
-- -------------------------------------------------------------------------------

-- Define the language
-- Available languages : "french", "english"
NAP_DEVTOOL.Config.Language = "english"
-- Define the money sign
-- Available sign : Whatever you want as long as it's a "string"
NAP_DEVTOOL.Config.MoneySign = "€"

-- If set to "true" show every entity of the addon
-- I suggest you leave it on "false" if you want to prohibit the administrator from "cheating" by giving himself ingredients recipes
NAP_DEVTOOL.Config.General.DebugMod = true

-- Manage which gamemode you are running
-- Certains functionality are disabled by default or changed depending on the gamemode
-- 0 (by default) Sandbox
-- 1 DarkRP
-- 2 Basewars
NAP_DEVTOOL.Config.General.Gamemode = 0

-- List of "ulx" rank that are allowed to use DEBUG COMMAND such as "!waila", "!model"
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
NAP_DEVTOOL.Config.AllowedRanksDebugCommands = {"superadmin", "admin"}

-- List of "ulx" rank that are allowed to use "Teleport" features
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
NAP_DEVTOOL.Config.AllowedRanksTpFeatures = {"superadmin", "admin", "dev"}

-- This command can be change as you want. This is the command to open the menu to buy with WaterMoney & WaterPoints all configured objects
NAP_DEVTOOL.Config.MenuCommand = "!devtool"

--[[          YOUTUBE BUTTON          ]]
-- If you don't have Youtube channel for your server you can change the button text for whatever you want
NAP_DEVTOOL.Config.YoutubeChannelButton = "Youtube channel"
-- You can put your Youtube Channel if you made one for the server else you can put any other link (relative to the text button right above)
NAP_DEVTOOL.Config.YoutubeChannelLink = "https://www.youtube.com/"

--[[          DISCORD BUTTON          ]]
-- If you don't have Discord for your server you can change the button text for whatever you want
NAP_DEVTOOL.Config.DiscordButtonButton = "Discord"
-- You cna put your Discord link if you made one for the server else you can put any other link (relative to the text button right above)
NAP_DEVTOOL.Config.DiscordLink = "https://discord.com/"

NAP_DEVTOOL.Config.DestinationList = {

    {
        Name = "Spawn",
        x = -1500,
        y = 500,
        z = -11995,
    },
    {
        Name = "Car dealer",
        x = -293,
        y = 1653,
        z = -12009,
    },
    {
        Name = "Other exemple",
        x = -331,
        y = -2649,
        z = -12800,
    },
}