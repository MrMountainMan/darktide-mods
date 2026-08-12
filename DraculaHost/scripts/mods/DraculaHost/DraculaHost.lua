local mod = get_mod("DraculaHost")

local SimpleAudio

--tracks whether or not audio hooks have been initialized yet
--mod.hooks_initialized = false
--keeps track of the current daemonhost
--mod.current_daemonhost = nil
--mod.hooks_installed = false

--local vars
--local math_random = math.random
local volume_setting = function() return mod:get("dracula_volume") or 30 end
local minimum_interval = 8

local whisper1
local whisper2
local lifted
local awake
local attack
local leave

local last_play_global = 0

-- check that simpleAudio is found
mod.on_all_mods_loaded = function()
	SimpleAudio = get_mod("SimpleAudio")

	if not SimpleAudio then
		mod:error("SimpleAudio is required.")
        return
	end

    whisper1 = SimpleAudio.glob("dhsleep*.mp3")
    whisper2 = SimpleAudio.glob("dhawake*.mp3")
    lifted = SimpleAudio.glob("hostile/*.mp3")
    awake = SimpleAudio.glob("wakingup/*.mp3")
    attack = SimpleAudio.glob("attack/*.mp3")
    leave = SimpleAudio.glob("leave/*.mp3")

    SimpleAudio.hook_sound("loc_enemy_daemonhost_a__mantra_1_*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        whisper1:play({
            audio_type = "sfx",
            volume = volume_setting() / 2,
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

    SimpleAudio.hook_sound("loc_enemy_daemonhost_a__mantra_2_*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        whisper2:play({
            audio_type = "sfx",
            volume = volume_setting() / 2,
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

    SimpleAudio.hook_sound("play_enemy_daemonhost_lifted_sfx*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        lifted:play({
            audio_type = "sfx",
            volume = volume_setting() / 2,
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

    SimpleAudio.hook_sound("play_enemy_daemonhost_alert_scream*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        awake:play({
            audio_type = "sfx",
            volume = volume_setting(),
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

    SimpleAudio.hook_sound("play_enemy_daemonhost_teleport_in*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        attack:play({
            audio_type = "sfx",
            volume = volume_setting(),
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

    SimpleAudio.hook_sound("play_enemy_daemonhost_execute_player_impact*", function(sound_type, event_name, delta, position_or_unit_or_id)
        local playback_target
        local now = Managers.time:time("main")
        if now - last_play_global < minimum_interval then
            return
        end
        if sound_type == "3d_sound" or sound_type == "unit_sound" then
            playback_target = position_or_unit_or_id
        end
        local update_delay = 0
        leave:play({
            audio_type = "sfx",
            volume = volume_setting(),
            on_update = function(play_id, dt)
                update_delay = update_delay + dt
                if update_delay < 0.05 then
                    return
                end
                update_delay = 0
                SimpleAudio.set_position(play_id, position_or_unit_or_id)
            end,
        }, playback_target, 0.01, 0, 30)
        last_play_global = now
        return false
    end)

end


--[[

--hook boss spawner to get daemonhosts. track current daemonhost (maybe breaks when multiple hosts?)
mod.on_game_state_changed = function(status, state)
    if status == "enter" and state == "GameplayStateRun" then
        if SimpleAudio then
            if not mod.hooks_installed then
                mod:echo("installing dracula host hooks")
                --[[
                mod:hook_safe(CLASS.UnitSpawnerManager, "spawn_husk_unit", function(self, game_object_id, owner_id)
                    local unit_spawner_manager = Managers.state.unit_spawner
                    if not unit_spawner_manager then
                        return
                    end
                    local unit = unit_spawner_manager._network_units[game_object_id]
                    -- Get breed
                    local unit_data_ext = ScriptUnit.extension(unit, "unit_data_system")
                    local breed = unit_data_ext and unit_data_ext:breed()
                    local raw_breed_name = breed and breed.name


                    if raw_breed_name == "chaos_daemonhost" then
                        mod.current_daemonhost = game_object_id
                    end

                end)]--
                
                mod:hook_safe(BossExtension, "update", function(self, unit)
                    if Unit.alive(unit) and Unit.get_data(unit, "unit_name") == "content/characters/enemy/chaos_daemonhost_witch/third_person/base" then
                        mod.current_daemonhost = unit
                    end
                end)
                mod.hooks_installed = true
            end
        else
            mod:echo("SimpleAudio mod not found.")
        end
    end
end

local function play_audio(filepaths)
    if not SimpleAudio or not SimpleAudio.play_file then
        return
    end

    --choose a random file from the list
    local file_to_play = filepaths[math_random(#filepaths)]

    local now = Managers.time:time("main")

    if mod.current_daemonhost and now - last_play_time >= minimum_interval then
        --[[
        SimpleAudio.play_file(file_to_play, {
            audio_type = "sfx",
            volume = volume_setting(),
        }, mod.current_daemonhost, 0.01, 0, 100) --unit, decay, min_distance, max_distance
        ]--
        local update_delay = 0

        SimpleAudio.play_file(file_to_play, {
            audio_type = "sfx",
            volume = volume_setting(),
            on_update = function(play_id, dt)
                update_delay = update_delay + dt

                if update_delay < 0.05 then
                    return
                end

                update_delay = 0
                SimpleAudio.set_position(play_id, mod.current_daemonhost)
            end,
        }, mod.current_daemonhost)

        last_play_time = now
    end
end

mod:hook_safe(WwiseWorld, "trigger_resource_event", function(_, wwise_event_name, unit_or_position_or_id)
    if wwise_event_name:match("loc_enemy_daemonhost_a__mantra_1_") then --whispering while sleeping
        play_audio({
            "dhsleep1.mp3", "dhsleep2.mp3", "dhsleep3.mp3", "dhsleep4.mp3",
            "dhsleep5.mp3", "dhsleep6.mp3", "dhsleep7.mp3", "dhsleep8.mp3",
            "dhsleep9.mp3", "dhsleep10.mp3", "dhsleep11.mp3", "dhsleep12.mp3",
            "dhsleep13.mp3", "dhsleep14.mp3", "dhsleep15.mp3", "dhsleep16.mp3",
            "dhsleep17.mp3", "dhsleep18.mp3", "dhsleep19.mp3", "dhsleep20.mp3"
        })
    elseif wwise_event_name:match("loc_enemy_daemonhost_a__mantra_2_") then --starting to wake up
        play_audio({
            "dhawake1.mp3", "dhawake2.mp3", "dhawake3.mp3", "dhawake4.mp3",
            "dhawake5.mp3", "dhawake6.mp3", "dhawake7.mp3", "dhawake8.mp3",
            "dhawake9.mp3", "dhawake10.mp3", "dhawake11.mp3", "dhawake12.mp3",
            "dhawake13.mp3", "dhawake14.mp3", "dhawake15.mp3", "dhawake16.mp3",
            "dhawake17.mp3", "dhawake18.mp3", "dhawake19.mp3", "dhawake20.mp3",
            "dhawake21.mp3"
        })
    elseif wwise_event_name:match("play_enemy_daemonhost_execute_player_impact") then --killing player and leaving
        play_audio({
            "leave/i had to do it to them snipe.mp3",
            "leave/you see it i really did this im really him.mp3",
            "leave/garbanzo.mp3",
            "leave/continue.mp3",
            "leave/president.mp3",
            "leave/amnesia.mp3",
            "leave/slowly faded.mp3",
            "leave/10 bands.mp3",
            "leave/tied the opps.mp3",
            "leave/opps wanted some initiative.mp3",
            "leave/broke boy amazon.mp3",
            "leave/glock 34.mp3",
            "leave/opps was talkin crazy.mp3",
            "leave/had to cast a spell.mp3",
        })
    elseif wwise_event_name:match("play_enemy_daemonhost_teleport_in") then --teleporting to attack player
        play_audio({
            "attack/i live for this shit.mp3",
            "attack/meat cannon.mp3",
            "attack/aint nothin.mp3",
            "attack/yummy.mp3",
            "attack/ill kill you.mp3",
            "attack/aint nothin to me stupid.mp3",
            "attack/step wrong.mp3",
            "attack/smokin that ibm.mp3",
            "attack/sick in the head.mp3",
            "attack/him kardashian.mp3",
            "attack/need percs.mp3",
            "attack/one perc.mp3",
            "attack/what the fuck is obamacare.mp3",
            "attack/im moving like gilbert.mp3",
            "attack/my bitch pussy.mp3",
        })
    elseif wwise_event_name:match("play_enemy_daemonhost_lifted_sfx") then --floating while very close to waking up
        play_audio({
            "hostile/popped a perk 30 got straight to fuckin.mp3",
            "hostile/i need fent.mp3",
            "hostile/stop a demon.mp3",
            "hostile/pricetag.mp3",
            "hostile/lookin to beat.mp3",
            "hostile/smokin filtered.mp3",
            "hostile/mudflaps.mp3",
            "hostile/example.mp3",
            "hostile/consequences.mp3",
            "hostile/elite pussy.mp3",
            "hostile/too much money.mp3",
            "hostile/shit aint nothin ill kill you.mp3",
            "hostile/popped a bean.mp3",
            "hostile/this henny got me.mp3",
        })
    elseif wwise_event_name:match("play_enemy_daemonhost_alert_scream") then --woken up
        play_audio({
            "wakingup/we straight gassin cuttin straight to the bricks.mp3",
            "wakingup/that pussy better stank otherwise i dont want it.mp3",
            "wakingup/i see god.mp3",
            "wakingup/flipped a whole brick into an empire stop playin with me.mp3",
            "wakingup/smokin the qui gon gin.mp3",
            "wakingup/blac.mp3",
            "wakingup/scooby doo.mp3",
            "wakingup/broward county.mp3",
            "wakingup/curbstomp.mp3",
            "wakingup/bacon egg and cheese.mp3",
            "wakingup/my diamonds.mp3",
            "wakingup/glock at the vatican.mp3",
            "wakingup/i have more percs.mp3",
            "wakingup/drive a stake.mp3",
            "wakingup/war is all i think about.mp3",
            "wakingup/smokin the boomhauer.mp3",
            "wakingup/knew the perc was fake.mp3",
            "wakingup/this zaza.mp3",
            "wakingup/go to the mall.mp3",
        })
    else
        return
    end

end)


]]--


--[[

local Audio

local last_play_time = 0
local minimum_interval = 10
local volume_setting = function() return mod:get("dracula_volume") or 100 end

mod.current_daemonhost = nil
mod.hooks_initialized = false

mod.lv_lookup = {
    { "attacking_unit", "Unit" },
    { "position", "Vector3" },
    { "parent_unit", "Unit" },
    { "unit", "Unit" },
    { "dialogue_actor_unit", "Unit" },
}

-- === UTILS === --

local function getUserdataType(v)
    if type(v) ~= "userdata" then return nil end
    if Unit.alive(v) then return "Unit"
    elseif Vector3.is_valid(v) then return "Vector3"
    else return nil end
end

local function findLocalValue(targets)
    local level = 1
    while debug.getinfo(level) do
        local i = 1
        while true do
            local name, val = debug.getlocal(level, i)
            if not name then break end
            for _, t in ipairs(targets) do
                if name == t[1] and getUserdataType(val) == t[2] then return val end
            end
            i = i + 1
        end
        level = level + 1
    end
end

local function get_player_position()
    local player = Managers.player:local_player_safe(1)
    local unit = player and player.player_unit
    return unit and Unit.alive(unit) and POSITION_LOOKUP[unit] or Vector3.zero()
end

local function get_distance_to_player(pos_or_unit)
    local player_pos = get_player_position()
    local target_pos
    if type(pos_or_unit) == "userdata" and Unit.alive(pos_or_unit) then
        target_pos = POSITION_LOOKUP[pos_or_unit]
    elseif type(pos_or_unit) == "table" then
        target_pos = pos_or_unit
    end
    if player_pos and target_pos then
        return Vector3.distance(player_pos, target_pos)
    end
    return nil
end

local function adjust_volume_based_on_distance(distance, max_distance)
    local base = volume_setting()
    if not distance or not max_distance then
        return math.max(base, 75)
    end
    local vol = base - ((distance / max_distance) * 100)
    return math.clamp(vol, 75, 100)  -- Always at least 75
end

-- === AUDIO === --

local function play_sound_with_distance(audio_file, position_or_unit, max_distance)
    local distance = get_distance_to_player(position_or_unit)
    local volume = adjust_volume_based_on_distance(distance, max_distance)
    local pos = position_or_unit or get_player_position()
    Audio.play_file(audio_file, { audio_type = "sfx", volume = volume }, pos)
end

local function play_random_sound_from_list(audio_files, position_or_unit, max_distance)
    local file_to_play = audio_files[math_random(#audio_files)]
    play_sound_with_distance(file_to_play, position_or_unit, max_distance)
end

local function play_random_sound_from_list_no_distance(audio_files, position_or_unit)
    local file_to_play = audio_files[math_random(#audio_files)]
    Audio.play_file(file_to_play, { audio_type = "sfx", volume = volume_setting() }, position_or_unit or get_player_position())
end

local function resolve_unit_or_position(position_or_unit)
    if getUserdataType(position_or_unit) == "Unit" or getUserdataType(position_or_unit) == "Vector3" then
        return position_or_unit
    end
    return mod.current_daemonhost or findLocalValue(mod.lv_lookup) or get_player_position()
end

local function hook_sound_with_command(audio, sound_event, command)
    audio.hook_sound(sound_event, function(_, _, _, _, position_or_unit)
        local now = Managers.time:time("main")
        if now - last_play_time >= minimum_interval then
            local resolved = resolve_unit_or_position(position_or_unit)
            get_mod("DMF").run_command(command, resolved)
            last_play_time = now
        end
        return false
    end)
end

-- === HOOKS === --

local function initialize_sound_hooks(audio)
    for i = 1, 20 do
        hook_sound_with_command(audio, "loc_enemy_daemonhost_a__mantra_1_" .. string.format("%02d", i), "dhsleep")
    end
    for i = 1, 21 do
        hook_sound_with_command(audio, "loc_enemy_daemonhost_a__mantra_2_" .. string.format("%02d", i), "dhawake")
    end
    audio.hook_sound("play_enemy_daemonhost_execute_player_impact", function(_, _, _, _, pos)
        get_mod("DMF").run_command("leave", resolve_unit_or_position(pos))
        return false
    end)
    audio.hook_sound("play_enemy_daemonhost_teleport_in", function(_, _, _, _, pos)
        get_mod("DMF").run_command("attack", resolve_unit_or_position(pos))
        return false
    end)
    audio.hook_sound("play_enemy_daemonhost_lifted_sfx", function(_, _, _, _, pos)
        get_mod("DMF").run_command("wakingup", resolve_unit_or_position(pos))
        return false
    end)
    audio.hook_sound("play_enemy_daemonhost_alert_scream", function(_, _, _, _, pos)
        get_mod("DMF").run_command("hostile", resolve_unit_or_position(pos))
        return false
    end)
    mod.hooks_initialized = true
end

-- === GAMESTATE === --

mod.on_game_state_changed = function(status, state)
    if status == "enter" and state == "GameplayStateRun" and not mod.hooks_initialized then
        Audio = Audio or get_mod("Audio")
        if Audio then
            initialize_sound_hooks(Audio)
            mod:hook_safe(BossExtension, "update", function(self, unit)
                if Unit.alive(unit) and Unit.get_data(unit, "unit_name") == "content/characters/enemy/chaos_daemonhost_witch/third_person/base" then
                    mod.current_daemonhost = unit
                end
            end)
        else
            mod:echo("Audio mod not found.")
        end
    end
end

-- === COMMANDS === --

mod:command("dhsleep", "", function(pos)
    play_random_sound_from_list({
        "audio/dhsleep1.mp3", "audio/dhsleep2.mp3", "audio/dhsleep3.mp3", "audio/dhsleep4.mp3",
        "audio/dhsleep5.mp3", "audio/dhsleep6.mp3", "audio/dhsleep7.mp3", "audio/dhsleep8.mp3",
        "audio/dhsleep9.mp3", "audio/dhsleep10.mp3", "audio/dhsleep11.mp3", "audio/dhsleep12.mp3",
        "audio/dhsleep13.mp3", "audio/dhsleep14.mp3", "audio/dhsleep15.mp3", "audio/dhsleep16.mp3",
        "audio/dhsleep17.mp3", "audio/dhsleep18.mp3", "audio/dhsleep19.mp3", "audio/dhsleep20.mp3"
    }, pos, 30)
end)

mod:command("dhawake", "", function(pos)
    play_random_sound_from_list({
        "audio/dhawake1.mp3", "audio/dhawake2.mp3", "audio/dhawake3.mp3", "audio/dhawake4.mp3",
        "audio/dhawake5.mp3", "audio/dhawake6.mp3", "audio/dhawake7.mp3", "audio/dhawake8.mp3",
        "audio/dhawake9.mp3", "audio/dhawake10.mp3", "audio/dhawake11.mp3", "audio/dhawake12.mp3",
        "audio/dhawake13.mp3", "audio/dhawake14.mp3", "audio/dhawake15.mp3", "audio/dhawake16.mp3",
        "audio/dhawake17.mp3", "audio/dhawake18.mp3", "audio/dhawake19.mp3", "audio/dhawake20.mp3",
        "audio/dhawake21.mp3"
    }, pos, 30)
end)

mod:command("wakingup", "", function(pos)
    play_random_sound_from_list({
        "audio/wakingup/we straight gassin cuttin straight to the bricks.mp3",
        "audio/wakingup/that pussy better stank otherwise i dont want it.mp3",
        "audio/wakingup/i see god.mp3",
        "audio/wakingup/flipped a whole brick into an empire stop playin with me.mp3",
        "audio/wakingup/smokin the qui gon gin.mp3",
        "audio/wakingup/blac.mp3",
        "audio/wakingup/scooby doo.mp3",
        "audio/wakingup/broward county.mp3",
        "audio/wakingup/curbstomp.mp3",
        "audio/wakingup/bacon egg and cheese.mp3",
        "audio/wakingup/my diamonds.mp3",
        "audio/wakingup/glock at the vatican.mp3",
        "audio/wakingup/i have more percs.mp3",
        "audio/wakingup/drive a stake.mp3",
        "audio/wakingup/war is all i think about.mp3",
        "audio/wakingup/smokin the boomhauer.mp3",
        "audio/wakingup/knew the perc was fake.mp3",
        "audio/wakingup/this zaza.mp3",
        "audio/wakingup/go to the mall.mp3",
    }, pos, 30)
end)

mod:command("hostile", "", function(pos)
    play_random_sound_from_list_no_distance({
        "audio/hostile/popped a perk 30 got straight to fuckin.mp3",
        "audio/hostile/i need fent.mp3",
        "audio/hostile/stop a demon.mp3",
        "audio/hostile/pricetag.mp3",
        "audio/hostile/lookin to beat.mp3",
        "audio/hostile/smokin filtered.mp3",
        "audio/hostile/mudflaps.mp3",
        "audio/hostile/example.mp3",
        "audio/hostile/consequences.mp3",
        "audio/hostile/elite pussy.mp3",
        "audio/hostile/too much money.mp3",
        "audio/hostile/shit aint nothin ill kill you.mp3",
        "audio/hostile/popped a bean.mp3",
        "audio/hostile/this henny got me.mp3",
    }, pos)
    --Audio.play_file("audio/dhhostile.mp3", { audio_type = "sfx", volume = volume_setting() }, pos or get_player_position())
end)

mod:command("attack", "", function(pos)
    play_random_sound_from_list_no_distance({
        "audio/attack/i live for this shit.mp3",
        "audio/attack/meat cannon.mp3",
        "audio/attack/aint nothin.mp3",
        "audio/attack/yummy.mp3",
        "audio/attack/ill kill you.mp3",
        "audio/attack/aint nothin to me stupid.mp3",
        "audio/attack/step wrong.mp3",
        "audio/attack/smokin that ibm.mp3",
        "audio/attack/sick in the head.mp3",
        "audio/attack/him kardashian.mp3",
        "audio/attack/need percs.mp3",
        "audio/attack/one perc.mp3",
        "audio/attack/what the fuck is obamacare.mp3",
        "audio/attack/im moving like gilbert.mp3",
        "audio/attack/my bitch pussy.mp3",
    }, pos)
    --Audio.play_file("audio/dhattack.mp3", { audio_type = "sfx", volume = volume_setting() }, pos or get_player_position())
end)

mod:command("leave", "", function(pos)
    play_random_sound_from_list_no_distance({
        "audio/leave/i had to do it to them snipe.mp3",
        "audio/leave/you see it i really did this im really him.mp3",
        "audio/leave/garbanzo.mp3",
        "audio/leave/continue.mp3",
        "audio/leave/president.mp3",
        "audio/leave/amnesia.mp3",
        "audio/leave/slowly faded.mp3",
        "audio/leave/10 bands.mp3",
        "audio/leave/tied the opps.mp3",
        "audio/leave/opps wanted some initiative.mp3",
        "audio/leave/broke boy amazon.mp3",
        "audio/leave/glock 34.mp3",
        "audio/leave/opps was talkin crazy.mp3",
        "audio/leave/had to cast a spell.mp3",
    }, pos)
    --Audio.play_file("audio/dhleave.mp3", { audio_type = "sfx", volume = volume_setting() }, pos or get_player_position())
end)


]]--