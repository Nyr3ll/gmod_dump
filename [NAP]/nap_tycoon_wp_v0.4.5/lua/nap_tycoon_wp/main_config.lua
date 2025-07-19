-- //////////////////////////////////////////////////////////////////////////////
--
--                  Here is the most important config part
--
--    Take note, certain configurations need a server reboot to be applied

-- Every player's data manipulation commands 
-- !nap_setwatermoney <steamid64> <value>
-- !nap_addwatermoney <steamid64> <value>
-- !nap_setwaterpoints <steamid64> <value>
-- !nap_addwaterpoints <steamid64> <value>
-- !nap_addprestigepoints <steamid64> <value>
-- !nap_setprestigepoints <steamid64> <value>
-- !nap_addprestigepoints <steamid64> <value>
-- !nap_setprestige <steamid64> <value>
-- !nap_addprestige <steamid64> <value>

-- Consol command :
-- 
-- "nap_tycoon_wp_db_reset_database" reset the database. Server need a restart after this command.
-- "nap_tycoon_wp_print_database " print the database in the console.

-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- -------------------------------------------------------------------------------
--                 GENERAL CONFIG (Gamemode, language, debug_mod, ...)
-- -------------------------------------------------------------------------------

-- Define the language
-- Available languages : "fr", "eng"
NAP_TYCOON_WP_LANGUAGES.Language = "fr"

