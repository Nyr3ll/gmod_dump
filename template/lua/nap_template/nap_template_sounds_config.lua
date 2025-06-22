
local function AddCustomSounds()    
    sound.Add({
        name = "template_sound_one",
        channel = CHAN_AUTO,
        volume = 0.5,
        level = 75,
        pitch = {95, 110},
        sound = "nap_template/pickaxe_hit_rock.wav"
    })

end

AddCustomSounds()
