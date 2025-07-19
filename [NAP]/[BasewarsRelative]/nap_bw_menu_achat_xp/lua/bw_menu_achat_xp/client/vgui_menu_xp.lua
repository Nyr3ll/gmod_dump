--          ///////////////////
--          ///// CONFIG /////
--          /////////////////

-- Définit la distance entre les objets et les bordures
local paddingBorder = 20
-- Définit la distance entre les objets et la bordure du haut (surtout pour les boutons qui sont sur la moitié droite du menu) 
local startPositionButton = 100

local paddingBeetweenButton = 40

local CustomizationsColor = {
     ["Menthe"] = Color(11, 227, 162, 255),
     ["Rouge"] = Color(255, 0, 0, 255),
     ["Cyan"] = Color(24, 176, 181, 255),
     ["Mauve"] = Color(101, 14, 194, 255),
     ["Jaune"] = Color(250, 192, 0, 255),
     ["Lime"] = Color(128, 255, 0, 255),
     ["Vert"] = Color(22, 212, 0, 255),
     ["Orange"] = Color(247, 158, 2, 255),
     ["Bleu"] = Color(0, 64, 214, 255),
     ["Rose"] = Color(227, 2, 208, 255),

}

local BuyableXP = {
    -- NE PAS DEPASSER LA VALEUR DE 18 Quintillion ("18.446.744.073.709.551.615")
    {NbrLevel = 1, Price = 500},
    {NbrLevel = 5, Price = 2500},
    {NbrLevel = 10, Price = 500000},
    {NbrLevel = 15, Price = 75000000},
    {NbrLevel = 20, Price = 100000000},
    {NbrLevel = 25, Price = 12500000000},
    {NbrLevel = 50, Price = 15000000000000},
    {NbrLevel = 75, Price = 175000000000000000},
    {NbrLevel = 100, Price = 20000000000000000000},
}

local MoneySymboles = {
    "$", -- de 0 à 999
    "k", -- de 1.000 à 999.999
    "M", -- de 1.000.000 à 999.999.999
    "B", -- de 1.000.000.000 à 999.999.999.999
    "T", -- de 1.000.000.000.000 à 999.999.999.999.999
    "Qd", -- de 1.000.000.000.000.000 à 999.999.999.999.999.999
    "Qt", -- de 1.000.000.000.000.000.000 à 999.999.999.999.999.999.999
}

--      ///////////////////////////////////////////////
--     ///// PARTIE TYPOGRAPHIE / POLICE ECRITURE ////
--    ///////////////////////////////////////////////

local resolutionMultiplierW, resolutionMultiplierH = ScrW()/1920, ScrH()/1080

surface.CreateFont("ComfortaaBold", {
    font = "Comfortaa-Bold",
    size = 18,
    weight = 1200,
    antialias = true
})

surface.CreateFont("ComfortaaTitle", {
    font = "Comfortaa-Bold",
    size = 50,
    weight = 1200,
    antialias = true
})

--      /////////////////////////////
--      ///// PARTIE FONCTIONS /////
--      ///////////////////////////

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

-- Fonction pour charger la configuration de l'utilisateur
local function LoadPlayerConfig()
    local steamID = LocalPlayer():SteamID64() or "unknown_player"
    local playerFolder = "bw_menu_achat_xp/" .. steamID .. "/"
    local defaultColor = "Menthe"
    local defaultVisibility = {}

    if file.Exists(playerFolder .. "color_config.txt", "DATA") then
        local colorName = file.Read(playerFolder .. "color_config.txt", "DATA")
        defaultColor = colorName
    end

    if file.Exists(playerFolder .. "xp_visibility_config.txt", "DATA") then
        local visibilityData = file.Read(playerFolder .. "xp_visibility_config.txt", "DATA")
        for line in visibilityData:gmatch("[^\r\n]+") do
            table.insert(defaultVisibility, line == "true")
        end
    else
        for i = 1, #BuyableXP do
            table.insert(defaultVisibility, true)
        end
    end

    return defaultColor, defaultVisibility
end


