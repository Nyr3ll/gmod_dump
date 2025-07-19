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
    self:SetColor(Color(227, 14, 14,255))

    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then

        local tempMaxHealth = caller:GetMaxHealth()
        local tempHealth = caller:Health()
        if (tempMaxHealth + tempMaxHealth*0.1) > tempHealth then

            if isCooldownOver() then
                
                caller:Say("/me se sent revigoré !", false )
                caller:SetHealth(tempMaxHealth + (tempMaxHealth*2)) -- Augmente la vie du joueur jusqu'à 10% au dessus de sa vie max
                self:Remove()

                lastButtonActionTime = CurTime()
            end

        else
            if isCooldownOver() then
                
                caller:Say("/me n'a pas soif", false )
                lastButtonActionTime = CurTime()
                return                
            end
            
        end
        

    end
end
