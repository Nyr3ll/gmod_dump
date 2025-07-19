hook.Add("HUDPaint", "ShowPlayerCoordinates", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local pos = ply:GetPos()
    local x, y, z = math.Round(pos.x), math.Round(pos.y), math.Round(pos.z)

    -- Position d'affichage (en bas à gauche)
    local screenW, screenH = ScrW(), ScrH()
    local padding = 10

    draw.SimpleText("Coords :", "DEVTOOL_FONT_MainPage_Button", padding, screenH*0.1, Color(0, 145, 200), TEXT_ALIGN_LEFT)
    draw.SimpleText("X :   " .. x, "DEVTOOL_FONT_MainPage_Button", padding, screenH*0.12, Color(0, 200, 255), TEXT_ALIGN_LEFT)
    draw.SimpleText("Y :   " .. y, "DEVTOOL_FONT_MainPage_Button", padding, screenH*0.14, Color(0, 200, 255), TEXT_ALIGN_LEFT)
    draw.SimpleText("Z :   " .. z, "DEVTOOL_FONT_MainPage_Button", padding, screenH*0.16, Color(0, 200, 255), TEXT_ALIGN_LEFT)
end)
