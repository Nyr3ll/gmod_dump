/*

1 = 99, 0, 0        --> 
2 = 24, 115, 173    --> 
3 = 101, 19, 170    --> 
4 = 61, 126, 9      --> 
5 = 192, 174, 23    --> 
6 = 216, 145, 81    --> 182, 102, 30

*/

-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Carte à gratter 1"
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

    BackgroundImage = "materials/nap_luckycards/images/lucky_card_1.png",
    Name = "Carte à gratter 1",
    Color = Color(99, 0, 0),
    Price = 100,
    PercentageOfWinnableCard = 50, -- This percentage is juste going to say how much out of 100 you have to win something on the card
    PricesToWin = {

        {  
            HowManySymbolesToWin = "3",
            WhatToWin = 1000,
            PercentageOfDrop = 50,
        },
        {       
            HowManySymbolesToWin = "4",
            WhatToWin = 2000,
            PercentageOfDrop = 20,
        },
        {       
            HowManySymbolesToWin = "5",
            WhatToWin = 4000,
            PercentageOfDrop = 15,
        },
        {       
            HowManySymbolesToWin = "6",
            WhatToWin = 8000,
            PercentageOfDrop = 5,
        },
        {       
            HowManySymbolesToWin = "7",
            WhatToWin = 16000,
            PercentageOfDrop = 5
        },
        {       
            HowManySymbolesToWin = "8",
            WhatToWin = 32000,
            PercentageOfDrop = 2.5,
        },
        {       
            HowManySymbolesToWin = "9",
            WhatToWin = 64000,
            PercentageOfDrop = 2.5,
        },
    },
}