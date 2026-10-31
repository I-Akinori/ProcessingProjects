import controlP5.*;
import processing.pdf.*;
PImage img;
ControlP5 cp5;

int range;
int steps;
boolean simulate = true;

float D1 = 0.2;
float D2 = 0.1;
float F = 0.034;
float K = 0.0618;

int num1 = 228;
int num2 = 152;
float stateA0[][] = new float[num1][num2];
float stateB0[][] = new float[num1][num2];
float stateA[][] = new float[num1][num2];
float stateB[][] = new float[num1][num2];
int mode = -1;

boolean filtering = false;

void setup() {
  size(2736, 1824);
  //size(1368, 912);
  //img = loadImage("amabie.png");
  img = loadImage("honpen420x280.jpg");
  //img = loadImage("FJ_GRAY.png");
  img.resize(width, height); 
  image(img, 0, 0);
  loadPixels();
  
  colorMode(HSB, 1);
  initialize();
  frameRate(30);
  
  controller();
}
void draw() {
  if (simulate) {
    drawCell();
    for (int i = 0; i < steps; i++)
      updateState();
  }
}

void Reset(){
  mode = -1;
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      stateA[i][j] = stateA0[i][j];
      stateB[i][j] = stateB0[i][j];
    }
  }
}

void Stop_Restart(){
  simulate = !simulate;
}

void Capture() {
  //String namePDF = "honpen" + str(num1) + "_" + str(num2) + ".pdf";
  //beginRecord(PDF, namePDF);
  //drawCell();
  //endRecord();
  //String namePNG = "honpen" + str(num1) + "_" + str(num2) + ".png";
  String namePNG = "FJ" + str(num1) + "_" + str(num2) + ".png";
  save(namePNG);
  
}
