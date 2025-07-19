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
local CFG = NAP_DEVTOOL.Config
local openMenuCommad = CFG.MenuCommand
local destinationList = NAP_DEVTOOL.Config.DestinationList
local closeButtonImage = "nap_dev_tool/vgui/close_button.png"
local burgerMenuImage = "nap_dev_tool/vgui/burger_menu.png"

-- //////////////////////////////////////////////////////////////////////////////
--                 BELOW HERE YOU CAN CHANGE SOME THINGS
--          NOTE : Modify things ONLY if you KNOW WHAT YOU ARE DOING
-- //////////////////////////////////////////////////////////////////////////////
-- ---------------------------------
--                 Fonts
-- ---------------------------------

surface.CreateFont("DEVTOOL_FONT_Menu_Title", {
    font = "Comfortaa",
    size = 38*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("DEVTOOL_FONT_MainPage_Button", {
    font = "Comfortaa",
    size = 28*resolutionMultiplierW,
    weight = 1000,
    antialias = true,
})

-- -----------------------------------------------
--                 Main page function
-- -----------------------------------------------
function DEVTOOL_MainPage()
    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40, 245))
        draw.SimpleText("Dev tool", "FONT_Menu_Title", w / 2, 20, Color(0, 135, 245), TEXT_ALIGN_CENTER)
    end

    local frameWide, frameTall = frame:GetSize()
    DEVTOOL_CloseButton(frame, frameWide, frameTall)

    local burgerMenuButton = vgui.Create("DImageButton", frame)
    burgerMenuButton:SetSize(burgerMenuButtonSizeW, burgerMenuButtonSizeH)
    burgerMenuButton:SetPos(10, 10)
    burgerMenuButton:SetImage(burgerMenuImage)
    burgerMenuButton.DoClick = function()
        DEVTOOL_OpenBurgerMenu(frame)
    end

    local buttonWidth, buttonHeight = frame:GetWide() * 0.4, frame:GetWide()*0.045
    local buttonX, buttonY = (frame:GetWide() - buttonWidth) / 2, frame:GetWide()*0.125

    local youtubeButton = vgui.Create("DButton", frame)
    youtubeButton:SetSize(buttonWidth, buttonHeight)
    youtubeButton:SetPos(buttonX, buttonY+(buttonHeight*1))
    youtubeButton:SetText(CFG.YoutubeChannelButton)
    youtubeButton:SetFont("DEVTOOL_FONT_MainPage_Button")
    youtubeButton:SetTextColor(Color(255, 255, 255))
    youtubeButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 0, 0))
    end
    youtubeButton.DoClick = function()
        gui.OpenURL(CFG.YoutubeChannelLink)
    end

    local discordButton = vgui.Create("DButton", frame)
    discordButton:SetSize(buttonWidth, buttonHeight)
    discordButton:SetPos(buttonX, buttonY+(buttonHeight*3))
    discordButton:SetText(CFG.DiscordButtonButton)
    discordButton:SetFont("DEVTOOL_FONT_MainPage_Button")
    discordButton:SetTextColor(Color(255, 255, 255))
    discordButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(88, 101, 242))
    end
    discordButton.DoClick = function()
        gui.OpenURL(CFG.DiscordLink)
    end

    local tutoButton = vgui.Create("DButton", frame)
    tutoButton:SetSize(buttonWidth, buttonHeight)
    tutoButton:SetPos(buttonX, buttonY+(buttonHeight*5))
    tutoButton:SetText("Tuto")
    tutoButton:SetFont("DEVTOOL_FONT_MainPage_Button")
    tutoButton:SetTextColor(Color(255, 255, 255))
    tutoButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(255, 125, 0))
    end
    tutoButton.DoClick = function()
        gui.OpenURL("https://example.com/tuto")
    end
end

