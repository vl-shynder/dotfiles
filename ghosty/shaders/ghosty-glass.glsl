// Ghosty Glass: a deliberately restrained edge treatment for long sessions.
// It adds a cool violet-blue tint near the window edges and a faint vignette
// while leaving the center of the terminal and its text essentially untouched.

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 screen = texture(iChannel0, uv);

    float edge = min(min(uv.x, 1.0 - uv.x), min(uv.y, 1.0 - uv.y));
    float rim = 1.0 - smoothstep(0.02, 0.20, edge);
    float corner = smoothstep(0.0, 0.42, length((uv - 0.5) * vec2(1.0, 0.78)));

    vec3 coolGlass = vec3(0.19, 0.24, 0.52);
    vec3 warmGlass = vec3(0.30, 0.16, 0.40);
    vec3 tint = mix(coolGlass, warmGlass, smoothstep(0.15, 0.9, uv.y));

    float intensity = rim * 0.035 + corner * 0.010;
    fragColor = vec4(screen.rgb + tint * intensity, screen.a);
}
