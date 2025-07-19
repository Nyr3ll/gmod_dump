include("shared.lua")

-- -----------------------------------------------
--                 FORMATING VALUE
-- -----------------------------------------------
local MoneySymboles = {
    "", -- 0 -> 999
    "k", -- 1.000 -> 999.999
    "M", -- 1.000.000 -> 999.999.999
    "B", -- 1.000.000.000 -> 999.999.999.999
    "T", -- 1.000.000.000.000 -> 999.999.999.999.999
    "Qd", -- 1.000.000.000.000.000 -> 999.999.999.999.999.999
    " Qt", -- 1.000.000.000.000.000.000 -> 999.999.999.999.999.999.999
}

local function FormatMoneyValue(value)
    local symbolIndex = 1
    local formattedValue = tostring(value)

    while value >= 1000 and symbolIndex < #MoneySymboles do
        value = value / 1000
        symbolIndex = symbolIndex + 1
    end

    formattedValue = string.format("%.3g", value)

    return formattedValue .. MoneySymboles[symbolIndex]
end


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

            local WaterGen_T1_RoundedBox = NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.RoundedBoxColor

            -- Title
            draw.RoundedBox( 16, -100, -300, 200, 40, WaterGen_T1_RoundedBox)
            draw.SimpleText(self.PrintName, "Trebuchet24", 0, -280, NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.TitleTextColor, 1, 1)

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
            draw.SimpleText(string.format("%.1f", self:GetNWFloat("Health")).." HP", "Trebuchet24", 0, -230, NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.HealthBarTextColor, 1, 1)

            -- Stored WaterMoney
            draw.RoundedBox( 16, -100, -200, 200, 40, WaterGen_T1_RoundedBox)
            draw.SimpleText(NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["bank_watermoney_stored"]..FormatMoneyValue(self:GetNWFloat("Stored_WaterMoney")).." WM", "Trebuchet24", 0, -180, NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.TitleTextColor, 1, 1)        

            -- Stored progress bar
            local storedPourcentage = (self:GetNWFloat("Stored_WaterMoney")/self:GetNWFloat("Stored_WaterMoney_Max"))*100
            if storedPourcentage > 100 then
                storedPourcentage = 100
            end
            
            draw.RoundedBox( 16, -100, -150, 200, 40, WaterGen_T1_RoundedBox)
            draw.RoundedBox( 16, -97.5, -145, (roundedBoxWdth-5)*((storedPourcentage)/100), 30, NAP_TYCOON_WATERPRODUCTION.Config.Entities.Bank_WaterMoney.TitleTextColor)
            draw.SimpleText(string.format("%.2f",storedPourcentage).." %", "Trebuchet24", 0, -130, Color(255, 255, 255), 1, 1)

        cam.End3D2D()
    end
end