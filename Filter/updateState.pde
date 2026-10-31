void updateState(){
  float[][] nextState = new float[num1][num2];
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      nextState[i][j] = transition(i, j);
    }
  }
  prestate = state;
  state = nextState;
}
