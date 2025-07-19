AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local config = NAP_MANUF.Config
local entIndex = 0
local color = NAP_MANUF.Colors

-- //////////////////////////////////////////////////////////////////////////////
--              INITIALISATION DE L'ENTITÉ
-- //////////////////////////////////////////////////////////////////////////////

function ENT:SpawnFunction(ply, tr)
	if (not tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create("nap_manuf_generatort1")
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), 90)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
    ent:CPPISetOwner(ply)
    NAP_MANUF.SetOwner(ent, ply:SteamID64())
	return ent
end

function ENT:Initialize()
    entIndex = self:EntIndex()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(config.CollisionType["GeneratorT1"])

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end

    if self:Get_WoodStored() > self:Get_WoodCapacity() then
        self:Set_WoodStored(self:Get_WoodCapacity())
    end
    if self:Get_EnergyStored() > self:Get_EnergyCapacity() then
        self:Set_EnergyStored(self:Get_EnergyCapacity())
    end
end

local lastInteract = 0
function ENT:Use(activator, caller)

    if (self:Get_EnergyCapacity() - self:Get_EnergyStored()) < self:Get_EnergyProduction() then self:Set_IsActive(false) return end

    local currentTime = CurTime()
    if currentTime - lastInteract < 0.5 then
        return
    end

    lastInteract = currentTime
    if self:Get_IsActive() then
        self:Set_IsActive(false)
    else
        self:Set_IsActive(true)
    end
end

function ENT:Think()
    if self:Get_IsActive() and not self:Get_IsProcessing() and self:Get_WoodStored() >= self:Get_WoodConsumption() and (self:Get_EnergyCapacity() - self:Get_EnergyStored()) >= self:Get_EnergyProduction() then
        self:StartProcessing()
    end

    self:NextThink(CurTime() + 1)
    return true
end


function ENT:StartProcessing()
    if self.ProcessingTimer then return end

    self:Set_IsProcessing(true)

    local entID = "NAP_GeneratorT1_Process_" .. self:EntIndex()

    timer.Create(entID, 1, 0, function()
        if not IsValid(self) then timer.Remove(entID) return end

        if not self:Get_IsActive()
        or self:Get_WoodStored() < self:Get_WoodConsumption()
        or (self:Get_EnergyCapacity() - self:Get_EnergyStored()) < self:Get_EnergyProduction() then

            self:Set_IsProcessing(false)
            timer.Remove(entID)
            self.ProcessingTimer = nil
            return
        end

        self:Set_WoodStored(self:Get_WoodStored() - self:Get_WoodConsumption())
        self:Set_ProcessTimeRemaining(self:Get_ProcessTimeRemaining() - 1)

        if self:Get_ProcessTimeRemaining() <= 0 then
            self:Set_EnergyStored(math.min(
                self:Get_EnergyStored() + self:Get_EnergyProduction(),
                self:Get_EnergyCapacity()
            ))

            self:Set_ProcessTimeRemaining(self:Get_ProcessTime())
        end
    end)

    self.ProcessingTimer = entID
end


function ENT:StartTouch(hitEnt)

    local target = hitEnt
    local whitelistedRopedEntity = {
        "nap_manuf_compressor",
        "nap_manuf_energy_storage",
    }
    local isValidEntity = false
    local targetClass = target:GetClass()
    for k, v in pairs(whitelistedRopedEntity) do
        if v == targetClass then isValidEntity = true end
    end
    local offSetRope = 0
    if targetClass == "nap_manuf_compressor" then
        offSetRope = Vector(-20, 12.5, 90)
    elseif targetClass == "nap_manuf_energy_storage" then
        offSetRope = Vector(5, 8, 20)
    end
    if not isValidEntity then return end
    local isAnyValue = false
    local isThisTargetAlreadyRegistered = false
    if self.RopedEntity[0] != nil then isAnyValue = true end
    if isAnyValue then
        for k, v in pairs(self.RopedEntity) do
            if v == target:EntIndex() then
                isThisTargetAlreadyRegistered = true
                return                
            end
        end
    else
        if target:EntIndex() != nil then
            table.insert(self.RopedEntity, #self.RopedEntity, target:EntIndex())
            isThisTargetAlreadyRegistered = true
            constraint.Rope(self, target, 0, 0, Vector(-60, 0, 50), target:WorldToLocal(target:GetPos()+offSetRope), 600, 100, 0, 8, "cable/blue_elec", false, color.White)
        end
    end
    if not isThisTargetAlreadyRegistered then
        if target:EntIndex() != nil then
            table.insert(self.RopedEntity, #self.RopedEntity, target:EntIndex())
            constraint.Rope(self, target, 0, 0, Vector(-60, 0, 50), target:WorldToLocal(target:GetPos()+offSetRope), 600, 100, 0, 8, "cable/blue_elec", false, color.White)
        end
    end
end

function ENT:OnRemove()
    constraint.RemoveConstraints(self, "Rope")
end