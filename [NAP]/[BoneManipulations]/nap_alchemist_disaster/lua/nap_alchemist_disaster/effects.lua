local language = NAP_ALCH_DISASTER_LANG[NAP_ALCH_DISASTER_LANG.Language]
-- language["TARGET-DIALOGUE"]
local BONE_INDEX = NAP_ALCH_DISASTER.Bones

NAP_ALCH_DISASTER_EFFECTS = NAP_ALCH_DISASTER_EFFECTS or {}

NAP_ALCH_DISASTER_EFFECTS = {
    -- ////////////////////////////////////////////
    --              DEFAULT EFFECTS
    -- ////////////////////////////////////////////
    ["BigHead"] = {
        Name = language["NAP_AD_EffectName_GrowthSpurt"],
        Desc = language["NAP_AD_EffectDesc_GrowthSpurt"],
        Duration = 10,
        Stackable = false,
        MaxStack = 5,
        MaxDuration = 5,
        ["StatsModifiers"] = {
            StatsModifier = true,
            HealthMultiplier = 1,
            ArmorMultiplier = 1,
            SpeedMultiplier = 1,
            ViewMultiplier = 1,
            JumpHeightMultiplier = 1,
        },
        ["BodyModifiers"] = {
            BodyModifier = true,
            ["WholeBody"] = {
                ColorModifier = Color(237, 192, 69),
            },
            ["Head"] = {
                SizeModifier = Vector(1.3, 1.3, 1.3),
                Bones = {
                    BONE_INDEX["Head"],
                },
            },
            ["Neck"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Neck"],
                },
            },
            ["Torso"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Spine1"],
                    BONE_INDEX["Spine2"],
                    BONE_INDEX["Spine3"],
                    BONE_INDEX["Spine4"],
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["Pelvis"],
                }
            },
            ["RightArm"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["RightUpperArm"],
                    BONE_INDEX["RightForearm"],
                    BONE_INDEX["RUlna"],
                    BONE_INDEX["RWrist"],
                    BONE_INDEX["RElbow"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RShoulder"],
                    BONE_INDEX["RTrapezius"],   
                }
            },
            ["LeftArm"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["LeftUpperArm"],
                    BONE_INDEX["LeftForearm"],
                    BONE_INDEX["LUlna"],
                    BONE_INDEX["LWrist"],
                    BONE_INDEX["LElbow"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LShoulder"],
                    BONE_INDEX["LTrapezius"],   
                }

            },
            ["RightLeg"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["RTight"],
                    BONE_INDEX["RCalf"],
                    BONE_INDEX["RFoot"],
                    BONE_INDEX["RToe"],
                }
            },
            ["LeftLeg"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["LTight"],
                    BONE_INDEX["LCalf"],
                    BONE_INDEX["LFoot"],
                    BONE_INDEX["LToe"], 
                }
            }


        },
        IsPersistent = false, -- If you want effect keep going even if the target died
    },
    ["InflateArms"] = {
        Name = language["NAP_AD_EffectName_InflateArms"],
        Desc = language["NAP_AD_EffectDesc_InflateArms"],
        Duration = 10,
        Stackable = false,
        MaxStack = 5,
        MaxDuration = 5,
        ["StatsModifiers"] = {
            StatsModifier = true,
            HealthMultiplier = 1,
            ArmorMultiplier = 1,
            SpeedMultiplier = 1,
            ViewMultiplier = 1,
            JumpHeightMultiplier = 1,
        },
        ["BodyModifiers"] = {
            BodyModifier = true,
            ["WholeBody"] = {
                ColorModifier = Color(237, 192, 69),
            },
            ["Head"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Head"],
                },
            },
            ["Neck"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Neck"],
                },
            },
            ["Torso"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Spine1"],
                    BONE_INDEX["Spine2"],
                    BONE_INDEX["Spine3"],
                    BONE_INDEX["Spine4"],
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["Pelvis"],
                }
            },
            ["RightArm"] = {
                SizeModifier = Vector(1.3, 1.3, 1.3),
                Bones = {
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["RightUpperArm"],
                    BONE_INDEX["RightForearm"],
                    BONE_INDEX["RUlna"],
                    BONE_INDEX["RWrist"],
                    BONE_INDEX["RElbow"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RShoulder"],
                    BONE_INDEX["RTrapezius"],   
                }
            },
            ["LeftArm"] = {
                SizeModifier = Vector(1.3, 1.3, 1.3),
                Bones = {
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["LeftUpperArm"],
                    BONE_INDEX["LeftForearm"],
                    BONE_INDEX["LUlna"],
                    BONE_INDEX["LWrist"],
                    BONE_INDEX["LElbow"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LShoulder"],
                    BONE_INDEX["LTrapezius"],   
                }

            },
            ["RightLeg"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["RTight"],
                    BONE_INDEX["RCalf"],
                    BONE_INDEX["RFoot"],
                    BONE_INDEX["RToe"],
                }
            },
            ["LeftLeg"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["LTight"],
                    BONE_INDEX["LCalf"],
                    BONE_INDEX["LFoot"],
                    BONE_INDEX["LToe"], 
                }
            }


        },
        IsPersistent = false, -- If you want effect keep going even if the target died
    },
    ["RunnerLegs"] = {
        Name = language["NAP_AD_EffectName_RunnerLegs"],
        Desc = language["NAP_AD_EffectDesc_RunnerLegs"],
        Duration = 10,
        Stackable = false,
        MaxStack = 5,
        MaxDuration = 5,
        ["StatsModifiers"] = {
            StatsModifier = true,
            HealthMultiplier = 1,
            ArmorMultiplier = 1,
            SpeedMultiplier = 1,
            ViewMultiplier = 1,
            JumpHeightMultiplier = 1,
        },
        ["BodyModifiers"] = {
            BodyModifier = true,
            ["WholeBody"] = {
                ColorModifier = Color(237, 192, 69),
            },
            ["Head"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Head"],
                },
            },
            ["Neck"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Neck"],
                },
            },
            ["Torso"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["Spine1"],
                    BONE_INDEX["Spine2"],
                    BONE_INDEX["Spine3"],
                    BONE_INDEX["Spine4"],
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["Pelvis"],
                }
            },
            ["RightArm"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["RightClavicle"],
                    BONE_INDEX["RightUpperArm"],
                    BONE_INDEX["RightForearm"],
                    BONE_INDEX["RUlna"],
                    BONE_INDEX["RWrist"],
                    BONE_INDEX["RElbow"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RBicep"],
                    BONE_INDEX["RShoulder"],
                    BONE_INDEX["RTrapezius"],   
                }
            },
            ["LeftArm"] = {
                SizeModifier = Vector(1, 1, 1),
                Bones = {
                    BONE_INDEX["LeftClavicle"],
                    BONE_INDEX["LeftUpperArm"],
                    BONE_INDEX["LeftForearm"],
                    BONE_INDEX["LUlna"],
                    BONE_INDEX["LWrist"],
                    BONE_INDEX["LElbow"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LBicep"],
                    BONE_INDEX["LShoulder"],
                    BONE_INDEX["LTrapezius"],   
                }

            },
            ["RightLeg"] = {
                SizeModifier = Vector(1.3, 1.3, 1.3),
                Bones = {
                    BONE_INDEX["RTight"],
                    BONE_INDEX["RCalf"],
                    BONE_INDEX["RFoot"],
                    BONE_INDEX["RToe"],
                }
            },
            ["LeftLeg"] = {
                SizeModifier = Vector(1.3, 1.3, 1.3),
                Bones = {
                    BONE_INDEX["LTight"],
                    BONE_INDEX["LCalf"],
                    BONE_INDEX["LFoot"],
                    BONE_INDEX["LToe"], 
                }
            },
        },
        IsPersistent = false, -- If you want effect keep going even if the target died
    },
}