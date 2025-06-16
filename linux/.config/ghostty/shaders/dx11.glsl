
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

// Thermal Color Gradient Function (kept) - Adjusted to be more flexible for "thermal"
vec3 getThermalColor(float val) {
    val = clamp(val, 0.0, 1.0);
    vec3 cold_color = colorMutedBlue(0.5);   // Blue for cool
    vec3 warm_color = colorDXHRGold(0.6);    // Gold for warm
    vec3 hot_color = vec3(0.8, 0.2, 0.1);    // Reddish for hot (subtle)
    
    if (val < 0.5) return mix(cold_color, warm_color, val / 0.5);
    return mix(warm_color, hot_color, (val - 0.5) / 0.5);
}


// Pseudo-random 3D vector for movement variation (kept)
vec3 hash3(float n) {
    return fract(sin(vec3(n, n * 2.0, n * 3.0)) * vec3(43758.5453, 22453.6483, 76842.1287));
}

// Radial distortion function (for CRT/visor curvature) (kept)
vec2 distortUV(vec2 uv_in, float intensity) {
    vec2 centered_uv = uv_in - 0.5;
    float r = length(centered_uv);
    float distortion = 1.0 + r * r * intensity;
    return (centered_uv * distortion) + 0.5;
}

// CRT scanline effect (kept, but adjusted for subtlety)
float scanlines(vec2 uv_in, float num_lines, float strength) {
    return smoothstep(0.0, 0.5, abs(sin(uv_in.y * num_lines * 3.14159))) * strength;
}

// Grid Line Function (kept)
float gridLines(vec2 uv_in, float scale, float thickness) {
    vec2 p = uv_in * scale;
    vec2 grid = fract(p) - 0.5;
    float line_x = smoothstep(thickness, 0.0, abs(grid.x));
    float line_y = smoothstep(thickness, 0.0, abs(grid.y));
    return max(line_x, line_y);
}

// Simple Square Wave (for glitch timing) (kept)
float squareWave(float t, float frequency) {
    return step(0.5, fract(t * frequency));
}

// Character drawing (simplified, for abstract data) (kept)
float char(vec2 uv, float char_id, float scale) {
    uv /= scale;
    uv.y += char_id; // Use char_id to select a 'row' of characters

    // Very simple abstract patterns representing characters
    if (char_id < 0.5) return smoothstep(0.05, 0.0, abs(uv.x - 0.5)) * smoothstep(0.05, 0.0, abs(uv.y - 0.5)); // Box
    else if (char_id < 1.5) return smoothstep(0.05, 0.0, abs(uv.x - 0.3)) + smoothstep(0.05, 0.0, abs(uv.y - 0.7)); // L-shape
    else if (char_id < 2.5) return smoothstep(0.05, 0.0, abs(uv.x - 0.7)) + smoothstep(0.05, 0.0, abs(uv.y - 0.3)); // Upside-down L
    return smoothstep(0.05, 0.0, length(uv - 0.5)); // Dot/circle
}


// --- Variation 32: Data Intercept / Signal Decryption ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION AND CENTERING
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV to -1 to 1 range
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction for the visual pattern

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern
    
    // Base very dark gunmetal black background
    final_pattern_color = colorGunmetalBlack(0.0); 

    // --- 1. Scrambled Data Background ---
    float scramble_scale = 40.0; // Density of scramble
    vec2 scramble_uv = uv_pattern * scramble_scale; // Use uv_pattern for scramble_uv
    vec2 scramble_id = floor(scramble_uv);
    vec2 scramble_frac = fract(scramble_uv);

    // Dynamic hash for each character cell, making it scramble rapidly
    float scramble_char_val = 0.0;
    for (int i = -1; i <= 1; i++) { // Check neighbors
        for (int j = -1; j <= 1; j++) {
            vec2 current_cell_id = scramble_id + vec2(float(i), float(j));
            float char_seed = hash(dot(current_cell_id, vec2(12.9898, 78.233)) + iTime * 20.0); // Fast time offset
            // Pass the correct local UV to the char function
            scramble_char_val += char(scramble_frac - vec2(float(i), float(j)), floor(char_seed * 4.0), 1.0);
        }
    }
    
    float scramble_intensity = 0.8; 
    final_pattern_color += colorMutedBlue(0.2) * scramble_char_val * scramble_intensity;


    // --- 2. Decryption Progress & Resolution ---
    // Simulate decryption progress: a value from 0.0 (scrambled) to 1.0 (clear)
    // This could be driven by a game state, but here it's time-based and cycles.
    float decryption_progress_cycle_time = 10.0; // Full cycle every 10 seconds
    float current_decryption_progress = fract(iTime / decryption_progress_cycle_time);
    // Use a smoothstep to make the transition more dramatic
    current_decryption_progress = smoothstep(0.0, 1.0, current_decryption_progress);
    
    // Reverse the progress for a "re-scramble" effect after decryption
    float resolve_phase = sin(current_decryption_progress * 3.14159 * 2.0) * 0.5 + 0.5; // Cycles from 0 to 1 and back to 0
    resolve_phase = pow(resolve_phase, 2.0); // Sharpen the "clear" moment

    // Clear data: A more ordered grid or specific pattern
    float clear_grid_strength = gridLines(uv_pattern * 25.0, 1.0, 0.01) * 0.5; // Use uv_pattern for gridLines
    clear_grid_strength += smoothstep(0.0, 1.0, fbm(uv_pattern * 8.0 + iTime * 0.1) * 0.5); // Use uv_pattern for fbm

    // Interpolate between scrambled and clear based on resolve_phase
    vec3 resolved_color = mix(colorMutedBlue(0.2), colorDXHRGold(0.5), clear_grid_strength);
    final_pattern_color = mix(final_pattern_color, resolved_color * 1.5, resolve_phase); // Overlay resolved data

    // Add a pulsing effect to the resolved data
    float resolved_pulse = sin(iTime * 12.0) * 0.5 + 0.5;
    final_pattern_color += resolved_color * resolved_pulse * resolve_phase * 0.5;

    // --- 4. Overall Screen Effects ---
    // Light scanlines. Use uv_terminal for this effect as it's a screen-level effect.
    float scanline_effect = scanlines(uv_terminal, iResolution.y / 1.5, 0.05); 
    final_pattern_color -= scanline_effect * 0.1;

    // Gentle vignette. Use uv_pattern for vignette calculation since it's centered and aspect-corrected.
    float dist_from_center_pattern = length(uv_pattern);
    float vignette_strength = 0.2;
    float edge_vignette = pow(dist_from_center_pattern, 2.0);
    final_pattern_color *= (1.0 - edge_vignette * vignette_strength);


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
