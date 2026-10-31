void mouseDragged() {
  int posX = (num * mouseY / height + num) % num;
  int posY = (num * mouseX / width + num) % num;
  if (posX < 0) posX += num;
  if (posY < 0) posY += num;
  
  state[(posX - 1 + num) % num][posY] = 0;
  state[posX][(posY - 1 + num) % num] = 0;
  state[posX][posY] = 0;
  state[(posX + 1) % num][posY] = 0;
  state[posX][(posY + 1) % num] = 0;
  
  prestate[posX][posY] = 0;
}
