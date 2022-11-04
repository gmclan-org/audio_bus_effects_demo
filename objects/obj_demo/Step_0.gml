

	if (keyboard_check_pressed(vk_enter)) {
		current = (current + 1) % array_length(effects);
		bus1.effects[0] = effects[current].effect;
	}