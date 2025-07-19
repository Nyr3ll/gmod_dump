-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_GeneratorT1_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.RopedEntity = ENT.RopedEntity or {}

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "_IsProcessing")
    self:NetworkVar("Bool", 1, "_IsActive")
    self:NetworkVar("Float", 0, "_ProcessTime")
    self:NetworkVar("Float", 1, "_ProcessTimeRemaining")
    self:NetworkVar("Float", 2, "_EnergyCapacity")
    self:NetworkVar("Float", 3, "_EnergyStored")
    self:NetworkVar("Float", 4, "_EnergyProduction")
    self:NetworkVar("Float", 5, "_WoodCapacity")
    self:NetworkVar("Float", 6, "_WoodStored")
    self:NetworkVar("Float", 7, "_WoodConsumption")

	if SERVER then
        self:Set_IsProcessing(false)
        self:Set_IsActive(false)
        self:Set_ProcessTime(config.GeneratorT1_ProcessTime)
        self:Set_ProcessTimeRemaining(config.GeneratorT1_ProcessTime)
        self:Set_EnergyCapacity(config.GeneratorT1_MaxEnergyCapacity)
        self:Set_EnergyStored(0)
        self:Set_EnergyProduction(config.GeneratorT1_EnergyProduction)
        self:Set_WoodCapacity(config.GeneratorT1_MaxWoodCapacity)
        self:Set_WoodStored(0)
        self:Set_WoodConsumption(config.GeneratorT1_WoodConsumption)      
	end
end


-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////

-- Custom the model if you want
-- I cannot certify the good visual rendering of certain entities if you change the model
ENT.Model = "models/props_vehicles/generatortrailer01.mdl"