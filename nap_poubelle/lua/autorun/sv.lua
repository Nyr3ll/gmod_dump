AddCSLuaFile("config.lua")
include("config.lua")

if SERVER then

    util.AddNetworkString("BWNYRELL_FoundSomthings_InTrash")
    util.AddNetworkString("BWNYRELL_StartLoadingBar")
    util.AddNetworkString("BWNYRELL_StopLoadingBar")
    util.AddNetworkString("BWNYRELL_FinishLoading")

end