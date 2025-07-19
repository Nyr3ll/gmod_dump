-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_WoodLog_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "_SellPrice")
    self:NetworkVar("Float", 1, "_BurnValue")

	if SERVER then
        self:Set_SellPrice(config.WoodLog_DefaultSellPrice)
        self:Set_BurnValue(config.WoodLog_DefaultBurnValue)
          
	end
end


-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////