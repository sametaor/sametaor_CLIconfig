
// Augmented Apex Grid with iChannel0 Blending and Corrected Grid Aspect Ratio
// Deus Ex: Mankind Divided Inspired Shadertoy Variation

// Note: This shader assumes that iChannel0 is provided by the terminal
// (e.g., Ghostty) and contains the underlying terminal content.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Base UV for sampling iChannel0 (terminal content) - NO ASPECT CORRECTION HERE
    vec2 uv_terminal = fragCoord/iResolution.xy;

    // Separate UV for generating the grid pattern - WITH ASPECT CORRECTION
    vec2 uv_grid = fragCoord/iResolution.xy;
    uv_grid.x *= iResolution.x/iResolution.y; // Aspect ratio correction for the grid pattern

    // Define Deus Ex color palette
    vec3 color_bg_dark = vec3(0.05, 0.07, 0.1); // Muted dark blue/almost black
    vec3 color_blue_accent = vec3(0.1, 0.3, 0.4); // Muted blue
    vec3 color_gold_accent = vec3(0.6, 0.5, 0.2); // Muted gold
    vec3 color_grey_metallic = vec3(0.3, 0.35, 0.4); // Grey metallic

    // --- Triangular Grid Logic ---
    // Scale for the grid. Use uv_grid for this.
    float scale = 15.0; // Adjust for more/fewertriangles
    vec2 p = uv_grid * scale; // Use uv_grid here

    // Time component for subtle movement
    p += vec2(sin(iTime * 0.1), cos(iTime * 0.1)) * 0.5;

    // Create a triangular tiling pattern
    vec2 ip = floor(p);
    vec2 fp = fract(p);

    // Determines which "half" of the square the point is in, forming triangles
    float tri_id = mod(ip.x + ip.y, 2.0);
    vec2 tri_coord = (tri_id < 0.5) ? fp : vec2(1.0) - fp;

    // Calculate distance to triangle edges for line drawing
    float d1 = abs(tri_coord.x);
    float d2 = abs(tri_coord.y);
    float d3 = abs(tri_coord.x + tri_coord.y - 1.0);

    // Smallest distance gives the closest edge
    float edge_dist = min(min(d1, d2), d3);

    // Smoothstep to create lines
    float line_width = 0.02; // Adjust for line thickness
    float lines = smoothstep(line_width, line_width + 0.01, edge_dist);

    // --- Metallic Reflection Effect ---
    // Simple reflection based on screen position and time. Use uv_grid for this.
    float reflection_factor = pow(length(uv_grid - 0.5) * 2.0, 2.0) * 0.5 + sin(iTime * 0.5) * 0.2 + 0.5;
    reflection_factor = clamp(reflection_factor, 0.0, 1.0);

    // Apply color based on distance and lines
    vec3 grid_pattern_color = mix(color_blue_accent, color_bg_dark, lines); // Base triangular structure
    grid_pattern_color = mix(grid_pattern_color, color_gold_accent, 1.0 - lines); // Gold for the lines

    // Blend with metallic grey based on reflection factor
    grid_pattern_color = mix(grid_pattern_color, color_grey_metallic, reflection_factor * 0.3);

    // Add a subtle glow to the lines for high-tech feel
    grid_pattern_color += (1.0 - lines) * color_gold_accent * 0.1;

    // Overall Scene Tint/Atmosphere. Use uv_grid for this.
    grid_pattern_color = mix(grid_pattern_color, color_bg_dark, uv_grid.y * 0.5);

    // --- iChannel0 Blending ---
    // Sample the iChannel0 texture using uv_terminal (uncorrected)
    vec4 terminal_content = texture2D(iChannel0, uv_terminal);

    // Define how much of the grid pattern to show.
    // Keeping this at a subtle value for readability.
    float grid_opacity = 0.25;

    // Mix the terminal content with the grid pattern.
    vec3 final_output_color = mix(terminal_content.rgb, grid_pattern_color, grid_opacity);

    // The final alpha value for the shader output.
    fragColor = vec4(final_output_color, terminal_content.a);
}
