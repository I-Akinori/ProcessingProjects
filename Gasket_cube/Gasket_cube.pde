int count = 0;
int x;
int y;
int rad;
color[] cols;

void setup() {
  //size(2339, 1654);
  size(1169, 827);
  
  x = width / 16 * 15;
  y = height / 2;
  rad = height / 64;
  
  colorMode(HSB, 1);
  float h = 0.5;
  float s = 0.3;
  cols = new color[]{color(0.00, 0.0, 0.7), 
                     color(0.33, 0.0, 0.9), 
                     color(0.66, 0.0, 0.5)};
  print(cols.length);
  background(0, 0, 1);
  
  stroke(0.5);
  fill(0);
  DrawGasket(x, y, rad, count, true);  
}

void draw() {}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    count++;
    if (count % 2 == 1) {
      x -= rad;
      rad *= 2;  
    }
    DrawGasket(x, y, rad, count, true);
  } else {
    String namePNG = "gasket_cube_" + count + ".png";
    save(namePNG);
  }
}

void DrawGasket(float x, float y, float r, int grade, boolean first) {
  if (grade > 0) {
    if (!first || count % 2 == 0) 
      //drawRadialLines((int)x, (int)y, (int)r / 2, 3, 180);
      drawRhombus((int)x, (int)y, (int)r / 2, 3, 180);
      
    DrawGasket(x + r / 2, y, r / 2, grade - 2, false);
    DrawGasket(x - r / 4, y - r / 4 * sqrt(3), r / 2, grade - 2, false);
    DrawGasket(x - r / 4, y + r / 4 * sqrt(3), r / 2, grade - 2, false);
  }
  else {
    drawRadialLines((int)x, (int)y, (int)r, 3, 0);
    
  }
}
void drawRadialLines(int x, int y, int r, int vertexNum, int offset) {
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < vertexNum; i++) {
    line(0, 0, r*cos(radians(360*i/vertexNum + offset)), r*sin(radians(360*i/vertexNum + offset)));
  }
  popMatrix();
}
void drawRhombus(int x, int y, int r, int vertexNum, int offset) {
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < vertexNum; i++) {
    fill(cols[i]);
    beginShape();
    vertex(0, 0);
    vertex(r * cos(radians(360 * i/vertexNum + offset)), r * sin(radians(360 * i/vertexNum + offset)));
    vertex(r * cos(radians(360 * (i + 0.5) /vertexNum + offset)), r * sin(radians(360 * (i + 0.5) /vertexNum + offset)));
    vertex(r * cos(radians(360 * (i + 1) /vertexNum + offset)), r * sin(radians(360 * (i + 1) /vertexNum + offset)));
    endShape(CLOSE);
  }
  popMatrix();
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
