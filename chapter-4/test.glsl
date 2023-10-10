// fragCoord: 1920 * 1080
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  
  uv = (uv - 0.5) * 2.0;
  uv.x *= iResolution.x / iResolution.y;
  
  float d = length(uv);
  
  d -= 0.5;
  
  float c = smoothstep(0.0, 0.02, d);
  
  fragColor = vec4(vec3(c), 1.0);
}