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
	local ent = ents.Create("nap_manuf_compressor")
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

function ENT:SpawnItem()
    local item = ents.Create("nap_manuf_motor_oil")
    if not IsValid(item) then return end

    item:SetPos(self:LocalToWorld(Vector(50, 0,25)), self:LocalToWorldAngles(Angle(0,0,0)))
    item:Spawn()
end

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(config.CollisionType["Compressor"])

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end

    local entIndex = self:EntIndex()
    local processTime = self:Get_ProcessTime()

    if self:Get_EnergyStored() > self:Get_EnergyCapacity() then
        self:Set_EnergyStored(self:Get_EnergyCapacity())
    end

    timer.Create("SpawnItem_" .. entIndex, processTime, 0, function()
        if not IsValid(self) then return end
        
        self:SpawnItem()
        self:Set_ProcessTimeRemaining(processTime)
    end)
    local lastTry = 0
    timer.Create("ProcessingTimer_" .. entIndex, 0, 0, function()
        if not IsValid(self) then return end
        if self:Get_EnergyStored() <= 0 then self:Set_IsActive(false) return end

        local currentTime = CurTime()
        if currentTime - lastTry < 1 then
            return
        end

        lastTry = currentTime

        if self:Get_IsActive() then
            if (self:Get_EnergyStored()-self:Get_Energyconsumption()) >= 0 then
            self:Set_EnergyStored(self:Get_EnergyStored() - self:Get_Energyconsumption())
            else
                self:Set_IsActive(false)
            end
            timer.UnPause("SpawnItem_"..entIndex)
            self:Set_ProcessTimeRemaining(self:Get_ProcessTimeRemaining() - 1)
        else
            timer.Pause("SpawnItem_"..entIndex)
        end
        
    end)
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

function ENT:OnRemove()
    constraint.RemoveConstraints(self, "Rope")
    timer.Remove("SpawnItem_" .. self:EntIndex())
    timer.Remove("ProcessingTimer_" .. self:EntIndex())
end