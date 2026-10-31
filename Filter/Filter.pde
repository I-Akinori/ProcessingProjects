import controlP5.*;
import processing.pdf.*;
PImage img;
ControlP5 cp5;

int num1 = 500;
int num2 = 500;
float state0[][] = new float[num1][num2];
float state[][] = new float[num1][num2];
float prestate[][] = new float[num1][num2];
float filter[][][] = new float[4][5][5];
int mode = -1;

boolean filtering = false;

void setup() {
  size(500, 500);
  //img = loadImage("amabie.png");
  img = loadImage("honpen.jpg");
  img.resize(width, height); 
  image(img, 0, 0);
  loadPixels();
  
  colorMode(HSB, 1);
  initialize();
  frameRate(2);
  
  controller();
}
void draw() {
  drawCell();
  //updateState();
}

void Gaussian(){
   mode = 0;
   updateState();
   mode = -1;
   println("Gaussian");
}

void edge(){
   mode = 1;
   updateState();
   mode = -1;
   println("edge");
}

void Laplacian(){
   mode = 2;
   updateState();
   mode = -1;
   println("Laplacian");
}

void Custom(){
   mode = 3;
   updateState();
   mode = -1;
   println("Custom");
}

void Reset(){
  mode = -1;
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      state[i][j] = state0[i][j];
    }
  }
   println("Reset");
}

void Capture() {
  String namePDF = "honpen" + str(num1) + "_" + str(num2) + ".pdf";
  beginRecord(PDF, namePDF);
  drawCell();
  endRecord();
  String namePNG = "honpen" + str(num1) + "_" + str(num2) + ".png";
  save(namePNG);
  
  println("Capture");
}
