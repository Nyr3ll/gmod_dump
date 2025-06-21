-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Carte à gratter 2"
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Lucky Cards"
ENT.Spawnable = true
ENT.AdminSpawnable = true

-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Model = "models/props_lab/clipboard.mdl"

-- Use : "surface.SetMaterial(self.Config[1])" pour mettre le background

ENT.Config = {

    BackgroundImage = "materials/nap_luckycards/images/lucky_card_2.png",
    Name = "Carte à gratter 2",
    Color = Color(99, 0, 0),
    Price = 100,
    PercentageOfWinnableCard = 20, -- This percentage is juste going to say how much out of 100 you have to win something on the card
    PricesToWin = {

        {  
            HowManySymbolesToWin = "3",
            WhatToWin = 5000,
            PercentageOfDrop = 50,
        },
        {       
            HowManySymbolesToWin = "4",
            WhatToWin = 50000,
            PercentageOfDrop = 20,
        },
        {       
            HowManySymbolesToWin = "5",
            WhatToWin = 100000,
            PercentageOfDrop = 15,
        },
        {       
            HowManySymbolesToWin = "6",
            WhatToWin = 200000,
            PercentageOfDrop = 5,
        },
        {       
            HowManySymbolesToWin = "7",
            WhatToWin = 400000,
            PercentageOfDrop = 5
        },
        {       
            HowManySymbolesToWin = "8",
            WhatToWin = 800000,
            PercentageOfDrop = 2.5,
        },
        {       
            HowManySymbolesToWin = "9",
            WhatToWin = 1600000,
            PercentageOfDrop = 2.5,
        },
    },
}