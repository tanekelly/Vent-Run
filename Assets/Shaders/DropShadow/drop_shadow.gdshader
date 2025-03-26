shader_type canvas_item;

uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform vec2 shadow_offset = vec2(0.0, 10.0);

void fragment() {
    // Get texture pixel color for the current position
    vec4 sprite_color = texture(TEXTURE, UV);

    // Calculate shadow UV (reversed offset because we're moving the shadow, not the sample point)
    vec2 shadow_uv = UV - shadow_offset * TEXTURE_PIXEL_SIZE * 100.0;

    // Sample the texture at the shadow position with repeat disabled (using textureLod with bias=0)
    // This prevents the shadow from wrapping around to the other side
    vec4 shadow_sample = textureLod(TEXTURE, shadow_uv, 0.0);

    // Create the shadow with the sampled alpha
    vec4 shadow = vec4(shadow_color.rgb, shadow_sample.a * shadow_color.a);

    // First draw shadow, then overlay the sprite
    // This ensures shadow appears correctly regardless of offset
    if (shadow.a > 0.0) {
        COLOR = shadow;
    } else {
        COLOR = vec4(0.0); // Transparent background
    }

    // Overlay sprite on top of shadow
    if (sprite_color.a > 0.0) {
        COLOR = vec4(mix(COLOR.rgb, sprite_color.rgb, sprite_color.a), max(COLOR.a, sprite_color.a));
    }
}