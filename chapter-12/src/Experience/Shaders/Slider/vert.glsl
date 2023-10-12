#include "/node_modules/lygia/math/const.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

uniform float uVelocity;
uniform float uDistortX;
uniform float uDistortZ;
uniform float uProgress;

uniform vec2 uMeshSize;
uniform vec2 uMeshPosition;

varying vec2 vUv;

// 扭曲函数
vec3 distort(vec3 p) {
  p.x += sin(uv.y * PI) * uVelocity * uDistortX;
  p.z += cos((p.x / iResolution.y) * PI) * abs(uVelocity) * uDistortZ;
  
  return p;
}

float getStagger(vec2 uv) {
  float left = uv.x;
  float bottom = uv.y;
  float right = 1.0 - uv.x;
  float top = 1.0 - uv.y;
  return top * right;
}

vec3 transition(vec3 p) {
  float pr = uProgress;
  float stagger = getStagger(uv);
  pr = smoothstep(stagger * 0.8, 1.0, pr);
  
  vec2 targetScale = iResolution.xy / uMeshSize.xy;
  vec2 scale = mix(vec2(1.0), targetScale, pr);
  p.xy *= scale;
  p.z += pr;
  return p;
}

// 顶点着色器
void main() {
  vec3 p = position;
  p = transition(p);
  vec4 mvPosition = modelViewMatrix * vec4(p, 1.0);
  mvPosition.xyz = distort(mvPosition.xyz);
  gl_Position = projectionMatrix * mvPosition;
  
  vUv = uv;
}