include("shared.lua")

surface.CreateFont("FONT_EnergyStorage_EnergyInfos", {
    font = "Comfortaa",
    size = 128,
    weight = 500,
    antialias = true,
})

local color = NAP_MANUF.Colors

function ENT:Draw()
    self:DrawModel()

    local ply = LocalPlayer()
	local entPos = self:GetPos()
    if NAP_MANUF.ShowCam3D2D(entPos, ply) then
        self:DrawInfo()
    end
end

function ENT:DrawInfo()
    -- Energy CAM3D2D
    cam.Start3D2D(self:LocalToWorld(Vector(14.75, -8,0)), self:LocalToWorldAngles(Angle(180,-90,-90)), 1) 

        local posX, posY, width, height = 0, 0, 7, 22.5
        local storedEnergy = 0 + (self:Get_EnergyStored() / self:Get_EnergyCapacity())

        -- Stored Energy indicator
        draw.RoundedBox(8, posX, posY, width, height, color.Gray_Dark)
        draw.RoundedBox(8, posX+1, posY+1, width-2, storedEnergy*(height-2), color.Blue)

    cam.End3D2D()

    -- Energy Text
    cam.Start3D2D(self:LocalToWorld(Vector(14.75, 0, -5)), self:LocalToWorldAngles(Angle(270,-90,-90)), 0.035) 

        draw.DrawText(NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Energy"], "FONT_EnergyStorage_EnergyInfos", -200, -240, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        draw.DrawText(self:Get_EnergyStored().."/"..self:Get_EnergyCapacity(), "FONT_EnergyStorage_EnergyInfos", -200, -150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)

    cam.End3D2D()
end