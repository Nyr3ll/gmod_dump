
local function AddCustomSounds()    
    sound.Add({
        name = "dev_tool_sound_one",
        channel = CHAN_AUTO,
        volume = 0.5,
        level = 75,
        pitch = {95, 110},
        sound = "nap_dev_tool/pickaxe_hit_rock.wav"
    })

end

AddCustomSounds()
