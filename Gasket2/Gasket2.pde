int count = 0;
int x;
int y;
int rad;

void setup() {
  //size(2339, 1654);
  size(1169, 827);
  
  x = width / 8 * 7;
  y = height / 2;
  rad = height / 64;
  
  colorMode(HSB, 1);
  background(0, 0, 1);
  
  stroke(0.5);
  fill(0);
  DrawGasket(x, y, rad, count);  
}

void draw() {}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    count++;
    x -= rad;
    rad *= 2;
    DrawGasket(x, y, rad, count);
  } else {
    String namePNG = "lsystem_koch_" + count + ".png";
    save(namePNG);
  }
}

void DrawGasket(float x, float y, float r, int grade) {
  if (grade > 0) {
    DrawGasket(x + r / 2, y, r / 2, grade - 1);
    DrawGasket(x - r / 4, y - r / 4 * sqrt(3), r / 2, grade - 1);
    DrawGasket(x - r / 4, y + r / 4 * sqrt(3), r / 2, grade - 1);
  }
  else
    drawPolygon((int)x, (int)y, (int)r, 3);
}

void drawPolygon(int x, int y, int r, int vertexNum) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (int i = 0; i < vertexNum; i++) {
    vertex(r*cos(radians(360*i/vertexNum)), r*sin(radians(360*i/vertexNum)));
  }
  endShape(CLOSE);
  popMatrix();
}
