void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  // uv.x 坐标的分布情况
  // fragColor=vec4(uv.x,0.,0.,1.);
  // uv.y 坐标的分布情况
  // fragColor=vec4(0.,uv.y,0.,1.);
  // uv.xy 坐标的分布情况
  // fragColor = vec4(uv.xy, 0.0, 1.0);
  fragColor = vec4(uv.x, uv.y, 0.0, 1.0);
}