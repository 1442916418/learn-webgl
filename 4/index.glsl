const float PI=3.14159265359;

#define mix(x,y,t)x*(1.-t)+y*t

// 长方形
float sdBox(in vec2 p,in vec2 b)
{
  vec2 d=abs(p)-b;
  return length(max(d,0.))+min(max(d.x,d.y),0.);
}

// 等边三角形函数
float sdEquilateralTriangle(in vec2 p,in float r)
{
  const float k=sqrt(3.);
  p.x=abs(p.x)-r;
  p.y=p.y+r/k;
  if(p.x+k*p.y>0.)p=vec2(p.x-k*p.y,-k*p.x-p.y)/2.;
  p.x-=clamp(p.x,-2.*r,0.);
  return-length(p)*sign(p.y);
}

mat2 rotation2d(float angle){
  float s=sin(angle);
  float c=cos(angle);
  
  return mat2(
    c,-s,
    s,c
  );
}

// 旋转
vec2 rotate(vec2 v,float angle){
  return rotation2d(angle)*v;
}

// 圆角
float opRound(in float d,in float r)
{
  return d-r;
}

// 镂空
float opOnion(in float d,in float r)
{
  return abs(d)-r;
}

// 并
float opUnion(float d1,float d2)
{
  return min(d1,d2);
}

// 交
float opIntersection(float d1,float d2)
{
  return max(d1,d2);
}

// 差
float opSubtraction(float d1,float d2)
{
  return max(-d1,d2);
}

// 圆形
float sdCircle(vec2 p,float r)
{
  return length(p)-r;
}

// 平滑版 - 并
float opSmoothUnion(float d1,float d2,float k){
  float h=clamp(.5+.5*(d2-d1)/k,0.,1.);
  return mix(d2,d1,h)-k*h*(1.-h);
}

// 平滑版 - 交
float opSmoothIntersection(float d1,float d2,float k){
  float h=clamp(.5-.5*(d2-d1)/k,0.,1.);
  return mix(d2,d1,h)+k*h*(1.-h);
}

