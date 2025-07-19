-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

local cfg = NAP_CUSTOM_SIGN.Config
local lang = NAP_CUSTOM_SIGN_LANGUAGES[cfg.Language]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = lang["nap_cs_sign_name"][2]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Sign"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Config = {
    model = "models/hunter/plates/plate1x3.mdl",
    entity_color = Color(50, 50, 50, 255),
    collider_grp = 11,
    scr_w = 570,
    scr_h = 189,
    scr_x = -285,
    scr_y = -94.5,
    background_color = Color(50, 50, 50, 255),
    relatives_coords = Vector(0, 0, 1.7),
    relatives_angles = Angle(0, 90, 0),
}