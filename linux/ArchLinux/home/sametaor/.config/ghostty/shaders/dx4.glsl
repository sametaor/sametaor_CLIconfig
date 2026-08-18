
// --- Common Utilities (Place these at the top of your ShaderToy code) ---

// Deus Ex Color Palette Functions
vec3 colorMutedBlue(float t) {
    return mix(vec3(0.01, 0.02, 0.03), vec3(0.1, 0.2, 0.3), t); // Very dark to muted blue
}

vec3 colorGunmetalBlack(float t) {
    // Almost black, with a hint of very dark blue/gray
    return mix(vec3(0.01, 0.01, 0.015), vec3(0.05, 0.06, 0.07), t);
}

vec3 colorGray(float t) {
    return mix(vec3(0.05), vec3(0.4), t); // Dark gray to medium gray
}

// Deus Ex: Human Revolution inspired Gold
vec3 colorDXHRGold(float t) {
    return mix(vec3(0.2, 0.1, 0.0), vec3(1.0, 0.7, 0.2), t); // A more vibrant, almost amber gold
}

// Simple hash function for pseudo-random numbers (float input)
float hash(float n) { return fract(sin(n) * 43758.5453); }
// Hash function for vec2 input (returns vec2)
vec2 hash2(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yxz + 19.19);
    return fract((p3.xx+p3.yz)*p3.zy);
}

// Rotation function
mat2 rotate2D(float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c);
}

// Re-using the triangular lines for a subtle undercurrent, but focusing on new noise
float getTriangularLines(vec2 uv_in, float scale, float thickness, vec2 offset) {
    vec2 p = uv_in * scale;
    p += offset;

    vec2 h_coords = vec2(dot(p, vec2(0.866, 0.5)), dot(p, vec2(0.866, -0.5)));
    vec2 id = floor(h_coords);
    vec2 f = fract(h_coords);

    float tri_dist = min(min(f.x, f.y), min(1.0-f.x, 1.0-f.y));
    tri_dist = abs(tri_dist - 0.5) * 2.0;

    return smoothstep(0.0, thickness, tri_dist);
}

// REVISED: Value Noise (simple implementation for organic look)
float valueNoise(vec2 p) {
    vec2 ip = floor(p);
    vec2 fp = fract(p);

    // Use hash2 and sum/dot product to get a single float from vec2 input
    float a = dot(hash2(ip), vec2(0.5, 0.5)); // Sum components of hash2 output
    float b = dot(hash2(ip + vec2(1.0, 0.0)), vec2(0.5, 0.5));
    float c = dot(hash2(ip + vec2(0.0, 1.0)), vec2(0.5, 0.5));
    float d = dot(hash2(ip + vec2(1.0, 1.0)), vec2(0.5, 0.5));

    vec2 u = fp * fp * (3.0 - 2.0 * fp); // Smoothstep interpolation curve

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// Fractional Brownian Motion (FBM) - combines multiple octaves of noise for complexity
float fbm(vec2 p) {
    float f = 0.0;
    float amp = 0.5;
    float freq = 2.0;
    for (int i = 0; i < 5; i++) { // 5 octaves
        f += amp * valueNoise(p * freq);
        freq *= 2.0;
        amp *= 0.5;
    }
    return f;
}


// --- Variation 5: Adaptive Bio-Metallic Skin ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV for pattern
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction for the visual pattern

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern

    // Dynamic movement for the fluid noise
    vec2 noise_uv = uv_pattern * 4.0; // Scale the noise, using uv_pattern
    noise_uv.x += iTime * 0.2; // Move noise horizontally
    noise_uv.y += iTime * 0.1; // Move noise vertically

    // Get the complex noise pattern
    float fluid_noise = fbm(noise_uv);
    fluid_noise = smoothstep(0.2, 0.8, fluid_noise); // Sharpen the contrast of the noise

    // Apply color based on fluid noise
    // Dark base for the "skin"
    final_pattern_color = colorGunmetalBlack(0.05);

    // Muted blue and gray for the main body of the liquid metal
    vec3 base_metal_color = mix(colorMutedBlue(0.2), colorGray(0.3), 0.5);
    final_pattern_color = mix(final_pattern_color, base_metal_color, fluid_noise);

    // Add strong metallic reflections (using a simulated normal from noise)
    // To get a normal, we can sample noise slightly offset
    vec2 small_offset = vec2(0.01, 0.0);
    float nx = fbm(noise_uv + small_offset.xy);
    float ny = fbm(noise_uv + small_offset.yx);
    vec3 normal = normalize(vec3(nx - fluid_noise, ny - fluid_noise, 1.0)); // Simplified normal

    vec3 light_dir = normalize(vec3(sin(iTime*0.5), cos(iTime*0.5), 1.0)); // Moving light
    float NdotL = max(0.0, dot(normal, light_dir));

    vec3 view_dir = normalize(vec3(uv_pattern, 1.0)); // Use uv_pattern for view_dir
    vec3 halfway_dir = normalize(light_dir + view_dir); // Blinn-Phong specular

    float specular_power = 100.0; // Sharpness of highlights
    float specular = pow(max(0.0, dot(normal, halfway_dir)), specular_power);

    // Fresnel effect for edge reflections, gives more liquid metal feel
    float fresnel = pow(1.0 - max(0.0, dot(normal, view_dir)), 3.0); // Power of 3 for softer falloff

    // Apply metallic sheen primarily with gold and white highlights
    final_pattern_color += colorDXHRGold(specular * 0.8) * specular * 1.5; // Gold specular
    final_pattern_color += vec3(1.0) * fresnel * 0.5; // White fresnel for stronger metallic edge

    // Subtle "Titan Augmentation" glow (pulsing underneath the surface)
    float glow_intensity = (sin(iTime * 3.0) * 0.5 + 0.5);
    final_pattern_color += colorDXHRGold(glow_intensity * 0.5) * glow_intensity * 0.2; // Ambient gold glow

    // Subtle triangular pattern underlay (optional, for texture)
    // Use uv_pattern for getTriangularLines
    float tri_underlay = getTriangularLines(uv_pattern * 2.0, 5.0, 0.1, vec2(iTime * 0.05, iTime * 0.03));
    final_pattern_color = mix(final_pattern_color, colorMutedBlue(0.1), tri_underlay * 0.1); // Very faint blue grid

    // Apply gamma correction
    final_pattern_color = pow(final_pattern_color, vec3(1.0/2.2));

    // --- iChannel0 Blending ---
    // Sample the iChannel0 texture using uv_terminal (uncorrected)
    vec4 terminal_content = texture2D(iChannel0, uv_terminal);

    // Define how much of the shader pattern to show.
    float grid_opacity = 0.25; // Keeping this at a subtle value for readability.

    // Mix the terminal content with the generated shader pattern.
    vec3 final_output_color = mix(terminal_content.rgb, final_pattern_color, grid_opacity);

    // The final alpha value for the shader output.
    fragColor = vec4(final_output_color, terminal_content.a);
}
