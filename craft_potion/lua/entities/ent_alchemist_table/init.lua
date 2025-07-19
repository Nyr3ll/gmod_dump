AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.HandledEntities = ENT.HandledEntities or {}

local lastButtonActionTime = 0
local cooldownDuration = 0.5

local function isCooldownOver()
    return CurTime() >= lastButtonActionTime + cooldownDuration
end

function ENT:Initialize()
    self:SetModel("models/props_wasteland/kitchen_counter001b.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetNW2Int("BlueStored", 0)
    self:SetNW2Int("GreenStored", 0)
    self:SetNW2Int("OrangeStored", 0)
    self:SetNW2Int("PurpleStored", 0)
    self:SetNW2Int("RedStored", 0)

    self:SetNW2Int("RecipeChosen", 0)

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
    
end

function ENT:MainMenu()
	self:SetNW2Int("RecipeChosen", 0)
end

function ENT:RecipeOne()
    self:SetNW2Int("RecipeChosen", 1)
end

function ENT:RecipeTwo()
    self:SetNW2Int("RecipeChosen", 2)
end

function ENT:CraftPotion()

    if self:GetNW2Int("RecipeChosen") == 1 then

        if self.AlcheTableInvCryst.blue >= self.RecipeJumpBoost.quantities[1] and self.AlcheTableInvCryst.green >= self.RecipeJumpBoost.quantities[2] and self.AlcheTableInvCryst.orange >= self.RecipeJumpBoost.quantities[3] and self.AlcheTableInvCryst.purple >= self.RecipeJumpBoost.quantities[4] and self.AlcheTableInvCryst.red >= self.RecipeJumpBoost.quantities[5] then

            self.AlcheTableInvCryst.blue = self.AlcheTableInvCryst.blue - self.RecipeJumpBoost.quantities[1]
            self:SetNW2Int("BlueStored", self.AlcheTableInvCryst.blue)
            self.AlcheTableInvCryst.green = self.AlcheTableInvCryst.green - self.RecipeJumpBoost.quantities[2]
            self:SetNW2Int("GreenStored", self.AlcheTableInvCryst.green)
            self.AlcheTableInvCryst.orange = self.AlcheTableInvCryst.orange - self.RecipeJumpBoost.quantities[3]
            self:SetNW2Int("OrangeStored", self.AlcheTableInvCryst.orange)
            self.AlcheTableInvCryst.purple = self.AlcheTableInvCryst.purple - self.RecipeJumpBoost.quantities[4]
            self:SetNW2Int("PurpleStored", self.AlcheTableInvCryst.purple)
            self.AlcheTableInvCryst.red = self.AlcheTableInvCryst.red - self.RecipeJumpBoost.quantities[5]
            self:SetNW2Int("RedStored", self.AlcheTableInvCryst.red)

            local jumpboostPotion = ents.Create("ent_potion_jumpboost")
            jumpboostPotion:SetPos(self:GetPos() + Vector(0,0,50))
            jumpboostPotion:Spawn()


        else
            return
        end
        

    elseif self:GetNW2Int("RecipeChosen") == 2 then

        if self.AlcheTableInvCryst.blue >= self.RecipeMaxHealth.quantities[1] and self.AlcheTableInvCryst.green >= self.RecipeMaxHealth.quantities[2] and self.AlcheTableInvCryst.orange >= self.RecipeMaxHealth.quantities[3] and self.AlcheTableInvCryst.purple >= self.RecipeMaxHealth.quantities[4] and self.AlcheTableInvCryst.red >= self.RecipeMaxHealth.quantities[5] then
         
            self.AlcheTableInvCryst.blue = self.AlcheTableInvCryst.blue - self.RecipeMaxHealth.quantities[1]
            self:SetNW2Int("BlueStored", self.AlcheTableInvCryst.blue)
            self.AlcheTableInvCryst.green = self.AlcheTableInvCryst.green - self.RecipeMaxHealth.quantities[2]
            self:SetNW2Int("GreenStored", self.AlcheTableInvCryst.green)
            self.AlcheTableInvCryst.orange = self.AlcheTableInvCryst.orange - self.RecipeMaxHealth.quantities[3]
            self:SetNW2Int("OrangeStored", self.AlcheTableInvCryst.orange)
            self.AlcheTableInvCryst.purple = self.AlcheTableInvCryst.purple - self.RecipeMaxHealth.quantities[4]
            self:SetNW2Int("PurpleStored", self.AlcheTableInvCryst.purple)
            self.AlcheTableInvCryst.red = self.AlcheTableInvCryst.red - self.RecipeMaxHealth.quantities[5]
            self:SetNW2Int("RedStored", self.AlcheTableInvCryst.red)

            local maxHealthPotion = ents.Create("ent_potion_maxhealth")
            maxHealthPotion:SetPos(self:GetPos() + Vector(0,0,50))
            maxHealthPotion:Spawn()

        else
            return
        end
    end

end

function ENT:Use(a, c, usetype, value)

    local TraceLine = util.TraceLine({start = c:GetShootPos(), endpos = c:GetAimVector() * 128 + c:GetShootPos(), filter = c})
    local HitPosition = self:WorldToLocal(TraceLine.HitPos)

    if self:GetNW2Int("RecipeChosen") == 1 or self:GetNW2Int("RecipeChosen") == 2 then
        
        --print(HitPosition.x .. " " .. HitPosition.y)

        if TraceLine.Entity == self
        and HitPosition.x >= 19.835090637207
        and HitPosition.x <= 25.461128234863
        and HitPosition.y >= -28.591400146484
        and HitPosition.y <= -19.324398040771
        and c:KeyDown(IN_USE) then
            
            self:MainMenu()

        end
    end

    if self:GetNW2Int("RecipeChosen") == 0 then

        if TraceLine.Entity == self
        and HitPosition.x >= -19.955783843994
        and HitPosition.x <= -17.144725799561
        and HitPosition.y >= -10.818373680115
        and HitPosition.y <= -3.6631276607513
        and c:KeyDown(IN_USE) then

            if isCooldownOver() then
                -- Effectuer l'action souhaitée
                self:RecipeOne()
        
                -- Mettre à jour le temps de la dernière action
                lastButtonActionTime = CurTime()
            --else

                -- Ajouter les notifications

            end
        end

        if TraceLine.Entity == self
        and HitPosition.x >= -14.383459091187
        and HitPosition.x <= -11.498001098633
        and HitPosition.y >= -10.817938804626
        and HitPosition.y <= -3.5450923442841
        and c:KeyDown(IN_USE) then

            if isCooldownOver() then
                -- Effectuer l'action souhaitée
                self:RecipeTwo()
        
                -- Mettre à jour le temps de la dernière action
                lastButtonActionTime = CurTime()

            --else
                -- Ajouter les notifications
            
            end
        end
    end

    if self:GetNW2Int("RecipeChosen") == 1 or self:GetNW2Int("RecipeChosen") == 2 then

        if TraceLine.Entity == self
        and HitPosition.x >= 20.068126678467
        and HitPosition.x <= 25.675888061523 
        and HitPosition.y >= 18.910608291626
        and HitPosition.y <= 28.041906356812
        and c:KeyDown(IN_USE) then

            if isCooldownOver() then
                -- Effectuer l'action souhaitée
                self:CraftPotion()
        
                -- Mettre à jour le temps de la dernière action
                lastButtonActionTime = CurTime()
            --else

                -- Ajouter les notifications

            end
 
        end
    end
end

function ENT:Touch(entityTouched)

    if entityTouched:GetClass() == "ent_crystal_blue" then

        if not self.HandledEntities[entityTouched] then

            entityTouched:Remove()
            self.AlcheTableInvCryst.blue = self.AlcheTableInvCryst.blue + 1
            self:SetNW2Int("BlueStored", self.AlcheTableInvCryst.blue)
            self.HandledEntities[entityTouched] = true
            
        end

    elseif entityTouched:GetClass() == "ent_crystal_green" then

        if not self.HandledEntities[entityTouched] then

            entityTouched:Remove()
            self.AlcheTableInvCryst.green = self.AlcheTableInvCryst.green + 1
            self:SetNW2Int("GreenStored", self.AlcheTableInvCryst.green)
            self.HandledEntities[entityTouched] = true
            

        end

    elseif entityTouched:GetClass() == "ent_crystal_orange" then

        if not self.HandledEntities[entityTouched] then

            entityTouched:Remove()
            self.AlcheTableInvCryst.orange = self.AlcheTableInvCryst.orange + 1
            self:SetNW2Int("OrangeStored", self.AlcheTableInvCryst.orange)
            self.HandledEntities[entityTouched] = true
            

        end
    
    elseif entityTouched:GetClass() == "ent_crystal_purple" then

        if not self.HandledEntities[entityTouched] then

            entityTouched:Remove()
            self.AlcheTableInvCryst.purple = self.AlcheTableInvCryst.purple + 1
            self:SetNW2Int("PurpleStored", self.AlcheTableInvCryst.purple)
            self.HandledEntities[entityTouched] = true
            

        end
    
    elseif entityTouched:GetClass() == "ent_crystal_red" then

        if not self.HandledEntities[entityTouched] then

            entityTouched:Remove()
            self.AlcheTableInvCryst.red = self.AlcheTableInvCryst.red + 1
            self:SetNW2Int("RedStored", self.AlcheTableInvCryst.red)
            self.HandledEntities[entityTouched] = true
            

        end
    else
        return
    end
    
end