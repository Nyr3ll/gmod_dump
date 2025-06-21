util.AddNetworkString("BWRAITOX_LuckyCards_Rewards")
util.AddNetworkString("BWRAITOX_LuckyCards_Rewards_Answers")
util.AddNetworkString("BWRAITOX_LuckyCards_CallMenu")
util.AddNetworkString("BWRAITOX_LuckyCards_RemoveThisCard")

net.Receive("BWRAITOX_LuckyCards_Rewards", function()

    local playerWon = net.ReadBool()
    local winPrice = net.ReadUInt64()
    local ply = net.ReadEntity()

    ply:GiveMoney(winPrice)

    net.Start("BWRAITOX_LuckyCards_Rewards_Answers")
        net.WriteBool(playerWon)
        net.WriteUInt64(winPrice)
    net.Send(ply)

end)