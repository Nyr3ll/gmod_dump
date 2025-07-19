-- //////////////////////////////////////////////////////////////////////////////
--                 DO NOT TOUCH THINGS BELOW HERE
-- //////////////////////////////////////////////////////////////////////////////
-- -------------------------------------------------------------------------------
--  Responsive variables (adapte the UI size depending on user screen resolution)
-- -------------------------------------------------------------------------------
local openMenuCommad = NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenuCommand 

local resolutionMultiplierW, resolutionMultiplierH = ScrW()/1920, ScrH()/1080
local menuW, menuH = ScrW()*resolutionMultiplierW, ScrH()*resolutionMultiplierH

local closeButtonSizeW, closeButtonSizeH = 64*resolutionMultiplierH, 64*resolutionMultiplierH
local burgerMenuButtonSizeW, burgerMenuButtonSizeH = 64*resolutionMultiplierH, 64*resolutionMultiplierH

-- -------------------------------------------------------------------------------
--       Some UI Image i'm using a lot of time
-- -------------------------------------------------------------------------------

local closeButtonImage = "nap_tycoon_wp/vgui/close_button_256x256.png"
local burgerMenuImage = "nap_tycoon_wp/vgui/burger_menu_256x256.png"

-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
--          NOTE : Modify things ONLY if you KNOW WHAT YOU ARE DOING
-- //////////////////////////////////////////////////////////////////////////////
-- ---------------------------------
--                 Fonts
-- ---------------------------------
surface.CreateFont("FONT_Menu_Title", {
    font = "Comfortaa",
    size = 38*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_MainPage_Button", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_BurgerMenu_Button", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_WaterMoneyShop_Button", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("FONT_WaterMoneyShop_Description", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 500,
    antialias = true,
})

surface.CreateFont("FONT_WaterMoneyShop_Limit", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 500,
    antialias = true,
})

-- -----------------------------------------------
--                 FORMATING VALUE
-- -----------------------------------------------
local MoneySymboles = {
    "", -- 0 -> 999
    "k", -- 1.000 -> 999.999
    "M", -- 1.000.000 -> 999.999.999
    "B", -- 1.000.000.000 -> 999.999.999.999
    "T", -- 1.000.000.000.000 -> 999.999.999.999.999
    "Qd", -- 1.000.000.000.000.000 -> 999.999.999.999.999.999
    " Qt", -- 1.000.000.000.000.000.000 -> 999.999.999.999.999.999.999
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
--                 GET NUMBER OF ENTITY BY CLASS
-- -----------------------------------------------
local function CountPlayerEntitiesByClass(player, entityClass)
    if not IsValid(player) or not player:IsPlayer() then
        return 0
    end
    local count = 0

    for _, ent in ipairs(ents.GetAll()) do
        if IsValid(ent) and ent:GetClass() == entityClass then
            local owner = ent:CPPIGetOwner()
            if owner == player then
                count = count + 1
            end
        end
    end
    return count
end

local language = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]
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
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40)) -- Fond gris foncé
        draw.SimpleText("Water Production Tycoon", "FONT_Menu_Title", w / 2, 20, Color(0, 135, 245), TEXT_ALIGN_CENTER)
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
    youtubeButton:SetText(NAP_TYCOON_WATERPRODUCTION.Config.YoutubeChannelButton)
    youtubeButton:SetFont("FONT_MainPage_Button")
    youtubeButton:SetTextColor(Color(255, 255, 255))
    youtubeButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 0, 0))
    end
    youtubeButton.DoClick = function()
        gui.OpenURL(NAP_TYCOON_WATERPRODUCTION.Config.YoutubeChannelLink)
    end

    local discordButton = vgui.Create("DButton", frame)
    discordButton:SetSize(buttonWidth, buttonHeight)
    discordButton:SetPos(buttonX, buttonY+(buttonHeight*3))
    discordButton:SetText(NAP_TYCOON_WATERPRODUCTION.Config.DiscordButtonButton)
    discordButton:SetFont("FONT_MainPage_Button")
    discordButton:SetTextColor(Color(255, 255, 255))
    discordButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(88, 101, 242))
    end
    discordButton.DoClick = function()
        gui.OpenURL(NAP_TYCOON_WATERPRODUCTION.Config.DiscordLink)
    end

    local tutoButton = vgui.Create("DButton", frame)
    tutoButton:SetSize(buttonWidth, buttonHeight)
    tutoButton:SetPos(buttonX, buttonY+(buttonHeight*5))
    tutoButton:SetText("Tuto")
    tutoButton:SetFont("FONT_MainPage_Button")
    tutoButton:SetTextColor(Color(255, 255, 255))
    tutoButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 125, 0))
    end
    tutoButton.DoClick = function()
        gui.OpenURL("https://example.com/tuto")
    end
