AddCSLuaFile()

local entities = {
    "ent_alchemist_table",
    "ent_crystal_blue",
    "ent_crystal_green",
    "ent_crystal_orange",
    "ent_crystal_pruple",
    "ent_crystal_red",
    "ent_potion_jumpboost",
    "ent_potion_maxhealth"
}

for _, ent in ipairs (entities) do
    script.AddCSLuaFile("../entities/" .. ent .. "/cl_init.lua")
    script.AddCSLuaFile("../entities/" .. ent .. "/shared.lua")
    include("../entities/" .. ent .. "/init.lua")
end
