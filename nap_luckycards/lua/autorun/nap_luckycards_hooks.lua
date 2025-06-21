if CLIENT then

    net.Receive("BWRAITOX_LuckyCards_Rewards_Answers", function()

        local playerWon = net.ReadBool()
        local winPrice = net.ReadUInt64()

        if playerWon then
            chat.AddText(Color(255, 255, 255), "Vous avez ", Color(108, 245, 66), "gagné ", Color(66, 245, 200), winPrice, Color(255, 255, 255), "$")
        else
            chat.AddText(Color(255, 255, 255), "Vous avez ", Color(255, 0, 0), "perdu ", Color(255, 255, 255), " n'hésitez pas à réessayer. Statistiquement ", Color(66, 245, 200), "90%", Color(255, 255, 255), " des joueurs arrêtent ", Color(66, 245, 200), "juste avant", Color(255, 255, 255), " de gagner le ", Color(108, 245, 66), "gros lot", Color(255, 255, 255), " !")
        end
    end)

end