shader_type canvas_item; // canvas_item = all 2d shaders

// uses a screen texture to render waht is underwater
//uniform sampler2D screen_texture: hint_screen_texture;
// A noise texture used to apply the distortion effect
uniform sampler2D noise_texture: filter_nearest, repeat_enable;

// Strength of the distortion effect
uniform float distortion = 0.01;
uniform vec2 speed = vec2(0.5, 0.3);

void vertex() {

}

void light() {
	float pulse = 1.2 + sin(TIME * 1.75) * 0.25;
	// Emissive lava glow (not affected by Light2D)
	vec3 emission = COLOR.rgb * 0.3 * pulse;
	//
	LIGHT = vec4(emission, COLOR.a);
}
