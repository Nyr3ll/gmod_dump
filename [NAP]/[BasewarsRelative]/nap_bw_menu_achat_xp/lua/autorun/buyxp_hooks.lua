if CLIENT then

    net.Receive("BWNYRELL_BuyXP_Answer", function()
        local hasMoneyToBuy = net.ReadBool()

        if hasMoneyToBuy then
            local amountLvl = net.ReadString()
            local costLabel = net.ReadString()

            chat.AddText(Color(255, 255, 255), "Vous avez ", Color(0, 255, 0), " acheté ", Color(11, 227, 162), amountLvl, Color(255, 255, 255), " niveau(x) pour ",Color(255, 0, 0), costLabel, Color(255, 255, 255), " $")
        else
            chat.AddText(Color(255, 255, 255), "Vous ", Color(255, 0, 0), "n'avez pas", Color(255, 255, 255), " l'argent pour acheter ceci ! ")
        end
    end)
end