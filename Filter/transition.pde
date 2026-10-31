float transition(int i, int j) {
  
  float nextC = 0;
  for (int s = 0; s < 5; s++) {
    for (int t = 0; t < 5; t++) {
      nextC += filter[mode][s][t] * state[(i - 2 + s + num1) % num1][(j - 2 + t + num2) % num2];
    }
  }
  
  //nextC += (1 - nextC) * 0.01;
  return nextC;
}
