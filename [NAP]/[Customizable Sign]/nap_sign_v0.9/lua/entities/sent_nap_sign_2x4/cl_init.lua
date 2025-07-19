include("shared.lua")

local sv_cfg = NAP_CUSTOM_SIGN.Config

function ENT:Draw()
    self:DrawModel()

    local showTextDistance = sv_cfg.ShowDistance
    local playerPos = LocalPlayer():GetPos()
    local entPos = self:GetPos()
    local distance = playerPos:Distance(entPos)
    local roundedBoxWdth = 200  

    if distance <= showTextDistance then

        local sent_cfg = self.Config
        cam.Start3D2D(self:LocalToWorld(sent_cfg.relatives_coords), self:LocalToWorldAngles(sent_cfg.relatives_angles), 0.25) 

            draw.RoundedBox(0, sent_cfg.scr_x, sent_cfg.scr_y, sent_cfg.scr_w, sent_cfg.scr_h, sent_cfg.background_color)
            if istable(self.UIElements) and #self.UIElements > 0 then
                for k, v in ipairs(self.UIElements) do
                    draw.RoundedBox(v.radius, v.x, v.y, v.w, v.h, v.background_color)
                    draw.SimpleText(v.text, v.font, v.txt_x, v.txt_y, v.text_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        cam.End3D2D()
    end
end

net.Receive("NAP_CUSTOM_SIGN_SendUIElements", function()
    local ent = net.ReadEntity()
    local data = net.ReadTable()
    if IsValid(ent) then
        ent.UIElements = data
    end
end)