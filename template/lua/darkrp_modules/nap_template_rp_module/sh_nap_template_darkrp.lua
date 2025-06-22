DarkRP.createCategory{
    name = "NAP Template",
    categorises = "jobs",
    startExpanded = true,
    color = Color(4, 154, 181, 255),
    canSee = function(ply) return true end,
    sortOrder = 1,
}

TEAM_NAP_ALCHEMIST = DarkRP.createJob("Template", {
    color = Color(4, 154, 181, 255),
    model = {
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/group01/male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl"
    },
    description = [[A template job]],
    weapons = {"nap_pickaxe"},
    command = "nap_template_job_one",
    max = 0,
    salary = 30,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "NAP Template",
    /*
    Whitelist to "superadmin" & "admin" -> DEV purpose
    
    customCheck = function(ply) return ply:GetUserGroup() == "superadmin" end,
    CustomCheckFailMsg = "En cours de debug !"
    */
})
