shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 20.0) = 2.0;
uniform vec4 modulate_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

float gaussian(float x, float y, float sigma) {
    return exp(-(x*x + y*y) / (2.0 * sigma * sigma));
}

void fragment() {
    vec2 pixel_size = 1.0 / vec2(textureSize(TEXTURE, 0));

    vec4 color = texture(TEXTURE, UV);

    if (blur_amount > 0.0) {
        color = vec4(0.0);
        float total_weight = 0.0;

        float sigma = blur_amount * 0.5;

        int samples = int(min(ceil(blur_amount * 1.5), 15.0));

        for (int x = -samples; x <= samples; x++) {
            for (int y = -samples; y <= samples; y++) {
                float weight = gaussian(float(x), float(y), sigma);

                vec2 offset = vec2(float(x) * pixel_size.x, float(y) * pixel_size.y) * blur_amount * 0.3;
                vec2 sample_uv = UV + offset;

                if (sample_uv.x >= 0.0 && sample_uv.x <= 1.0 && sample_uv.y >= 0.0 && sample_uv.y <= 1.0) {
                    color += texture(TEXTURE, sample_uv) * weight;
                    total_weight += weight;
                }
            }
        }

        if (total_weight > 0.0) {
            color /= total_weight;
        }
    }

    color.rgb *= modulate_color.rgb;
    color.a *= modulate_color.a;

    COLOR = color;
}