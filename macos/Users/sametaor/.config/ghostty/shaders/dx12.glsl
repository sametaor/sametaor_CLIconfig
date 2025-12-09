
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

// Draw a crosshair/reticle element (kept)
float drawCrosshair(vec2 uv, float thickness, float size) {
    uv = abs(uv);
    float cross = max(smoothstep(thickness, 0.0, uv.x) * smoothstep(size, size - thickness, uv.y),
                     smoothstep(thickness, 0.0, uv.y) * smoothstep(size, size - thickness, uv.x));
    return cross;
}

// Draw a circle (kept)
float drawCircle(vec2 uv, float radius, float thickness) {
    float d = length(uv);
    return smoothstep(thickness, 0.0, abs(d - radius));
}

// Draw a rounded rectangle outline (kept)
float drawRoundedRectOutline(vec2 uv, vec2 size, float radius, float thickness) {
    uv = abs(uv) - size + radius;
    float d = length(max(uv, 0.0)) + min(max(uv.x, uv.y), 0.0);
    return smoothstep(thickness, 0.0, abs(d - radius));
}

// Draw a solid rectangle (kept)
float drawRect(vec2 uv, vec2 size) {
    vec2 d = abs(uv) - size;
    return smoothstep(0.0, -0.01, max(d.x, d.y)); // Inner edge smoothstep
}

// Ray-Sphere Intersection (for 3D rendering of sphere) (kept)
float sphereIntersect(vec3 rayOrigin, vec3 rayDir, vec3 sphereCenter, float sphereRadius) {
    vec3 oc = rayOrigin - sphereCenter;
    float a = dot(rayDir, rayDir);
    float b = 2.0 * dot(oc, rayDir);
    float c = dot(oc, oc) - sphereRadius * sphereRadius;
    float discriminant = b * b - 4.0 * a * c;
    if (discriminant < 0.0) {
        return -1.0; // No intersection
    } else {
        return (-b - sqrt(discriminant)) / (2.0 * a); // Closest intersection point
    }
}

// Rotate a 3D vector (for globe rotation) (kept)
vec3 rotate3D(vec3 p, float angle, vec3 axis) {
    float s = sin(angle);
    float c = cos(angle);
    vec3 u = normalize(axis);
    return p * c + cross(u, p) * s + u * dot(u, p) * (1.0 - c);
}


// --- Variation 40: Data Stream / Info Flow Wall ---

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
    final_pattern_color = colorGunmetalBlack(0.0); 

    // --- 1. Background Binary / Hex Pattern ---
    float bg_char_density = 40.0;
    vec2 bg_char_uv = uv_pattern * bg_char_density; // Use uv_pattern for background characters
    vec2 bg_char_id = floor(bg_char_uv);
    vec2 bg_char_frac = fract(bg_char_uv);

    // Make it scroll slowly
    bg_char_id.y += floor(iTime * 0.5); // Vertical scroll
    bg_char_id.x += floor(iTime * 0.1); // Slower horizontal scroll

    float bg_char_value = hash(dot(bg_char_id, vec2(12.9898, 78.233))) > 0.5 ? 1.0 : 0.0; // Binary 0 or 1
    // Add some hex-like variations
    if (hash(dot(bg_char_id, vec2(9.123, 3.456))) > 0.8) {
        // Pass the correct local UV to the char function
        bg_char_value = char(bg_char_frac, hash(dot(bg_char_id, vec2(1.0, 2.0))) * 4.0, 1.0);
    }
    
    final_pattern_color += colorMutedBlue(0.05) * bg_char_value * 0.1; // Very subtle background


    // --- 2. Multiple Layers of Scrolling Data ---
    // Layer 1: Fast Vertical Scroll
    float layer1_density = 25.0;
    vec2 layer1_uv = uv_pattern * layer1_density; // Use uv_pattern for layer 1
    layer1_uv.y += iTime * 2.0; // Faster scroll

    vec2 layer1_char_id = floor(layer1_uv);
    vec2 layer1_char_frac = fract(layer1_uv);

    // Pass the correct local UV to the char function
    float layer1_char_value = char(layer1_char_frac, hash(dot(layer1_char_id, vec2(4.0, 7.0))) * 4.0, 1.0);
    // Add random blinking to some characters
    if (hash(dot(layer1_char_id, vec2(1.5, 3.2)) + iTime * 10.0) > 0.95) {
        layer1_char_value *= (sin(iTime * 50.0) * 0.5 + 0.5);
    }
    final_pattern_color += colorMutedBlue(0.4) * layer1_char_value * 3.0; // Medium intensity


    // Layer 2: Slower Horizontal Scroll with Blocks
    float layer2_density = 20.0;
    vec2 layer2_uv = uv_pattern * layer2_density; // Use uv_pattern for layer 2
    layer2_uv.x += iTime * 0.7; // Slower horizontal scroll

    vec2 layer2_block_id = floor(layer2_uv / vec2(2.0, 1.0)); // Blocks are wider
    vec2 layer2_block_frac = fract(layer2_uv / vec2(2.0, 1.0));

    float block_active = hash(dot(layer2_block_id, vec2(8.0, 1.0)) + floor(iTime * 0.5));
    if (block_active > 0.6) { // Only some blocks are active
        // Pass the correct local UV to the char function
        float block_pattern = char(layer2_block_frac, hash(dot(layer2_block_id, vec2(2.1, 5.3))) * 4.0, 1.0);
        final_pattern_color += colorGray(0.6) * block_pattern * 2.0;
    }
    
    // --- 5. Overall Screen Effects ---
    // Scanlines applied to the overall fragment (using uv_terminal or fragCoord/iResolution.xy)
    float scanline_effect = scanlines(uv_terminal, iResolution.y / 1.0, 0.08); 
    final_pattern_color -= scanline_effect * 0.05;

    // Gentle vignette. Use uv_pattern for vignette calculation since it's centered and aspect-corrected.
    float dist_from_center_pattern = length(uv_pattern);
    float vignette_strength = 0.18;
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
