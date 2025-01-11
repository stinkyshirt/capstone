#version 300 es
precision highp float;

in vec2 uv;
out vec4 out_color;

uniform vec2 u_resolution;
uniform float u_time;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(14.9898, 4.1414))) * 4315.5453);
}

const vec3 color1 = vec3(0.3, 0.41, 0.567) * 1.1;
const vec3 color2 = vec3(1.0);

vec3 getColor(float seed) {
    float t = rand(vec2(seed, 1.0));
    return mix(color1, color2, t);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float n = dot(i, vec2(1.0, 57.0));
    return mix(mix(rand(n + vec2(0.0, 0.0)), rand(n + vec2(1.0, 0.0)), f.x),
               mix(rand(n + vec2(0.0, 1.0)), rand(n + vec2(1.0, 1.0)), f.x), f.y);
}

void main() {
    vec2 coords = gl_FragCoord.xy / u_resolution;
    float aspect = u_resolution.x / u_resolution.y;
    coords.x *= aspect;

    vec3 finalColor = vec3(1.0);
    float totalWeight = 0.0;

    const int POINT_COUNT = 10;

    for (int i = 0; i < POINT_COUNT; i++) {
        float seed = float(i) * 17.0;
        float baseX = rand(vec2(seed, 123.45));
        float baseY = rand(vec2(seed + 1.0, 123.45));
        float radius = rand(vec2(baseX, baseY)) * 0.2 + 0.1;
        float offsetX = radius * sin(u_time * 0.25 + float(i));
        float offsetY = radius * cos(u_time * 0.25 + float(i));
        vec2 pointPos = vec2(baseX + offsetX, baseY + offsetY - .35);
        pointPos.x *= aspect;
        float dist = distance(coords, pointPos);
        float weight = 1.0 - smoothstep(-.1, 0.6, dist);
        vec3 color = getColor(seed);
        finalColor += color * weight;
        totalWeight += weight;
    }

    if (totalWeight >= 0.0) {
        finalColor /= max(totalWeight, 1e-4);
    }

    out_color = vec4(finalColor, 1.0);
}