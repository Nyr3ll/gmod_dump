BW_NYRELL = BW_NYRELL or {}
BW_NYRELL.PoubelleConfig = BW_NYRELL.PoubelleConfig or {}

-- If you want to display infos in console
-- Mainly used when I was coding / dev this addon
BW_NYRELL.PoubelleConfig.DebugMode = false

-- Define if you are using "BLogs" / "Billy Logs"
BW_NYRELL.PoubelleConfig.UseBillyLogs = false

-- Define if we show the cooldown above the trash
BW_NYRELL.PoubelleConfig.ShowInformationsAbove = true

-- Define the distance from where the player is able to see info above the trash
BW_NYRELL.PoubelleConfig.ShowedInformationsDistance = 500

-- Define the background color of the loading bar (not the loading one, the background just behind)
BW_NYRELL.PoubelleConfig.LoadingBarBackgroundColor = Color(50, 50, 50, 255)

-- Define the background color of the loading bar while your are searching
BW_NYRELL.PoubelleConfig.LoadingBarProgessColor = Color(255, 145, 0, 255)

-- Define the color of the text in the loading bar
BW_NYRELL.PoubelleConfig.LoadingBarTextColor = Color(255, 255, 255, 255)

-- Define the color of the text above trash
BW_NYRELL.PoubelleConfig.ShowedInformationsTextColor = Color(255, 255, 255)

-- Define if you want to draw the shape below the trash
BW_NYRELL.PoubelleConfig.HasShapeBelow = true

-- List of all shape available. Only usefull if you set "BW_NYRELL.PoubelleConfig.HasShapeBelow" to true
-- 0 = triangle
-- 1 = square
-- 2 = pentagon
-- 3 = hexagon
-- 4 = circle
BW_NYRELL.PoubelleConfig.TypeOfShape = 4

-- Define the radius if the shape
BW_NYRELL.PoubelleConfig.ShapeRadius = 50

-- Define tickness of the border
BW_NYRELL.PoubelleConfig.ShapeBorderSize = 2

-- Define the color of the shape
BW_NYRELL.PoubelleConfig.ShapeColor = Color(255, 145, 0, 255)

-- Define the time needed to fully search the trash
-- IN SECOND
BW_NYRELL.PoubelleConfig.InteractTime = 5

-- Define the time it take for the trash to be "searchable" again for everyone
-- IN SECOND
BW_NYRELL.PoubelleConfig.CooldownAfterSearch = 120

-- Define the cooldown of a "search" for each player. If player "A" already search a trash then he has to wait "BW_NYRELL.PoubelleConfig.CooldownPerPlayer" secondes before to search a other one
-- IN SECOND
BW_NYRELL.PoubelleConfig.CooldownPerPlayer = 60

