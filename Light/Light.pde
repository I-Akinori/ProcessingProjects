import processing.pdf.*;

int maxTH;
int TH = 0;
float turnAngle = 30;
float lengthRatio = 0.7;
float randRangeA = 10;
float randRangeR = 0.2;
float radRatio = (1 - sqrt(lengthRatio)) / (1 - lengthRatio);

void setup(){
  size(1000, 1000);
  background(0, 0, 0);
  blendMode(ADD);
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
  
  color C1 = visColor((float)h / TH);
  color C2 = visColor((float)(h + 0.5) / TH);
  //ellipse(x * (1 - radRatio / 2) + endx * (0 + radRatio / 2), y * (1 - radRatio / 2) + endy * (0 + radRatio / 2), l * radRatio, l * radRatio);
  lightPoint(x * (1 - radRatio / 2) + endx * (0 + radRatio / 2), y * (1 - radRatio / 2) + endy * (0 + radRatio / 2), C1, (l * radRatio) * 2, 1);
  lightPoint(x * (1 - radRatio) / 2 + endx * (1 + radRatio) / 2, y * (1 - radRatio) / 2 + endy * (1 + radRatio) / 2, C2, l * (1 - radRatio)* 2, 1);
}
float Sigmoid(float value, float gain, float ofset)
{
   return 1.0 / (1.0 + exp(- (value - ofset) * gain));
}

color visColor(float value) {
  if (value > 1) value = 1;
  if (value < 0) value = 0;
  float x = 2 * value - 1;
  float gain = 8f;
  return color(255 * Sigmoid(x, gain, 0.2), 
                255 * (- 1 + Sigmoid(x, gain, -0.7f) + (1 - Sigmoid(x, gain, 0.7f))),
                255 * (1 - Sigmoid(x, gain, -0.2)) 
                );
}

void draw() {
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    background(0, 0, 0);
    branch(width / 2, height, -90, height * 0.2, 0);
    //lightPoint(width / 2, height / 2, color(96, 192, 128), 128, 1);
    TH++;
  } else {
    String namePNG = "Spheres2_" + str(TH) + ".png";
    save(namePNG);
  }
}
