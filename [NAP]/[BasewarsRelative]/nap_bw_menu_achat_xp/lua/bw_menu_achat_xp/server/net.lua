util.AddNetworkString("BuyXpRequest")
util.AddNetworkString("BWNYRELL_BuyXP_Answer")
util.AddNetworkString("BWNYRELL_BuyXP_ValueToServer")

-- Réception de la demande du client
net.Receive("BuyXpRequest", function(len, ply)

    -- Vérifier que le joueur a suffisamment d'argent, etc. (ceci est à personnaliser selon tes besoins)

    local playerMoney = tonumber(ply:GetMoney()) -- Convertir en nombre si ce n'est pas déjà un nombre
    local cost = tonumber(net.ReadUInt64())
    local nbrLevel = net.ReadUInt64()
    local costLabel = net.ReadString()

    if not playerMoney or not cost then
        print("Erreur : Les valeurs de 'playerMoney' ou 'cost' ne sont pas des nombres valides.")
        return
    end

    -- Vérifier si le joueur peut acheter de l'XP
    if ply:GetMoney() >= cost then
        ply:GiveMoney(-cost)  -- Retirer l'argent du joueur
        ply:AddLevel(nbrLevel)  -- Ajouter un niveau d'XP au joueur

        net.Start("BWNYRELL_BuyXP_Answer")
            net.WriteBool(true)
            net.WriteString(tostring(nbrLevel))
            net.WriteString(costLabel)
        net.Send(ply)
    else
        net.Start("BWNYRELL_BuyXP_Answer")
            net.WriteBool(false)
            net.WriteString("0")
            net.WriteString(costLabel)
        net.Send(ply)
    end
end)