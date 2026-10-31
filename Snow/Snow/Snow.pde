import processing.pdf.*;

int maxTH;
int TH = 0;
float turnAngle = 30;
float lengthRatio = 0.7;
float radRatio = (1 - sqrt(lengthRatio)) / (1 - lengthRatio);

void setup(){
  size(1000, 1000);
  colorMode(HSB, 1);
  background(0, 0, 1);
  stroke(0.5, 1, 0.9);
  strokeWeight(5);
}

void mainbranch(float x, float y, float angle, float l, int h) {
  
  float endx = x + cos(radians(angle)) * l;
  float endy = y + sin(radians(angle)) * l;
  
  float midx = x + cos(radians(angle)) * l / 2;
  float midy = y + sin(radians(angle)) * l / 2;
  
  hexbranch(midx, midy, l / 4);
  
  float angle1 = angle + turnAngle * 2;
  float angle2 = angle - turnAngle;
  float length1 = l * lengthRatio;
  float length2 = l * lengthRatio;
  
  //if (h < TH) {
  //  mainbranch(endx, endy, angle1, length1, h + 1);
  //  mainbranch(endx, endy, angle2, length2, h + 1);
  //}
  line(x, y, endx, endy);
  //fill(0, 0, 0.5 * h / TH);
  //noStroke();
  //ellipse(x * (1 - radRatio / 2) + endx * (0 + radRatio / 2), y * (1 - radRatio / 2) + endy * (0 + radRatio / 2), l * radRatio, l * radRatio);
  //ellipse(x * (1 - radRatio) / 2 + endx * (1 + radRatio) / 2, y * (1 - radRatio) / 2 + endy * (1 + radRatio) / 2, l * (1 - radRatio), l * (1 - radRatio));
}
void hexbranch(float x, float y, float l){
  float endx = x + cos(radians(120)) * l;
  float endy = y + sin(radians(120)) * l;
  line(x, y, endx, endy);
  endx = x + cos(radians(-120)) * l;
  endy = y + sin(radians(-120)) * l;
  line(x, y, endx, endy);
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    for (int i = 0; i < 6; i++) {    
      mainbranch(width / 2, height / 2, i * 60, height * 0.1, 0);
    }
    TH++;
  } else {
    String namePNG = "Spheres2_" + str(TH) + ".png";
    save(namePNG);
  }
}
