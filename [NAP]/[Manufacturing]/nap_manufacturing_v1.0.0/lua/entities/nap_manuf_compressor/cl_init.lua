include("shared.lua")

surface.CreateFont("FONT_Compressor_EnergyInfos", {
    font = "Comfortaa",
    size = 28,
    weight = 500,
    antialias = true,
})

surface.CreateFont("FONT_Compressor_ProcessingTimeRemain", {
    font = "Comfortaa",
    size = 48,
    weight = 1000,
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

local circlesParams = {
	["ProcessCircles"] = {
		Radius = 9.5,
		CenterX = 40,
		CenterY = 47,
		Segments = 16,
	},
	["ActiveStateCircles"] = {
		Radius = 5.5,
		CenterX = 40,
		CenterY = 65,
		Segments = 16,
	}
}

local proceCirc, activeStateCirc = circlesParams["ProcessCircles"], circlesParams["ActiveStateCircles"]

function ENT:DrawInfo()

	-- Processing CAM3D2D
	cam.Start3D2D(self:LocalToWorld(Vector(27.5,-40,90)), self:LocalToWorldAngles(Angle(180,-90,-90)), 1)

		-- Background
		draw.NoTexture()
		surface.SetDrawColor(color.Gray_Dark)
		DrawCircle(proceCirc.CenterX, proceCirc.CenterY, proceCirc.Radius, proceCirc.Segments, 1)

		-- Processing circle
		local progress = 1 - (self:Get_ProcessTimeRemaining() / self:Get_ProcessTime())
		surface.SetDrawColor(color.Purple)
		DrawCircle(proceCirc.CenterX, proceCirc.CenterY, proceCirc.Radius, proceCirc.Segments, progress)
		
		-- Second circle (Active state)
		-- Background
		draw.NoTexture()
		local activeStateColor = color.Red
		if self:Get_IsActive() then
			activeStateColor = color.Green
		else
			activeStateColor = color.Red
		end
		surface.SetDrawColor(activeStateColor)
		DrawCircle(activeStateCirc.CenterX, activeStateCirc.CenterY, activeStateCirc.Radius, activeStateCirc.Segments, 1)

	cam.End3D2D()

	cam.Start3D2D(self:LocalToWorld(Vector(27.5,-40,90)), self:LocalToWorldAngles(Angle(180,-90,-90)), 0.15)
		draw.DrawText(self:Get_ProcessTimeRemaining().."s", "FONT_Compressor_ProcessingTimeRemain", 270, 285, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)

		local text = "OFF"
		if self:Get_IsActive() then
			text = "ON"
		else
			text = "OFF"
		end
		draw.DrawText(text, "FONT_Compressor_ProcessingTimeRemain", 265, 405, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
	cam.End3D2D()

	-- Energy CAM3D2D
	cam.Start3D2D(self:LocalToWorld(Vector(24, -3.5,90)), self:LocalToWorldAngles(Angle(180,-90,-90)), 1) 

		local posX, posY, width, height = 0, -5, 7, 22.5
		local storedEnergy = 0 + (self:Get_EnergyStored() / self:Get_EnergyCapacity())

		-- Stored Energy indicator
		draw.RoundedBox(8, posX, posY, width, height, color.Gray_Dark)
		draw.RoundedBox(8, posX+1, posY+1, width-2, storedEnergy*(height-2), color.Blue)

	cam.End3D2D()

	-- Energy Text
	cam.Start3D2D(self:LocalToWorld(Vector(24, 0,90)), self:LocalToWorldAngles(Angle(270,-90,-90)), 0.15) 

		draw.DrawText(NAP_MANUF_LANG[NAP_MANUF_LANG.Language]["NAP_MANUF_Energy"], "FONT_Compressor_EnergyInfos", -42.5, -25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
		draw.DrawText(self:Get_EnergyStored().."/"..self:Get_EnergyCapacity(), "FONT_Compressor_EnergyInfos", -42.5, -7.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)

	cam.End3D2D()
end


