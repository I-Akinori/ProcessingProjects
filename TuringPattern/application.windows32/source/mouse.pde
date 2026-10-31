void mouseDragged() {
  int posY = (num2 * mouseY / height + num2) % num2;
  int posX = (num1 * mouseX / width + num1) % num1;
  if (posX < 0) posX += num1;
  if (posY < 0) posY += num2;
  
  for (int s = 0; s < range; s++) {
    for (int t = 0; t < range; t++) {
      stateA[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2] = 1 - stateA[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2];
      stateB[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2] = 1 - stateB[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2];
    }
  }
  
  //stateA[(posX - 1 + num1) % num1][posY] = 1 - stateA[(posX - 1 + num1) % num1][posY];
  //stateA[posX][(posY - 1 + num1) % num1] = 1 - stateA[(posX - 1 + num1) % num1][posY];
  //stateA[posX][posY] = 1 - stateA[posX][posY];
  //stateA[(posX + 1) % num1][posY] = 1 - stateA[(posX + 1) % num1][posY];
  //stateA[posX][(posY + 1) % num1] = 1 - stateA[posX][(posY + 1) % num1];
  
}
