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
NAP_TEMPLATE.Config.Language = "french"
-- Define the money sign
-- Available sign : Whatever you want as long as it's a "string"
NAP_TEMPLATE.Config.MoneySign = "€"

-- If set to "true" show every entity of the addon
-- I suggest you leave it on "false" if you want to prohibit the administrator from "cheating" by giving himself ingredients recipes
NAP_TEMPLATE.Config.General.DebugMod = true

-- Manage which gamemode you are running
-- Certains functionality are disabled by default or changed depending on the gamemode
-- 0 (by default) Sandbox
-- 1 DarkRP
-- 2 Basewars
NAP_TEMPLATE.Config.General.Gamemode = 0