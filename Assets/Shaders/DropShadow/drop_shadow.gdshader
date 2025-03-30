shader_type canvas_item;

uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform vec2 shadow_offset = vec2(0.0, 10.0);

void fragment() {
    vec4 sprite_color = texture(TEXTURE, UV);

    vec2 shadow_uv = UV - shadow_offset * TEXTURE_PIXEL_SIZE * 100.0;

    vec4 shadow_sample = textureLod(TEXTURE, shadow_uv, 0.0);

    vec4 shadow = vec4(shadow_color.rgb, shadow_sample.a * shadow_color.a);

    if (shadow.a > 0.0) {
        COLOR = shadow;
    } else {
        COLOR = vec4(0.0);
    }

    if (sprite_color.a > 0.0) {
        COLOR = vec4(mix(COLOR.rgb, sprite_color.rgb, sprite_color.a), max(COLOR.a, sprite_color.a));
    }
}