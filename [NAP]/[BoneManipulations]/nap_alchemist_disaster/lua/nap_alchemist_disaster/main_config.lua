-- //////////////////////////////////////////////////////////////////////////////
--
--                  Here is the most important config part
--
--    Take note, certain configurations need a server reboot to be applied
--
-- //////////////////////////////////////////////////////////////////////////////

-- -------------------------------------------------------------------------------
--                 GENERAL CONFIG (Gamemode, language, debug_mod, ...)
-- -------------------------------------------------------------------------------

-- Can be set to "true" or "false". Only show some information on screen, console, ...
NAP_ALCH_DISASTER.Config.DebugMod = false

-- Define the language
-- Available languages : "fr", "eng"
NAP_ALCH_DISASTER_LANG.Language = "fr"


-- List of "ulx" rank that are allowed to use DEBUG COMMAND such as "!bones", "!applyBoneManip", "!nap_waila"
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
NAP_ALCH_DISASTER.Config.DebugCommandRank = {"superadmin", "admin"}

-- -------------------------------------------------------------------------------
--                      Enities configuration
-- -------------------------------------------------------------------------------

-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
NAP_ALCH_DISASTER.Config.CollisionType = 0