import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TuringPattern extends PApplet {



PImage img;
ControlP5 cp5;

int range;
int steps;
boolean simulate = true;

float D1 = 0.2f;
float D2 = 0.1f;
float F = 0.034f;
float K = 0.0618f;

int num1 = 228;
int num2 = 152;
float stateA0[][] = new float[num1][num2];
float stateB0[][] = new float[num1][num2];
float stateA[][] = new float[num1][num2];
float stateB[][] = new float[num1][num2];
int mode = -1;

boolean filtering = false;

public void setup() {
  
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
public void draw() {
  if (simulate) {
    drawCell();
    for (int i = 0; i < steps; i++)
      updateState();
  }
}

public void Reset(){
  mode = -1;
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      stateA[i][j] = stateA0[i][j];
      stateB[i][j] = stateB0[i][j];
    }
  }
}

public void Stop_Restart(){
  simulate = !simulate;
}

public void Capture() {
  //String namePDF = "honpen" + str(num1) + "_" + str(num2) + ".pdf";
  //beginRecord(PDF, namePDF);
  //drawCell();
  //endRecord();
  //String namePNG = "honpen" + str(num1) + "_" + str(num2) + ".png";
  String namePNG = "FJ" + str(num1) + "_" + str(num2) + ".png";
  save(namePNG);
  
}
public void controller() {
  cp5 = new ControlP5(this);
  /*
  cp5.addSlider("F")
   .setPosition(10, 10)
   .setSize(100, 20)
   .setRange(0.01, 0.09)
   .setValue(0.034)
   .setColorCaptionLabel(0)
   ;
   cp5.addSlider("K")
   .setPosition(10, 50)
   .setSize(100, 20)
   .setRange(0.04, 0.07)
   .setValue(0.0618)
   .setColorCaptionLabel(0)
   ;
  cp5.addSlider("steps")
   .setPosition(10, 90)
   .setSize(100, 20)
   .setRange(1, 100)
   .setValue(10)
   .setColorCaptionLabel(0)
   ;
  cp5.addSlider("range")
   .setPosition(10, 130)
   .setSize(100, 20)
   .setRange(2, 50)
   .setValue(10)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Stop_Restart")
   .setPosition(10, 170)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Reset")
   .setPosition(10, 210)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Capture")
   .setPosition(10, 250)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;*/
   /*
   cp5.addSlider("F")
   .setPosition(10, 10)
   .setSize(300, 60)
   .setRange(0.01, 0.09)
   .setValue(0.034)
   .setColorCaptionLabel(0)
   ;
   cp5.addSlider("K")
   .setPosition(10, 90)
   .setSize(300, 60)
   .setRange(0.04, 0.07)
   .setValue(0.0618)
   .setColorCaptionLabel(0)
   ;
  cp5.addSlider("steps")
   .setPosition(10, 170)
   .setSize(300, 60)
   .setRange(1, 100)
   .setValue(10)
   .setColorCaptionLabel(0)
   ;
  cp5.addSlider("range")
   .setPosition(10, 250)
   .setSize(300, 60)
   .setRange(2, 100)
   .setValue(20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Stop_Restart")
   .setPosition(10, 330)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Reset")
   .setPosition(10, 410)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Capture")
   .setPosition(10, 500)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
   */
  cp5.addSlider("steps")
   .setPosition(10, 10)
   .setSize(300, 60)
   .setRange(1, 100)
   .setValue(10)
   .setColorCaptionLabel(0)
   ;
  cp5.addSlider("range")
   .setPosition(10, 90)
   .setSize(300, 60)
   .setRange(2, 100)
   .setValue(20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Stop_Restart")
   .setPosition(10, 170)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Reset")
   .setPosition(10, 250)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Capture")
   .setPosition(10, 330)
   .setSize(150, 60)
   .setColorCaptionLabel(0)
   ;
}
public void drawCell() {
  float scalar1 = (float) width / num1;
  float scalar2 = (float) height / num2;
  float x = 0;
  float y = 0;
  for (int i = 0; i < num1; i++){
    y = 0;
    for (int j = 0; j < num2; j++){
      noStroke();
      int c = vis_color(stateA[i][j] * 1.0f);
      c = color(1.0f - stateA[i][j] * 1.0f, 0.7f, 0.8f);
      fill(c);
      rect(x, y, scalar1, scalar2);
      y += scalar2;
    }
    x += scalar1;
  }
}

public int vis_color(float v) {
  float r = 0;
  float g = 0;
  float b = 0;
  if (v < 0.5f) {
     r = 1.0f - 2 * v; 
  }
  if (v > 0.5f) {
     b = - 1.0f + 2 * v; 
  }
  if (v > 0.25f && v < 0.5f) {
     g = - 1.0f + 4 * v; 
  }
  if (v >= 0.5f && v < 0.75f) {
     g = + 3.0f - 4 * v; 
  }
  
  //return color(r * 255, g * 255, b * 255);
  return color(255, 255, 255);
}
public void initialize() {
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      int pix = pixels[(j * height / num2) * width + (i * width / num1)];
      float mask = pow(0.99f, sqrt((i - num1 / 2) * (i - num1 / 2) + (j - num2 / 2) * (j - num2 / 2)));
      stateA[i][j] = 1 * (0.3f * red(pix) + 0.6f * green(pix) + 0.1f * blue(pix));
      //stateA[i][j] *= mask;
      //stateA[i][j] = 1;
      
      stateB[i][j] = 1 - 1 * (0.3f * red(pix) + 0.6f * green(pix) + 0.1f * blue(pix));
      //stateB[i][j] *= mask;
      
      int range = 3;
      if (i > num1 / 2 - range && i < num1 / 2 + range && j > num2 / 2 - range && j < num2 / 2 + range) {
         float r = random(1);
         stateA[i][j] = r;
         stateB[i][j] = r;
      }
      
      stateA0[i][j] = stateA[i][j];
      stateB0[i][j] = stateB[i][j];
    }
  }
}
public void mouseDragged() {
  int posY = (num2 * mouseY / height + num2) % num2;
  int posX = (num1 * mouseX / width + num1) % num1;
  if (posX < 0) posX += num1;
  if (posY < 0) posY += num2;
  
  for (int s = 0; s < range; s++) {
    for (int t = 0; t < range; t++) {
      stateA[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2] = 1 - stateA[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2];
      stateB[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2] = 1 - stateB[(posX - range / 2 + s + num1) % num1][(posY - range / 2 + t + num2) % num2];
    }
  }
  
  //stateA[(posX - 1 + num1) % num1][posY] = 1 - stateA[(posX - 1 + num1) % num1][posY];
  //stateA[posX][(posY - 1 + num1) % num1] = 1 - stateA[(posX - 1 + num1) % num1][posY];
  //stateA[posX][posY] = 1 - stateA[posX][posY];
  //stateA[(posX + 1) % num1][posY] = 1 - stateA[(posX + 1) % num1][posY];
  //stateA[posX][(posY + 1) % num1] = 1 - stateA[posX][(posY + 1) % num1];
  
}
public float transitionA(int i, int j) {
  
  float Ac = stateA[i][j];
  float Al = stateA[(i - 1 + num1) % num1][j];
  float Ar = stateA[(i + 1) % num1][j];
  float Au = stateA[i][(j - 1 + num2) % num2];
  float Ad = stateA[i][(j + 1) % num2];
  float Bc = stateB[i][j];
  
  float deltaC = D1 * (Al + Ar + Au + Ad - 4 * Ac) - Ac * Bc * Bc + F * (1 - Ac);
  
  return Ac + deltaC * 1.0f;
}

