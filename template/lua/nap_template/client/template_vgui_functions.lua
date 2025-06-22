-- Responsive side
local resolutionMultiplierW, resolutionMultiplierH = ScrW()/1920, ScrH()/1080
local menuW, menuH = ScrW()*resolutionMultiplierW, ScrH()*resolutionMultiplierH
local closeButtonWidth, closeButtonHeight = 381*resolutionMultiplierH, 381*resolutionMultiplierH
-----------------------------------------------------------------------------------------------------------------------------------


surface.CreateFont("TemplateCustomFont", {
    font = "Tox Typewriter",
    size = 70*resolutionMultiplierW,
    weight = 500,
    antialias = true,
})

function DEBUG_Menu()
    
    if IsValid(MenuFrameState) then
        MenuFrameState:Close()
    end

    local closeButtonSizeW, closeButtonSizeH = menuW*0.028, menuW*0.028
    local frame = vgui.Create("DFrame")
        MenuFrameState = frame

        frame:ShowCloseButton(false)
        frame:SetDraggable(false)
        frame:SetSizable(false)

        frame:SetTitle("")
        frame:SetSize(menuW, menuH)
        frame:Center()
        frame:MakePopup()

        frame:SetBackgroundBlur(true)

        frame.Paint = function(self,w,h)

            surface.SetDrawColor(Color(255,255,255,255))
            surface.DrawTexturedRect(0, 0, w, h)

        end

    -----------------------------------------------------------------------------------
    -- Bouton pour fermer le menu
    -----------------------------------------------------------------------------------
    local frameWidth, frameHeight = book_mainpage:GetSize()
    
    Book_CloseButton(frame, frameWidth, frameHeight)
end

function Book_CloseButton(parent, parentSizeW, parentSizeH)

    local bookCloseButton = vgui.Create("DImageButton", parent)
    bookCloseButton:SetText("")
    bookCloseButton:SetPos(parentSizeW*0.835, parentSizeH*0.025)
    bookCloseButton:SetSize(closeButtonWidth*0.125, closeButtonHeight*0.125)
    bookCloseButton:SetImage("materials/nap_template/vgui/close_button.png")
    bookCloseButton:SetColor(Color(255, 255, 255, 255))

    bookCloseButton.OnCursorEntered = function()
        bookCloseButton:SetColor(Color(255, 0, 0, 255))
    end

    bookCloseButton.OnCursorExited = function()
        bookCloseButton:SetColor(Color(255, 255, 255, 255))
    end

    bookCloseButton.DoClick = function()
        parent:Close()
    end

end