-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_MotorOil_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Float", 1, "_Value")

	if SERVER then
        self:Set_Value(config.MotorOil_DefaultValue)
	end
end

-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Model = "models/props_junk/plasticbucket001a.mdl"