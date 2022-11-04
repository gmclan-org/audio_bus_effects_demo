
	// setup
	bus1 = audio_bus_create();
	e1 = audio_emitter_create();
	audio_emitter_bus(e1, bus1);
	
	enum demo_effects {
		reverb, delay, bitcrusher, lp, hp, gain
	}
	
	effects = [
		// Reverb
		{
			effect: audio_effect_create(AudioEffectType.Reverb1),
			name: "Reverb",
			settings: [
				"size", "damp", "mix"
			],
		},
		// Delay
		{
			effect: audio_effect_create(AudioEffectType.Delay),
			name: "Delay",
			settings: [
				"time", "feedback", "mix"
			],
		},
		// Bitcrusher <3
		{
			effect: audio_effect_create(AudioEffectType.Bitcrusher),
			name: "Bitcrusher",
			settings: [
				"gain", "factor", "resolution", "mix"
			],
		},
		// Lowpass
		{
			effect: audio_effect_create(AudioEffectType.LPF2),
			name: "Low-pass",
			settings: [
				"cutoff", "q"
			],
		},
		// Highpass
		{
			effect: audio_effect_create(AudioEffectType.HPF2),
			name: "High-pass",
			settings: [
				"cutoff", "q"
			],
		},
		// Gain
		{
			effect: audio_effect_create(AudioEffectType.Gain),
			name: "Gain",
			settings: [
				"gain"
			],
		},
	];
	
	current = demo_effects.bitcrusher;
	
	bus1.effects[0] = effects[current].effect;
	audio_play_sound_on(e1, snd_sample, true, 1, 1.0);
	
	// set some defaults:
	effects[demo_effects.reverb].effect.size = 0.7;
	effects[demo_effects.reverb].effect.damp = 0.6;
	effects[demo_effects.reverb].effect.mix = 0.8;
	
	effects[demo_effects.delay].effect.time = 0.2;
	effects[demo_effects.reverb].effect.feedback = 0.6;
	effects[demo_effects.reverb].effect.mix = 1;
	
	effects[demo_effects.bitcrusher].effect.gain = 1.0;
	effects[demo_effects.bitcrusher].effect.factor = 10;
	effects[demo_effects.bitcrusher].effect.resolution = 8;
	effects[demo_effects.bitcrusher].effect.mix = 1.0;
	
	effects[demo_effects.lp].effect.cutoff = 1000;
	
	effects[demo_effects.hp].effect.cutoff = 8000;
	
	effects[demo_effects.gain].effect.gain = 0.3;
	
	