AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local sv_cfg = NAP_CUSTOM_SIGN.Config

function ENT:Initialize()
    local sent_cfg = self.Config    

    self:SetModel(sent_cfg.model)
    self:SetColor(sent_cfg.entity_color)
    self:SetCollisionGroup(0)
    self:SetMaterial(sv_cfg.DefaultMaterial)

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.UIElements = {}

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end 