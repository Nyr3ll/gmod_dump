-- -------------------------------------------------------------------------------
--                 DO NOT TOUCH THINGS UNDER THIS
-- -------------------------------------------------------------------------------
local nap_manuf_conf = NAP_MANUF.Config
local colors = NAP_MANUF.Colors
local openMenuCommad = nap_manuf_conf.Debug_OpenMenuUICommand
local language = NAP_MANUF_LANG[NAP_MANUF_LANG.Language]

local resolutionMultiplierW, resolutionMultiplierH = ScrW()/1920, ScrH()/1080
local menuW, menuH = ScrW()*resolutionMultiplierW, ScrH()*resolutionMultiplierH

local closeButtonSizeW, closeButtonSizeH = 64*resolutionMultiplierH, 64*resolutionMultiplierH
local burgerMenuButtonSizeW, burgerMenuButtonSizeH = 64*resolutionMultiplierH, 64*resolutionMultiplierH

local closeButtonImage = "nap_manufacturing/ui/close_button_256x256.png"
local burgerMenuImage = "nap_manufacturing/ui/burger_menu_256x256.png"

-- ---------------------------------
--                 Fonts
-- ---------------------------------

surface.CreateFont("FONT_Menu_Title", {
    font = "Comfortaa",
    size = 38*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_BurgerMenu_Button", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_Item_Description", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 500,
    antialias = true,
})

-- -----------------------------------------------
--                 FORMATING VALUE
-- -----------------------------------------------
local MoneySymboles = {
    "",     -- 0 -> 999
    "k",    -- 1.000 -> 999.999
    "M",    -- 1.000.000 -> 999.999.999
    "B",    -- 1.000.000.000 -> 999.999.999.999
    "T",    -- 1.000.000.000.000 -> 999.999.999.999.999
    "Qd",   -- 1.000.000.000.000.000 -> 999.999.999.999.999.999
    "Qt",   -- 1.000.000.000.000.000.000 -> 999.999.999.999.999.999.999
}

local function FormatMoneyValue(value)
    local symbolIndex = 1
    local formattedValue = tostring(value)

    while value >= 1000 and symbolIndex < #MoneySymboles do
        value = value / 1000
        symbolIndex = symbolIndex + 1
    end

    formattedValue = string.format("%.3g", value)

    return formattedValue .. MoneySymboles[symbolIndex]
end

-- -----------------------------------------------
--                 MAIN PAGE
-- -----------------------------------------------
function OpenMainPage()
    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, colors.Gray_Dark)
        draw.SimpleText(language["NAP_MANUF_Home_page"], "FONT_Menu_Title", w / 2, 20, colors.Blue, TEXT_ALIGN_CENTER)
    end

    local closeButton = vgui.Create("DImageButton", frame)
    closeButton:SetSize(closeButtonSizeW, closeButtonSizeH)
    closeButton:SetPos(frame:GetWide() - closeButtonSizeW - 10, 10)
    closeButton:SetImage(closeButtonImage)
    closeButton.DoClick = function()
        frame:Close()
    end

    local burgerMenuButton = vgui.Create("DImageButton", frame)
    burgerMenuButton:SetSize(burgerMenuButtonSizeW, burgerMenuButtonSizeH)
    burgerMenuButton:SetPos(10, 10)
    burgerMenuButton:SetImage(burgerMenuImage)
    burgerMenuButton.DoClick = function()
        OpenBurgerMenu(frame)
    end

    local buttonWidth, buttonHeight = frame:GetWide() * 0.4, frame:GetWide()*0.045
    local buttonX, buttonY = (frame:GetWide() - buttonWidth) / 2, frame:GetWide()*0.125

    local youtubeButton = vgui.Create("DButton", frame)
    youtubeButton:SetSize(buttonWidth, buttonHeight)
    youtubeButton:SetPos(buttonX, buttonY+(buttonHeight*1))
    youtubeButton:SetText(nap_manuf_conf.YoutubeChannelButton)
    youtubeButton:SetFont("FONT_BurgerMenu_Button")
    youtubeButton:SetTextColor(colors.White)
    youtubeButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, colors.Red)
    end
    youtubeButton.DoClick = function()
        gui.OpenURL(nap_manuf_conf.YoutubeChannelLink)
    end

    local discordButton = vgui.Create("DButton", frame)
    discordButton:SetSize(buttonWidth, buttonHeight)
    discordButton:SetPos(buttonX, buttonY+(buttonHeight*3))
    discordButton:SetText(nap_manuf_conf.DiscordButtonButton)
    discordButton:SetFont("FONT_BurgerMenu_Button")
    discordButton:SetTextColor(colors.White)
    discordButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, colors.Discord)
    end
    discordButton.DoClick = function()
        gui.OpenURL(nap_manuf_conf.DiscordLink)
    end

    local tutoButton = vgui.Create("DButton", frame)
    tutoButton:SetSize(buttonWidth, buttonHeight)
    tutoButton:SetPos(buttonX, buttonY+(buttonHeight*5))
    tutoButton:SetText("Tuto")
    tutoButton:SetFont("FONT_BurgerMenu_Button")
    tutoButton:SetTextColor(colors.White)
    tutoButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, colors.Orange)
    end
    tutoButton.DoClick = function()
        gui.OpenURL("https://example.com/tuto")
    end
end

-- -----------------------------------------------------
--                 BUGER MENU
-- -----------------------------------------------------
function OpenBurgerMenu(parentFrame)
    local menu = vgui.Create("DPanel", parentFrame)
    menu:SetSize(parentFrame:GetWide() * 0.25, parentFrame:GetTall())
    menu:SetPos(0, 0)
    menu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, colors.Gray_Medium)
    end

    local function CreateBurgerButton(text, y, onClick)
        local button = vgui.Create("DButton", menu)
        button:SetSize(menu:GetWide(), parentFrame:GetTall()*0.1)
        button:SetPos(0, y)
        button:SetText(text)
        button:SetFont("FONT_BurgerMenu_Button")
        button:SetTextColor(colors.White)
        button.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, colors.Gray_Medium)
        end

        button.OnCursorEntered = function()
            button.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, colors.Gray_Light)
            end
        end

        button.OnCursorExited = function()
            button.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, colors.Gray_Medium)
            end
        end

        button.DoClick = onClick
        return button
    end

    CreateBurgerButton(language["NAP_MANUF_Home_page"], 50, function()
        parentFrame:Close()
        OpenMainPage()
    end)

    CreateBurgerButton(language["NAP_MANUF_Home_page"], 100, function()
        parentFrame:Close()
        OpenWaterMoneyShopPage()
    end)

    CreateBurgerButton(language["NAP_MANUF_Home_page"], 150, function()
        parentFrame:Close()
        OpenWaterPointShopPage()
    end)

    CreateBurgerButton(language["NAP_MANUF_Home_page"], 200, function()
        parentFrame:Close()
        OpenPrestigeShopPage()
    end)

    -- Bouton pour fermer le burger menu
    local burgerMenuButton = vgui.Create("DImageButton", menu)
    burgerMenuButton:SetSize(burgerMenuButtonSizeW*0.5, burgerMenuButtonSizeH*0.5)
    burgerMenuButton:SetPos(10, 10)
    burgerMenuButton:SetImage(burgerMenuImage)
    burgerMenuButton.DoClick = function()
        menu:Remove()
    end
end

-- Commande pour ouvrir la page principale
hook.Add("OnPlayerChat", "OpenMainMenu", function(ply, text)
    if IsValid(ply) and ply == LocalPlayer() and string.lower(text) == openMenuCommad then
        OpenMainPage()
        return true
    end
end)
