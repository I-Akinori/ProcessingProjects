import processing.pdf.*;

int maxTH;
int TH = 0;
float angle = 45;
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
  
  float xm, ym; 
  if (mode == 0) {
    //xm = x1 + x12 * cosA * cosA + (cosA * sinA) * y12; // ritht triangle
    //ym = y1 + y12 * cosA * cosA - (cosA * sinA) * x12;
    xm = (x1 + x2) / 2 + tanA * y12 / 2 ;                // isosceles triangle 
    ym = (y1 + y2) / 2 - tanA * x12 / 2;
  } else {
    //xm = x1 + x12 * cosA * cosA - (cosA * sinA) * y12; // ritht triangle
    //ym = y1 + y12 * cosA * cosA + (cosA * sinA) * x12;
    xm = (x1 + x2) / 2 - tanA * y12 / 2;                 // isosceles triangle
    ym = (y1 + y2) / 2 + tanA * x12 / 2;
  }
  
  
  if (h < TH) {
    //bend(x1, y1, xm, ym, (random(1) > 0.5 ? 0 : 1), h + 1);
    //bend(xm, ym, x2, y2, (random(1) > 0.5 ? 0 : 1), h + 1);
    bend(x1, y1, xm, ym, 0, h + 1);
    bend(xm, ym, x2, y2, 1, h + 1);
  } else {
    line(x1, y1, xm, ym);
    line(xm, ym, x2, y2);
    //line(x1, y1, x2, y2);
  }
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    bend(1 * width / 4, height / 2, 3 * width / 4, height / 2, 0, 0);
    TH++;
  } else {
    String namePNG = "dragonA1_" + str(angle) + "_" + str(TH) +".png";
    save(namePNG);
  }
}
