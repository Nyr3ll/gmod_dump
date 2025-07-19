-- //////////////////////////////////////////////////////////////////////////////
--                 DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////
-- -------------------------------------------------------------------------------
--  Responsive variables (adapte the UI size depending on user screen resolution)
-- -------------------------------------------------------------------------------
local resolutionMultiplierW, resolutionMultiplierH = ScrW()/1920, ScrH()/1080
local menuW, menuH = ScrW()*resolutionMultiplierW, ScrH()*resolutionMultiplierH
local closeButtonWidth, closeButtonHeight = 381*resolutionMultiplierH, 381*resolutionMultiplierH
local burgerMenuButtonSizeW, burgerMenuButtonSizeH = 64*resolutionMultiplierH, 64*resolutionMultiplierH

-- -------------------------------------------------------------------------------
--       Some UI Image i'm using a lot of time
-- -------------------------------------------------------------------------------

local language = NAP_DEVTOOL_LANGUAGES[NAP_DEVTOOL.Config.Language]
local cfg = NAP_DEVTOOL.Config
local openMenuCommad = cfg.MenuCommand
local destinationList = NAP_DEVTOOL.Config.DestinationList
local closeButtonImage = "nap_dev_tool/vgui/close_button.png"
local burgerMenuImage = "nap_dev_tool/vgui/burger_menu.png"
local hidden_color = Color(255, 255, 255, 0)
local white_color = Color(255, 255, 255, 255)
local nice_color1 = Color(0, 200, 255, 255)
local nice_color2 = Color(0, 145, 200, 255)
local coords = nil
--------------------------------------------------------------------------------
--                                                                            --
--------------------------------------------------------------------------------

local function AddDLabel(parent, text, background_color, text_color, font, x, y)
    local title = vgui.Create("DLabel", parent)
    title:SetPos(x, y)
    title:SetFont(font)
    title:SetText(text)
    title:SetColor(text_color)
    title:SizeToContents()
    return title
end

local function Coords()
    coords = vgui.Create("DFrame")
    coords:SetSize(menuW * 0.075, menuH * 0.15)
    coords:SetPos(20*resolutionMultiplierW, 200*resolutionMultiplierW)
    coords:SetTitle("")
    coords:ShowCloseButton(false)
    coords.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40, 220))
    end
end

timer.Create("TIMER_NAP_DEVTOOL_Coords", 0.1, 0, function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    if coords ~= nil then
        coords:Close()
        coords = nil
    end

    if ply:GetNWBool("NAP_DEVTOOL_Coords") then
        if coords == nil then
            Coords()
        end
        local pos = ply:GetPos()
        local x, y, z = math.Round(pos.x), math.Round(pos.y), math.Round(pos.z)
        local coordsWide, coordsTall = coords:GetSize()
        local coords_label = AddDLabel(coords, "Coords", hidden_color, nice_color1, "DEVTOOL_FONT_MainPage_Button", coordsWide*0.2, coordsTall*0.1)
        local xLabel = AddDLabel(coords, "X : "..x, hidden_color, nice_color2, "DEVTOOL_FONT_MainPage_Button", coordsWide*0.2, coordsTall*0.3)
        local yLabel = AddDLabel(coords, "Y : "..y, hidden_color, nice_color2, "DEVTOOL_FONT_MainPage_Button", coordsWide*0.2, coordsTall*0.5)
        local zLabel = AddDLabel(coords, "Z : "..z, hidden_color, nice_color2, "DEVTOOL_FONT_MainPage_Button", coordsWide*0.2, coordsTall*0.7)
    else
        if coords ~= nil then
            coords:Close()
            coords = nil
        end
    end


    if ply:GetNWBool("NAP_DEVTOOL_Traces") then
        
        hook.Add("PostDrawTranslucentRenderables", "DrawViewTraces", function()
            for _, ply in ipairs(player.GetAll()) do
                if not IsValid(ply) or ply == LocalPlayer() or not ply:Alive() then continue end

                local startPos = ply:EyePos()
                local direction = ply:EyeAngles():Forward()

                local trace = util.TraceLine({
                    start = startPos,
                    collisiongroup = 0,
                    endpos = startPos + direction * 10000,
                    filter = ply,
                    mask = MASK_SHOT
                })

                render.SetColorMaterial()
                render.DrawBeam(startPos, trace.HitPos, 3, 0, 1, Color(0, 255, 0, 180))

                render.DrawSphere(trace.HitPos, 2, 8, 8, Color(255, 0, 0, 180))
            end
        end)

    end

end)

