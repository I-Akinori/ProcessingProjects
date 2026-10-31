void drawCell() {
  float scalar1 = (float) width / num2;
  float scalar2 = (float) height / num1;
  float y = 0;
  float x;
  for (int i = 0; i < num1; i++){
    x = 0;
    for (int j = 0; j < num2; j++){
      noStroke();
      fill(color(0, 0, state[i][j] * 1.0));
      rect(x, y, scalar1, scalar2);
      x += scalar1;
    }
    y += scalar2;
  }
}
