AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- //////////////////////////////////////////////////////////////////////////////
--              INITIALISATION DE L'ENTITÉ
-- //////////////////////////////////////////////////////////////////////////////

function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetColor(Color(0, 119, 255, 255))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HasCollision)

    local maxHealth = NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.Health
    self:SetNWInt("Health", maxHealth)
    self:SetNWInt("MaxHealth", maxHealth)
    self:SetHealth(maxHealth)

    self:SetNWFloat("Stored_WaterMoney", 2)
    self:SetNWFloat("Stored_WaterMoney_Max", NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.MaximumStorageQuantity)


    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    self:MonitorHealth()

end

-- //////////////////////////////////////////////////////////////////////////////
--                         Gestion des étincelles
-- //////////////////////////////////////////////////////////////////////////////

function ENT:MonitorHealth()
    timer.Create("SparkEffect_" .. self:EntIndex(), 3, 0, function()
        if not IsValid(self) then
            timer.Remove("SparkEffect_" .. self:EntIndex())
            return
        end
        local health = self:GetNWInt("Health")
        local maxHealth = self:GetNWInt("MaxHealth")

        if health < maxHealth * 0.33 then
            local effectData = EffectData()
            effectData:SetOrigin(self:GetPos() + Vector(0, 0, 70))
            effectData:SetMagnitude(5)
            effectData:SetScale(10)
            effectData:SetRadius(10)
            util.Effect("StunstickImpact", effectData)
            self:EmitSound("ambient/energy/zap1.wav", 65, 100, 1)
        end
    end)
end

function EntityPrice(entityClass)
    local itemsSold = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold
    local priceFound = false
    for _, v in pairs(itemsSold) do
        if v.Entity == entityClass then
            priceFound = true
            if v.Price == nil then
                return 0
            else
                return v.Price
            end
        end
    end
    if not priceFound then
        return 0
    end
end

-- //////////////////////////////////////////////////////////////////////////////
--                         Damage management
-- //////////////////////////////////////////////////////////////////////////////

function ENT:OnTakeDamage(dmginfo)
    if NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HealthModule  then
        local currentHealth = self:GetNWInt("Health")
        local damage = dmginfo:GetDamage()
        

        currentHealth = currentHealth - damage
        self:SetNWInt("Health", currentHealth)
        self:SetHealth(currentHealth)
        if currentHealth <= 0 then
            local attacker = dmginfo:GetAttacker()
            local owner = self:CPPIGetOwner()
            local entityPrice = EntityPrice(self:GetClass())
            if NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.BeRewardToDestroyGenerator then
                if attacker == owner and NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.BeRewardToDestroyOwnedGenerator then

                    net.Start("NAP_TYCOON_WP_WaterGeneratoreDestroyed_Reward")
                        net.WriteString(self.PrintName)
                        net.WriteString(entityPrice)
                    net.Send(attacker)

                    AddWaterMoney(attacker:SteamID64(), entityPrice)
                else
                    net.Start("NAP_TYCOON_WP_WaterGeneratoreDestroyed_Reward")
                        net.WriteString(self.PrintName)
                        net.WriteString(entityPrice)
                    net.Send(attacker)

                    AddWaterMoney(attacker:SteamID64(), entityPrice)
                end
            end

            net.Start("NAP_TYCOON_WP_WaterGeneratoreDestroyed_Warning")
                net.WriteString(self.PrintName)
            net.Send(owner)

            self:Remove()
            local effectData = EffectData()
            effectData:SetOrigin(self:GetPos())
            util.Effect("Explosion", effectData)
        end
    end
end
