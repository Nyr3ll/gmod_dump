local resolutionMultiplierW, resolutionMultiplierH = ScrW() / 1920, ScrH() / 1080
local tailleMaxCarteGratter = 800

--  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--  //         NE PAS TOUCHER A CA C'EST DES COMMENTAIRES POUR AVOIR LES RATIO POUR LE CÔTE RESPONSIVE         ///
-- //                                                                                                         ///   
-- 713x1024                                                                                                  ///
-- Ratio : 713 = 69.62890625% of 1024                                                                       ///
-- Ratio : paddingBetweenButtonX = 22.44039270687237% of 713                                               ///
-- Ratio : paddingBetweenButtonY = 15.625% of 1024                                                        ///
-- Ratio : buttonSize = 11.22019635343619% of 713                                                        ///
-- Ratio : closeButton:Size() = 5.61009817671809% of 713                                                ///
--  //////////////////////////////////////////////////////////////////////////////////////////////////////

surface.CreateFont("TextInGeneral", {
    font = "Comfortaa",
    size = 28,
    weight = 500,
})

function LuckyCardMenu_CloseConfirmation()
    
    surface.CreateFont("ConfTextFont", {
        font = "Comfortaa",
        size = 32,
        weight = 500,
    })

    local scrW, scrH = ScrW(), ScrH()
    local menuLuckyCard_closeConfirmation = vgui.Create("DFrame")
    menuLuckyCard_closeConfirmation:SetSize(scrW*0.35, scrH*0.20)
    menuLuckyCard_closeConfirmation:SetPos(scrW*0.50-(scrW*0.175), scrH*0.5-(scrH*0.10))
    menuLuckyCard_closeConfirmation:SetTitle("")
    menuLuckyCard_closeConfirmation:Center()
    menuLuckyCard_closeConfirmation:MakePopup()

    menuLuckyCard_closeConfirmation:ShowCloseButton(false)
    menuLuckyCard_closeConfirmation:SetDraggable(false)
    menuLuckyCard_closeConfirmation:SetSizable(false) 
    menuLuckyCard_closeConfirmation.Paint = function(self, w, h)
        draw.RoundedBox(16, 0, 0, w, h, Color(20, 20, 20, 245))
    end

    local menuLuckyCard_closeConfirmationSizeW, menuLuckyCard_closeConfirmationSizeH = menuLuckyCard_closeConfirmation:GetSize()

    local confLabel = vgui.Create("DLabel", menuLuckyCard_closeConfirmation)
    confLabel:SetPos(menuLuckyCard_closeConfirmationSizeW*0.1, menuLuckyCard_closeConfirmationSizeH*0.1)
    confLabel:SetSize(scrW*0.25, scrH*0.10)
    confLabel:SetText("Si vous fermer la carte à gratter elle sera perdue. Continuer et fermer la carte ?")
    confLabel:SetFont("ConfTextFont")
    confLabel:SetColor(Color(255, 255, 255))
    confLabel:SetWrap(true)
    confLabel:SetContentAlignment(5) 

    /*    If the player does want to close the scrating card         */
    local ColorClose = Color(90, 0, 0, 255)
    local confButton = vgui.Create("DButton", menuLuckyCard_closeConfirmation)
    confButton:SetSize(menuLuckyCard_closeConfirmationSizeW*0.3, menuLuckyCard_closeConfirmationSizeH*0.25)
    confButton:SetPos((menuLuckyCard_closeConfirmationSizeW*0.2)-(menuLuckyCard_closeConfirmationSizeW*0.15), menuLuckyCard_closeConfirmationSizeH*0.7)
    confButton:SetText("Oui")
    confButton:SetFont("ConfTextFont")

    confButton.DoClick = function()
        menuLuckyCard:Close()
        menuLuckyCard_closeConfirmation:Close()
    end

    confButton.Paint = function(self, w, h)
        draw.RoundedBox(16, 0, 0, w, h, ColorClose)
    end

    /*    If the player does NOT want to close the sratch card      */
    local ColorNotClose = Color(69, 204, 20, 255)
    local notConfButton = vgui.Create("DButton", menuLuckyCard_closeConfirmation)
    notConfButton:SetSize(menuLuckyCard_closeConfirmationSizeW*0.3, menuLuckyCard_closeConfirmationSizeH*0.25)
    notConfButton:SetPos((menuLuckyCard_closeConfirmationSizeW*0.8)-(menuLuckyCard_closeConfirmationSizeW*0.15), menuLuckyCard_closeConfirmationSizeH*0.7)
    notConfButton:SetText("Non")
    notConfButton:SetFont("ConfTextFont")

    notConfButton.DoClick = function()
        menuLuckyCard_closeConfirmation:Close()
        menuLuckyCard:Show()
    end
    
    notConfButton.Paint = function(self, w, h)
        draw.RoundedBox(16, 0, 0, w, h, ColorNotClose)
    end
