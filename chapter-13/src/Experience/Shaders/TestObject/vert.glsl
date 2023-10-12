#include "/node_modules/lygia/generative/cnoise.glsl";
#include "/node_modules/lygia/math/const.glsl";

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;
varying float vNoise;
varying vec3 vNormal;
varying vec3 vWorldPosition;
uniform float uFrequency;

varying vec2 vUv;

uniform float uDistort;

vec3 distort(vec3 p) {
    float offset = cnoise(p / uFrequency + iTime * 0.5);
    float t = (p.y + offset) * PI * 12.0;
    float noise = (sin(t) * p.x + cos(t) * p.z) * 2.0;
    noise *= uDistort;
    vNoise = noise;
    p += noise * normal * 0.01;
    return p;
}

#include "../Common/fixNormal.glsl";

void main() {
    vec3 p = position;
    vec3 dp = distort(p);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(dp, 1.0);
    
    vUv = uv;
    // vNormal=normal;
    vNormal = fixNormal(p, dp, normal, RADIUS / SEGMENTS);
    vWorldPosition = vec3(modelMatrix * vec4(p, 1));
}