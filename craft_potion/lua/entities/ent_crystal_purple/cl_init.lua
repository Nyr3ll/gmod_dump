-- entities/ent_gaziniere/cl_init.lua
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    self:SetColor(Color(92, 38, 163, 255))
    self:SetMaterial("models/debug/debugwhite")
end