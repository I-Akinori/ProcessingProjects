float transition(int i, int j) {
  
  float nextC = 0;
  for (int s = 0; s < 5; s++) {
    for (int t = 0; t < 5; t++) {
      nextC += filter[s][t] * state[(i - 2 + s + num) % num][(j - 2 + t + num) % num];
    }
  }
  
  nextC += (1 - nextC) * 0.01;
  return nextC;
}
