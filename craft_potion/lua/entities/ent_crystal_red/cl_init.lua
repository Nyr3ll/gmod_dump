-- entities/ent_gaziniere/cl_init.lua
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    self:SetColor(Color(237, 17, 17, 255))
    self:SetMaterial("models/debug/debugwhite")
end