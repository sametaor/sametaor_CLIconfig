
// Deus Ex Data Stream
// Re-imagined Variation 2: Focus on complexity and layered data flow
// Adapted for terminal background with iChannel0 blending

// Note: This shader assumes that iChannel0 is provided by the terminal
// (e.g., Ghostty) and contains the underlying terminal content.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the shader pattern - WITH ASPECT CORRECTION
    vec2 uv_pattern = fragCoord/iResolution.xy;
    uv_pattern.x *= iResolution.x/iResolution.y; // Aspect ratio correction for the visual pattern

    vec2 center = uv_pattern - 0.5; // Use uv_pattern for centering the visual effects

    // Deus Ex Color Palette
    vec3 color_bg_dark = vec3(0.05, 0.07, 0.1);       // Muted dark blue/almost black
    vec3 color_blue_accent = vec3(0.15, 0.35, 0.45);  // Slightly brighter muted blue
    vec3 color_gold_accent = vec3(0.6, 0.5, 0.2);     // Muted gold
    vec3 color_grey_metallic = vec3(0.3, 0.35, 0.4);  // Grey metallic
    vec3 color_yellow_glow = vec3(1.0, 1.0, 0.0);     // Hint of cybernetic yellow

    vec3 final_pattern_color = color_bg_dark; // This will accumulate the shader's visual pattern

    // --- Layered Triangular Grids ---
    for (float i = 0.0; i < 3.0; i++) // Create 3 layers
    {
        float scale = 15.0 + i * 5.0; // Different scales for depth
        float speed = 0.05 + i * 0.02; // Different speeds for movement
        float intensity = 0.1 + i * 0.05; // Different line intensities

        // Use uv_pattern for grid generation
        vec2 p = (uv_pattern * scale) + vec2(iTime * speed, iTime * speed * 0.5 + i * 10.0);

        // Minor chaotic offset for a more organic/data feel
        p += vec2(sin(iTime * 0.3 + i * 7.0), cos(iTime * 0.4 + i * 11.0)) * 0.2;

        vec2 ip = floor(p);
        vec2 fp = fract(p);

        float tri_id = mod(ip.x + ip.y, 2.0);
        vec2 tri_coord = (tri_id < 0.5) ? fp : vec2(1.0) - fp;

        float edge_dist = min(min(abs(tri_coord.x), abs(tri_coord.y)), abs(tri_coord.x + tri_coord.y - 1.0));

        float line_width = 0.03;
        float lines = smoothstep(line_width, line_width + 0.01, edge_dist);
        lines = 1.0 - lines; // Invert to make lines brighter

        // Add a "flow" effect - lines get brighter/thinner based on fractional part of P
        float flow_factor = fract(p.x * 0.5 + p.y * 0.3 - iTime * 0.8) * 0.5 + 0.5;
        flow_factor = pow(flow_factor, 4.0); // Sharpen flow

        vec3 layer_color;
        if (i == 0.0) layer_color = color_blue_accent; // Base layer blue
        else if (i == 1.0) layer_color = color_gold_accent * 0.7; // Mid layer darker gold
        else layer_color = color_yellow_glow * 7.5; // Top layer now brighter yellow
        // Changed from *0.5 to *1.5 to make the yellow glow more prominent

        // Fade layers towards edges using uv_pattern for length calculation
        final_pattern_color = mix(final_pattern_color, layer_color * intensity * flow_factor, lines * (1.0 - smoothstep(0.4, 0.8, length(uv_pattern - 0.5))));
    }

    // --- Metallic Sheen and Vignette ---
    // Use uv_pattern for reflection calculation
    float metallic_sheen = pow(length(uv_pattern - 0.5) * 2.0, 2.0) * 0.3 + sin(iTime * 0.2) * 0.1 + 0.2;
    metallic_sheen = clamp(metallic_sheen, 0.0, 1.0);
    final_pattern_color = mix(final_pattern_color, color_grey_metallic, metallic_sheen * 0.2); // Subtle grey metallic overlay

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
