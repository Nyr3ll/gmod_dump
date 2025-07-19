local config = NAP_MANUF.Config

SWEP.PrintName = "Hache"
SWEP.Author = "Nyrell"
SWEP.Instructions = "Clic hauche pour couper une buche"
SWEP.Category = "[NAP] Manufacturing"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/hl2meleepack/v_axe.mdl"
SWEP.WorldModel = "models/weapons/hl2meleepack/w_axe.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 75
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Primary.Delay = 1

if config.Axe_CanDamageToPlayer then
    SWEP.Primary.Damage = config.Axe_DamageToPlayer
else
    SWEP.Primary.Damage = 0
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local ply = self:GetOwner()

    ply:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_HITCENTER)

    if SERVER then  
        local tr = ply:GetEyeTrace()
        local distance = tr.HitPos:Distance(ply:GetShootPos())
        if tr.Hit and (distance <= 100) then
            local hitEnt = tr.Entity
            if IsValid(hitEnt) then
                if hitEnt:GetClass() == "nap_manuf_trees" then
                    if hitEnt:Get_IsActive() then
                        hitEnt:Set_Health(hitEnt:Get_Health() - config.Axe_DamageToTree)
                        local table = NAP_MANUF.Config.WhitelistedTreeModel
                        local modelOfDrop = "models/hunter/blocks/cube025x025x025.mdl"
                        local random = 1
                        for k, v in pairs(table) do
                            if v.ModelOfTree == hitEnt:GetModel() then
                                random = NAP_MANUF.Random(1, #v.ModelOfTheLog)
                                modelOfDrop = v.ModelOfTheLog[random]
                            end
                        end
                        local drop = ents.Create("nap_manuf_wood_log")
                        drop:SetPos(ply:GetPos() + Vector(20, -20, 20))
                        drop:SetAngles(Angle(90, 0, 0))
                        drop:Spawn()
                        
                    end
                end
            end
        end
    end
end

function SWEP:Deploy()
    return true
end

function SWEP:Initialize()
    self:SetHoldType("melee2")
end