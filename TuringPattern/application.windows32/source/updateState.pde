void updateState(){
  float[][] nextStateA = new float[num1][num2];
  float[][] nextStateB = new float[num1][num2];
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      nextStateA[i][j] = transitionA(i, j);
      nextStateB[i][j] = transitionB(i, j);
    }
  }
  stateA = nextStateA;
  stateB = nextStateB;
  
  float[] FList = {0.012, 0.022, 0.025, 0.035, 0.025, 0.027, 0.035, 0.040, 0.025, 0.011};
  float[] KList = {0.050, 0.051, 0.060, 0.062, 0.050, 0.053, 0.057, 0.060, 0.052, 0.046};
  int step = 200;
  int states = 10;
  int i = (frameCount / step) % states;
  int j = frameCount % step;
  F = interporation(j, 0, step, FList[i], FList[(i + 1) % states]);
  K = interporation(j, 0, step, KList[i], KList[(i + 1) % states]);
  //F = 0.04 + 0.01 * sin(frameCount * 0.013);
  //K = 0.05 + 0.01 * sin(frameCount * 0.004);
}

float interporation(int t, int St, int Gt, float Sv, float Gv){
  return (float) (t - St) / (Gt - St) * (Gv - Sv) + Sv;
}
