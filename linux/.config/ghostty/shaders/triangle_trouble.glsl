/*
 * Created using Google Gemini, with cues from Deus Ex Mankind Divided
 * Adapted for Ghostty terminal by layering visual background over terminal text via iChannel0.
 */

#define ANIMATION_SPEED 0.2
#define GRID_SCALE 24.0
#define Z_FACTOR 1.2
#define BRIGHTNESS 1.0

#define FLUID_SPEED 1.0
#define FLUID_SCALE 30.0
#define FLUID_INTENSITY 1.5

#define LIGHT_SPEED 1.0
#define LIGHT_COLOR vec3(0.6, 0.8, 1.0)

vec2 hash(vec2 p) {
    p = vec2(dot(p, vec2(127.1, 311.7)),
             dot(p, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

vec3 get_vertex_pos(vec2 id) {
    float time_component = sin(iTime * ANIMATION_SPEED + hash(id).y * 3.14159);
    float z = hash(id).x * Z_FACTOR * time_component;

    vec2 fluid_uv = id / FLUID_SCALE;
    float noise = (sin(fluid_uv.x + iTime * FLUID_SPEED) + cos(fluid_uv.y + iTime * FLUID_SPEED)) * 0.5;

    vec2 displacement = hash(id) * noise * FLUID_INTENSITY;
    vec2 displaced_id = id + displacement;

    return vec3(displaced_id, z * GRID_SCALE);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    vec2 grid_uv = uv * GRID_SCALE;
    vec2 grid_id = floor(grid_uv);
    vec2 grid_frac = fract(grid_uv);

    vec3 v00 = get_vertex_pos(grid_id + vec2(0.0, 0.0));
    vec3 v10 = get_vertex_pos(grid_id + vec2(1.0, 0.0));
    vec3 v01 = get_vertex_pos(grid_id + vec2(0.0, 1.0));
    vec3 v11 = get_vertex_pos(grid_id + vec2(1.0, 1.0));

    vec3 p0, p1, p2;
    if (grid_frac.x + grid_frac.y < 1.0) {
        p0 = v00; p1 = v10; p2 = v01;
    } else {
        p0 = v11; p1 = v01; p2 = v10;
    }

    vec3 normal = normalize(cross(p1 - p0, p2 - p0));

    float light_angle = iTime * LIGHT_SPEED;
    vec3 light_dir = normalize(vec3(cos(light_angle) * 1.5, sin(light_angle), -1.0));

    float diffuse = max(0.0, dot(normal, light_dir));
    vec3 color = vec3(diffuse) * BRIGHTNESS * LIGHT_COLOR;

    color *= 1.0 - 0.25 * length(uv * 1.2); // vignette

    // Sample the terminal framebuffer texture (text and background)
    vec3 base = texture(iChannel0, fragCoord / iResolution.xy).rgb;

    // Mix procedural shader with terminal content (text preserved)
    color = clamp(1.0 - (1.0 - base) * (1.0 - color * 0.7), 0.0, 1.0);

    fragColor = vec4(color, 1.0);
}
