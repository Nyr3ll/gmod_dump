include("shared.lua")

local lastInteract = 0

function ENT:Draw()
    self:DrawModel()
end

net.Receive("BWRAITOX_LuckyCards_CallMenu", function()
    local WinnerLooserButtons = net.ReadTable()
    local PriceWinnedByPlayer =  net.ReadUInt64()

    local ply = net.ReadEntity()
    local trace = ply:GetEyeTrace()
    if trace.Entity and IsValid(trace.Entity) then
        local className = trace.Entity:GetClass()
        if className == "nap_luckycards_card_1" then
            local currentTime = CurTime()

            if currentTime - lastInteract < 0.2 then
                return
            end

            lastInteract = currentTime

            /*
            print("\nDEBUG\n")
            PrintTable(trace.Entity.Config)
            print("\nDEBUG\n")
            */
            local entIndex = trace.Entity:EntIndex()

            LuckyCardBaseMenu(trace.Entity.Config, entIndex, WinnerLooserButtons, PriceWinnedByPlayer, ply)

            
        end
    end
    
    net.Start("BWRAITOX_LuckyCards_RemoveThisCard")
    net.WriteEntity(trace.Entity)
    net.SendToServer()

end)