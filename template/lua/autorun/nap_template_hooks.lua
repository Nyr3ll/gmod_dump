if SERVER then

    hook.Add("PlayerSay", "WailaCommand", function(ply, text)
        if string.lower(text) == "!nap_waila" then
            if ply:GetUserGroup() == "superadmin" then
                local trace = ply:GetEyeTrace()
                if trace.Entity and IsValid(trace.Entity) then
                    local className = trace.Entity:GetClass()
                    net.Start("NAP_WailaCommand")
                        net.WriteString(className)
                        net.WriteBool(true)
                    net.Send(ply)
                else
                    net.Start("NAP_WailaCommand")
                    net.WriteBool(false)
                    net.Send(ply)
                    
                end
            else
                net.Start("NAP_NotAcces")
                net.Send(ply)
            end
            return false
        end
        
    end)

end

if CLIENT then

    net.Receive("NAP_NotAcces", function()
        chat.AddText(Color(255, 255, 255), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_NotAcces"])
    end)

    net.Receive("NAP_WailaCommand", function()
        local className = net.ReadString()
        local goodArg = net.ReadBool()
        if goodArg then
            chat.AddText(Color(255, 255, 255), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_wailaCommand"][1], Color(235, 183, 52), className, Color(255,255,255), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_wailaCommand"][2])
        else
            chat.AddText(Color(255, 255, 255), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_wailaCommand"][3], Color(255, 0, 0), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_wailaCommand"][4], Color(255,255,255), NAP_TEMPLATE_LANGUAGES[NAP_TEMPLATE.Config.Language]["admincommand_wailaCommand"][5])
        end

    end)
end