function OpenCustomizationMenu(colorToUse)

    local defaultColor, xpVisibility = LoadPlayerConfig()

    local scrW, scrH = ScrW(), ScrH()
    local menuW, menuH = (scrW * 0.4) * resolutionMultiplierW, (scrH * 0.4) * resolutionMultiplierH
    local buttonW, buttonH = menuW*0.18, menuH*0.10
    local customizationMenu = vgui.Create("DFrame")
    customizationMenu:SetSize(menuW, menuH)
    customizationMenu:Center()
    customizationMenu:SetTitle("")
    customizationMenu:SetDraggable(false)
    customizationMenu:ShowCloseButton(false)
    customizationMenu:MakePopup()
    customizationMenu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 230))
    end

    -- Bouton de fermeture
    local closeButton = vgui.Create("DButton", customizationMenu)
    closeButton:SetSize(menuW * 0.05, menuW * 0.05)
    closeButton:SetPos(menuW - buttonW * 0.5, paddingBorder)
    closeButton:SetText("")
    closeButton:SetFont("ComfortaaBold")
    closeButton:SetTextColor(Color(255, 255, 255, 255))

    local closebutton_backgroundImage = Material("materials/bw_menu_achat_xp/images/close_button_256x256.png")

    closeButton.Paint = function(self, w, h)
        surface.SetMaterial(closebutton_backgroundImage)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    closeButton.DoClick = function()
        customizationMenu:Close()
    end

    -- Bouton de page principale
    local homepageButton = vgui.Create("DButton", customizationMenu)
    homepageButton:SetSize(menuW * 0.05, menuW * 0.05)
    homepageButton:SetPos(paddingBorder, paddingBorder)
    homepageButton:SetText("")
    homepageButton:SetFont("ComfortaaBold")
    homepageButton:SetTextColor(Color(255, 255, 255, 255))

    local homepageButton_backgroundImage = Material("materials/bw_menu_achat_xp/images/home_256x256.png")

    homepageButton.Paint = function(self, w, h)
        surface.SetMaterial(homepageButton_backgroundImage)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    homepageButton.DoClick = function()
        customizationMenu:Close()
        OpenBuyXpMenu()
    end

    -- Menu déroulant pour les couleurs
    local colorScrollMenu = vgui.Create("DLabel", customizationMenu)
    colorScrollMenu:SetPos(paddingBorder*2, paddingBorder*3)
    colorScrollMenu:SetText("Sélectionnez une couleur :")
    colorScrollMenu:SetFont("ComfortaaBold")
    colorScrollMenu:SetTextColor(Color(255, 255, 255, 255))
    colorScrollMenu:SizeToContents()

    local colorDropdown = vgui.Create("DComboBox", customizationMenu)
    colorDropdown:SetPos(paddingBorder*2, paddingBorder*4)
    colorDropdown:SetSize(150, 30)
    for colorName, colorValue in pairs(CustomizationsColor) do
        colorDropdown:AddChoice(colorName)
    end
    colorDropdown:SetValue(defaultColor) -- Valeur par défaut

    -- Cases à cocher pour les achats d'XP
    local checkboxY = 120
    local xpCheckBoxes = {}
    for i, xpData in ipairs(BuyableXP) do
        local xpCheckBox = vgui.Create("DCheckBoxLabel", customizationMenu)
        xpCheckBox:SetPos(paddingBorder*2, checkboxY)
        xpCheckBox:SetText("Afficher l'achat de " .. xpData.NbrLevel .. " niveaux")
        xpCheckBox:SetValue(xpVisibility[i]) -- Par défaut, toutes les cases sont cochées
        xpCheckBox:SizeToContents()
        table.insert(xpCheckBoxes, xpCheckBox)
        checkboxY = checkboxY + 30
    end

    -- Sauvegrader
    local saveButton = vgui.Create("DButton", customizationMenu)
    saveButton:SetSize(menuW*0.2, menuH*0.1)
    saveButton:SetPos(menuW - menuW*0.25, menuH - 60)
    saveButton:SetText("Sauvegarder")
    saveButton:SetFont("ComfortaaBold")
    saveButton:SetTextColor(Color(255, 255, 255, 255))
    saveButton.Paint = function(self, w, h)
        draw.RoundedBox(16, 0, 0, w, h, colorToUse)
    end

    saveButton.DoClick = function()
        local selectedColor = colorDropdown:GetSelected()
        local steamID = LocalPlayer():SteamID64() or "unknown_player"
        local playerFolder = "bw_menu_achat_xp/" .. steamID .. "/"

        -- Création du dossier si nécessaire
        if not file.IsDir(playerFolder, "DATA") then
            file.CreateDir(playerFolder)
        end

        -- Sauvegarde de la couleur choisie
        file.Write(playerFolder .. "color_config.txt", selectedColor or "Menthe")

        -- Sauvegarde de l'état des cases à cocher
        local xpVisibility = {}
        for i, checkbox in ipairs(xpCheckBoxes) do
            xpVisibility[i] = checkbox:GetChecked() and "true" or "false"
        end
        file.Write(playerFolder .. "xp_visibility_config.txt", table.concat(xpVisibility, "\n"))

        customizationMenu:Close()
        OpenBuyXpMenu()
    end

end

