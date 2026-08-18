
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
    return mix(vec3(0.5), vec3(0.1), t); // Dark gray to medium gray
}

// Deus Ex: Human Revolution inspired Gold
vec3 colorDXHRGold(float t) {
    return mix(vec3(0.1, 0.1, 0.0), vec3(1.0, 0.55, 1.0), t); // A more vibrant, almost amber gold
}

vec3 colorMutedPurple(float t) {
    return mix(vec3(0.05, 0.0, 0.4), vec3(1.0, 1.0, 1.5), t);
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

// Function to generate a simple grid line pattern (simplified from previous)
float getSimpleGrid(vec2 uv_in, float scale, float thickness) {
    vec2 p = uv_in * scale;
    vec2 f = fract(p);
    float lines = min(f.x, 1.0 - f.x);
    lines = min(lines, f.y);
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

// Radial distortion function (for CRT/visor curvature) (kept)
vec2 distortUV(vec2 uv_in, float intensity) {
    vec2 centered_uv = uv_in - 0.5;
    float r = length(centered_uv);
    float distortion = 1.0 + r * r * intensity;
    return (centered_uv * distortion) + 0.5;
}

// CRT scanline effect (kept)
float scanlines(vec2 uv_in, float num_lines, float strength) {
    return smoothstep(0.0, 0.5, abs(sin(uv_in.y * num_lines * 3.14159))) * strength;
}

// Function to create a simple rectangle (or square) mask (kept)
float rect(vec2 uv_in, vec2 center, vec2 size) {
    vec2 d = abs(uv_in - center) - size * 0.5;
    return smoothstep(0.0, 0.01, max(d.x, d.y)); // Returns 0 inside, 1 outside
}

// Function to create a single line within the display for data readouts (kept)
float dataLine(vec2 uv_in, float y_pos, float thickness, float length_scale, float char_offset, float time_offset) {
    float line_y_dist = abs(uv_in.y - y_pos);
    float line_mask = smoothstep(thickness, 0.0, line_y_dist);

    float character_flicker = hash(floor(uv_in.x * 20.0 + iTime * time_offset + char_offset) + floor(uv_in.y * 50.0));
    character_flicker = smoothstep(0.7, 1.0, character_flicker);

    float x_bounds = smoothstep(0.0, 0.05, uv_in.x) * smoothstep(1.0, 0.95, uv_in.x);

    return line_mask * character_flicker * x_bounds * length_scale;
}


// --- Variation 24: Glitching Grid with Breathing Pulses (Smoothed Frames) ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION AND CENTERING
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV to -1 to 1 range
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction for the visual pattern

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern

    // Base dark background
    final_pattern_color = colorGunmetalBlack(0.05);

    // --- 1. Base Grid ---
    float grid_scale = 30.0; // Density of grid lines
    float grid_thickness = 0.01; // Thickness of grid lines
    float base_grid = getSimpleGrid(uv_pattern, grid_scale, grid_thickness); // Use uv_pattern for grid
    
    // Base grid color: muted blue with a hint of gold for consistency
    //vec3 base_grid_color = mix(colorMutedBlue(0.2), colorDXHRGold(0.05), base_grid);
    //final_pattern_color += base_grid_color * base_grid * 0.5; // Apply faint base grid


    // --- 2. Glitching Energy Pulses with Breathing Animation ---
    // Identify grid cells
    vec2 cell_id = floor(uv_pattern * grid_scale); // Use uv_pattern for cell identification
    vec2 cell_uv = fract(uv_pattern * grid_scale); // UV within the cell, using uv_pattern

    // Smoother random activation for energy pulses per cell
    float pulse_seed = cell_id.x * 59.3 + cell_id.y * 2.8;
    
    // Use fractional time for smooth transitions between random states
    float time_factor = iTime * 0.5; // Speed of state change (can adjust)
    float t_floor = floor(time_factor);
    float t_frac = fract(time_factor);

    // Get random values for current and next state
    float pulse_noise_curr = hash(pulse_seed + t_floor);
    float pulse_noise_next = hash(pulse_seed + t_floor + 1.0);
    
    // Interpolate smoothly between current and next random state
    float smoothed_pulse_noise = mix(pulse_noise_curr, pulse_noise_next, smoothstep(0.0, 1.0, t_frac));
    
    // Apply a higher power for sharper "pops" but still smooth transitions
    smoothed_pulse_noise = pow(smoothed_pulse_noise, 4.0); // Less aggressive pow than 8.0 for smoother fade


    // Create a pulse "wave" that spreads from the center of the active cell
    float pulse_center_dist = length(cell_uv - 0.5); // Distance from cell center
    
    // Make the pulse grow and shrink in a breathing manner
    // The pulse_noise now acts as an intensity modulator for the entire pulse shape
    float pulse_shape = 1.0 - smoothstep(0.0, 0.4, pulse_center_dist); // Basic inverse distance falloff
    pulse_shape = pow(pulse_shape, 2.0); // Sharpen the center of the pulse

    // Combine smoothed noise with the pulse shape
    // The smoothed_pulse_noise now directly controls the *intensity* of the pulse,
    // which will gradually rise and fall.
    float pulse_strength = smoothed_pulse_noise * pulse_shape;
    pulse_strength = clamp(pulse_strength, 0.0, 1.0);
    
    // Color for the pulse: bright gold
    vec3 pulse_color = colorDXHRGold(1.0);
    
    // Apply pulse to final_pattern_color
    final_pattern_color += pulse_color * pulse_strength * 2.5; // Boost brightness for the pulse


    // --- 3. Grid Distortion around Pulses ---
    // Distort UV around active pulses
    float distort_amount = pulse_strength * 0.02; // Distortion strength tied to pulse intensity
    vec2 distorted_uv = uv_pattern; // Initialize with uv_pattern
    distorted_uv.x += sin(uv_pattern.y * 50.0 + iTime * 10.0) * distort_amount; // Use uv_pattern here
    distorted_uv.y += cos(uv_pattern.x * 40.0 + iTime * 8.0) * distort_amount; // Use uv_pattern here

    // Recalculate grid with distorted UVs to show effect
    float distorted_grid = getSimpleGrid(distorted_uv, grid_scale, grid_thickness);
    
    // Mix the distorted grid on top of the original where the pulse is strong
    // Use pulse_strength for smooth mixing
    final_pattern_color = mix(final_pattern_color, colorMutedBlue(0.7) * distorted_grid * 1.5, pulse_strength * 0.8);


    // --- 4. Subtle Scanlines & Vignette ---
    // Scanlines applied to the overall fragment (using uv_terminal or fragCoord/iResolution.xy)
    float scanline_effect = scanlines(uv_terminal, iResolution.y / 1.5, 0.05);
    final_pattern_color -= scanline_effect * 0.1;

    // Vignette for focus, using uv_pattern since it's already centered [-1,1]
    float dist_from_center_pattern = length(uv_pattern);
    float vignette_strength = 0.3;
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