public float transitionB(int i, int j) {
  
  float Bc = stateB[i][j];
  float Bl = stateB[(i - 1 + num1) % num1][j];
  float Br = stateB[(i + 1) % num1][j];
  float Bu = stateB[i][(j - 1 + num2) % num2];
  float Bd = stateB[i][(j + 1) % num2];
  float Ac = stateA[i][j];
  
  float deltaC = D2 * (Bl + Br + Bu + Bd - 4 * Bc) + Ac * Bc * Bc - (F + K) * Bc;
  return Bc + deltaC * 1.0f;
}
public void updateState(){
  float[][] nextStateA = new float[num1][num2];
  float[][] nextStateB = new float[num1][num2];
  for (int i = 0; i < num1; i++) {
    for (int j = 0; j < num2; j++) {
      nextStateA[i][j] = transitionA(i, j);
      nextStateB[i][j] = transitionB(i, j);
    }
  }
  stateA = nextStateA;
  stateB = nextStateB;
  
  float[] FList = {0.012f, 0.022f, 0.025f, 0.035f, 0.025f, 0.027f, 0.035f, 0.040f, 0.025f, 0.011f};
  float[] KList = {0.050f, 0.051f, 0.060f, 0.062f, 0.050f, 0.053f, 0.057f, 0.060f, 0.052f, 0.046f};
  int step = 200;
  int states = 10;
  int i = (frameCount / step) % states;
  int j = frameCount % step;
  F = interporation(j, 0, step, FList[i], FList[(i + 1) % states]);
  K = interporation(j, 0, step, KList[i], KList[(i + 1) % states]);
  //F = 0.04 + 0.01 * sin(frameCount * 0.013);
  //K = 0.05 + 0.01 * sin(frameCount * 0.004);
}

public float interporation(int t, int St, int Gt, float Sv, float Gv){
  return (float) (t - St) / (Gt - St) * (Gv - Sv) + Sv;
}
  public void settings() {  size(2736, 1824); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#030303", "--stop-color=#FFFFFF", "TuringPattern" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
