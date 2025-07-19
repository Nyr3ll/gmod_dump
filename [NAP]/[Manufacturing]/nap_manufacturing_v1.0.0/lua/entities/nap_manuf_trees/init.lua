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
	local ent = ents.Create("nap_manuf_trees")
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
    local random = math.random(1, #config.WhitelistedTreeModel)
    local model = config.WhitelistedTreeModel[random].ModelOfTree

    self:SetModel(model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(config.CollisionType["Tree"])


    
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:Think()
    if self:Get_IsActive() then
        if self:Get_Health() <= 0 then
            self:Set_IsActive(false)
            self:SetColor(Color(255, self:GetColor().g, self:GetColor().b, 180))
            self:SetRenderMode( RENDERMODE_TRANSCOLOR )
            self:SetCollisionGroup(11)
            timer.Simple(config.Tree_TimeBeforeRespawn, function()
                if self:IsValid() then
                    self:Set_Health(config.Tree_Health)
                    self:SetColor(Color(self:GetColor().r, self:GetColor().g, self:GetColor().b, 255))
                    self:SetCollisionGroup(config.CollisionType["Tree"])
                    self:SetRenderMode( RENDERMODE_NORMAL )
                    self:Set_IsActive(true)
                end
            end)
        end
    end
end