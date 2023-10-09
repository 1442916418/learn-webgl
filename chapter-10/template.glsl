float sdSphere(vec3 p,float r)
{
  return length(p)-r;
}

float sdPlane(vec3 p,vec3 n,float h)
{
  return dot(p,n)+h;
}

float opUnion(float d1,float d2)
{
  return min(d1,d2);
}

vec2 opUnion(vec2 d1,vec2 d2)
{
  return(d1.x<d2.x)?d1:d2;
}

float opIntersection(float d1,float d2)
{
  return max(d1,d2);
}

float opSubtraction(float d1,float d2)
{
  return max(-d1,d2);
}

float opSmoothUnion(float d1,float d2,float k){
  float h=clamp(.5+.5*(d2-d1)/k,0.,1.);
  return mix(d2,d1,h)-k*h*(1.-h);
}

float opSmoothSubtraction(float d1,float d2,float k){
  float h=clamp(.5-.5*(d2+d1)/k,0.,1.);
  return mix(d2,-d1,h)+k*h*(1.-h);
}

float opSmoothIntersection(float d1,float d2,float k){
  float h=clamp(.5-.5*(d2-d1)/k,0.,1.);
  return mix(d2,d1,h)+k*h*(1.-h);
}

vec2 map(vec3 p){
  vec2 d=vec2(1e10,0.);
  
  float d1=sdSphere(p-vec3(0.,0.,-2.),1.);
  
  float d2=sdSphere(p-vec3(0.,.8+abs(sin(iTime)),-2),.5);
  d1=opSmoothUnion(d1,d2,.5);
  d=opUnion(d,vec2(d1,1.));
  
  float d3=sdPlane(p-vec3(0.,-1.,0.),vec3(0.,1.,0.),.1);
  d=opUnion(d,vec2(d3,2.));
  
  return d;
}

vec3 calcNormal(in vec3 p)
{
  const float h=.0001;
  const vec2 k=vec2(1,-1);
  return normalize(k.xyy*map(p+k.xyy*h).x+
  k.yyx*map(p+k.yyx*h).x+
  k.yxy*map(p+k.yxy*h).x+
  k.xxx*map(p+k.xxx*h).x);
}

float softshadow(in vec3 ro,in vec3 rd,float mint,float maxt,float k)
{
  float res=1.;
  float t=mint;
  for(int i=0;i<256&&t<maxt;i++)
  {
    float h=map(ro+rd*t).x;
    if(h<.001)
    return 0.;
    res=min(res,k*h/t);
    t+=h;
  }
  return res;
}

vec3 getSceneColor(vec2 fragCoord){
  vec2 uv=fragCoord/iResolution.xy;
  uv=(uv-.5)*2.;
  uv.x*=iResolution.x/iResolution.y;
  
  vec3 ro=vec3(0.,0.,1.);
  vec3 rd=normalize(vec3(uv,0.)-ro);
  
  vec3 col=vec3(0.);
  
  float depth=0.;
  for(int i=0;i<128;i++){
    vec3 p=ro+rd*depth;
    // float d=map(p);
    vec2 res=map(p);
    float d=res.x;
    float m=res.y;
    depth+=d;
    if(d<.01){
      // col=vec3(1.);
      col=vec3(0.);
      vec3 normal=calcNormal(p);
      
      vec3 objectColor=vec3(1.);
      vec3 lightColor=vec3(.875,.286,.333);
      
      // material
      if(m==2.){
        lightColor=vec3(1.);
      }
      
      // ambient
      float ambIntensity=.2;
      vec3 ambient=lightColor*ambIntensity;
      col+=ambient*objectColor;
      
      // diffuse
      vec3 lightPos=vec3(10.,10.,10.);
      vec3 lightDir=normalize(lightPos-p);
      float diff=dot(normal,lightDir);
      diff=max(diff,0.);
      vec3 diffuse=lightColor*diff;
      float shadow=softshadow(p,lightDir,.01,10.,16.);
      col+=diffuse*objectColor*shadow;
      
      // specular
      vec3 reflectDir=reflect(-lightDir,normal);
      vec3 viewDir=normalize(ro-p);
      vec3 halfVec=normalize(lightDir+viewDir);
      float spec=dot(normal,halfVec);
      spec=max(spec,0.);
      float shininess=32.;
      spec=pow(spec,shininess);
      vec3 specular=lightColor*spec;
      col+=specular*objectColor;
      
      break;
    }
  }
  
  return col;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
  vec3 tot=vec3(0.);
  
  float AA_size=1.;
  float count=0.;
  for(float aaY=0.;aaY<AA_size;aaY++)
  {
    for(float aaX=0.;aaX<AA_size;aaX++)
    {
      tot+=getSceneColor(fragCoord+vec2(aaX,aaY)/AA_size);
      count+=1.;
    }
  }
  tot/=count;
  
  fragColor=vec4(tot,1.);
}