-- Steam ID Whitelisted to reset the database of the server (ONLY RELATIVE TO PLAYER DATA FOR THIS ADDON )
-- Only one steam ID 64 can be Whitelisted. (I suggest to put the server's owner steamid64 to be sure nobody can reset database)
-- This must be SteamID64 must look like this "91567394446687197"
NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig.WhtielistSteamID = "76561198216637607"

-- List of "ulx" rank that are allowed to use player's data manipulation
-- This must look like this : {"superadmin", "seniormoderator", "dev", "admin"}
-- Note : Those ranks are NOT allowed to see or reset databse. They only can do command to set/add watermoney, waterpoints, prestiges, ...
NAP_TYCOON_WATERPRODUCTION.Config.DatabaseConfig.PlayerDataEditing = {"superadmin"}

-- If you purchased "Billy's Logs" you can turn this on "true" to get some extra logs for this addon
-- Billy's logs addon : https://www.gmodstore.com/market/view/billys-logs
NAP_TYCOON_WATERPRODUCTION.Config.BillysLogsCompatibilite = false

-- This command can be change as you want. This is the command to open the menu to buy with WaterMoney & WaterPoints all configured objects
NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenuCommand = "!nap_tycoon"

--[[          YOUTUBE BUTTON          ]]
-- If you don't have Youtube channel for your server you can change the button text for whatever you want
NAP_TYCOON_WATERPRODUCTION.Config.YoutubeChannelButton = "Youtube channel"
-- You can put your Youtube Channel if you made one for the server else you can put any other link (relative to the text button right above)
NAP_TYCOON_WATERPRODUCTION.Config.YoutubeChannelLink = "https://www.youtube.com/"

--[[          DISCORD BUTTON          ]]
-- If you don't have Discord for your server you can change the button text for whatever you want
NAP_TYCOON_WATERPRODUCTION.Config.DiscordButtonButton = "Discord"
-- You cna put your Discord link if you made one for the server else you can put any other link (relative to the text button right above)
NAP_TYCOON_WATERPRODUCTION.Config.DiscordLink = "https://discord.com/"

-- -------------------------------------------------------------------------------
--                      VGUI General Config (Colors, menu visual, ...)
-- -------------------------------------------------------------------------------
-- How is this work ?
-- Easy :
-- "Type" must be part of the list right here : "WaterMoney Generator", "WaterPoints Generator", "Weapon", "Other Entity" (this is a entity wich is not a weapon, can be food, ...)
-- "Name" can be whatever you want
-- "ImagePath" you have to NOT CHANGE "nap_tycoon_wp/vgui/", you put the name of your image just after the last "/"
-- "Description" your description you want to put on this item
-- "Price" every price in "NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold" table are "WaterMoney" (look to other table if you want to make a other money)
-- "Limit" is the limit of a entity. For exemple you put "3" then the player can't buy more then "3"
-- "Entity" must be the "Entity class" you want to sell. To obtain it, you can "right clic" on a entity in "Props menu" -> "Copy to clipboard"
-- "NameTextColor" Is the color of the text which is displaying the name of your entity

NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold = {
    -- I suggest you to only custom "Price" and "Limit" for all "WaterGenerator" & "WaterPoints Generator"
    {
        Type = "WaterMoney Generator",
        Name = "Water Generator T1",
        ImagePath = "nap_tycoon_wp/vgui/water_generator_t1.png",
        Description = "Très lent et très peu d'HP mais c'est gratuit !",
        Price = 0,
        Limit = 3,
        Entity = "nap_tycoon_wp_watergenerator_t1",
        NameTextColor = Color(0, 135, 245),
    },
    {
        Type = "WaterMoney Generator",
        Name = "Water Generator T2",
        ImagePath = "nap_tycoon_wp/vgui/water_generator_t1.png",
        Description = "Un peu plus rapide.",
        Price = 2000,
        Limit = 3,
        Entity = "nap_tycoon_wp_watergenerator_t2",
        NameTextColor = Color(0, 135, 245),
    },
    {
        Type = "WaterMoney Generator",
        Name = "Water Generator T3",
        ImagePath = "nap_tycoon_wp/vgui/water_generator_t1.png",
        Description = "Pas mal plus rapide.",
        Price = 4000,
        Limit = 3,
        Entity = "nap_tycoon_wp_watergenerator_t3",
        NameTextColor = Color(0, 135, 245),
    },
    -- Those 2 below are exemples for weapon and "Other Entity"
    {
        Type = "Weapon",
        Name = "Poings",
        ImagePath = "nap_tycoon_wp/vgui/water_generator_t1.png",
        Description = "Des poings.",
        Price = 0,
        Limit = 1,
        Entity = "weapon_frag",
        NameTextColor = Color(0, 135, 245),
    },
    {
        Type = "Other Entity",
        Name = "Combine mine",
        ImagePath = "nap_tycoon_wp/vgui/mine.PNG",
        Description = "Pas mal plus rapide.",
        Price = 10000,
        Limit = 4,
        Entity = "combine_mine",
        NameTextColor = Color(0, 135, 245),
    },
}

-- Those parameters are applied on every WaterGenerator
-- Change the show distance for infos on top of WaterGenerators
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.ShowTextDistance = 350
-- Change colors of Health Bar for all WaterGenerator
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_FullHealth = Color(0, 255, 0, 255)        -- Between 100% & 67%
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_MiddleHealth = Color(255, 128, 0, 255)    -- Between 66% & 33%
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_LowHealth = Color(255, 0, 0, 255)         -- Between 32% & 1%

-- -------------------------------------------------------------------------------
--                      WaterMoney Generator T1
-- Those parameters are applied on "WaterGenerator T1" only
-- -------------------------------------------------------------------------------
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.RoundedBoxColor = Color(50, 50, 50, 230)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.TitleTextColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.WorkingRoundedBoxColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.HealthBarTextColor = Color(255, 255, 255, 255)

-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.HasCollision = 11
-- Time it take in second to make one "cycle" of processing
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.ProcessingTime = 10
-- Quantity of "WaterMoney" you got at the end of the processing cycle
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.WaterMoneyOutput = 20
-- If you turn "HealthModule" to "false" the health bar doesn't dispear but entites are not going to take damage
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.HealthModule = true
-- Define the number of HP for WaterGenerator T1
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.Health = 2
-- Reward the player which destroy a watergenerator T1
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.BeRewardToDestroyGenerator = true
-- Reward the player who destroy is own watergenerator T1
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT1.BeRewardToDestroyOwnedGenerator = true

-- -------------------------------------------------------------------------------
--                      WaterMoney Generator T2
-- Those parameters are applied on "WaterGenerator T2" only
-- -------------------------------------------------------------------------------
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.RoundedBoxColor = Color(50, 50, 50, 230)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.TitleTextColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.WorkingRoundedBoxColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.HealthBarTextColor = Color(255, 255, 255, 255)

-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.HasCollision = 11
-- Time it take in second to make one "cycle" of processing
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.ProcessingTime = 10
-- Quantity of "WaterMoney" you got at the end of the processing cycle
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.WaterMoneyOutput = 60
-- If you turn "HealthModule" to "false" the health bar doesn't dispear but entites are not going to take damage
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.HealthModule = true
-- Define the number of HP for WaterGenerator T1
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.Health = 2
-- Reward the player which destroy a watergenerator T2
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.BeRewardToDestroyGenerator = true
-- Reward the player who destroy is own watergenerator T2
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT2.BeRewardToDestroyOwnedGenerator = true

-- -------------------------------------------------------------------------------
--                      WaterMoney Generator T3
-- Those parameters are applied on "WaterGenerator T3" only
-- -------------------------------------------------------------------------------
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.RoundedBoxColor = Color(50, 50, 50, 230)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.TitleTextColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WorkingRoundedBoxColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HealthBarTextColor = Color(255, 255, 255, 255)

-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HasCollision = 11
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.ProcessingTime = 10
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WaterMoneyOutput = 120
-- If you turn "HealthModule" to "false" the health bar doesn't dispear but entites are not going to take damage
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HealthModule = true
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.Health = 2
-- Reward the player which destroy a watergenerator T3
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.BeRewardToDestroyGenerator = true
-- Reward the player who destroy is own watergenerator T3
NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.BeRewardToDestroyOwnedGenerator = true

-- -------------------------------------------------------------------------------
--                      WaterMoney Bank
-- Those parameters are applied on "WaterMoney Bank"" only
-- -------------------------------------------------------------------------------
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.RoundedBoxColor = Color(50, 50, 50, 230)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.TitleTextColor = Color(0, 135, 245, 255)
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HealthBarTextColor = Color(255, 255, 255, 255)

-- Choose collision type of this entitie. You have to choose one collision groupe base on the enumaration on official facepunch page down here.
-- Note : Most usefull is "0" (for normal collision) and "11" (for "No player and vehicule collision")
-- https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HasCollision = 11
-- MAXIMUM Storage : 4.294.967.295
-- MAXIMUL Storage : 2.147.483.647
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.MaximumStorageQuantity = 20000
-- If you turn "HealthModule" to "false" the health bar doesn't dispear but entites are not going to take damage
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HealthModule = true
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.Health = 50
-- Reward the player which destroy a Bank_WaterMoney
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.BeRewardToDestroyGenerator = true
-- Reward the player who destroy is own Bank_WaterMoney
NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.BeRewardToDestroyOwnedGenerator = true

