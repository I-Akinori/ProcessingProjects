void initialize() {
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      color pix = pixels[(j * height / num2) * width + (i * width / num1)];
      float mask = pow(0.99, sqrt((i - num1 / 2) * (i - num1 / 2) + (j - num2 / 2) * (j - num2 / 2)));
      stateA[i][j] = 1 * (0.3 * red(pix) + 0.6 * green(pix) + 0.1 * blue(pix));
      //stateA[i][j] *= mask;
      //stateA[i][j] = 1;
      
      stateB[i][j] = 1 - 1 * (0.3 * red(pix) + 0.6 * green(pix) + 0.1 * blue(pix));
      //stateB[i][j] *= mask;
      
      int range = 3;
      if (i > num1 / 2 - range && i < num1 / 2 + range && j > num2 / 2 - range && j < num2 / 2 + range) {
         float r = random(1);
         stateA[i][j] = r;
         stateB[i][j] = r;
      }
      
      stateA0[i][j] = stateA[i][j];
      stateB0[i][j] = stateB[i][j];
    }
  }
}