end

function LuckyCardStatsMenu(cardConfig)

    surface.CreateFont("TextStats", {
        font = "Graduate Shades",
        size = 28*resolutionMultiplierW,
        weight = 500,
    })

    local cardInfos = cardConfig
    local menuLuckyCardStatsSizeW = (tailleMaxCarteGratter*0.6962890625) * resolutionMultiplierW
    local menuLuckyCardStatsSizeH = tailleMaxCarteGratter * resolutionMultiplierH

    menuLuckyCardStats = vgui.Create("DFrame")
    menuLuckyCardStats:SetSize(menuLuckyCardStatsSizeW, menuLuckyCardStatsSizeH)
    menuLuckyCardStats:SetTitle("")
    menuLuckyCardStats:Center()
    menuLuckyCardStats:MakePopup()

    menuLuckyCardStats:ShowCloseButton(false)
    menuLuckyCardStats:SetDraggable(false)
    menuLuckyCardStats:SetSizable(false) 

    local cardBackground = Material("materials/nap_luckycards/images/lucky_card_stats.png")

    function menuLuckyCardStats:Paint(width, height)
        surface.SetMaterial(cardBackground)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, width, height)
    end

    for i = 0, 6 do
        local statsLabel = vgui.Create("DLabel", menuLuckyCardStats)
        statsLabel:SetPos(menuLuckyCardStatsSizeW*0.445, ((menuLuckyCardStatsSizeH*0.455) + ((menuLuckyCardStatsSizeH*0.0575)*i)))
        statsLabel:SetSize(menuLuckyCardStatsSizeW*0.5, menuLuckyCardStatsSizeH*0.075)
        statsLabel:SetText(cardInfos["PricesToWin"][i+1].WhatToWin.."$")
        statsLabel:SetFont("TextStats")
        statsLabel:SetColor(Color(30, 65, 130))
        statsLabel:SetWrap(false)
        statsLabel:SetContentAlignment(4) 
    end

    

    local backwardButtonBackground = Material("materials/nap_luckycards/images/arrow_backward_256x256.png")
    local backwardButton = vgui.Create("DButton", menuLuckyCardStats)
    backwardButton:SetSize(menuLuckyCardStatsSizeW*0.0561009817671809, menuLuckyCardStatsSizeW*0.0561009817671809)
    backwardButton:SetPos(menuLuckyCardStatsSizeW * 0.925, menuLuckyCardStatsSizeH * 0.01)
    backwardButton:SetText("")
    backwardButton.Paint = function(self, w, h)
        surface.SetMaterial(backwardButtonBackground)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    backwardButton.DoClick = function()
        menuLuckyCard:Show()
        menuLuckyCardStats:Close()
    end
end

