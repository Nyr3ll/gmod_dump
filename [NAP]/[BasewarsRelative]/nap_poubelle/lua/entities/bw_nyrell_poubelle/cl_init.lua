include("shared.lua")

-- Phrases to show on the "animated" loading bar.
local phrases = {
    "Vous fouillez la poubelle",
    "Vous fouillez la poubelle.",
    "Vous fouillez la poubelle..",
    "Vous fouillez la poubelle..."
}

local currentPhraseIndex = 1
local lastUpdate = 0

-- Function to draw shape below the trash (only for "brilliant" visual not really usefull)
-- Only usefull if "BW_NYRELL.PoubelleConfig.HasShapeBelow" has been turn on "true" in config file (nap_poubelle/lua/autorun/config.lua)
function draw.OutlinedShape(x, y, radius, seg, thickness)
    local outerCir = {}
    local innerCir = {}

    for i = 0, seg do
        local a = math.rad((i / seg) * -360)
        table.insert(outerCir, {x = x + math.sin(a) * (radius + thickness / 2), y = y + math.cos(a) * (radius + thickness / 2)})
        table.insert(innerCir, {x = x + math.sin(a) * (radius - thickness / 2), y = y + math.cos(a) * (radius - thickness / 2)})
    end

    local a = math.rad(0)
    table.insert(outerCir, {x = x + math.sin(a) * (radius + thickness / 2), y = y + math.cos(a) * (radius + thickness / 2)})
    table.insert(innerCir, {x = x + math.sin(a) * (radius - thickness / 2), y = y + math.cos(a) * (radius - thickness / 2)})

    for i = 1, #outerCir do
        local p1 = outerCir[i]
        local p2 = outerCir[i % #outerCir + 1]
        local p3 = innerCir[i % #innerCir + 1]
        local p4 = innerCir[i]

        surface.DrawPoly({p1, p2, p3, p4})
    end
end


function ENT:Draw()
    self:DrawModel()

    local ply = LocalPlayer()
    local distance = self:GetPos():Distance(ply:GetPos())

    -- Draw the shape depending on config file & if player is close enough (to avoid drawing it from too far away)
    if BW_NYRELL.PoubelleConfig.HasShapeBelow then
        if distance <= 1000 then

            local pos = self:GetPos()
            local shape = 1
            pos.z = pos.z + (-24)

            cam.Start3D2D(pos, self:GetAngles(), 1)
                draw.NoTexture()
                surface.SetDrawColor(BW_NYRELL.PoubelleConfig.ShapeColor)
                if BW_NYRELL.PoubelleConfig.TypeOfShape == 0 then
                    shape = 3
                elseif BW_NYRELL.PoubelleConfig.TypeOfShape == 1 then
                    shape = 4
                elseif BW_NYRELL.PoubelleConfig.TypeOfShape == 2 then
                    shape = 5
                elseif BW_NYRELL.PoubelleConfig.TypeOfShape == 3 then
                    shape = 6
                else
                    shape = 80
                end
                draw.OutlinedShape(0, 0, BW_NYRELL.PoubelleConfig.ShapeRadius, shape, BW_NYRELL.PoubelleConfig.ShapeBorderSize)
                
            cam.End3D2D()

        end
    end

    -- Display text above the trash depending on config file
    if BW_NYRELL.PoubelleConfig.ShowInformationsAbove then
        local showTextDistance = BW_NYRELL.PoubelleConfig.ShowedInformationsDistance
        local playerPos = LocalPlayer():GetPos()
        local entPos = self:GetPos()
        local distance = playerPos:Distance(entPos)

        if distance <= showTextDistance then

            local playerAng = LocalPlayer():GetAngles()
            local ang = Angle(180, 90 + playerAng.yaw, 270)
            local pos = self:GetPos() + Vector(0, 0, 60)
            cam.Start3D2D(pos, ang, 0.2)
                if self:GetNWBool("HasBeenSearched") then
                    draw.SimpleText("Temps restant".." "..tostring(math.floor((self:GetTimeRemaining()/60), 0)).."m"..tostring(self:GetTimeRemaining()%60).."s", "Trebuchet24", 0, 80, BW_NYRELL.PoubelleConfig.ShowedInformationsTextColor, 1, 1)
                else
                    draw.SimpleText("Appuyer sur \"E\" pour fouiller.", "Trebuchet24", 0, 80, BW_NYRELL.PoubelleConfig.ShowedInformationsTextColor, 1, 1)
                end
            cam.End3D2D()

        end
    end
end

-- Receiving net message for loading bar visual
net.Receive("BWNYRELL_StartLoadingBar", function()
    local entity = net.ReadEntity()
    local startTime = CurTime()
    local endTime = startTime + BW_NYRELL.PoubelleConfig.InteractTime

    hook.Add("Think", "CheckPlayerLookingAtEntity", function()
        local ply = LocalPlayer()
        local tr = ply:GetEyeTrace()
        if tr.Entity ~= entity then
            net.Start("BWNYRELL_StopLoadingBar")
            net.SendToServer()
            hook.Remove("HUDPaint", "DrawLoadingBar")
            hook.Remove("Think", "CheckPlayerLookingAtEntity")
        end
    end)

    hook.Add("HUDPaint", "DrawLoadingBar", function()
        local timeLeft = endTime - CurTime()
        if timeLeft <= 0 then
            
            net.Start("BWNYRELL_FinishLoading")
            net.WriteEntity(entity)
            net.SendToServer()

            hook.Remove("HUDPaint", "DrawLoadingBar")
            hook.Remove("Think", "CheckPlayerLookingAtEntity")
            return
        end

        local scrW = ScrW()
        local scrH = ScrH()
        local barWidth = 300
        local barHeight = 25
        local barX = (scrW - barWidth) / 2
        local barY = (scrH - barHeight) / 2

        draw.RoundedBox(8, barX, barY, barWidth, barHeight, BW_NYRELL.PoubelleConfig.LoadingBarBackgroundColor)
        local progressWidth = (1 - (timeLeft / BW_NYRELL.PoubelleConfig.InteractTime)) * (barWidth - 4)
        draw.RoundedBox(8, barX + 2, barY + 2, progressWidth, barHeight - 4, BW_NYRELL.PoubelleConfig.LoadingBarProgessColor)

        if CurTime() - lastUpdate >= 0.75 then
            currentPhraseIndex = currentPhraseIndex % #phrases + 1
            lastUpdate = CurTime()
        end
    
        draw.SimpleText(phrases[currentPhraseIndex], "DermaDefaultBold", scrW / 2, barY*1.02, BW_NYRELL.PoubelleConfig.LoadingBarTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end)
end)

net.Receive("BWNYRELL_StopLoadingBar", function()
    hook.Remove("HUDPaint", "DrawLoadingBar")
    hook.Remove("Think", "CheckPlayerLookingAtEntity")
end)