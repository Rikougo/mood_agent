shader_type canvas_item;

uniform float u_colorFactor;

void fragment(){
	vec4 sample = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float grey = 0.21 * sample.r + 0.71 * sample.g + 0.07 * sample.b;
	
	COLOR = vec4(sample.r * u_colorFactor + grey * (1.0 - u_colorFactor), sample.g * u_colorFactor + grey * (1.0 - u_colorFactor), sample.b * u_colorFactor + grey * (1.0 - u_colorFactor), 1.0);
}