function LuckyCardBaseMenu(cardConfig, entIndex, WinnerLooserButtons, PriceWinnedByPlayer, ply)
    local menuLuckyCardSizeW = (tailleMaxCarteGratter*0.6962890625) * resolutionMultiplierW
    local menuLuckyCardSizeH = tailleMaxCarteGratter * resolutionMultiplierH

    -- [[          Main DFrame (name = menuLuckyCard)          ]]
    menuLuckyCard = vgui.Create("DFrame")
    menuLuckyCard:SetSize(menuLuckyCardSizeW, menuLuckyCardSizeH)
    menuLuckyCard:SetTitle("")
    menuLuckyCard:Center()
    menuLuckyCard:MakePopup()

    menuLuckyCard:ShowCloseButton(false)
    menuLuckyCard:SetDraggable(false)
    menuLuckyCard:SetSizable(false) 

    local cardBackground = Material(cardConfig["BackgroundImage"])

    function menuLuckyCard:Paint(width, height)
        surface.SetMaterial(cardBackground)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, width, height)
    end


    -- [[          Management of all button which you need to "scratch"          ]]
    local paddingBetweenButtonX = menuLuckyCardSizeW*0.2244039270687237
    local paddingBetweenButtonY = menuLuckyCardSizeH*0.15625
    local buttonSize = (menuLuckyCardSizeW*0.1122019635343619) * resolutionMultiplierW
    local buttonBackground = Material("materials/nap_luckycards/images/interrogation_256x256.png")
    local nbrClick = 0
    for i = 0, 8 do
        local button = vgui.Create("DButton", menuLuckyCard)
        button:SetSize(buttonSize, buttonSize)

        if i < 3 then
            button:SetPos((menuLuckyCardSizeW * 0.225) + paddingBetweenButtonX * i, (menuLuckyCardSizeH * 0.4725))
        elseif i < 6 then
            button:SetPos((menuLuckyCardSizeW * 0.225) + paddingBetweenButtonX * (i - 3), (menuLuckyCardSizeH * 0.4725) + paddingBetweenButtonY)
        else
            button:SetPos((menuLuckyCardSizeW * 0.225) + paddingBetweenButtonX * (i - 6), (menuLuckyCardSizeH * 0.4725) + 2 * paddingBetweenButtonY)
        end
        
        button:SetText("")

        button.Paint = function(self, w, h)
            surface.SetMaterial(buttonBackground)
            surface.SetDrawColor(cardConfig["Color"])
            surface.DrawTexturedRect(0, 0, w, h)
        end

        button.DoClick = function()
            nbrClick = nbrClick + 1
            local myImage = vgui.Create("DImage", menuLuckyCard)
            local clickedButtonPosX, clickedButtonPosY = button:GetPos()
            local clickedButtonSizeX, clickedButtonSizeY = button:GetSize()
            myImage:SetPos(clickedButtonPosX, clickedButtonPosY)
            myImage:SetSize(clickedButtonSizeX, clickedButtonSizeY)
            if WinnerLooserButtons[i+1] == 1 then
                myImage:SetImage("materials/nap_luckycards/images/money_256x256.png")
            else
                myImage:SetImage("materials/nap_luckycards/images/nothing_256x256.png")
            end
            button:Remove()

            if nbrClick > 8 then
                local playerWon = false
                if tonumber(PriceWinnedByPlayer) > 0 then
                    playerWon = true
                end
        
                net.Start("BWRAITOX_LuckyCards_Rewards")
                    net.WriteBool(playerWon)
                    net.WriteUInt64(PriceWinnedByPlayer)
                    net.WriteEntity(ply)
                net.SendToServer()
            end

        end
    end

    -- [[          Management of the close button          ]]
    local closeButtonBackground = Material("materials/nap_luckycards/images/close_button_256x256.png")
    local closeButton = vgui.Create("DButton", menuLuckyCard)
    closeButton:SetSize(menuLuckyCardSizeW*0.0561009817671809, menuLuckyCardSizeW*0.0561009817671809)
    closeButton:SetPos(menuLuckyCardSizeW * 0.925, menuLuckyCardSizeH * 0.01)
    closeButton:SetText("")
    closeButton.Paint = function(self, w, h)
        surface.SetMaterial(closeButtonBackground)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    closeButton.DoClick = function()
        LuckyCardMenu_CloseConfirmation()
        menuLuckyCard:Hide()
    end

    local statsButtonBackground = Material("materials/nap_luckycards/images/stats_256x256.png")
    local statsButton = vgui.Create("DButton", menuLuckyCard)
    statsButton:SetSize(menuLuckyCardSizeW*0.0561009817671809, menuLuckyCardSizeW*0.0561009817671809)
    statsButton:SetPos(menuLuckyCardSizeW * 0.825, menuLuckyCardSizeH * 0.01)
    statsButton:SetText("")
    statsButton.Paint = function(self, w, h)
        surface.SetMaterial(statsButtonBackground)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    statsButton.DoClick = function()
        menuLuckyCard:Hide()
        LuckyCardStatsMenu(cardConfig)
    end

end