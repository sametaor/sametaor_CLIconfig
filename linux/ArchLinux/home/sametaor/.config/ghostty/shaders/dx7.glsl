
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


// --- Variation 20: Abstract Data Stream ---

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern = uv_pattern * 2.0 - 1.0; // Center UV to -1 to 1 range
    uv_pattern.x *= iResolution.x / iResolution.y; // Aspect ratio correction for the visual pattern

    vec3 final_pattern_color = vec3(0.0); // This will accumulate the shader's visual pattern

    // Base very dark background
    final_pattern_color = colorGunmetalBlack(0.0);

    // --- 1. Main Data Stream Flow ---
    float stream_speed = 0.2; // Speed of the data flow
    float stream_density = 5.0; // How dense the data particles are
    float stream_turbulence = 0.5; // Amount of wiggling/turbulence

    // Use FBM to create a flowing, turbulent field
    // Add time component to the Y-axis (or X for horizontal flow) for movement
    vec2 flow_uv = uv_pattern * stream_density; // Use uv_pattern for flow_uv
    flow_uv.y += iTime * stream_speed; // Vertical scroll
    flow_uv.x += fbm(uv_pattern * 3.0 + iTime * 0.1) * stream_turbulence; // Horizontal turbulence, use uv_pattern

    float data_pattern = fbm(flow_uv);
    data_pattern = pow(data_pattern, 2.0) * 1.5; // Amplify contrast and brightness
    data_pattern = clamp(data_pattern, 0.0, 1.0); // Ensure it stays within range

    // Add subtle, faster-moving "glitches" within the stream
    float micro_glitch = hash(floor(uv_pattern.x * 100.0 + iTime * 20.0) + floor(uv_pattern.y * 50.0)) * 0.1; // Use uv_pattern
    micro_glitch = smoothstep(0.9, 1.0, micro_glitch);
    data_pattern += micro_glitch;
    data_pattern = clamp(data_pattern, 0.0, 1.0);

    // Color the data stream
    vec3 stream_color_a = colorMutedBlue(0.8);
    vec3 stream_color_b = colorDXHRGold(0.9);

    // Mix colors based on data_pattern intensity
    vec3 colored_stream = mix(stream_color_a, stream_color_b, data_pattern);
    final_pattern_color += colored_stream * data_pattern * 0.8; // Apply stream to final color


    // --- 2. Background Digital Grid ---
    // A very faint, static grid behind the data stream for structure
    float bg_grid_val = getGridLines(uv_pattern * 15.0, 1.0, 0.005, vec2(0.0)); // Static grid, use uv_pattern
    final_pattern_color += colorMutedBlue(0.1) * bg_grid_val * 0.05; // Very faint blue grid


    // Apply subtle overall ambient glow
    final_pattern_color += colorDXHRGold(0.05) * 0.01;
    final_pattern_color += colorMutedBlue(0.05) * 0.01;

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
