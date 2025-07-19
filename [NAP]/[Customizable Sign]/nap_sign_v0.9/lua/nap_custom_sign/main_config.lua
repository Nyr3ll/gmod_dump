-- //////////////////////////////////////////////////////////////////////////////
--
--                  Here is the most important config part
--
--    Take note, certain configurations need a server reboot to be applied
--
-- //////////////////////////////////////////////////////////////////////////////
--
-- DEBUG Commands (Only available for "NAP_CUSTOM_SIGN.Config.AllowedRanksCmd" ranks)
-- !nap_cs_save       Save every sign which are on the map in a .txt file linked to the actual map.
-- !nap_cs_load       Remove all "sign" from the map and load every save sign (only saved sign by the commad "!nap_cs_save")
--
-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
-- //////////////////////////////////////////////////////////////////////////////


-- -------------------------------------------------------------------------------
--                 GENERAL CONFIG (Gamemode, language, debug_mod)
-- -------------------------------------------------------------------------------

-- Define the language
-- Available languages : "french", "english"
NAP_CUSTOM_SIGN.Config.Language = "english"

-- If set to "true" show every entity of the addon & unlock some "debug" features such as some "print" in console ...
-- I suggest you leave it on "false" if you want to prohibit the administrator from "cheating"
NAP_CUSTOM_SIGN.Config.DebugMod = false

-- List of "ulx" rank that are allowed to use DEBUG COMMAND such as "!nap_waila"
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
NAP_CUSTOM_SIGN.Config.AllowedRanksCmd = {"superadmin"}

-- Define the distance to show or hide the UI elements on sign. More the distance is higher and more client has to load things.
-- Suggestion : between 500~4000 depending on your need.
-- 500 is for a really short distance showing (in a building, corridor, ...)
-- 4000 is for a far away showing (in the street, side of a road, ...)
NAP_CUSTOM_SIGN.Config.ShowDistance = 2000

-- Mainly used to be sure a player just see a "plate" with a material when too far away to see text on the sign
NAP_CUSTOM_SIGN.Config.DefaultMaterial = "models/debug/debugwhite"







-- //////////////////////////////////////////////////////////////////////////////
--                 DO NOT TOUCH THINGS BELOW HERE
--              IF YOU DON'T KNOW WHAT YOU ARE DOING
--          ANY MODIFICATION DOWN HERE CAN BREAK THIS ADDON
-- //////////////////////////////////////////////////////////////////////////////

NAP_CUSTOM_SIGN.Config.CustomSents = {
    "sent_nap_sign_075x2", 
    "sent_nap_sign_075x3",
    "sent_nap_sign_1x2", 
    "sent_nap_sign_1x3",
    "sent_nap_sign_1x4", 
    "sent_nap_sign_2x2",
    "sent_nap_sign_2x3", 
    "sent_nap_sign_2x4",
    "sent_nap_sign_3x3", 
    "sent_nap_sign_3x4",
    "sent_nap_sign_4x4",
}