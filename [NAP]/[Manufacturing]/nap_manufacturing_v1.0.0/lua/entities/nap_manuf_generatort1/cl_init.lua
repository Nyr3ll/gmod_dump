include("shared.lua")

surface.CreateFont("FONT_GeneratorT1_ActiveState", {
    font = "Comfortaa",
    size = 128,
    weight = 500,
    antialias = true,
})

surface.CreateFont("FONT_GeneratorT1_EnergyInfos", {
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
    cam.Start3D2D(self:LocalToWorld(Vector(0, 22.25, 47.5)), self:LocalToWorldAngles(Angle(-180,0,-90)), 1) 

        local posX, posY, width, height = 20, -15, 40, 7.5
        local timeRamain = 1 - (self:Get_ProcessTimeRemaining() / self:Get_ProcessTime())

        draw.RoundedBox(0, posX, posY, width, height, color.Gray_Dark)
        draw.RoundedBox(0, posX+1, posY+1, timeRamain*(width-2), height-2, color.Purple)

        local woodRemain = 0 + (self:Get_WoodStored() / self:Get_WoodCapacity())
        draw.RoundedBox(0, posX, posY*0.35, width, height, color.Gray_Dark)
        draw.RoundedBox(0, posX+1, (posY+1)*0.35, woodRemain*(width-2), height-2, color.Brown)
    cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld(Vector(0, 21.5, 47.5)), self:LocalToWorldAngles(Angle(-180,0,-90)), 1)
        local activeStateColor = color.Red
		if self:Get_IsActive() then
			activeStateColor = color.Green
		else
			activeStateColor = color.Red
		end
        local posX, posY, width, height = 0, -2.5, 19, 6.25
        local storedEnergyPercentage = 0 + (self:Get_EnergyStored() / self:Get_EnergyCapacity())
        draw.RoundedBox(0, -5, -17.5, 25, 25, color.Gray_Dark)
        draw.RoundedBox(0, -2.5, -15, 6.25, 6.25, activeStateColor)
        draw.RoundedBox(0, -2.5, -5, width, height, color.Gray_Light)
        draw.RoundedBox(0, -2.5, -5, storedEnergyPercentage*width, height, color.Blue)
        
    cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld(Vector(0,21.5,180)), self:LocalToWorldAngles(Angle(180, 0,-90)), 0.075)
		local text = "OFF"
		if self:Get_IsActive() then
			text = "ON"
		else
			text = "OFF"
		end
		draw.DrawText(text, "FONT_GeneratorT1_ActiveState", 145, 1535, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
	cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld(Vector(-14, 21.5, 45.5)), self:LocalToWorldAngles(Angle(180,0,-90)), 0.030) 
        draw.DrawText(NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Energy"], "FONT_GeneratorT1_EnergyInfos", -200, -240, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        draw.DrawText(self:Get_EnergyStored().."/"..self:Get_EnergyCapacity(), "FONT_GeneratorT1_EnergyInfos", -200, -150, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
    cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld(Vector(-14, 22.25, 40)), self:LocalToWorldAngles(Angle(180,0,-90)), 0.05) 

        draw.DrawText(self:Get_ProcessTimeRemaining().."s", "FONT_GeneratorT1_EnergyInfos", 500, -450, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        draw.DrawText(self:Get_WoodStored().."Kg", "FONT_GeneratorT1_EnergyInfos", 520, -250, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)

    cam.End3D2D()
    
end