// 平滑版 - 差
float opSmoothSubtraction(float d1,float d2,float k){
  float h=clamp(.5-.5*(d2+d1)/k,0.,1.);
  return mix(d2,-d1,h)+k*h*(1.-h);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
  // 用输入坐标 fragCoord 除以画布大小 iResolution.xy，
  // 我们就能得到一个归一化的坐标，把它命名为 uv
  vec2 uv=fragCoord/iResolution.xy;
  
  // 重复
  // uv=fract(uv*vec2(2.,2.));
  
  // uv=(uv-.5)*2.;
  // uv.x*=iResolution.x/iResolution.y;
  
  // ------------------------ uv 坐标 ------------------------
  // x 坐标的分布情况
  // fragColor=vec4(uv.x,0.,0.,1.);
  
  // y 坐标的分布情况
  // fragColor=vec4(0.,uv.y,0.,1.);
  
  // 同时输出 x 坐标和 y 坐标的分布
  // fragColor=vec4(uv,0.,1.);
  
  // ------------------------ 圆形的绘制 ------------------------
  // 目前图形的位置在左下角，我们来把它挪到中间吧，将UV的坐标减去 0.5，再整体乘上 2。（注意这一行代码要放在length函数代码的上面。）
  // uv=(uv-.5)*2.;
  
  // 然而，图形目前的形状是一个椭圆，这是为什么呢？因为UV坐标的值并不会自动地适应画布的比例，导致了图形被拉伸这一现象。
  // uv.x*=iResolution.x/iResolution.y;
  
  // // 计算UV坐标上的点到原点的距离
  // float d=length(uv);
  
  // d-=.5;
  
  // fragColor=vec4(vec3(d),1.);
  // // fragColor=vec4(uv,0.,1.);
  
  // // 圆形
  // // float c=0.;
  // // if(d>0.){
    //   //     c=1.;
  // // }else{
    //   //     c=0.;
  // // }
  
  // // 阶梯函数
  // // float c=step(0.,d);
  
  // // 平滑阶梯函数
  // float c=smoothstep(0.,.02,d);
  
  // // fragColor=vec4(vec3(d),1.);
  // fragColor=vec4(vec3(c),1.);
  
  // // ------------------------ 圆形 ------------------------
  // float d=length(uv);
  
  // // d-=.5;
  
  // // 平滑阶梯函数 - 模糊效果
  // // float c=smoothstep(0.,.2,d);
  
  // // 发光效果
  // float c=.25/d;
  
  // // 范围缩小
  // c=pow(c,1.6);
  
  // // fragColor=vec4(vec3(d),1.);
  // fragColor=vec4(vec3(c),1.);
  
  // ------------------------ 长方形 ------------------------
  // float d=sdBox(uv,vec2(.6,.3));
  // float c=smoothstep(0.,.02,d);
  // fragColor=vec4(vec3(c),1.);
  
  // ------------------------ UV 变换 ------------------------
  
  // 平移
  // uv-=vec2(.2,.4);
  
  // 缩放 - 缩小
  // uv*=vec2(2.,2.);
  // 缩放 - 放大
  // uv/=vec2(2.,2.);
  
  // float d=sdBox(uv,vec2(.6,.3));
  
  // 目前的三角形沿x轴方向是非对称的，如果想按x轴翻转，给UV的y坐标乘上-1 即可。
  // uv.y*=-1.;
  
  // 旋转 90 度
  // uv=rotate(uv,PI/2.);
  
  // 旋转的动画
  // uv=rotate(uv,iTime);
  
  // float d=sdEquilateralTriangle(uv,.5);
  // float c=smoothstep(0.,.02,d);
  
  // fragColor=vec4(vec3(c),1.);
  
  // 重复
  // uv=fract(uv*vec2(2.,2.));
  
  // 镜像
  // uv.y=abs(uv.y);
  
  // float d=sdEquilateralTriangle(uv,.5);
  // float c=smoothstep(0.,.02,d);
  
  // fragColor=vec4(vec3(c),1.);
  // // fragColor=vec4(uv,0.,1.);
  
  // ------------------------ SDF 图形变换 ------------------------
  
  // float d=sdBox(uv,vec2(.6,.3));
  
  // // 圆角
  // // d=opRound(d,.1);
  
  // // 镂空
  // // d=opOnion(d,.1);
  
  // float c=smoothstep(0.,.02,d);
  // fragColor=vec4(vec3(c),1.);
  
  // ------------------------ SDF 布尔运算 ------------------------
  
  // float d1=sdCircle(uv,.5);
  // float d2=sdBox(uv,vec2(.6,.3));
  
  // float d=d1;
  
  // // 并
  // // d=opUnion(d1,d2);
  // // d=opSmoothUnion(d1,d2,.1);
  
  // // 交
  // // d=opIntersection(d1, d2);
  // // d=opSmoothIntersection(d1,d2,.1);
  
  // // 差(长方形减去圆形)
  // // d=opSubtraction(d1,d2);
  // // d=opSmoothSubtraction(d1,d2,.1);
  
  // // 差(圆形减去长方形)
  // // d=opSubtraction(d2,d1);
  // d=opSmoothSubtraction(d2,d1,.1);
  
  // float c=smoothstep(0.,.02,d);
  // fragColor=vec4(vec3(c),1.);
  
  // ------------------------ mix 函数 ------------------------
  
  // 创建渐变
  // vec3 col1=vec3(1.,0.,0.);
  // vec3 col2=vec3(0.,1.,0.);
  // vec3 col=mix(col1,col2,uv.x);
  // fragColor=vec4(col,1.);
  
  // 给图形染色
  // float d=sdBox(uv,vec2(.6,.3));
  // float c=smoothstep(0.,.02,d);
  // vec3 colInner=vec3(1.,0.,0.);
  // vec3 colOuter=vec3(1.);
  // vec3 col=mix(colInner,colOuter,c);
  // fragColor=vec4(col,1.);
  
  // 形状转变效果
  // float d1=sdCircle(uv,.5);
  // float d2=sdBox(uv,vec2(.6,.3));
  // float d=mix(d1,d2,abs(sin(iTime)));
  // float c=smoothstep(0.,.02,d);
  // fragColor=vec4(vec3(c),1.);
  
  // ------------------------ 重复图案 ------------------------
  // // uv.y+=sin(uv.x);
  
  // // 弯曲
  // uv.y+=sin(uv.x*6.)*.4;
  
  // // 重复 - 条纹
  // uv=fract(uv*16.);
  
  // // 条纹
  // // vec3 c=vec3(step(.5,uv.x));
  // // fragColor=vec4(c,1.);
  
  // // 波浪
  // vec3 c=vec3(step(.5,uv.y));
  // fragColor=vec4(c,1.);
  
  // 网格
  uv=fract(uv*16.);
  
  // x
  // vec3 c=vec3(step(.25,uv.x));
  // y
  vec3 c=vec3(step(.25,uv.y));
  fragColor=vec4(c,1.);
  
  // TODO:  用布尔运算里的“并”操作，将这 2 种图形合并。
  
}
