void updateState(){
  float[][] nextState = new float[num][num];
  for (int i = 0; i < num; i++) {
    for (int j = 0; j < num; j++) {
      nextState[i][j] = transition(i, j);
    }
  }
  prestate = state;
  state = nextState;
}
