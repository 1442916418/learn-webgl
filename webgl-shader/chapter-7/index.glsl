#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"
#iChannel1"https://s2.loli.net/2023/09/10/63quVIA9xZLksDc.jpg"

// 随机函数
highp float random(vec2 co)
{
  highp float a=12.9898;
  highp float b=78.233;
  highp float c=43758.5453;
  highp float dt=dot(co.xy,vec2(a,b));
  highp float sn=mod(dt,3.14);
  return fract(sin(sn)*c);
}

// 膨胀
vec2 bulge(vec2 p){
  // vec2 center=vec2(.5);
  vec2 center=iMouse.xy/iResolution.xy;
  
  float radius=.9;
  float strength=1.1;
  
  p-=center;
  
  float d=length(p);
  d/=radius;
  float dPow=pow(d,2.);
  float dRev=strength/(dPow+1.);
  
  // p*=d;
  // p*=dPow;
  p*=dRev;
  
  p+=center;
  
  return p;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
  vec2 uv=fragCoord/iResolution.xy;
  
  // ------------------------ 染色 ------------------------
  // vec3 tex=texture(iChannel0,uv).xyz;
  
  // vec3 col=tex;
  // vec3 tintColor=vec3(.2196,.2824,.651);
  // col*=tintColor;
  
  // fragColor=vec4(col,1.);
  
  // ------------------------ RGB 位移 ------------------------
  // vec2 rUv=uv;
  // vec2 gUv=uv;
  // vec2 bUv=uv;
  
  // // 阈值
  // // float offset=.0025;
  // // 阈值1
  // // float noise=random(uv)*.5+.5;
  // // vec2 offset=.05*vec2(cos(noise),sin(noise));
  // // 阈值1
  // float noise=random(uv)*.5+.5;
  // vec2 offset=.0025*vec2(cos(noise),sin(noise));
  
  // rUv+=offset;
  // bUv-=offset;
  
  // vec4 rTex=texture(iChannel1,rUv);
  // vec4 gTex=texture(iChannel1,gUv);
  // vec4 bTex=texture(iChannel1,bUv);
  // vec4 col=vec4(rTex.r,gTex.g,bTex.b,gTex.a);
  
  // fragColor=col;
  
  // ------------------------ 膨胀 ------------------------
  // uv=bulge(uv);
  
  // vec3 tex=texture(iChannel0,uv).xyz;
  
  // fragColor=vec4(tex,1.);
  
  // ------------------------ 像素化 ------------------------
  // // float c=uv.x;
  
  // // c=floor(c*10.)/10.;
  
  // // fragColor=vec4(vec3(c),1.);
  
  // vec2 size=vec2(50.,50.);
  // // uv.x=floor(uv.x*size.x)/size.x;
  // // uv.y=floor(uv.y*size.y)/size.y;
  
  // uv=floor(uv*size)/size;
  
  // vec3 tex=texture(iChannel0,uv).xyz;
  
  // fragColor=vec4(tex,1.);
  
  // ------------------------ 晕影 ------------------------
  
  vec3 tex=texture(iChannel0,uv).xyz;
  // vec3 col=vec3(1.);
  vec3 col=tex;
  
  vec2 p=uv;
  p-=.5;
  float d=length(p);
  // float c=smoothstep(.4,.8,d);
  float c=smoothstep(.8,.4,d);
  
  col*=c;
  
  fragColor=vec4(col,1.);
}