include("shared.lua")

surface.CreateFont("FONT_1", {
    font = "Comfortaa",
    size = 28,
    weight = 500,
    antialias = true,
})

surface.CreateFont("FONT_2", {
    font = "Comfortaa",
    size = 48,
    weight = 1000,
    antialias = true,
})

local color = NAP_MANUF.Colors

function ENT:Draw()
    self:DrawModel()
end