-- -----------------------------------------------
--                 Page 2
-- -----------------------------------------------
function DEVTOOL_Page_Two()
    local ply = LocalPlayer()
    local frame = vgui.Create("DFrame")
    frame:SetSize(menuW * 0.5, menuH * 0.5)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(40, 40, 40, 245))
        draw.SimpleText("Dev tool", "FONT_Menu_Title", w / 2, 20, Color(0, 135, 245), TEXT_ALIGN_CENTER)
    end

    local frameWide, frameTall = frame:GetSize()
    DEVTOOL_CloseButton(frame, frameWide, frameTall)

    local burgerMenuButton = vgui.Create("DImageButton", frame)
    burgerMenuButton:SetSize(burgerMenuButtonSizeW, burgerMenuButtonSizeH)
    burgerMenuButton:SetPos(10, 10)
    burgerMenuButton:SetImage(burgerMenuImage)
    burgerMenuButton.DoClick = function()
        DEVTOOL_OpenBurgerMenu(frame)
    end

    local entryWidth, entryHeight = frameWide * 0.2, frameTall*0.05
    local labelPosX, labelPosY = frameWide*0.1, frameTall * 0.15
    local entryPosX, entryPosY = frameWide*0.1, frameTall * 0.225 

    local labelX = vgui.Create("DLabel", frame)
    labelX:SetPos(labelPosX, labelPosY)
    labelX:SetFont("DEVTOOL_FONT_MainPage_Button")
    labelX:SetText("X :")
    labelX:SizeToContents()

    local inputX = vgui.Create("DTextEntry", frame)
    inputX:SetPos(entryPosX, entryPosY)
    inputX:SetSize(entryWidth, entryHeight)
    inputX:SetPlaceholderText("0")

    local labelY = vgui.Create("DLabel", frame)
    labelY:SetPos(labelPosX*3.5, labelPosY)
    labelY:SetFont("DEVTOOL_FONT_MainPage_Button")
    labelY:SetText("Y :")
    labelY:SizeToContents()

    local inputY = vgui.Create("DTextEntry", frame)
    inputY:SetPos(entryPosX*3.5, entryPosY)
    inputY:SetSize(entryWidth, entryHeight)
    inputY:SetPlaceholderText("0")

    local labelZ = vgui.Create("DLabel", frame)
    labelZ:SetPos(labelPosX*6, labelPosY)
    labelZ:SetFont("DEVTOOL_FONT_MainPage_Button")
    labelZ:SetText("Z :")
    labelZ:SizeToContents()

    local inputZ = vgui.Create("DTextEntry", frame)
    inputZ:SetPos(entryPosX*6, entryPosY)
    inputZ:SetSize(entryWidth, entryHeight)
    inputZ:SetPlaceholderText("0")

    local buttonWidth, buttonHeight = frameWide * 0.1, frameTall * 0.05
    local specificCoordsTP = vgui.Create("DButton", frame)
    specificCoordsTP:SetSize(buttonWidth, buttonHeight)
    specificCoordsTP:SetPos(frameWide*0.85, frameTall*0.225)
    specificCoordsTP:SetText(language["teleporter"])
    specificCoordsTP:SetFont("DEVTOOL_FONT_MainPage_Button")
    specificCoordsTP:SetTextColor(Color(255, 255, 255))
    specificCoordsTP.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 135, 245))
    end
    specificCoordsTP.DoClick = function()
        local x, y, z = tonumber(inputX:GetValue()), tonumber(inputY:GetValue()), tonumber(inputZ:GetValue())
        if x == nil then 
            x = 0
        end
        if y == nil then 
            y = 0
        end
        if z == nil then
            z = 0
        end
        frame:Close()
        DEVTOOL_TeleportAt(ply, Vector(x, y, z))
    end

    local destinationsListLabel = vgui.Create("DLabel", frame)
    destinationsListLabel:SetPos(frameWide*0.1, frameTall*0.325)
    destinationsListLabel:SetFont("DEVTOOL_FONT_MainPage_Button")
    destinationsListLabel:SetText(language["teleporter_destination_list"])
    destinationsListLabel:SizeToContents()

    local destinationDropdown = vgui.Create("DComboBox", frame)
    destinationDropdown:SetPos(frameWide*0.1, frameTall*0.375)
    destinationDropdown:SetSize(entryWidth, entryHeight)
    for k, destinationInfos in pairs(destinationList) do
        destinationDropdown:AddChoice(destinationInfos.Name)
    end
    destinationDropdown:SetValue("None")

    local destinationCoords = Vector(0, 0, 0)
    local labelCoords = vgui.Create("DLabel", frame)
    local selectedDestination = "None"
    labelCoords:Hide()
    destinationDropdown.OnSelect = function( self, i, value )
        if value != nil or value != "None" then
            selectedDestination = value
            labelCoords:SetText("")
            labelCoords:Show()
            labelCoords:SetPos(frameWide*0.35, frameTall*0.39)
            labelCoords:SetFont("DEVTOOL_FONT_MainPage_Button")
            labelCoords:SetText("X : "..(destinationList[i].x).."                    Y : "..(destinationList[i].y).."                    Z : "..(destinationList[i].z))
            destinationCoords.x = tonumber(destinationList[i].x)
            destinationCoords.y = tonumber(destinationList[i].y)
            destinationCoords.z = tonumber(destinationList[i].z)
            labelCoords:SizeToContents()

            local destinationTP = vgui.Create("DButton", frame)
            destinationTP:Hide()
            if selectedDestination != "None" then
                destinationTP:Show()
                destinationTP:SetSize(buttonWidth, buttonHeight)
                destinationTP:SetPos(frameWide*0.85, frameTall*0.39)
                destinationTP:SetText(language["teleporter"])
                destinationTP:SetFont("DEVTOOL_FONT_MainPage_Button")
                destinationTP:SetTextColor(Color(255, 255, 255))
                destinationTP.Paint = function(self, w, h)
                    draw.RoundedBox(8, 0, 0, w, h, Color(0, 135, 245))
                end
                destinationTP.DoClick = function()
                    frame:Close()
                    DEVTOOL_TeleportAt(ply, destinationCoords)
                end
            end
        end
    end

    local teleporterToPlayer = vgui.Create("DLabel", frame)
    teleporterToPlayer:SetPos(frameWide*0.1, frameTall*0.5)
    teleporterToPlayer:SetFont("DEVTOOL_FONT_MainPage_Button")
    teleporterToPlayer:SetText(language["teleporter_player_destination"])
    teleporterToPlayer:SizeToContents()

    local playerDropDown = vgui.Create("DComboBox", frame)
    playerDropDown:SetPos(frameWide * 0.1, frameTall * 0.55)
    playerDropDown:SetSize(entryWidth, entryHeight)

    local playerMap = {}
    for _, ply in ipairs(player.GetAll()) do
        playerDropDown:AddChoice(ply:Nick())
        playerMap[ply:Nick()] = ply
    end

    playerDropDown:SetValue("None")

    local playerDestination = vgui.Create("DButton", frame)
    playerDestination:Hide()
    playerDestination:SetSize(buttonWidth, buttonHeight)
    playerDestination:SetPos(frameWide * 0.4, frameTall * 0.55)
    playerDestination:SetText(language["teleporter"])
    playerDestination:SetFont("DEVTOOL_FONT_MainPage_Button")
    playerDestination:SetTextColor(Color(255, 255, 255))
    playerDestination.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 135, 245))
    end

    playerDropDown.OnSelect = function(self, index, value)
        if value and playerMap[value] and playerMap[value]:Nick() != ply:Nick() then
            local selectedPly = playerMap[value]
            local pos = selectedPly:GetPos() + Vector(0, 0, 100)
            playerDestination:Show()
            playerDestination.DoClick = function()
                frame:Close()
                DEVTOOL_TeleportAt(ply, pos)
            end
        else
            playerDestination:Hide()
        end
    end

