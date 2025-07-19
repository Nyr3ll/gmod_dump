util.AddNetworkString("NAP_DEVTOOL_WailaCommand")
util.AddNetworkString("NAP_DEVTOOL_NotAcces")
util.AddNetworkString("NAP_DEVTOOL_WrongPermission")
util.AddNetworkString("NAP_DEVTOOL_TeleportAt")
util.AddNetworkString("NAP_DEVTOOL_TeleportAt_ServerAnswer")
util.AddNetworkString("NAP_DEVTOOL_ViewsTogglerUpdater")


local cfg = NAP_DEVTOOL.Config
local language = NAP_DEVTOOL_LANGUAGES[cfg.Language]
local traceRanks = cfg.AllowedRanksViewsFeatures

local function IsPlayerInRankList(steamid64, ranks)
    local ply = player.GetBySteamID64(steamid64)

    if not IsValid(ply) then
        return false
    end

    local rank = ply:GetUserGroup()

    if table.HasValue(ranks, rank) then
        return true
    else
        return false
    end
end


net.Receive("NAP_DEVTOOL_ViewsTogglerUpdater", function()

    local ply = net.ReadPlayer()
    local string = net.ReadString()
    local newState = net.ReadBool()

    local canUseViewToggler = IsPlayerInRankList(ply:SteamID64(), traceRanks)
    if canUseViewToggler then
        ply:SetNWBool("NAP_DEVTOOL_"..string, newState)
    else
        net.Start("NAP_DEVTOOL_NotAcces")
        net.Send(ply)
    end
end)