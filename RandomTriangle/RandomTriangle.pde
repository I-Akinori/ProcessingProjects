PImage img;
int Px;
int Py;
int num1 = 100;
int num2 = 100;
float offset = 0.5;
int count = 0;
float[][] weight = new float[num1 + 1][num2 + 1];

void setup() {
  size(1000, 866);
  //img = loadImage("honpen.jpg");
  //image(img, 0, 0, width, height);
  //loadPixels();
  Px = num1 / 4;
  Py = num2 / 2;
  
  //colorMode(HSB, 1);
  background(255, 255, 255);
  frameRate(100);
  stroke(216);
  drawGrid();
  strokeWeight(2);
  stroke(0, 0, 0);
  //setWeight();
 // drawCell(Px, Py, color(255, 0, 0));
}

void draw() {
  if (count > 0) {
    //moveCell((int)random(4), 1);
    moveEdge((int)random(6), (int)random(6));
    count = 0;
  }
  count++;
}

void mouseClicked() {
  //drawCell(Px, Py, color(0, 0, 0));
  String namePNG = "RandomCell_" + str(year()) + str(month()) + str(day()) + "_" + str(hour()) + str(minute()) + "_" + str(second()) +".png";
  save(namePNG);
  //drawCell(Px, Py, color(255, 0, 0));
}

void drawGrid() {
  float scale1 = (float) width / num1;
  float scale2 = (float) height / num2;
  for (int i = -num1; i < num1; i++) {
    line(i * scale1, 0, i * scale1 + scale1 * offset * num2, scale2 * num2);
  }
  for (int i = 0; i < num1 * 2; i++) {
    line(i * scale1, 0, i * scale1 + scale1 * (offset - 1) * num2, scale2 * num2);
  }
  for (int i = 1; i < num2 + 1; i++) {
    line(0, i * scale2, width, i * scale2);
  }
}

void moveEdge(int dir, int steps) {
  float scale1 = (float) width / num1;
  float scale2 = (float) height / num2;
  switch(dir){
    case 0:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px + 1, Py);
      Px += 1;
    }
    break;
    case 1:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px + 1, Py - 1);
      Px += 1;
      Py -= 1;
    }
    break;
    case 2:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px, Py + 1);
      Py += 1;
    }
    break;
    case 3:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px - 1, Py);
      Px -= 1;
    }
    break;
    case 4:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px - 1, Py + 1);
      Px -= 1;
      Py += 1;
    }
    break;
    default:
    for (int i = 0; i < steps; i++) {
      lineOnGrid(Px, Py, Px, Py - 1);
      Py -= 1;
    }
  }
}

void lineOnGrid(int Sx, int Sy, int Ex, int Ey) {
  float scale1 = (float) width / num1;
  float scale2 = (float) height / num2;
  
  line(Sx * scale1 + Sy * scale1 * offset, Sy * scale2, Ex * scale1 + Ey * scale1 * offset, Ey * scale2);
}

void setWeight() {
  for (int i = 0; i < num1 + 1; i++) {
    for (int j = 0; j < num2 + 1; j++) {
      color pix = pixels[(i % num1 * width / num1) + width * (j  % num2 * width / num2)];
      
      weight[i][j] = 0.3 * red(pix) + 0.6 * green(pix) + 0.1 * blue(pix);
      //weight[i][j] = 255 - weight[i][j];
      weight[i][j] *= 32.0 / 256;
    }
  }
}