end

-- -----------------------------------------------------
--                 Burger menu function
-- -----------------------------------------------------
function DEVTOOL_OpenBurgerMenu(parentFrame)
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

    CreateBurgerButton(language["home_page"], 50, function()
        parentFrame:Close()
        DEVTOOL_MainPage()
    end)

    CreateBurgerButton(language["teleporter"], 100, function()
        parentFrame:Close()
        DEVTOOL_Page_Two()
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

-- -----------------------------------------------
--                 Close button function
-- -----------------------------------------------
function DEVTOOL_CloseButton(parent, parentSizeW, parentSizeH)

    local bookCloseButton = vgui.Create("DImageButton", parent)
    bookCloseButton:SetText("")
    bookCloseButton:SetPos(parentSizeW*0.935, parentSizeH*0.025)
    bookCloseButton:SetSize(closeButtonWidth*0.125, closeButtonHeight*0.125)
    bookCloseButton:SetImage(closeButtonImage)
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

function DEVTOOL_TeleportAt(ply, coords)
    net.Start("NAP_DEVTOOL_TeleportAt")
        net.WriteEntity(ply)
        net.WriteVector(coords)
    net.SendToServer()

    net.Receive("NAP_DEVTOOL_TeleportAt_ServerAnswer", function()
        local hasPermission = net.ReadBool()
        if hasPermission then
            chat.AddText(Color(255, 255, 255), language["teleporter_answer"][1], Color(16, 168, 13), language["teleporter_answer"][2], Color(255, 255, 255), language["teleporter_answer"][3])
        else
            local wrong_permission = language["wrong_permissions"]
            chat.AddText(Color(255, 255, 255), wrong_permission[1], Color(255, 0, 0), wrong_permission[2], Color(255, 255, 255), wrong_permission[3])
        end
    end)
end

-- -------------------------------------------------------------------------------
--                 Command to open the menu
-- -------------------------------------------------------------------------------
hook.Add("OnPlayerChat", "DEVTOOL_OpenMenu", function(ply, text)
    if IsValid(ply) and ply == LocalPlayer() and string.lower(text) == openMenuCommad then
        DEVTOOL_MainPage()
        return true
    end
end)