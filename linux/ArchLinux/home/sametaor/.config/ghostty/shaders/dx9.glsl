
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

// CRT scanline effect (kept, but adjusted for subtlety)
float scanlines(vec2 uv_in, float num_lines, float strength) {
    return smoothstep(0.0, 0.5, abs(sin(uv_in.y * num_lines * 3.14159))) * strength;
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


// --- Variation 28: Neural Interface (Minimalist) ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION AND CENTERING
    vec2 uv_pattern = fragCoord/iResolution.xy;
    // Apply initial distortion for the pattern
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV to -1 to 1 range
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern
    
    // Base very dark gunmetal black background
    final_pattern_color = colorGunmetalBlack(0.0); 

    // --- 1. Neural Connections / Data Streams (Glowing Lines) ---
    // Create a grid of points, and draw lines between them
    float grid_density = 20.0; // How many points
    vec2 grid_uv = uv_pattern * grid_density; // Use uv_pattern for grid calculation
    vec2 grid_id = floor(grid_uv);
    vec2 grid_frac = fract(grid_uv);

    float line_effect = 0.0;
    float pulse_effect = 0.0;

    // Iterate through neighboring cells to draw connections
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            vec2 neighbor_id = grid_id + vec2(float(i), float(j));
            
            // Random offset for each point to make connections look organic/unstructured
            vec2 neighbor_offset = hash2(neighbor_id * 10.0); 
            // Animate point movement slightly
            neighbor_offset += sin(iTime * 1.5 + neighbor_id.x + neighbor_id.y) * 0.05;

            vec2 current_point_pos = neighbor_offset;
            vec2 local_uv = grid_frac;

            // Distance to the current connection point
            float dist_to_point = length(local_uv - current_point_pos);
            
            // Pulsating points
            float point_pulse = sin(iTime * 8.0 + (neighbor_id.x + neighbor_id.y) * 0.5) * 0.5 + 0.5;
            point_pulse = pow(point_pulse, 4.0); // Sharper pulse
            pulse_effect += smoothstep(0.08, 0.01, dist_to_point) * point_pulse;

            // Draw line from center of current cell to this neighbor's point
            vec2 line_start = vec2(0.5, 0.5); // Center of current cell
            vec2 line_end = current_point_pos;

            float line_dist_uv = distance(line_start, line_end);
            if (line_dist_uv > 0.001) { // Avoid division by zero
                vec2 line_dir = normalize(line_end - line_start);
                float proj_dist = dot(local_uv - line_start, line_dir);
                vec2 closest_point_on_line = line_start + line_dir * clamp(proj_dist, 0.0, line_dist_uv);
                
                float dist_to_line = length(local_uv - closest_point_on_line);
                // Fade lines that are too long
                line_effect += smoothstep(0.02, 0.005, dist_to_line) * (1.0 - smoothstep(0.0, 1.0, line_dist_uv));
            }
        }
    }
    line_effect = clamp(line_effect, 0.0, 1.0); // Clamp to prevent excessive brightness
    pulse_effect = clamp(pulse_effect, 0.0, 1.0);

    // Color glowing lines and pulses with DXHR Gold
    vec3 line_color = colorDXHRGold(0.8) * line_effect * 2.0;
    vec3 pulse_color = colorDXHRGold(1.0) * pulse_effect * 3.0; // Brighter pulses

    final_pattern_color += line_color;
    final_pattern_color += pulse_color;


    // --- 2. Overall Screen Effects ---
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
