boolean pattern = false;
int circle_size = 10;
boolean keep_distance = false;
boolean vivid = false;
boolean use_image = false;
PImage img;
int count;
int pivot_n;
int[] pivot_x;
int[] pivot_y;
color[] pivot_c;
int[] index;
float[] dists;
boolean[] painted;

ArrayList<PVector> Possible = new ArrayList<PVector>();
ArrayList<PVector> Impossible = new ArrayList<PVector>();
float distance = 0.5;
float scale = 100;

void setup(){
  size(1024, 1024);
  //img = loadImage("honpen1024x1024.jpg");
  img = loadImage("styley.jpg");
  img.resize(width, height);
  colorMode(HSB, 1);
  background(0, 0, 1);
  frameRate(60);
  
  if (keep_distance) {
    PoissonDisk();
    pivot_n = Impossible.size();
  } else
    pivot_n = 100;
  
  pivot_x = new int[pivot_n];
  pivot_y = new int[pivot_n];
  pivot_c = new color[pivot_n];
  index = new int[width * height];
  dists = new float[width * height];
  painted = new boolean[width * height];
  for(int i = 0; i < index.length; i++) {
    painted[i] = false;
    index[i] = -1;
  }
  for(int i = 0; i < pivot_n; i++) {
    if (keep_distance) {
      pivot_x[i] = (int)TX(Impossible.get(i).x);
      pivot_y[i] = (int)TY(Impossible.get(i).y);
    } else {
      pivot_x[i] = (int)random(width);
      pivot_y[i] = (int)random(height);
    }
    if (use_image) {
      pivot_c[i] = img.get(pivot_x[i], pivot_y[i]);
    }
    else if (vivid)
      pivot_c[i] = random(1) < 0 ? color(0, 0, 0) : color(random(1), 1, 1);
    else
      pivot_c[i] = color(0.55, 0.2, random(1));
  }
  
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      int id = y * width + x;
      dists[id] = 100000;
      for(int j = 0; j < pivot_n; j++) {
        if (dists[id] > dist(pivot_x[j], pivot_y[j], x, y)) {
          dists[id] = dist(pivot_x[j], pivot_y[j], x, y);
          index[id] = j;
        }
      }
    }
  }

}

void draw(){
  int[] index_buffer = new int[width * height];
  count++;
  loadPixels();
  
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      
      int id = y * width + x;
      if (!painted[id] && dists[id] < count) {
        painted[id] = true;
        
        if(pattern) {
          if (count % circle_size  > count / circle_size ) 
             pixels[id] = color(hue(pivot_c[index[id]]), saturation(pivot_c[index[id]]), 1.0);
           else
             pixels[id] = color(0);
        } else {
          pixels[id] = pivot_c[index[id]];
        }
      }
    }  
  }
  
  updatePixels();
}

void mouseClicked() {
  String namePNG = "voronoi_" + (pattern ? "withCircle_" : "") + (keep_distance ? "PD_" : "") + Impossible.size() + ".png";
  save(namePNG);
}

float distance(int x0, int y0, int x1, int y1){
  return sqrt(pow(x0 - x1, 2) + pow(y0 - y1, 2));
}

void PoissonDisk() {
  Possible.add(new PVector(0, 0));
  while (Possible.size() > 0) {
    int itr = 0;
    while (itr < 20) {
      itr++;
      
      PVector test = Possible.get(0).copy();
      test.add(PVector.random2D().mult(distance * random(1.0, 2.0)));
      
      if (TX(test.x) < 0 || TX(test.x) > width || TY(test.y) < 0 || TY(test.y) > height)
        continue;
      
      boolean pointable = true;
      for (int i = 1; i < Possible.size() && pointable; i++)
        if (test.dist(Possible.get(i)) < distance)
          pointable = false;
      for (int i = 0; i < Impossible.size() && pointable; i++)
        if (test.dist(Impossible.get(i)) < distance)
          pointable = false;
          
      if (pointable) {
        //println("point");
        //println(Possible.get(0));
        Possible.add(test);
        itr = 0;
      }
    }
    Impossible.add(Possible.get(0));
    Possible.remove(0);
  }

}
float TX(float x) {
  return x * scale + width / 2;
}
float TXI(float X) {
  return (X - width / 2) / scale;
}
float TY(float y) {
  return - y * scale + height / 2;
}
float TYI(float Y) {
  return (Y - height / 2) / (-scale);
}
float TS(float s) {
  return s * scale;
}
