shader_type canvas_item;

// Godot 4 requires a uniform to access the screen texture
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float strength : hint_range(0.0, 0.1) = 0.05;
uniform float frequency : hint_range(0.1, 50.0) = 10.0;
uniform float speed : hint_range(0.1, 10.0) = 2.0;

void fragment() {
    // Read the pixel currently on the screen at this location
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
	vec2 uv = SCREEN_UV;
	uv.x += sin(uv.y * frequency + TIME * speed) * strength;
	float r = 0.5 + 0.5 * sin(TIME);
    float g = 0.5 + 0.5 * sin(TIME + 2.0); // Offset for different timing
    float b = 0.5 + 0.5 * sin(TIME + 4.0);
    vec3 animated_color = vec3(r, g, b);
    COLOR = vec4(animated_color * screen_color.rgb, screen_color.a) + texture(screen_texture, uv);
}