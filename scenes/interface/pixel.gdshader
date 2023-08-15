shader_type canvas_item;

uniform int pixel_factor = 4;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment(){
	ivec2 size = textureSize(SCREEN_TEXTURE, 0);
	vec2 factor = vec2(size)/vec2(ivec2(max(pixel_factor,1)));
	vec2 pixelated_uv = round(UV * factor)/factor;
	
	COLOR = textureLod(SCREEN_TEXTURE, pixelated_uv, 0.0);
}