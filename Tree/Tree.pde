import processing.pdf.*;

int maxTH;
int TH = 0;
float turnAngle = 30;
float lengthRatio = 0.7;
float randRangeA = 0;
float randRangeR = 0;

void setup(){
  size(1000, 1000);
  colorMode(HSB, 1);
  background(0, 0, 1);
}

void branch(float x, float y, float angle, float l, int h) {
  
  float endx = x + cos(radians(angle)) * l;
  float endy = y + sin(radians(angle)) * l;
  
  float angle1 = angle + (turnAngle + random(-randRangeA, randRangeA));
  float angle2 = angle - (turnAngle + random(-randRangeA, randRangeA));
  float length1 = l * (lengthRatio + random(-randRangeR, randRangeR));
  float length2 = l * (lengthRatio + random(-randRangeR, randRangeR));
  
  if (h < TH) {
    branch(endx, endy, angle1, length1, h + 1);
    branch(endx, endy, angle2, length2, h + 1);
  }
  
  stroke(0, 0, 0.5 * h / TH);
  strokeWeight(TH - h);
  line(x, y, endx, endy);
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    branch(width / 2, height, -90, height * 0.2, 0);
    TH++;
  } else {
    String namePNG = "tree_" + str(TH) + ".png";
    save(namePNG);
  }
}