-- Modifier la fonction `OpenBuyXpMenu` pour utiliser les préférences du joueur
function OpenBuyXpMenu()
    local defaultColor, xpVisibility = LoadPlayerConfig()

    local scrW, scrH = ScrW(), ScrH()
    local menuW, menuH = (scrW * 0.4) * resolutionMultiplierW, (scrH * 0.4) * resolutionMultiplierH
    local mainMenu = vgui.Create("DFrame")
    mainMenu:SetSize(menuW, menuH)
    mainMenu:Center()
    mainMenu:SetTitle("")
    mainMenu:SetDraggable(true)
    mainMenu:ShowCloseButton(false)
    mainMenu:MakePopup()
    mainMenu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 230)) -- Arrière-plan noir
    end

    local buttonW, buttonH = menuW*0.18, menuH*0.10
    local classicLabelW, classicLabelH = menuW*0.5, menuH*0.10
    local xPos = menuW - buttonW*1.5 - paddingBorder
    local yPos = 0

    -- Panneau déroulant
    local scrollPanel = vgui.Create("DScrollPanel", mainMenu)
    scrollPanel:SetSize(menuW - paddingBorder * 2, menuH - (buttonH + paddingBorder * 3))
    scrollPanel:SetPos(paddingBorder, buttonH + paddingBorder * 2)

    -- Bouton de fermeture
    local closeButton = vgui.Create("DButton", mainMenu)
    closeButton:SetSize(menuW * 0.05, menuW * 0.05)
    closeButton:SetPos(menuW - buttonW * 0.5, paddingBorder)
    closeButton:SetText("")
    closeButton:SetFont("ComfortaaBold")
    closeButton:SetTextColor(Color(255, 255, 255, 255))

    local closebutton_backgroundImage = Material("materials/bw_menu_achat_xp/images/close_button_256x256.png")

    closeButton.Paint = function(self, w, h)
        surface.SetMaterial(closebutton_backgroundImage)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    closeButton.DoClick = function()
        mainMenu:Close()
    end

    -- Bouton de paramètres
    local settingsButton = vgui.Create("DButton", mainMenu)
    settingsButton:SetSize(menuW * 0.05, menuW * 0.05)
    settingsButton:SetPos(paddingBorder, paddingBorder)
    settingsButton:SetText("")
    settingsButton:SetFont("ComfortaaBold")
    settingsButton:SetTextColor(Color(255, 255, 255, 255))

    local settingsButton_backgroundImage = Material("materials/bw_menu_achat_xp/images/settings_gear_256x256.png")

    settingsButton.Paint = function(self, w, h)
        surface.SetMaterial(settingsButton_backgroundImage)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    settingsButton.DoClick = function()
        mainMenu:Close()
        OpenCustomizationMenu(CustomizationsColor[defaultColor])
    end

    -- Titre
    local titleLabelSizeW, titleLabelSizeH = menuW*0.5, menuH*0.2
    local title_label = vgui.Create("DLabel", mainMenu)
    title_label:SetSize(titleLabelSizeW, titleLabelSizeH)
    title_label:SetPos(((menuW*0.5)-(titleLabelSizeW*0.5)), 0)
    title_label:SetText("Acheter de l'exp")
    title_label:SetFont("ComfortaaTitle")
    title_label:SetTextColor(CustomizationsColor[defaultColor])

    -- Boutons d'achat d'XP
    for i, xpData in ipairs(BuyableXP) do
        if xpVisibility[i] then
            local button = vgui.Create("DButton", scrollPanel)
            button:SetSize(buttonW, buttonH)
            button:SetPos(xPos, yPos)
            button:SetText("Acheter")
            button:SetFont("ComfortaaBold")
            button:SetTextColor(Color(255, 255, 255, 255))
            button.Paint = function(self, w, h)
                draw.RoundedBox(16, 0, 0, w, h, CustomizationsColor[defaultColor])
            end

            button.DoClick = function()
                net.Start("BuyXpRequest")
                    net.WriteUInt64(xpData.Price)
                    net.WriteUInt64(xpData.NbrLevel)
                    net.WriteString(FormatMoneyValue(xpData.Price))
                net.SendToServer()
            end

            local xp_choice_label = vgui.Create("DLabel", scrollPanel)
            xp_choice_label:SetSize(classicLabelW, classicLabelH)
            xp_choice_label:SetPos(paddingBorder, yPos)
            xp_choice_label:SetText(xpData.NbrLevel .. " lvl pour " .. FormatMoneyValue(xpData.Price))
            xp_choice_label:SetFont("ComfortaaBold")
            xp_choice_label:SetTextColor(CustomizationsColor[defaultColor])

            yPos = yPos + buttonH + paddingBeetweenButton
        end
    end
end

-- Hook pour ouvrir le menu lorsque la commande est utilisée
hook.Add("OnPlayerChat", "OpenBuyXpMenuCommand", function(ply, text)
    if ply == LocalPlayer() then
        if text == "/buyxp" then
            OpenBuyXpMenu()
            return true
        end
    end
end)