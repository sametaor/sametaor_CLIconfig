
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

// Muted Purple (kept for palette consistency if needed later)
vec3 colorMutedPurple(float t) {
    return mix(vec3(0.05, 0.0, 0.1), vec3(0.3, 0.1, 0.5), t);
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

// Function to generate a triangular grid line pattern (kept)
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

// Function to generate a simple grid line pattern (kept)
float getGridLines(vec2 uv_in, float scale, float thickness, vec2 offset) {
    vec2 p = uv_in * scale;
    p += offset;

    vec2 f = fract(p); // Fractional part within cell
    float lines = min(f.x, f.y);
    lines = min(lines, 1.0 - f.x);
    lines = min(lines, 1.0 - f.y);

    return smoothstep(0.0, thickness, lines);
}

// Value Noise (simple implementation for organic look)
float valueNoise(vec2 p) {
    vec2 ip = floor(p);
    vec2 fp = fract(p);

    float a = dot(hash2(ip), vec2(0.5, 0.5));
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

// Thermal Color Gradient Function (kept)
vec3 getThermalColor(float val) {
    if (val < 0.2) return mix(colorGunmetalBlack(0.0), colorMutedBlue(0.1), val / 0.2);
    if (val < 0.4) return mix(colorMutedBlue(0.1), colorMutedBlue(0.6), (val - 0.2) / 0.2);
    if (val < 0.6) return mix(colorMutedBlue(0.6), vec3(0.0, 0.5, 0.5), (val - 0.4) / 0.2); // Cyan
    if (val < 0.8) return mix(vec3(0.0, 0.5, 0.5), colorDXHRGold(0.5), (val - 0.6) / 0.2); // Cyan to Gold
    if (val < 0.9) return mix(colorDXHRGold(0.5), colorDXHRGold(0.8), (val - 0.8) / 0.1); // Darker to brighter gold
    return mix(colorDXHRGold(0.8), vec3(1.0, 0.9, 0.6), (val - 0.9) / 0.1); // Brightest point, almost white-gold
}

// Pseudo-random 3D vector for movement variation (kept)
vec3 hash3(float n) {
    return fract(sin(vec3(n, n * 2.0, n * 3.0)) * vec3(43758.5453, 22453.6483, 76842.1287));
}

// NEW: Radial distortion function (for CRT/visor curvature)
// This function expects UVs in 0-1 range, outputs 0-1 range.
vec2 distortUV(vec2 uv_in, float intensity) {
    vec2 centered_uv = uv_in - 0.5;
    float r = length(centered_uv);
    float distortion = 1.0 + r * r * intensity;
    return (centered_uv * distortion) + 0.5;
}

// NEW: CRT scanline effect (not used in mainImage but kept)
float scanlines(vec2 uv_in, float num_lines, float strength) {
    return smoothstep(0.0, 0.5, abs(sin(uv_in.y * num_lines * 3.14159))) * strength;
}


// --- Variation 15: Cybernetic Visor Overlay ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION
    vec2 uv_pattern = fragCoord/iResolution.xy;

    // Apply initial distortion to uv_pattern to simulate lens/visor curvature
    // Note: distortUV expects 0-1 UVs, so apply before -1 to 1 centering
    uv_pattern = distortUV(uv_pattern, 0.1); // Adjust 0.1 for more/less curvature

    // Now center uv_pattern and apply aspect ratio correction
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV to -1 to 1 range
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern

    // Base background: very dark, subtle noise
    final_pattern_color = colorGunmetalBlack(0.05);
    final_pattern_color += fbm(uv_pattern * 5.0 + iTime * 0.01) * 0.01; // Subtle background noise

    // --- 2. Grid and Data Overlay ---
    // Background Grid
    float main_grid = getGridLines(uv_pattern * 10.0, 1.0, 0.01, vec2(iTime * 0.005));
    final_pattern_color += colorMutedBlue(0.1) * main_grid * 0.2; // Faint blue grid

    // Diagonal lines for dynamic data flow
    float diag_lines = abs(sin((uv_pattern.x + uv_pattern.y) * 20.0 - iTime * 0.5));
    diag_lines = smoothstep(0.9, 1.0, diag_lines);
    final_pattern_color += colorMutedBlue(0.2) * diag_lines * 0.1; // Faint diagonal lines


    // --- 3. Central Focus / Targeting Reticle ---
    vec2 center = vec2(0.0, 0.0); // Center is (0,0) in the -1 to 1 uv_pattern space
    float dist_from_center = length(uv_pattern - center); // Use uv_pattern for distance

    // Outer circle
    float outer_circle = smoothstep(0.5, 0.49, dist_from_center); // Faint outer circle
    outer_circle -= smoothstep(0.4, 0.39, dist_from_center);
    final_pattern_color += colorDXHRGold(0.5) * outer_circle * 0.5;

    // Crosshair lines
    float cross_thickness = 0.002;
    float crosshair = smoothstep(cross_thickness, 0.0, abs(uv_pattern.x)) + smoothstep(cross_thickness, 0.0, abs(uv_pattern.y)); // Use uv_pattern
    crosshair = clamp(crosshair, 0.0, 1.0); // Ensure it's not too bright
    final_pattern_color += colorDXHRGold(0.8) * crosshair * 0.8;

    // Inner pulsing dot/aura
    float inner_radius = 0.05;
    float inner_glow_dist = smoothstep(inner_radius, inner_radius * 0.8, dist_from_center);
    float pulse_time = sin(iTime * 5.0) * 0.5 + 0.5; // Fast pulse
    final_pattern_color += colorDXHRGold(0.9) * inner_glow_dist * pulse_time * 0.3;


    // --- 4. Edge Vignette / Lens Effect ---
    // Darken edges to simulate visor frame or lens falloff
    float vignette_strength = 0.5;
    float edge_vignette = pow(length(uv_pattern) * 0.8, 3.0); // Stronger falloff towards edges, use uv_pattern
    final_pattern_color *= (1.0 - edge_vignette * vignette_strength);


    // Apply overall glow and final color tweaks
    final_pattern_color += colorDXHRGold(0.05) * 0.02; // Subtle global gold ambient
    final_pattern_color += colorMutedBlue(0.05) * 0.03; // Subtle global blue ambient

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
