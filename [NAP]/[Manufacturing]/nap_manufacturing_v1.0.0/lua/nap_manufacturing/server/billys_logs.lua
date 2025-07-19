--[[

    To print information in BLogs you have to use those function :

        GAS.Logging:FormatProp(model)           --> Ajout le model du props dans les variables du logs
        GAS.Logging:FormatTeam(team)            --> Ajout le nom de l'équipe
        GAS.Logging:FormatPlayer(ply)           --> Print Player's name + his job
        GAS.Logging:Highlight(string)           --> Print the string in orange color
        GAS.Logging:FormatEntity(entityClass)   --> Print the entity class in orange color
        GAS.Logging:FormatMoney(moneyValue)     --> Print the money value in format "${moneyValue}"
        GAS.Logging:Format_____(theSubject)
        GAS.Logging:Format_____(theSubject)
        GAS.Logging:FormatCurrencyStr(amount)           --> 

]]

--------------------------------------------------------------------------------
-- Gardé tout mais changer les variables ou nom de variables
--------------------------------------------------------------------------------

local createBillysLogs = NAP_MANUF.Config.BillysLogsCompatibilite

if createBillysLogs then
    local MODULE = GAS.Logging:MODULE()

    MODULE.Category = "Tycoon"
    MODULE.Name = "WaterMoney"
    MODULE.Colour = Color(0, 135, 245, 255)

    function waterMoneyLog(staffMember, amount, target, newAmount)
        local toThisPerson = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["to_this_person"]
        local now_owns = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["now_owns"]
        local addingValue = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["added"]
        if amount <= 0 then
            addingValue = NAP_TYCOON_WP_LANGUAGES[NAP_TYCOON_WP_LANGUAGES.Language]["removed"]
        end
        MODULE:Setup(function()
            MODULE:Hook("MakingLog_WaterMoney", "NAP_TycoonWP_WaterMoneyLogs", MODULE:Log("{1} "..addingValue.." {2}"..toThisPerson.." {3}."..now_owns.."  {4}.", GAS.Logging:FormatPlayer(staffMember), GAS.Logging:Highlight(amount), GAS.Logging:FormatPlayer(target), GAS.Logging:Highlight(newAmount)))
        end)
        
        GAS.Logging:AddModule(MODULE)

    end

    GAS.Logging:AddModule(MODULE)


end
