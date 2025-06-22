SWEP.PrintName =  NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["name_nap_weapon_pickaxe"]
SWEP.Author = "Nyrell"
SWEP.Instructions = NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["instruction_weapon_pickaxe"]
SWEP.Category = "[NAP] Template"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 54
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Primary.Delay = 2
SWEP.Primary.Damage = 10

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local ply = self:GetOwner()

    ply:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_HITCENTER)

    if SERVER then  
        local tr = ply:GetEyeTrace()
        local distance = tr.HitPos:Distance(ply:GetShootPos())
        if tr.Hit and (distance <= 70) then
            local hitEnt = tr.Entity
            if IsValid(hitEnt) then
                if hitEnt:GetClass() == "nap_debug_item" then
                    hitEnt:EmitSound("template_sound_one")
                    -- Spawn entity logic right below
                    --local newRockFrag = ents.Create("nap_template")
                    --newRockFrag:SetPos(ply:GetPos() + Vector(0, 0, 50))
                    --newRockFrag:Spawn()
                else
                    ply:PrintMessage(3, "You can only hit \"nap_template\" entity with this weapon !")
                end
            end
        end
    end
end

function SWEP:Deploy()
    return true
end

function SWEP:Initialize()
    self:SetHoldType("melee")
end