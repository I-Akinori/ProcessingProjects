PImage img;
int num = 250;
int mod = 3;
float[][] state = new float[num][num];
float[][] prestate = new float[num][num];
float[][] filter = new float[5][5];

void setup() {
  size(500, 500);
  img = loadImage("HNG.jpg");
  image(img, 0, 0);
  loadPixels();
  
  colorMode(HSB, 1);
  initialize();
  frameRate(10);
}

void draw() {
  drawCell();
  updateState();
}

void mouseClicked() {
  mod = int(random(2, 20));
  println(mod);
  background(0, 0, 1);
}
