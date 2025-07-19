ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "BW Poubelle"
ENT.Author = "Nyrell"
ENT.Category = "[BW Nyrell] Poubelle"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.HasBeenSearched = false

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "TimeRemaining")

	if SERVER then
		self:SetTimeRemaining(BW_NYRELL.PoubelleConfig.CooldownAfterSearch)
	end
end


-- Définie le cooldown avant que la poubelle puisse à nouveau être fouillée
ENT.CooldownAfterSearch = BW_NYRELL.PoubelleConfig.CooldownAfterSearch

-- Tu change le modèle de base ici
ENT.Model = BW_NYRELL.PoubelleConfig.Model

-- Tu change le modèle quand elle est déjà loot (si tu veux pas changer de model tu peux mettre le même qu'au dessus)
ENT.OpenedModel = BW_NYRELL.PoubelleConfig.OpenedModel

-- Définie le pourcentage pour chaque type de loot
-- Par défaut j'ai mis 50% de chance d'avoir de l'argent, 45% de chance d'avoir de l'exp et 5% de chance d'avoir une arme
ENT.Percentage = BW_NYRELL.PoubelleConfig.Percentage

-- Définie les loots possibles
ENT.Loots = BW_NYRELL.PoubelleConfig.Loots

ENT.Model = BW_NYRELL.PoubelleConfig.Model
ENT.OpenedModel = BW_NYRELL.PoubelleConfig.OpenedModel