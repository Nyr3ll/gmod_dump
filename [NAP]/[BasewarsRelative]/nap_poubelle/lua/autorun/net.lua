local function AddSpacesToNumberString(numString)
    local reversed = numString:reverse()
    local spacedReversed = reversed:gsub("(%d%d%d)", "%1 ")
    local spaced = spacedReversed:reverse():gsub("^%s+", "")
    return spaced
end

if CLIENT then

    net.Receive("BWNYRELL_FoundSomthings_InTrash", function()
        local alreadySearched = net.ReadBool()
        local timeRemaining = net.ReadFloat()
        local foundSomething = net.ReadBool()
        local whatFound = net.ReadString()
        local typeOfLoot = net.ReadString()
        local percentage = net.ReadFloat()

        percentage = math.Round(percentage*100, 1)

        if alreadySearched then

            chat.AddText(Color(255, 255, 255), "Déjà fouillé. Attendez encore ", Color(255, 0, 0), tostring(timeRemaining), Color(255, 255, 255), " secondes !")

        else
            if foundSomething then
                if typeOfLoot == "Money" then
                    whatFound = AddSpacesToNumberString(whatFound)
                    chat.AddText(Color(255, 255, 255), "Vous avez trouvé ", Color(0, 255, 0), whatFound, Color(255, 255, 255), "$ (", Color(0, 255, 0), tostring(percentage),Color(255, 255, 255), " % de votre argent)")
                
                elseif typeOfLoot == "Exp" then

                    whatFound = AddSpacesToNumberString(whatFound)
                    chat.AddText(Color(255, 255, 255), "Vous avez trouvé ", Color(0, 255, 0), whatFound, Color(255, 255, 255), "xp (", Color(0, 255, 0), tostring(percentage), Color(255, 255, 255), " % de l'exp pour passer au prochain niveau)")

                else

                    chat.AddText(Color(255, 255, 255), "Vous avez trouvé ", Color(0, 255, 0), whatFound)

                end
            else
                chat.AddText(Color(255, 255, 255), "Vous n'avez rien trouvé !")
            end
        end
    end)
end