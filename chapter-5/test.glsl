#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"
#iChannel1"https://s2.loli.net/2023/09/10/Jb8mIhZMBElPiuC.jpg"
#iChannel2"https://s2.loli.net/2023/07/17/3GDlwcvehqQjTPH.jpg"

vec4 getFromColor(vec2 uv) {
  return texture(iChannel0, uv);
}

vec4 getToColor(vec2 uv) {
  return texture(iChannel1, uv);
}

// 置换转场
vec4 transition(vec2 uv) {
  float progress = iMouse.x / iResolution.x;
  float ratio = iResolution.x / iResolution.y;
  
  vec2 dispVec = texture(iChannel2, uv).xy;
  vec2 uv1 = vec2(uv.x - dispVec.x * progress, uv.y);
  vec2 uv2 = vec2(uv.x + dispVec.x * (1.0 - progress), uv.y);
  return mix(getFromColor(uv1), getToColor(uv2), progress);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  
  vec4 col = transition(uv);
  
  fragColor = col;
}