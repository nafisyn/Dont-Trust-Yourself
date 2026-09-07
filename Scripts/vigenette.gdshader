shader_type canvas_item;

void fragment() {
    vec2 uv = UV;

    // Distance from the center
    float dist = distance(uv, vec2(0.5));

    // Vignette strength
    float vignette = smoothstep(0.25, 0.75, dist);

    // Black with adjustable transparency
    COLOR = vec4(0.0, 0.0, 0.0, vignette * 0.7);
}
