float transitionA(int i, int j) {
  
  float Ac = stateA[i][j];
  float Al = stateA[(i - 1 + num1) % num1][j];
  float Ar = stateA[(i + 1) % num1][j];
  float Au = stateA[i][(j - 1 + num2) % num2];
  float Ad = stateA[i][(j + 1) % num2];
  float Bc = stateB[i][j];
  
  float deltaC = D1 * (Al + Ar + Au + Ad - 4 * Ac) - Ac * Bc * Bc + F * (1 - Ac);
  
  return Ac + deltaC * 1.0;
}

float transitionB(int i, int j) {
  
  float Bc = stateB[i][j];
  float Bl = stateB[(i - 1 + num1) % num1][j];
  float Br = stateB[(i + 1) % num1][j];
  float Bu = stateB[i][(j - 1 + num2) % num2];
  float Bd = stateB[i][(j + 1) % num2];
  float Ac = stateA[i][j];
  
  float deltaC = D2 * (Bl + Br + Bu + Bd - 4 * Bc) + Ac * Bc * Bc - (F + K) * Bc;
  return Bc + deltaC * 1.0;
}
