
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


// --- Variation 31: Augmentation Cooling System / Thermal Management Display ---

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

    // --- 1. Base Thermal Flow Pattern ---
    float flow_speed = iTime * 0.05;
    vec2 flow_uv_offset = vec2(cos(iTime * 0.1), sin(iTime * 0.07)) * 0.5; // Gentle overall drift
    
    // Generate swirling, turbulent noise for thermal patterns
    vec2 p_noise = uv_pattern * 3.0 + flow_uv_offset; // Use uv_pattern for noise
    float thermal_noise = fbm(p_noise + fbm(p_noise * 2.0 + iTime * 0.3) * 0.5); // More complex noise
    
    // Simulate heat dissipation / flow lines
    float thermal_flow_lines = smoothstep(0.015, 0.0, abs(fract(thermal_noise * 8.0 + iTime * 0.5) - 0.5));
    
    // Map noise value to thermal color gradient
    vec3 thermal_color_base = getThermalColor(thermal_noise);
    
    final_pattern_color += thermal_color_base * (0.1 + thermal_flow_lines * 7.0); // Base glow and lines


    // --- 2. Cooling Vents / Hotspots / Conduits ---
    // Define some fixed points for "vents" or "hotspots"
    // These positions are relative to the uv_pattern space (-1 to 1 range)
    vec2 vent_pos_1 = vec2(-0.4, 0.3);
    vec2 vent_pos_2 = vec2(0.5, -0.2);
    vec2 hot_pos_1 = vec2(0.0, 0.0); // Center hotspot / core

    // You can add more logic here to draw these vents/hotspots if desired
    // For example, using `length(uv_pattern - vent_pos_1)` and `smoothstep`

    // --- 3. Overall Screen Effects ---
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
