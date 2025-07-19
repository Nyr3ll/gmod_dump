util.AddNetworkString("NAP_CUSTOM_SIGN_WrongPerm")
util.AddNetworkString("NAP_CUSTOM_SIGN_ApplyingSettings")
util.AddNetworkString("NAP_CUSTOM_SIGN_OpenEditMenu")
util.AddNetworkString("NAP_CUSTOM_SIGN_SendUIElements")


local cfg = NAP_CUSTOM_SIGN.Config
local lang = NAP_CUSTOM_SIGN[cfg.Language]

net.Receive("NAP_CUSTOM_SIGN_ApplyingSettings", function()

    local color = net.ReadColor()
    local target_sign = net.ReadEntity()
    local table = net.ReadTable()

    target_sign.UIElements = table

    net.Start("NAP_CUSTOM_SIGN_SendUIElements")
        net.WriteEntity(target_sign)
        net.WriteTable(target_sign.UIElements)
    net.Broadcast()
end)