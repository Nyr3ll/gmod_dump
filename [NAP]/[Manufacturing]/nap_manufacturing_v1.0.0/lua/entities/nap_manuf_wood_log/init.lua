AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local config = NAP_MANUF.Config
-- //////////////////////////////////////////////////////////////////////////////
--              INITIALISATION DE L'ENTITÉ
-- //////////////////////////////////////////////////////////////////////////////

function ENT:SpawnFunction(ply, tr)
	if (not tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create("nap_manuf_wood_log")
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), 180)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
    ent:CPPISetOwner(ply)
    NAP_MANUF.SetOwner(ent, ply:SteamID64())
	return ent
end

function ENT:Initialize()

    local random1 = NAP_MANUF.Random(1, #config.WhitelistedTreeModel)
    local random2 = NAP_MANUF.Random(1, #config.WhitelistedTreeModel[random1].ModelOfTheLog)
    local model = config.WhitelistedTreeModel[random1].ModelOfTheLog[random2]
    self:SetModel(model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(config.CollisionType["WoodLog"])

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:StartTouch(hitEnt)
    
    local entityConsumerWood = entityWithWood
    local target = hitEnt

    for k, v in pairs(entityConsumerWood) do
        if target:GetClass() == v then
            if target:Get_WoodStored() + self:Get_BurnValue() <= target:Get_WoodCapacity() then
                target:Set_WoodStored(target:Get_WoodStored() + self:Get_BurnValue())
                self:Remove()
            end
        end
    end

end