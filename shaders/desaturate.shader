shader_type canvas_item;

void fragment(){
	// Get the color from the texture
	vec4 col = texture(SCREEN_TEXTURE,SCREEN_UV);
	COLOR = vec4(col.r * 0.3, col.g * 0.59, col.b * 0.11, 1);
}
	
