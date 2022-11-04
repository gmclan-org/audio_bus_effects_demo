

	if (keyboard_check_pressed(vk_enter)) {
		current = (current + 1) % array_length(effects);
		bus1.effects[0] = effects[current].effect;
	}
	
	if (not audio_is_playing(snd_sample)) {
		audio_play_sound_on(e1, snd_sample, true, 1, 1.0);
	}