shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

uniform vec4 color_workaround = vec4(1.0);
uniform float time_scale = 1.0;
uniform float pulse_strength = 1.0;

const int regions_in_sprite_sheet = 6;

void fragment() {
	float t = sin(2.0*PI*TIME*time_scale);
	t *= .9999;
	
	float N = float(regions_in_sprite_sheet);
	COLOR = texture(TEXTURE,vec2(1.0/N*(floor(N*(t+1.0)/2.0)+fract(N*UV.x)),UV.y));
	COLOR *= color_workaround;
	
	if(COLOR.a < .0001){
		vec2 corrected_texture_uv = vec2(fract(N*UV.x),UV.y);
		vec2 vec_from_center = corrected_texture_uv - vec2(.5);
		
		vec2 diff = normalize(vec_from_center)*pulse_strength*t*vec2(SCREEN_PIXEL_SIZE.x/SCREEN_PIXEL_SIZE.y,1.0)/50.0;
		
		COLOR = texture(screen_texture, SCREEN_UV-diff);
	}
}
