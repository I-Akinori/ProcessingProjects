void drawCell() {
  float scalar1 = (float) width / num1;
  float scalar2 = (float) height / num2;
  float x = 0;
  float y = 0;
  for (int i = 0; i < num1; i++){
    y = 0;
    for (int j = 0; j < num2; j++){
      noStroke();
      color c = vis_color(stateA[i][j] * 1.0);
      c = color(1.0 - stateA[i][j] * 1.0, 0.7, 0.8);
      fill(c);
      rect(x, y, scalar1, scalar2);
      y += scalar2;
    }
    x += scalar1;
  }
}

color vis_color(float v) {
  float r = 0;
  float g = 0;
  float b = 0;
  if (v < 0.5) {
     r = 1.0 - 2 * v; 
  }
  if (v > 0.5) {
     b = - 1.0 + 2 * v; 
  }
  if (v > 0.25 && v < 0.5) {
     g = - 1.0 + 4 * v; 
  }
  if (v >= 0.5 && v < 0.75) {
     g = + 3.0 - 4 * v; 
  }
  
  //return color(r * 255, g * 255, b * 255);
  return color(255, 255, 255);
}
