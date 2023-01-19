
	var slider_width = 200;
	
	draw_set_halign(fa_right);
	draw_text(790, 550, "Created for gmclan.org\nSource (free) available on: github.com/gmclan-org");
	draw_set_halign(fa_left);

	draw_text(10, 10, "Audio bus demo");
	draw_text(10, 500, "Click on left half of slider to reduce, and right half to rise values.\nMouse wheel also works. Press Enter for next effect.");
		
	draw_text(10, 30, "Current effect: (" + string(current+1) + "/"+ string(array_length(effects)) + ") " + string(effects[current].name));
	
	var i, e, l = array_length(effects[current].settings);
	var _min, _max, _hover;
	
	for(i = 0; i < l; i++) {
		e = effects[current].settings[i];
		draw_text(10, 100 + i*100,
			e + ": " +
			string(effects[current].effect[$ e] ?? "unknown")
		);
		
		_min = 0;
		_max = 1;
		if (e == "resolution") _max = 16;
		if (e == "factor" or e == "q") _max = 100;
		if (e == "cutoff") _max = 20000;
		if (e == "rate") _max = 20;
		if (e == "intensity") _max = 1;
		if (e == "offset") _max = 1;
		if (e == "shape") _max = 4;
		
		_hover = false;
		
		if (mouse_x > 0 and mouse_x < 20 + slider_width) {
			if (mouse_y > 100 + i*100 and mouse_y < 200 + i*100) {
				_hover = true;
				
				draw_set_alpha(0.3);
					draw_set_color(c_red);
					draw_rectangle(10, 100 + i*100, 10 + slider_width/2, 200 + i*100, false);
					draw_set_color(c_green);
					draw_rectangle(10+slider_width/2, 100 + i*100, 10 + slider_width, 200 + i*100, false);
					draw_set_color(c_white);
				draw_set_alpha(1);
				
				// normally it's not good to check for input in draw event, but that's demo - and I wanted to write less code ;)
				if (mouse_check_button(mb_left) or mouse_wheel_up() or mouse_wheel_down()) {
					var _step = (_max - _min) / 20;
					if (e == "factor" or e == "resolution") _step = 1;
					if (e == "cutoff") _step = 100;
					if (e == "rate") _step = 0.1;
					if (e == "intensity") _step = 0.1;
					if (e == "offset") _step = 0.1;
					if (e == "shape") _step = 1;
					
					var _newval = 0;
					
					if (mouse_wheel_up() or (!mouse_wheel_down() and mouse_x > 10 + slider_width/2)) {
						// rise
						_newval = min(_max, effects[current].effect[$ e] + _step);
					} else {
						// lower
						_newval = max(_min, effects[current].effect[$ e] - _step);
					}
					
					// bug in beta
					// effects[current].effect[$ e] = _newval;
					/*
					as accessor [$ ""] and variable_struct_set() weren't working on runtime 2022.1100.0.214
					we need to do the trick:
					*/
					switch(e) {
						case "size": effects[current].effect.size = _newval; break;
						case "damp": effects[current].effect.damp = _newval; break;
						case "mix": effects[current].effect.mix = _newval; break;
						case "time": effects[current].effect.time = _newval; break;
						case "feedback": effects[current].effect.feedback = _newval; break;
						case "gain": effects[current].effect.gain = _newval; break;
						case "factor": effects[current].effect.factor = _newval; break;
						case "resolution": effects[current].effect.resolution = _newval; break;
						case "cutoff": effects[current].effect.cutoff = _newval; break;
						case "q": effects[current].effect.q = _newval; break;
						case "rate": effects[current].effect.rate = _newval; break;
						case "intensity": effects[current].effect.intensity = _newval; break;
						case "offset": effects[current].effect.offset = _newval; break;
						case "shape": effects[current].effect.shape = _newval; break;
					}
					
					//bus1.effects[0] = effects[current].effect;
				}
			}
		}
		
		draw_sprite_stretched(spr_slider, 1, 10, 150 - 32 + i*100, slider_width, 64);
		draw_sprite(spr_slider, 0, 10 + (effects[current].effect[$ e]/_max) * slider_width, 150 + i*100);
	}
	
	//var _debug = string(effects[current].effect);
	//_debug = string_replace_all(_debug, ",", ",\n");
	//draw_text(300, 50, _debug);