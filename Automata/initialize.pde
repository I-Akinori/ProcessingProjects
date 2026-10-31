void initialize() {
  for (int i = 0; i < num; i++) {
    for (int j = 0; j < num; j++) {
      color pix = pixels[(i * 2) * width + (j * 2)];
      state[i][j] = 0.3 * red(pix) + 0.6 * green(pix) + 0.1 * blue(pix);
    }
  }
  
  float[][] fil = new float[][] {
    {1,  4,  6,  4,  1},
    {4, 16, 24, 16,  4},
    {6, 24, 36, 24,  6},
    {4, 16, 24, 16,  4},
    {1,  4,  6,  4,  1}
  };
  
  float sum = 0;
  
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      sum += fil[i][j];
    }
  }
  
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      fil[i][j] /= sum;
    }
  }
  
  filter = fil;
  println(filter[2][2]);
}
