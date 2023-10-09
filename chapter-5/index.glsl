#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"
#iChannel1"https://s2.loli.net/2023/09/10/Jb8mIhZMBElPiuC.jpg"
#iChannel2"https://s2.loli.net/2023/07/17/3GDlwcvehqQjTPH.jpg"

// 扭曲
// vec2 distort(vec2 p){
  //   p.x+=sin(p.y);
  //   return p;
// }
vec2 distort(vec2 p){
  p.x+=sin(p.y*10.+iTime)/50.;
  return p;
}

vec4 getFromColor(vec2 uv){
  return texture(iChannel0,uv);
}

vec4 getToColor(vec2 uv){
  return texture(iChannel1,uv);
}

// 左右淡入淡出转场
vec4 transition(vec2 uv){
  float progress=iMouse.x/iResolution.x;
  return mix(getFromColor(uv),getToColor(uv),progress);
}

// 滑动转场
vec4 transition1(vec2 uv){
  float progress=iMouse.x/iResolution.x;
  return mix(getFromColor(uv),getToColor(uv),1.-step(progress,uv.x));
}

float sdCircle(vec2 p,float r){
  return length(p)-r;
}

// 虚化的圆形遮罩转场效果
vec4 transition2(vec2 uv){
  float progress=iMouse.x/iResolution.x;
  float ratio=iResolution.x/iResolution.y;
  
  vec2 p=uv;
  p-=.5;
  p.x*=ratio;
  float d=sdCircle(p,progress*sqrt(2.));
  float c=smoothstep(-.2,0.,d);
  return mix(getFromColor(uv),getToColor(uv),1.-c);
}

// 置换转场
vec4 transition3(vec2 uv){
  float progress=iMouse.x/iResolution.x;
  float ratio=iResolution.x/iResolution.y;
  
  vec2 dispVec=texture(iChannel2,uv).xy;
  vec2 uv1=vec2(uv.x-dispVec.x*progress,uv.y);
  vec2 uv2=vec2(uv.x+dispVec.x*(1.-progress),uv.y);
  return mix(getFromColor(uv1),getToColor(uv2),progress);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
  vec2 uv=fragCoord/iResolution.xy;
  
  // // 扭曲
  // uv=distort(uv);
  
  // // 采样
  // vec3 tex=texture(iChannel0,uv).xyz;
  
  // fragColor=vec4(tex,1.);
  
  // 转场
  // vec4 col=transition(uv);
  // vec4 col=transition1(uv);
  // vec4 col=transition2(uv);
  vec4 col=transition3(uv);
  
  fragColor=col;
}