shader_type canvas_item;

// Blur parameter
uniform float blur_amount : hint_range(0.0, 20.0) = 2.0;
// Modulate color parameter
uniform vec4 modulate_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Gaussian weight function for higher quality blur
float gaussian(float x, float y, float sigma) {
    return exp(-(x*x + y*y) / (2.0 * sigma * sigma));
}

void fragment() {
    // Calculate pixel size
    vec2 pixel_size = 1.0 / vec2(textureSize(TEXTURE, 0));
    
    // Get the base color at the current UV
    vec4 color = texture(TEXTURE, UV);
    
    // Only do the blur if we have a non-zero blur amount
    if (blur_amount > 0.0) {
        // Reset the color accumulation
        color = vec4(0.0);
        float total_weight = 0.0;
        
        // Calculate sigma for Gaussian blur (higher for smoother blur)
        float sigma = blur_amount * 0.5;
        
        // Determine sample count based on blur amount
        // Higher sample count for better quality
        int samples = int(min(ceil(blur_amount * 1.5), 15.0));
        
        // Full Gaussian blur in both directions
        for (int x = -samples; x <= samples; x++) {
            for (int y = -samples; y <= samples; y++) {
                // Gaussian weight provides much smoother blur
                float weight = gaussian(float(x), float(y), sigma);
                
                // Smaller step size between samples for higher resolution
                vec2 offset = vec2(float(x) * pixel_size.x, float(y) * pixel_size.y) * blur_amount * 0.3;
                vec2 sample_uv = UV + offset;
                
                // Stay in bounds
                if (sample_uv.x >= 0.0 && sample_uv.x <= 1.0 && sample_uv.y >= 0.0 && sample_uv.y <= 1.0) {
                    color += texture(TEXTURE, sample_uv) * weight;
                    total_weight += weight;
                }
            }
        }
        
        // Normalize by the total weight
        if (total_weight > 0.0) {
            color /= total_weight;
        }
    }
    
    // Apply modulate color
    color.rgb *= modulate_color.rgb;
    color.a *= modulate_color.a;
    
    // Output the result
    COLOR = color;
} 