-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_EnergyStorage_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 1, "_IsActive")
    self:NetworkVar("Float", 0, "_EnergyCapacity")
    self:NetworkVar("Float", 1, "_EnergyStored")

	if SERVER then
        self:Set_IsActive(true)
        self:Set_EnergyCapacity(config.EnergyStorage_MaxEnergyCapacity)
        self:Set_EnergyStored(0)
          
	end
end


-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Model = "models/props_c17/substation_transformer01d.mdl"