end

-- -----------------------------------------------------
--                 WATER MONEY SHOP PAGE
-- -----------------------------------------------------
function OpenWaterMoneyShopPage()
    local localPly = LocalPlayer()
    local localPlySteamId64 = localPly:SteamID64()

    local function DrawPositionRectangle(frameWide, frameTall, wideMultiplicator, tallMultiplicator, xMultiplicator, yMultiplicator, roundedPercentage)
        local rectW, rectH = frameWide * wideMultiplicator, frameTall * tallMultiplicator
        local rectX, rectY = frameWide * xMultiplicator, frameTall * yMultiplicator
        draw.RoundedBox(roundedPercentage, rectX, rectY, rectW, rectH, Color(255, 255, 255, 50))
        return rectX, rectY, rectW, rectH
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)

    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40)) -- Fond gris foncé
        draw.SimpleText("Water Money Shop", "FONT_Menu_Title", w * 0.5, h * 0.02, Color(0, 135, 245), TEXT_ALIGN_CENTER)
        draw.SimpleText(FormatMoneyValue(localPly:GetNWInt("WaterMoney")) .. " WM", "FONT_Menu_Title", w * 0.8, h * 0.02, Color(255, 255, 255), TEXT_ALIGN_CENTER)
    end

    -- Bouton de menu burger
    local burgerMenuButton = vgui.Create("DImageButton", frame)
    burgerMenuButton:SetSize(32, 32)
    burgerMenuButton:SetPos(10, 10)
    burgerMenuButton:SetImage(burgerMenuImage)
    burgerMenuButton.DoClick = function()
        OpenBurgerMenu(frame)
    end

    local scrollPanel = vgui.Create("DScrollPanel", frame)
    scrollPanel:SetSize(frame:GetWide() - 20, frame:GetTall() - 60)
    scrollPanel:SetPos(10, 50)

    local yOffset = 10

    -- Fonction pour actualiser l'état d'un bouton
    local function UpdateButtonState(buyButton, item)
        local waterMoney = localPly:GetNWInt("WaterMoney")
        local ownedEntities = CountPlayerEntitiesByClass(localPly, item.Entity)

        local baseColor = Color(0, 135, 245)
        local hoverColor = Color(0, 74, 135)

        if ownedEntities >= item.Limit then
            buyButton:SetText(language["limit_reached"])
            baseColor = Color(128, 128, 128)
            hoverColor = Color(80, 80, 80)
        elseif waterMoney < item.Price then
            buyButton:SetText(language["too_expensive"])
            baseColor = Color(255, 0, 0)
            hoverColor = Color(150, 0, 0)
        else
            if item.Price <= 0 then
                buyButton:SetText(language["free"])
            else
                buyButton:SetText(language["buy"])
            end
        end

        buyButton.Paint = function(self, w, h)
            if self:IsHovered() then
                draw.RoundedBox(8, 0, 0, w, h, hoverColor)
            else
                draw.RoundedBox(8, 0, 0, w, h, baseColor)
            end
        end
    end

    for _, item in ipairs(NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold) do

        local itemIsCorrect = false
        if item.Type != "WaterMoney Generator" and item.Type != "WaterPoints Generator" and item.Type != "Weapon" and item.Type != "Other Entity" then 
            print("\n-----------------------------------------------------------------")
            print("\n                 [NAP TYCOON WATER PRODUCTION]")
            print("\n[Error]")
            print("\naddons\\nap_tycoon_wp\\lua\\nap_tycoon_wp\\main_config.lua")
            print("\n\"Type\" in \"NAP_TYCOON_WATERPRODUCTION.Config.TycoonMenu.WaterMoneyShop.ItemsSold\" variable must be one type of list below :")
            print("\n\"WaterMoney Generator\" OR \"WaterPoints Generator\" OR \"Weapon\" OR \"Other Entity\"")
            print("\nFor now \"Type\" of \""..item.Name.."\" is define to \""..item.Type.."\"")
            print("\nThis item is not display in the menu so no lua error are to fear but please repair this !")
            print("-----------------------------------------------------------------")
            
        else
            itemIsCorrect = true
        end
        if itemIsCorrect then
            local itemPanel = vgui.Create("DPanel", scrollPanel)
            itemPanel:SetSize(scrollPanel:GetWide() * 0.975, frame:GetTall() * 0.38)
            itemPanel:SetPos(0, yOffset)
            itemPanel.Paint = function(self, w, h)
                draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50))
            end

            local imgX, imgY, imgW, imgH = 10, 10, itemPanel:GetWide() * 0.2, itemPanel:GetWide() * 0.2
            local image = vgui.Create("DImage", itemPanel)
            image:SetPos(imgX, imgY)
            image:SetSize(imgW, imgH)
            image:SetImage(item.ImagePath)

            local nameX, nameY, nameW, nameH = imgX + imgW + itemPanel:GetWide() * 0.0125, itemPanel:GetTall() * 0.05, itemPanel:GetWide() * 0.4, itemPanel:GetTall() * 0.1
            local name = vgui.Create("DLabel", itemPanel)
            name:SetPos(nameX, nameY)
            name:SetSize(nameW, nameH)
            name:SetText(item.Name)
            name:SetFont("FONT_WaterMoneyShop_Description")
            name:SetTextColor(item.NameTextColor)
            name:SetWrap(false)

            local descX, descY, descW, descH = imgX + imgW + itemPanel:GetWide() * 0.0125, itemPanel:GetTall() * 0.2, itemPanel:GetWide() * 0.5, itemPanel:GetTall() * 0.5
            local description = vgui.Create("DLabel", itemPanel)
            description:SetPos(descX, descY)
            description:SetSize(descW, descH)
            description:SetText(item.Description)
            description:SetFont("FONT_WaterMoneyShop_Description")
            description:SetTextColor(Color(255, 255, 255))
            description:SetWrap(true)

            local limitX, limitY, limitW, limitH = imgX + imgW + itemPanel:GetWide() * 0.0125, itemPanel:GetTall() * 0.8, itemPanel:GetWide() * 0.4, itemPanel:GetTall() * 0.2
            local limit = vgui.Create("DLabel", itemPanel)
            limit:SetPos(limitX, limitY)
            limit:SetSize(limitW, limitH)
            local text = "Error"
            if item.Price <= 0 then
                text = language["free"]
            else
                text = item.Price
            end
            limit:SetText("Max : " .. item.Limit.."                               "..language["price"].." : "..text)
            limit:SetFont("FONT_WaterMoneyShop_Limit")
            limit:SetTextColor(Color(255, 255, 255))
            limit:SetWrap(false)

            local btnX, btnY, btnW, btnH = itemPanel:GetWide() * 0.775, itemPanel:GetTall() * 0.8, itemPanel:GetWide() * 0.2, itemPanel:GetTall() * 0.15
            local buyButton = vgui.Create("DButton", itemPanel)
            buyButton:SetPos(btnX, btnY)
            buyButton:SetSize(btnW, btnH)
            buyButton:SetFont("FONT_WaterMoneyShop_Button")
            buyButton:SetTextColor(Color(255, 255, 255))

            UpdateButtonState(buyButton, item)

            buyButton.DoClick = function()
                if CountPlayerEntitiesByClass(localPly, item.Entity) >= item.Limit then
                    net.Start("NAP_TYCOON_WP_WaterMoneyShop_SpawnLimitReachedCall")
                        net.WritePlayer(localPly)
                    net.SendToServer()
                else
                    if localPly:GetNWInt("WaterMoney") >= item.Price then
                        localPly:SetNWInt("WaterMoney", localPly:GetNWInt("WaterMoney")-item.Price)
                        if item.Type == "WaterMoney Generator" or item.Type == "WaterPoints Generator" or item.Type == "OtherEntity" then
                            net.Start("NAP_TYCOON_WP_WaterMoneyShop_SpawnPurchasedItem")
                                net.WriteVector(localPly:GetPos())
                                net.WriteString(item.Entity)
                                net.WriteString(localPlySteamId64)
                            net.SendToServer()
                        elseif item.Type == "Weapon" then
                            net.Start("NAP_TYCOON_WP_WaterMoneyShop_BuyWeapon")
                                net.WritePlayer(localPly)
                                net.WriteString(item.Entity)
                            net.SendToServer()
                            localPly:ChatPrint(language["tycoonMenu_waterMoneyshop_buyWeapon"])
                        end
                    else
                        net.Start("NAP_TYCOON_WP_WaterMoneyShop_NotEnoughToBuyCall")
                            net.WritePlayer(localPly)
                        net.SendToServer()
                    end
                end
            end

            buyButton.Think = function()
                UpdateButtonState(buyButton, item)
            end

            yOffset = yOffset + itemPanel:GetTall() + 15
        end
    end

    local closeButton = vgui.Create("DImageButton", frame)
    closeButton:SetSize(32, 32)
    closeButton:SetPos(frame:GetWide() - 42, 10)
    closeButton:SetImage(closeButtonImage)
    closeButton.DoClick = function()
        frame:Close()
    end
