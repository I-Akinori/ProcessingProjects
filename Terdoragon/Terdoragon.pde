import processing.pdf.*;

int maxTH;
int TH = 0;
float angle = 30;
float lengthRatio = 0.7;
float randRangeA = 0;
float randRangeR = 0;

void setup(){
  size(1000, 1000);
  colorMode(HSB, 1);
  background(0, 0, 1);
  initCurve();
}

void bend(float x1, float y1, float x2, float y2, int mode, int col, int h) {
  
  float x12 = x2 - x1;
  float y12 = y2 - y1;
  float cosA = cos(radians(angle));
  float sinA = sin(radians(angle));
  float tanA = tan(radians(angle));
  
  float xm1, ym1, xm2, ym2; 
  if (mode == 0) {
    //xm = x1 + x12 * cosA * cosA + (cosA * sinA) * y12; // ritht triangle
    //ym = y1 + y12 * cosA * cosA - (cosA * sinA) * x12;
    xm1 = (x1 + x2) / 2 + tanA * y12 / 2;                // isosceles triangle 
    ym1 = (y1 + y2) / 2 - tanA * x12 / 2;
    xm2 = (x1 + x2) / 2 - tanA * y12 / 2;                 
    ym2 = (y1 + y2) / 2 + tanA * x12 / 2;
  } else {
    //xm = x1 + x12 * cosA * cosA - (cosA * sinA) * y12; // ritht triangle
    //ym = y1 + y12 * cosA * cosA + (cosA * sinA) * x12;
    xm1 = (x1 + x2) / 2 + tanA * y12 / 2;                // isosceles triangle 
    ym1 = (y1 + y2) / 2 - tanA * x12 / 2;
    xm2 = (x1 + x2) / 2 - tanA * y12 / 2;                 
    ym2 = (y1 + y2) / 2 + tanA * x12 / 2;
  }
  
  
  if (h < TH) {
    //bend(x1, y1, xm, ym, (random(1) > 0.5 ? 0 : 1), h + 1);
    //bend(xm, ym, x2, y2, (random(1) > 0.5 ? 0 : 1), h + 1);
    bend(x1, y1, xm1, ym1, 0, col, h + 1);
    bend(xm1, ym1, xm2, ym2, 0, col, h + 1);
    bend(xm2, ym2, x2, y2, 0, col, h + 1);
  } else {
    switch(col) {
      case 0:
        stroke(0, 1, 1);
      break;
      case 1:
        stroke(0.333, 1, 1);
      break;
      case 2:
        stroke(0.666, 1, 1);
      break;
      default:
        stroke(0, 0, 0);
    }
    line(x1, y1, xm1, ym1);
    line(xm1, ym1, xm2, ym2);
    line(xm2, ym2, x2, y2);
    //line(x1, y1, x2, y2);
  }
}

void initCurve() {
  line(1 * width / 4, height / 2, 3 * width / 4, height / 2);
  /*
  stroke(0, 1, 1);
  line(width / 2 + width / 4 * cos(radians(90)), height / 2 + width / 4 * sin(radians(90)),  width / 2 + width / 4 * cos(radians(210)), height / 2 + width / 4 * sin(radians(210)));
  stroke(0.333, 1, 1);
  line(width / 2 + width / 4 * cos(radians(210)), height / 2 + width / 4 * sin(radians(210)),  width / 2 + width / 4 * cos(radians(330)), height / 2 + width / 4 * sin(radians(330)));
  stroke(0.666, 1, 1);
  line(width / 2 + width / 4 * cos(radians(330)), height / 2 + width / 4 * sin(radians(330)),  width / 2 + width / 4 * cos(radians(90)), height / 2 + width / 4 * sin(radians(90)));
  */
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    bend(1 * width / 4, height / 2, 3 * width / 4, height / 2, 0, 4, 0);
    //bend(width / 2 + width / 4 * cos(radians(90)), height / 2 + width / 4 * sin(radians(90)),  width / 2 + width / 4 * cos(radians(210)), height / 2 + width / 4 * sin(radians(210)), 0, 0, 0);
    //bend(width / 2 + width / 4 * cos(radians(210)), height / 2 + width / 4 * sin(radians(210)),  width / 2 + width / 4 * cos(radians(330)), height / 2 + width / 4 * sin(radians(330)), 0, 1, 0);
    //bend(width / 2 + width / 4 * cos(radians(330)), height / 2 + width / 4 * sin(radians(330)),  width / 2 + width / 4 * cos(radians(90)), height / 2 + width / 4 * sin(radians(90)), 0, 2, 0);
    TH++;
  } else {
    String namePNG = "TerdragonA_" + str(angle) + "_" + str(TH) +".png";
    save(namePNG);
  }
}
