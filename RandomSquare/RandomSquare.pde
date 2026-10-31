PImage img;
int Px;
int Py;
int num1 = 50;
int num2 = 50;
int count = 0;

void setup() {
  size(500, 500);
  //img = loadImage("HNG.jpg");
  //image(img, 0, 0);
  loadPixels();
  Px = num1 / 2;
  Py = num2 / 2;
  
  //colorMode(HSB, 1);
  background(255, 255, 255);
  frameRate(50);
  stroke(191);
  drawGrid();
  stroke(0);
 // drawCell(Px, Py, color(255, 0, 0));
}

void draw() {
  if (count > 0) {
    //moveCell((int)random(4), 1);
    moveEdge((int)random(4), (int)random(4));
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

void moveCell(int dir, int steps) {
  drawCell(Px, Py, color(0));
  switch (dir) {
    case 0:
      for (int i = 0; i < steps; i++) {
        Px = (Px + 1) % num1;
        drawCell(Px, Py, color(0));     
      }
    break;
    case 1:
      for (int i = 0; i < steps; i++) {
        Py = (Py + 1) % num2;
        drawCell(Px, Py, color(0));     
      }
    break;
    case 2:
      for (int i = 0; i < steps; i++) {
        Px = (Px - 1 + num1) % num1;
        drawCell(Px, Py, color(0));     
      }
    break;
    default:
      for (int i = 0; i < steps; i++) {
        Py = (Py - 1 + num2) % num2;
        drawCell(Px, Py, color(0));     
      }
  }
  drawCell(Px, Py, color(255, 0, 0));
}

void drawCell (int x, int y, color c) {
  float scale1 = width / num1;
  float scale2 = height / num2;
  fill(c);
  rect(x * scale1, y * scale2, width / num1, height / num2);
}

void drawGrid() {
  float scale1 = width / num1;
  float scale2 = height / num2;
  for (int i = 1; i < num1; i++) {
    line(i * scale1, 0, i * scale1, height);
  }
  for (int i = 1; i < num2; i++) {
    line(0, i * scale2, width, i * scale2);
  }
}

void moveEdge(int dir, int steps) {
  strokeWeight(2);
  float scale1 = width / num1;
  float scale2 = height / num2;
  switch (dir) {
    case 0:
      for (int i = 0; i < steps; i++) {
        if (Px < num1) {
          line(Px * scale1, Py * scale2, (Px + 1) % (num1 + 1) * scale1, Py * scale2);
        } else {
          line(0 * scale1, Py * scale2, (Px + 1) % (num1 + 1) * scale1, Py * scale2);
        }
        Px = (Px + 1) % (num1 + 1);     
      }
    break;
    case 1:
      for (int i = 0; i < steps; i++) {
        if (Py < num2) {
          line(Px * scale1, Py * scale2, Px * scale1, (Py + 1) % (num2 + 1) * scale2);
        } else {
          line(Px * scale1, 0 * scale2, Px * scale1, (Py + 1) % (num2 + 1) * scale2);
        }
        Py = (Py + 1) % (num2 + 1);     
      }
    break;
    case 2:
      for (int i = 0; i < steps; i++) {
        if (Px > 0) {
          line(Px * scale1, Py * scale2, (Px + num1) % (num1 + 1) * scale1, Py * scale2);
        } else {
          line(num1 * scale1, Py * scale2, (Px + num1) % (num1 + 1) * scale1, Py * scale2);
        }
        Px = (Px + num1) % (num1 + 1);     
      }
    break;
    default:
      for (int i = 0; i < steps; i++) {
        if (Py > 0) {
          line(Px * scale1, Py * scale2, Px * scale1, (Py + num2) % (num2 + 1) * scale2);
        } else {
          line(Px * scale1, num2 * scale2, Px * scale1, (Py + num2) % (num2 + 1) * scale2);
        }
        Py = (Py + num2) % (num2 + 1);  
      }
  }
}