end



-- -----------------------------------------------------
--                 WATER POINTS SHOP PAGE
-- -----------------------------------------------------
function OpenWaterPointShopPage()
    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40)) -- Fond gris foncé
        draw.SimpleText("Water Production Tycoon", "FONT_Menu_Title", w / 2, 20, Color(0, 135, 245), TEXT_ALIGN_CENTER)
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

end

-- -----------------------------------------------------
--                 PRESTIGES SHOP PAGE
-- -----------------------------------------------------
function OpenPrestigeShopPage()
    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40)) -- Fond gris foncé
        draw.SimpleText("Water Production Tycoon", "FONT_Menu_Title", w / 2, 20, Color(0, 135, 245), TEXT_ALIGN_CENTER)
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

end

-- -----------------------------------------------------
--                 BUGER MENU
-- -----------------------------------------------------
function OpenBurgerMenu(parentFrame)
    local menu = vgui.Create("DPanel", parentFrame)
    menu:SetSize(parentFrame:GetWide() * 0.25, parentFrame:GetTall())
    menu:SetPos(0, 0)
    menu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(60, 60, 60))
    end

    local function CreateBurgerButton(text, y, onClick)
        local button = vgui.Create("DButton", menu)
        button:SetSize(menu:GetWide(), parentFrame:GetTall()*0.1)
        button:SetPos(0, y)
        button:SetText(text)
        button:SetFont("FONT_BurgerMenu_Button")
        button:SetTextColor(Color(255, 255, 255))
        button.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 80))
        end

        button.OnCursorEntered = function()
            button.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40))
            end
        end

        button.OnCursorExited = function()
            button.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 80))
            end
        end

        button.DoClick = onClick
        return button
    end

    CreateBurgerButton(language["tycoonMenu_home_page"], 50, function()
        parentFrame:Close()
        OpenMainPage()
    end)

    CreateBurgerButton("Water Money", 100, function()
        parentFrame:Close()
        OpenWaterMoneyShopPage()
    end)

    CreateBurgerButton("Water Points", 150, function()
        parentFrame:Close()
        OpenWaterPointShopPage()
    end)

    CreateBurgerButton("Prestiges", 200, function()
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
