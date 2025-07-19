AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- //////////////////////////////////////////////////////////////////////////////
--              INITIALISATION DE L'ENTITÉ
-- //////////////////////////////////////////////////////////////////////////////

function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetColor(Color(0, 255, 46, 255 ) )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HasCollision)

    local maxHealth = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.Health
    self:SetNWInt("Health", maxHealth)
    self:SetNWInt("MaxHealth", maxHealth)
    self:SetHealth(maxHealth)

    self:SetNWFloat("WatermoneyProduction", NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WaterMoneyOutput)
    self:SetNWFloat("ProcessingTime", NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.ProcessingTime)
    self:SetNWFloat("ProcessingTimeRemaining", self:GetNWFloat("ProcessingTime"))


    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    self:Processing()
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

-- //////////////////////////////////////////////////////////////////////////////
--                          Process of money
-- //////////////////////////////////////////////////////////////////////////////

function ENT:Processing()
    
    self:SetNWFloat("ProcessingTimeRemaining", self:GetNWFloat("ProcessingTime"))
    
    local entIndex = self:EntIndex()

    timer.Create("ProcessingTimer_" .. entIndex, 1, self:GetNWFloat("ProcessingTime"), function()
        if not IsValid(self) then return end
        self:SetNWFloat("ProcessingTimeRemaining", self:GetNWFloat("ProcessingTimeRemaining") - 1)
    end)

    timer.Simple(self:GetNWFloat("ProcessingTime"), function()
        if not IsValid(self) then return end
        self:SetNWFloat("ProcessingTimeRemaining", 0)

        local owner = FPP and FPP.entGetOwner and FPP.entGetOwner(self) or nil

        if IsValid(owner) and owner:IsPlayer() then
            local steamID = owner:SteamID64()

            local result = sql.QueryRow("SELECT * FROM nap_tycoon_wp_db WHERE SteamID = '" .. steamID .. "'")
            if result then
                local newWaterMoney = tonumber(result.WaterMoney) + self:GetNWFloat("WatermoneyProduction")
                sql.Query("UPDATE nap_tycoon_wp_db SET WaterMoney = " .. newWaterMoney .. " WHERE SteamID = '" .. steamID .. "'")

                owner:SetNWInt("WaterMoney", newWaterMoney)
            end
        end
        self:Processing()
    end)
end


function EntityPrice(entityClass)
    local itemsSold = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold
    local priceFound = false
    for _, v in pairs(itemsSold) do
        if v.Entity == entityClass then
            priceFound = true
            return v.Price
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
    if NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HealthModule  then
        local currentHealth = self:GetNWInt("Health")
        local damage = dmginfo:GetDamage()

        currentHealth = currentHealth - damage
        self:SetNWInt("Health", currentHealth)
        self:SetHealth(currentHealth)

        if currentHealth <= 0 then
            local attacker = dmginfo:GetAttacker()
            local owner = self:CPPIGetOwner()
            local entityPrice = EntityPrice(self:GetClass())
            if NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.BeRewardToDestroyGenerator then
                if attacker == owner and NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.BeRewardToDestroyOwnedGenerator then

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
