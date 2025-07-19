-- //////////////////////////////////////////////////////////////////////////////
--                      DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Entity_HarvestableTree_Name"]
ENT.Author = "Nyrell"
ENT.Category = "[NAP] Manufacturing"
ENT.Spawnable = true
ENT.AdminSpawnable = true 

local config = NAP_MANUF.Config

function ENT:SetupDataTables()
    self:NetworkVar("Float", 1, "_Health")
    self:NetworkVar("Bool", 1, "_IsActive")

	if SERVER then
        local health = config.Tree_Health
        if health <= 0 then
            health = 1
        end
        self:Set_Health(health)
        self:Set_IsActive(true)          
	end
end

-- //////////////////////////////////////////////////////////////////////////////
--                      BELOW HERE YOU CAN CUSTOM THINGS
-- //////////////////////////////////////////////////////////////////////////////
