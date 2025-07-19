AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local lastInteract = 0

function ScratchCardResult(ent)
    local PriceWinnedByPlayer = 0
    local WinnerLooserButtons = {0, 0, 0, 0, 0, 0, 0, 0, 0}

    local isWinningCard = math.random() * 100 <= ent.Config.PercentageOfWinnableCard

    if not isWinningCard then
        return WinnerLooserButtons, PriceWinnedByPlayer
    end

    local playerWinningSymbols = 0
    for _, prize in ipairs(ent.Config.PricesToWin) do
        if math.random() * 100 <= prize.PercentageOfDrop then
            playerWinningSymbols = tonumber(prize.HowManySymbolesToWin)
            PriceWinnedByPlayer = prize.WhatToWin
            break
        end
    end

    if playerWinningSymbols == 0 then
        return WinnerLooserButtons, PriceWinnedByPlayer
    end

    local remainingSymbols = playerWinningSymbols
    while remainingSymbols > 0 do
        local randomIndex = math.random(1, 9)
        if WinnerLooserButtons[randomIndex] == 0 then
            WinnerLooserButtons[randomIndex] = 1
            remainingSymbols = remainingSymbols - 1
        end
    end

    --print("Disposition des cases gagnantes et perdantes : ")
    for i = 1, #WinnerLooserButtons do
        print(WinnerLooserButtons[i] .. " ")
        if i % 3 == 0 then
            print("\n")
        end
    end
    --print("Gain du joueur : " .. PriceWinnedByPlayer)

    return WinnerLooserButtons, PriceWinnedByPlayer
end

function ENT:Initialize()
    self:SetModel(self.Model)

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end

end

function ENT:Use(activator, caller)

    local currentTime = CurTime()

    if currentTime - lastInteract < 0.2 then
        return
    end

    lastInteract = currentTime

    local WinnerLooserButtons, PriceWinnedByPlayer = ScratchCardResult(self)
    net.Start("BWRAITOX_LuckyCards_CallMenu")
    net.WriteTable(WinnerLooserButtons)
    net.WriteUInt64(PriceWinnedByPlayer)
    net.WriteEntity(activator)
    net.Send(activator)
end

net.Receive("BWRAITOX_LuckyCards_RemoveThisCard", function()
    ent = net.ReadEntity()
    ent:Remove()

end)

