void drawCell() {
  float scalar = (float) height / num;
  float y = 0;
  float x;
  
  for (int i = 0; i < num; i++) {
    x = 0;
    for (int j = 0; j < num; j++) {
      noStroke();
      fill(color(0, 0, state[i][j] * 1.0));
      rect(x, y, scalar, scalar);
      x += scalar;
    }
    y += scalar;
  }
}
