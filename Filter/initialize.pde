void initialize() {
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      color pix = pixels[(i * width / num1) * width + (j * height / num2)];
      state[i][j] = 0.3 * red(pix) + 0.6 * green(pix) + 0.1 * blue(pix);
      state0[i][j] = state[i][j];
    }
  }
  
  float[][][] fil = new float[4][5][5];
  
  fil[0] = new float[][] {
    {1,  4,  6,  4,  1},
    {4, 16, 24, 16,  4},
    {6, 24, 36, 24,  6},
    {4, 16, 24, 16,  4},
    {1,  4,  6,  4,  1}
  };
  fil[1] = new float[][] {
    {0,  0,  0,  0,  0},
    {0, -1,  0,  1,  0},
    {0, -1,  0,  1,  0},
    {0, -1,  0,  1,  0},
    {0,  0,  0,  0,  0}
  };
  fil[2] = new float[][] {
    {1,  1,  1,  1,  1},
    {1,  1,  1,  1,  1},
    {1,  1,-24,  1,  1},
    {1,  1,  1,  1,  1},
    {1,  1,  1,  1,  1}
  };
  fil[3] = new float[][] {
    {0,  0,  0,  0,  1},
    {0,  0,  0,  0,  1},
    {-1,  -1,  1,  1,  1},
    {-1,  0,  0,  0,  0},
    {-1,  0,  0,  0,  0}
  };
  
  for (int m = 0; m < 4; m++) {
    float sum = 0;
  
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        sum += fil[m][i][j];
      }
    }
  
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (sum != 0) fil[m][i][j] /= sum;
      }
    }
    
    filter[m] = fil[m];
  }
}
