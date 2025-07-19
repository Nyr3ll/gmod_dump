-- entities/ent_gaziniere/cl_init.lua
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    self:SetColor(Color(230, 122, 7, 255))
    self:SetMaterial("models/debug/debugwhite")
end