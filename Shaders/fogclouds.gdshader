shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}


uniform float radius : hint_range(0, 2000) = 540.0;

uniform float fade_width : hint_range(0, 500) = 100.0;

void fragment() {
	// Calculate pixel position relative to the center of the sprite in local coordinates
	vec2 sprite_size = vec2(textureSize(TEXTURE, 0));
	vec2 pixel_pos = UV * sprite_size;
	vec2 center = sprite_size * 0.5;
	float dist = distance(pixel_pos, center);

	if (dist < radius - fade_width) {
		discard;
	}

	float fade = smoothstep(radius - fade_width, radius, dist);
	COLOR.a *= fade;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
