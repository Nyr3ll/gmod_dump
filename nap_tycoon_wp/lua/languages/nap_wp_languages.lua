------------------------

NAP_TYCOON_WP_LANGUAGES = NAP_TYCOON_WP_LANGUAGES or {}

NAP_TYCOON_WP_LANGUAGES = {

    ["fr"] = {

        -- System messages
        ["wrong_permissions"] = {"Vous ", "n'avez pas ", "les permissions pour faire cela ", "!"},
        ["database_reset_confirmation"] = {"La ", "base de donnée ", "a bien été ", "réinitialisée", ". N'oubliez pas de reboot le serveur !"},
        ["database_reset"] = "Base de données réinitialisée.",
        ["added"] = "ajotué",
        ["removed"] = "retiré",
        ["now_owns"] = "Cette personne a maintenant",
        ["to_this_person"] = "à",
        ["free"] = "Gratuit",
        ["tycoonMenu_home_page"] = "Page principale",
        ["too_expensive"] = "Trop cher",
        ["limit_reached"] = "Limite atteinte",
        ["buy"] = "Acheter",
        ["price"]= "Prix",
        ["tycoonMenu_waterMoneyshop_NotEnoughToBuy"] = {"Vous ", "n'avez pas asser ", "de ", "WaterMoney ", "pour acheter ça !"},
        ["tycoonMenu_waterMoneyshop_BuyLimitReached"] = "Vous avez atteint la limite d'achat de cet objet.",
        ["tycoonMenu_waterMoneyshop_buyWeapon"] = "Vous avez acheté une arme et elle vous a été give !",
        ["playerDataManipulation_MissingSteamID"] = "[NAP Tycoon] Veuillez entrer un SteamID64 valide après la commande.",
        ["playerDataManipulation_MissingValue"] = "[NAP Tycoon] Veuillez entrer un montant valide (nombre positif ou négatif).",
        ["playerDataManipulation_ValueTooBig"] = "[NAP Tycoon] Le montant dépasse les limites autorisées.",
        ["name_nap_tycoon_wp_watergenerator_destroyed_warning"] = {"Un de vos ", " a été détruit !"},
        ["name_nap_tycoon_wp_watergenerator_destroyed_reward"] = {"Vous avez ", "détruit ", "un ", ". Vous recevez donc ", " WaterMoney !"},
        ["bank_watermoney_stored"] = "Stocké : ",
        

        -- Player's data manipulation
        ["playerData_SetWaterMoney_ConfMsg"] = {"Vous avez changer la quantité de \"", "WaterMoney", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " WaterMoney", "."},
        ["playerData_AddWaterMoney_ConfMsg"] = {"Vous avez ", "ajouté ", "retiré ", " de \"", "WaterMoney", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " WaterMoney", "."},
        ["playerData_SetWaterPoints_ConfMsg"] = {"Vous avez changer la quantité de \"", "WaterPoints", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " WaterPoints", "."},
        ["playerData_AddWaterPoints_ConfMsg"] = {"Vous avez ", "ajouté ", "retiré ", " de \"", "WaterPoints", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " WaterPoints", "."},
        ["playerData_SetPrestigePoints_ConfMsg"] = {"Vous avez changer la quantité de \"", "PrestigePoints", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " PrestigePoints", "."},
        ["playerData_AddPrestigePoints_ConfMsg"] = {"Vous avez ", "ajouté ", "retiré ", " de \"", "PrestigePoints", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " PrestigePoints", "."},
        ["playerData_SetPrestige_ConfMsg"] = {"Vous avez changer la quantité de \"", "Prestige", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " Prestige", "."},
        ["playerData_AddPrestige_ConfMsg"] = {"Vous avez ", "ajouté ", "retiré ", " de \"", "Prestige", "\" pour le steamid64 ", ". Cette personne possède maintenant \"", "\"", " Prestige", "."},

        -- Machine / Entities names
        ["name_nap_tycoon_wp_watergenerator_t1"] = "Générateur d'eau T1",
        ["name_nap_tycoon_wp_watergenerator_t2"] = "Générateur d'eau T2",
        ["name_nap_tycoon_wp_watergenerator_t3"] = "Générateur d'eau T3",
        ["name_nap_tycoon_wp_bank_watermoney"] = "WaterMoney Bank",

        -- Machine / Entities processing text

    },["eng"] = {

        -- System / Error messages
        ["wrong_permissions"] = {"You ", "do not have", " permission to do that ", "!"},
        ["database_reset_confirmation"] = {"Databse ", "has been correctly ", "reset ", ". Don't forget to reboot the server !"},
        ["database_reset"] = "Database has been reset.",
        ["added"] = "added",
        ["removed"] = "removed",
        ["now_owns"] = "This person now owns",
        ["to_this_person"] = "to",
        ["free"] = "Free",
        ["tycoonMenu_home_page"] = "Home Page",
        ["too_expensive"] = "Too expensive",
        ["limit_reached"] = "Limit reached",
        ["buy"] = "Buy",
        ["price"]= "Price",
        ["tycoonMenu_waterMoneyshop_NotEnoughToBuy"] = {"You ", "do not have enough ", "of ", "WaterMoney ", "to buy this !"},
        ["tycoonMenu_waterMoneyshop_BuyLimitReached"] = "You reached the buy limit for this item.",
        ["tycoonMenu_waterMoneyshop_buyWeapon"] = "You bought a weapon and it was given to you !",
        ["playerDataManipulation_MissingSteamID"] = "[NAP Tycoon] Please insert a valid SteamID64 after the command.",
        ["playerDataManipulation_MissingValue"] = "[NAP Tycoon] Please insert a valid value (it can be positive & negative).",
        ["playerDataManipulation_ValueTooBig"] = "[NAP Tycoon] The value reached maximum limit.",
        ["name_nap_tycoon_wp_watergenerator_destroyed_warning"] = {"One of your ", "got destroyed !"},
        ["name_nap_tycoon_wp_watergenerator_destroyed_reward"] = {"You ", "destroyed ", " a ", ". You received ", " WaterMoney for that !"},
        ["bank_watermoney_stored"] = "Stored : ",

        -- Player's data manipulation
        ["playerData_SetWaterMoney_ConfMsg"] = {"You changed the amount of \"", "WaterMoney", "\" for steamid64 ", ". This person now owns \"", "\"", " WaterMoney", "."},
        ["playerData_AddWaterMoney_ConfMsg"] = {"You ", "added ", "removed ", " of \"", "WaterMoney", "\" for steamid64 ", ". This person now owns \"", "\"", " WaterMoney", "."},
        ["playerData_SetWaterPoints_ConfMsg"] = {"You changed the amount of \"", "WaterPoints", "\" for steamid64 ", ". This person now owns \"", "\"", " WaterPoints", "."},
        ["playerData_AddWaterPoints_ConfMsg"] = {"You ", "added ", "removed ", " of \"", "WaterPoints", "\" for steamid64 ", ". This person now owns \"", "\"", " WaterPoints", "."},
        ["playerData_SetPrestigePoints_ConfMsg"] = {"You changed the amount of \"", "PrestigePoints", "\" for steamid64 ", ". This person now owns \"", "\"", " PrestigePoints", "."},
        ["playerData_AddPrestigePoints_ConfMsg"] = {"You ", "added ", "removed ", " of \"", "PrestigePoints", "\" for steamid64 ", ". This person now owns \"", "\"", " PrestigePoints", "."},
        ["playerData_SetPrestige_ConfMsg"] = {"You changed the amount of \"", "Prestige", "\" for steamid64 ", ". This person now owns \"", "\"", " Prestige", "."},
        ["playerData_AddPrestige_ConfMsg"] = {"You ", "added ", "removed ", " of \"", "Prestige", "\" for steamid64 ", ". This person now owns \"", "\"", " Prestige", "."},

        -- Machine / Entities names
        ["name_nap_tycoon_wp_watergenerator_t1"] = "Water Generator T1",
        ["name_nap_tycoon_wp_watergenerator_t2"] = "Water Generator T2",
        ["name_nap_tycoon_wp_watergenerator_t3"] = "Water Generator T3",
        ["name_nap_tycoon_wp_bank_watermoney"] = "WaterMoney Bank",

        -- Machine / Entities processing text


    },

}