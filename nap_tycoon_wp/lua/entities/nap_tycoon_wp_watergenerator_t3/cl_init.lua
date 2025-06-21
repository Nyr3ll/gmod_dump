include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local showTextDistance = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.ShowTextDistance
    local playerPos = LocalPlayer():GetPos()
    local entPos = self:GetPos()
    local distance = playerPos:Distance(entPos)
    local roundedBoxWdth = 200  

    if distance <= showTextDistance then

        local playerAng = LocalPlayer():GetAngles()
        local ang = Angle(180, 90 + playerAng.yaw, 270)
        local pos = self:GetPos() + Vector(0, 0, 60)

        cam.Start3D2D(pos, ang, 0.2)

            local WaterGen_T1_RoundedBox = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.RoundedBoxColor

            -- Title
            draw.RoundedBox( 16, -100, -300, 200, 40, WaterGen_T1_RoundedBox)
            draw.SimpleText(self.PrintName, "Trebuchet24", 0, -280, NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.TitleTextColor, 1, 1)

            -- Health Bar
            draw.RoundedBox( 16, -100, -250, 200, 40, WaterGen_T1_RoundedBox)
            local healthBarColor = Color(255, 255, 255, 255)
            if (self:GetNWFloat("Health") > (self:GetNWFloat("MaxHealth")*0.66)) then
                healthBarColor = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_FullHealth
            elseif (self:GetNWFloat("Health") >= (self:GetNWFloat("MaxHealth")*0.33)) and (self:GetNWFloat("Health") <= (self:GetNWFloat("MaxHealth")*0.66)) then
                healthBarColor = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_MiddleHealth
            else
                healthBarColor = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGenerators.HealthBarColor_LowHealth
            end
            draw.RoundedBox( 16, -95, -245, 0+(((roundedBoxWdth/(self:GetNWFloat("MaxHealth")+(self:GetNWFloat("MaxHealth")*0.05)))*self:GetNWFloat("Health"))), 30, healthBarColor)
            draw.SimpleText(string.format("%.1f", self:GetNWFloat("Health")).." HP", "Trebuchet24", 0, -230, NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.HealthBarTextColor, 1, 1)

            -- Producing rate
            local quantityProduced = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WaterMoneyOutput
            local timeToProduced = NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.ProcessingTime
            draw.RoundedBox( 16, -100, -200, 200, 40, WaterGen_T1_RoundedBox)
            draw.SimpleText(quantityProduced/timeToProduced.." WM / Sec", "Trebuchet24", 0, -180, NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.TitleTextColor, 1, 1)        

            -- Processing bar
            draw.RoundedBox( 16, -100, -150, 200, 40, WaterGen_T1_RoundedBox)
            draw.RoundedBox( 16, -97.5, -145, 195-(((roundedBoxWdth/(self:GetNWFloat("ProcessingTime")+1))*self:GetNWFloat("ProcessingTimeRemaining"))), 30, NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WorkingRoundedBoxColor)
            draw.SimpleText(self:GetNWFloat("ProcessingTimeRemaining").." s", "Trebuchet24", 0, -130, NAP_TYCOON_WATERPRODUCTION.Config.Entities.WaterGeneratorT3.WorkingTextColor, 1, 1)       

        cam.End3D2D()
    end
end