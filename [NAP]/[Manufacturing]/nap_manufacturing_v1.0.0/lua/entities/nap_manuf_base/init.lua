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
	local ent = ents.Create("nap_manuf_base")
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
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(config.CollisionType["DebugBaseItem"])

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

local lastInteract = 0
function ENT:Use(activator, caller)
    
    local currentTime = CurTime()
    if currentTime - lastInteract < 0.5 then
        return
    end

    lastInteract = currentTime
    if self:Get_IsActive() then
        self:Set_IsActive(false)
    else
        if (self:Get_EnergyStored() - self:Get_Energyconsumption()) >= 0 then
            self:Set_IsActive(true)
        else
            self:Set_IsActive(false)
        end
    end
end