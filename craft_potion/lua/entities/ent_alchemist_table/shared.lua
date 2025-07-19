ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Table d'alchimiste"
ENT.Author = "Nyrell"
ENT.Category = "Craft Potion"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.AlcheTableInvCryst = {
    
    blue = 0,
    green = 0,
    orange = 0,
    purple = 0,
    red = 0
}

ENT.RecipeJumpBoost = {

    name = "Jump boost",
    ingredientNameSing = {"Crystal bleu", "Crystal vert", "Crystal orange", "Crystal mauve", "Crystal rouge"},
    ingredientNamePlu = {"Crystaux bleu", "Crystaux vert", "Crystaux orange", "Crystaux mauve", "Crystaux rouge"},
    ingredientEntitie = {"ent_crystal_blue", "ent_crystal_green", "ent_crystal_orange","ent_crystal_purple", "ent_crystal_red"},
    quantities = {1, 0, 2, 0, 0}
    
}

ENT.RecipeMaxHealth = {

    name = "Vie max",
    ingredientNameSing = {"Crystal bleu", "Crystal vert", "Crystal orange", "Crystal mauve", "Crystal rouge"},
    ingredientNamePlu = {"Crystaux bleu", "Crystaux vert", "Crystaux orange", "Crystaux mauve", "Crystaux rouge"},
    ingredientsEntitie = {"ent_crystal_blue", "ent_crystal_green", "ent_crystal_orange","ent_crystal_purple", "ent_crystal_red"},
    quantities = {0, 2, 0, 0, 2}


}