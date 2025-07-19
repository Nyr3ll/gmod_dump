-- entities/ent_gaziniere/cl_init.lua
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    self:SetColor(Color(52, 146, 235, 255))
    self:SetMaterial("models/debug/debugwhite")
end