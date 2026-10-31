import processing.pdf.*;

int maxTH;
int TH = 0;
float angle = 36;
float lengthRatio = 0.7;
float randRangeA = 0;
float randRangeR = 0;

void setup(){
  size(1000, 1000);
  colorMode(HSB, 1);
  background(0, 0, 1);
}

void bend(float x1, float y1, float x2, float y2, int mode, int h) {
  
  float x12 = x2 - x1;
  float y12 = y2 - y1;
  float cosA = cos(radians(angle));
  float sinA = sin(radians(angle));
  float tanA = tan(radians(angle));
  
  float x3, y3, x4, y4, x5, y5; 
  
  x3 = x2 + y12;
  y3 = y2 - x12;
  x4 = x1 + y12;
  y4 = y1 - x12;
  
  x5 = x4 + x12 * cosA * cosA + (cosA * sinA) * y12; // ritht triangle
  y5 = y4 + y12 * cosA * cosA - (cosA * sinA) * x12;  
  
  if (h < TH) {
    //bend(x1, y1, xm, ym, (random(1) > 0.5 ? 0 : 1), h + 1);
    //bend(xm, ym, x2, y2, (random(1) > 0.5 ? 0 : 1), h + 1);
    bend(x4, y4, x5, y5, 0, h + 1);
    bend(x5, y5, x3, y3, 0, h + 1);
  }
  
  //line(x2, y2, x3, y3);
  //line(x3, y3, x4, y4);
  //line(x4, y4, x1, y1);
  //line(x4, y4, x5, y5);
  //line(x5, y5, x3, y3);
  
  //stroke(1.0 * (h + 1) / (TH + 1));
  //strokeWeight(TH - h);
  //line(x1, y1, x3, y3);
  //line(x2, y2, x4, y4);
  
  noStroke();
  fill(1.0 * (h + 1) / (TH + 1));
  quad(x1, y1, x2, y2, x3, y3, x4, y4);
  
  //noFill();
  //stroke(1.0 * (h + 1) / (TH + 1));
  //strokeWeight(TH - h);
  //float dia = sqrt((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3));
  //ellipse((x1 + x3) / 2, (y1 + y3) / 2, dia, dia);
  
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    float sinA = sin(radians(angle));
    float cosA = cos(radians(angle));
    
    background(0, 0, 1);
    //line(4 * width / 9, height / 2, 5 * width / 9, height / 2);
    bend(4 * width / 9, height / 2, 5 * width / 9, height / 2, 0, 0);
    //line(5 * width / 9, height / 2, 4 * width / 9 + sinA * sinA * width / 9, height / 2 + sinA * cosA * width / 9);
    bend(5 * width / 9, height / 2, 4 * width / 9 + sinA * sinA * width / 9, height / 2 + sinA * cosA * width / 9, 0, 0);
    //line(4 * width / 9 + sinA * sinA * width / 9, height / 2 + sinA * cosA * width / 9, 4 * width / 9, height / 2);
    bend(4 * width / 9 + sinA * sinA * width / 9, height / 2 + sinA * cosA * width / 9, 4 * width / 9, height / 2, 0, 0);
    
    TH++;
  } else {
    String namePNG = "CircleDragonXL_" + str(angle) + "_" + str(TH) +".png";
    save(namePNG);
  }
}
