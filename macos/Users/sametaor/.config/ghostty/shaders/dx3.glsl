
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

// Simple hash function for pseudo-random numbers
float hash(float n) { return fract(sin(n) * 43758.5453); }
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

// Function to generate a triangular grid line pattern
// uv_in will now always be uv_pattern for corrected aspect ratio
float getTriangularLines(vec2 uv_in, float scale, float thickness, float time_offset) {
    vec2 p = uv_in * scale;
    p += vec2(sin(iTime * 0.2 + time_offset * 1.0) * 0.5, cos(iTime * 0.3 + time_offset * 0.5) * 0.5); // Add subtle movement

    vec2 h_coords = vec2(dot(p, vec2(0.866, 0.5)), dot(p, vec2(0.866, -0.5)));
    vec2 id = floor(h_coords);
    vec2 f = fract(h_coords);

    float tri_dist = min(min(f.x, f.y), min(1.0-f.x, 1.0-f.y));
    tri_dist = abs(tri_dist - 0.5) * 2.0;

    return smoothstep(0.0, thickness, tri_dist);
}

// --- Variation 2 (Adjusted Further): Dark Core Cybernetics ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV for pattern
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction for the visual pattern

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern

    // REVISED: Base background color (starts with muted blue, will be mixed with gold)
    final_pattern_color = colorMutedBlue(0.1); // Slightly brighter base for subtle blue hint

    // Layer 1: Large, slow-moving, subtle lines (background layer)
    float lines1 = getTriangularLines(uv_pattern, 4.0 + sin(iTime * 0.05) * 1.0, 0.2, 0.0);
    // REVISED: Gunmetal lines on a slightly golden background
    vec3 layer1_color = mix(colorDXHRGold(0.1), colorGunmetalBlack(0.1), 0.5); // Very dark gold background, lighter gunmetal lines
    final_pattern_color = mix(final_pattern_color, layer1_color, 1.0 - lines1); // Blend by showing background color more

    // Layer 2: Medium size, slightly faster, gunmetal lines
    float lines2 = getTriangularLines(uv_pattern, 8.0 + cos(iTime * 0.1) * 2.0, 0.28, 10.0);
    // REVISED: Gunmetal for the lines
    vec3 layer2_color = colorGunmetalBlack(0.5); // Medium gunmetal for these lines
    // Add metallic reflection (subtle on dark)
    // Use uv_pattern for normalization
    float fresnel2 = pow(1.0 - dot(normalize(vec3(uv_pattern, 1.0)), normalize(vec3(0.0, 0.0, 1.0))), 2.0);
    layer2_color = mix(layer2_color, vec3(0.2), fresnel2 * smoothstep(0.5, 0.8, lines2) * 0.5); // Subtle dark reflections
    final_pattern_color = mix(final_pattern_color, layer2_color, lines2); // Blend over previous layer

    // Layer 3: Smaller, faster, sharper gunmetal lines (foreground details)
    vec2 uv_rotated = uv_pattern; // Rotate uv_pattern
    uv_rotated = rotate2D(iTime * 0.05) * uv_rotated;
    float lines3 = getTriangularLines(uv_rotated, 16.0 + sin(iTime * 0.2) * 3.0, 0.35, 20.0);

    // REVISED: Bright gunmetal for these lines for contrast against background
    vec3 layer3_color = colorGunmetalBlack(0.8);
    // Add stronger metallic reflection
    // Use uv_pattern for normalization
    float fresnel3 = pow(1.0 - dot(normalize(vec3(uv_pattern, 1.0)), normalize(vec3(0.0, 0.0, 1.0))), 4.0); // Sharper fresnel
    layer3_color = mix(layer3_color, vec3(0.4), fresnel3 * smoothstep(0.6, 0.9, lines3) * 0.6); // Stronger dark reflections
    final_pattern_color = mix(final_pattern_color, layer3_color, lines3); // Blend over previous layer

    // REVISED: "Titan augmentation" glow should now be the *background* color, pulsing and shining through the dark patterns
    // Use lines3 and uv_pattern for calculations
    float bg_glow_intensity = smoothstep(0.0, 0.2, 1.0 - lines3); // Glow strongest where lines3 is absent (background)
    bg_glow_intensity *= (sin(iTime * 4.0) * 0.5 + 0.5) * 0.4 + 0.2; // Pulsing glow
    final_pattern_color += colorDXHRGold(bg_glow_intensity * 0.7) * bg_glow_intensity * 7.0; // Add strong gold glow to background

    // Apply gamma correction for better visual range to the pattern BEFORE blending
    final_pattern_color = pow(final_pattern_color, vec3(1.0/2.2));

    // --- iChannel0 Blending ---
    // Sample the iChannel0 texture using uv_terminal (uncorrected)
    vec4 terminal_content = texture2D(iChannel0, uv_terminal);

    // Define how much of the grid pattern to show.
    // Keeping this at a subtle value for readability.
    float grid_opacity = 0.25;

    // Mix the terminal content with the generated shader pattern.
    vec3 final_output_color = mix(terminal_content.rgb, final_pattern_color, grid_opacity);

    // The final alpha value for the shader output.
    fragColor = vec4(final_output_color, terminal_content.a);
}