-- Define the model of the trash (you can put a "custom model" but the logic to download the custom model isn't made)
-- NOTE: Every "default" Gmod model are available.
BW_NYRELL.PoubelleConfig.Model = "models/props_junk/TrashDumpster01a.mdl"

-- Define the model when the trash is searched (If you do NOT have a model with "2 states" then put the same model on both "Model" variables)
BW_NYRELL.PoubelleConfig.OpenedModel = "models/props_junk/TrashDumpster01a.mdl"

-- Define all percentage of loot type
-- NOTE: 
--      Make sure to reach "100%"
--      Make sure to NOT change name of types (KEEP "Money", "Exp", "Weapon")
BW_NYRELL.PoubelleConfig.Percentage = {

    ["Money"] = 50,
    ["Exp"] = 45,
    ["Weapon"] = 5,

}

-- Define the default money value if the player as no money
-- NOTE: I made this cause basicly the loot of money from trash was based on player's money. You could received a certain percentage of your money. So if you has "0$" then you would received "0$".
BW_NYRELL.PoubelleConfig.DefaultMoney = 10000

-- Define loots
BW_NYRELL.PoubelleConfig.Loots = {

    ["Money"] = {

        -- NOTE: Money give is based on actual money of the player and if the player has no money, then it's giving "BW_NYRELL.PoubelleConfig.DefaultMoney" amount.
        -- Structure :
        --      Meaning : { [chance to loot], [percentage of money to give] }
        --      Range : { [1 ~ 100], [0.01 ~ 1.00] }

        {80, 0.01}, -- Exemple : This one has "80%" of drop and it's giving "1%" of the actual player money.
        {15, 0.05},
        {5, 0.10},

    },
    ["Exp"] = {

        -- NOTE: It's going to give the needed exp to reach next level and going to give a certain percentage of this amount.
        -- Exemple : Player needs "500xp" to level up and has "200xp" it's going to take a percentage of "500" NOT "200"
        -- Structure :
        --      Meaning : { [chance to loot], [percentage of money to give] }
        --      Range : { [1 ~ 100], [0.01 ~ 1.00] }

        {80, 0.01}, -- Exemple : This one has "80%" of drop and it's giving "1%" of the total exp needed to level up (it's not taking care about actual XP the player has).
        {15, 0.05},
        {5, 0.10},

    },
    ["Weapon"] = {

        -- List of all weapon you want a player can received.
        -- There is a lot of "popular" weapons addons I already put weapons in there. Remove all weapons that you do NOT use the addon.


        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=229683363
        "ak47_beast",
        "m4a1_beast",
        "tempest_smg",
        "d_slingshot",
        "m3_umbrella",
        "scout_xbow",
        "divine_flintlock",
        "l96_dragon",

        -- Addon : 
        "weapon_doritos",
        "weapon_lays2",
        "weapon_lays",
        "weapon_lays4",
        "weapon_lays3",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=316414565
        "gidzco_shrekzooka",

        -- Addon : Gmod (default weapon from H2L already, vanilla Gmod's weapon)
        "weapon_bugbait",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=128089118
        -- M9K Assault
        "m9k_winchester73",
        "m9k_ak47",
        "m9k_ak74",
        "m9k_amd65",
        "m9k_an94",
        "m9k_g36",
        "m9k_tar21",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=128091208
        -- M9K Minigun / Machine gun
        "m9k_minigun",
        "m9k_m60",
        "m9k_pkm",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=128093075
        -- M9k pistol
        "m9k_guardian",
        "m9k_colt1911",
        "m9k_sig_p229r",
        "m9k_model3russian",
        "m9k_usps",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=834520203
        -- M9k Shotgun
        "m9k_jackhammer",
        "m9k_mossberg590",
        "m9k_spas12",
        "m9k_m3",
        "m9k_striker12",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=128091208
        -- M9k Sniper
        "m9k_aw50",
        "m9k_barret_m82",
        "m9k_svu",
        "m9k_m24",
        "m9k_dragunov",

        -- Addon : I don't remember which addon it is (sorry)
        -- M9K Submachine gun
        "m9k_smgp90",
        "m9k_vector",
        "m9k_mp5sd",
        "m9k_uzi",

        -- Addon : I don't remember which addon it is (sorry)
        -- Modern Warfare (Assault)
        "mg_akilo47",
        "mg_falima",

        -- Addon : I don't remember which addon it is (sorry)
        -- Modern Warfare (Machine gun)
        "mg_pkilo",
        "mg_mgolf34",
        "mg_mkilo3",

        -- Addon : I don't remember which addon it is (sorry)
        -- Modern Warfare (Carabines)
        "mg_kilo98",
        "mg_romeo700",
        "mg_crossbow",

        -- Addon : I don't remember which addon it is (sorry)
        -- Modern Warfare (Sniper)
        "mg_delta",
        "mg_xmike109",
        "mg_alpha50",

        -- Addon : I don't remember which addon it is (sorry)
        -- Modern Warfare (Minigun)
        "mg_dblmg",

        -- Addon : https://steamcommunity.com/sharedfiles/filedetails/?id=171935748
        "weapon_popcorn",

        -- Addons : https://steamcommunity.com/sharedfiles/filedetails/?id=1285568255 & https://steamcommunity.com/sharedfiles/filedetails/?id=123277559
        "weapon_nyangun_hot",
        "weapon_nyangun",   

    },
}