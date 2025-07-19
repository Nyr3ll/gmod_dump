-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_Compressor_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 1, "_IsActive")
    self:NetworkVar("Float", 0, "_ProcessTime")
    self:NetworkVar("Float", 1, "_ProcessTimeRemaining")
    self:NetworkVar("Float", 2, "_EnergyCapacity")
    self:NetworkVar("Float", 3, "_EnergyStored")
    self:NetworkVar("Float", 4, "_Energyconsumption")

	if SERVER then
        self:Set_IsActive(false)
        self:Set_ProcessTime(config.Compressor_ProcessTime)
        self:Set_ProcessTimeRemaining(config.Compressor_ProcessTime)
        self:Set_EnergyCapacity(config.Compressor_MaxEnergyCapacity)
        self:Set_EnergyStored(0)
        self:Set_Energyconsumption(config.Compressor_EnergyConsumption)
          
	end
end


-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Model = "models/props/de_train/processor.mdl"