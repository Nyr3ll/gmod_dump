-- entities/ent_gaziniere/init.lua
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local lastButtonActionTime = 0
local cooldownDuration = 2

local function isCooldownOver()
    return CurTime() >= lastButtonActionTime + cooldownDuration
end

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetColor(Color(252, 186, 3, 255))

    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then

        local tempJumpHeight = caller:GetJumpPower()
        if tempJumpHeight < 300 then

            if isCooldownOver() then
                
                caller:SetJumpPower(300) -- Augmente le saut
                caller:Say("/me se sent léger !", false )
                self:Remove()

                lastButtonActionTime = CurTime()
            end
        else

            if isCooldownOver() then
                
                caller:Say("/me pense qu'il vaut mieux ne pas abuser des bonnes choses !", false )
                lastButtonActionTime = CurTime()
                return

                
            end
            
        end
    end
end
