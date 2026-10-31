PVector[] vec;
float gap = 0.1;
int gon = 6;
int count = 0;
void setup(){
  size(500, 500);
  colorMode(HSB, 1);
  background(1);
  vec = new PVector[gon];
  
  for (int i = 0; i < gon; i++) {
    vec[i] = PVector.fromAngle(2 * i * PI / gon);
    vec[i].mult(width / 2);
  }
}
void draw(){
  //noStroke();
  stroke(color(count % 10 / 10.0, 1, 1));
  strokeWeight(2);
  //fill(color(count % 10 / 10.0, 0.5, 1)); 
  translate(width / 2, height / 2);
  drawPolygon(vec);
  vec = getVector(vec);
  count++;
}
void mousePressed() {
   String namePNG = "polygon" + "_" + gon + "_" + gap + ".png";
   save(namePNG);
}
