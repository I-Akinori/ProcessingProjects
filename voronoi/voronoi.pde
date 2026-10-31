PImage img;
int count;
int pivot_n;
int[] pivot_x;
int[] pivot_y;
color[] pivot_c;
int[] index;

void setup(){
  size(1024, 1024);
  img = loadImage("honpen1024x1024.jpg");
  img.resize(width, height);
  colorMode(HSB, 1);
  background(0, 0, 1);
  frameRate(60);
  
  pivot_n = 100;
  
  pivot_x = new int[pivot_n];
  pivot_y = new int[pivot_n];
  pivot_c = new color[pivot_n];
  index = new int[width * height];
  for(int i = 0; i < index.length; i++) {
    index[i] = -1;
  }
  for(int i = 0; i < pivot_n; i++) {
    pivot_x[i] = (int)random(width);
    pivot_y[i] = (int)random(height);
    //pivot_c[i] = random(1) < 0 ? color(0, 0, 0) : color(random(1), 1, 1);
    pivot_c[i] = color(0.55, 0.2, random(1));
    //pivot_c[i] = img.get(pivot_x[i], pivot_y[i]);
  }
  loadPixels();
  for(int i = 0; i < pivot_n; i++) {
      int pivot = pivot_y[i] * width + pivot_x[i];
      pixels[pivot] = pivot_c[i];
      index[pivot] = i;
  }
  updatePixels();
}

void draw(){
  int[] index_buffer = new int[width * height];
  count++;
  loadPixels();
  
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      
      int id = y * width + x;
      index_buffer[id] = index[id];
      if (index[id] >= 0) continue;
      
      if (index[(x + 1) % width + y * width] >= 0) {
        index_buffer[id] = index[(x + 1) % width + y * width];
        pixels[id] = pivot_c[index_buffer[id]];
      } else if (index[x + (y + 1) % height * width] >= 0) {
        index_buffer[id] = index[x + (y + 1) % height * width];
        pixels[id] = pivot_c[index_buffer[id]];
      } else if (index[(x - 1 + width) % width + y * width] >= 0) {
        index_buffer[id] = index[(x - 1 + width) % width + y * width];
        pixels[id] = pivot_c[index_buffer[id]];
      } else if (index[x + (y - 1 + height) % height * width] >= 0) {
        index_buffer[id] = index[x + (y - 1 + height) % height * width];
        pixels[id] = pivot_c[index_buffer[id]];
      }
    }  
  }
  for(int i = 0; i < index.length; i++) {
    index[i] = index_buffer[i];
  }
  
  updatePixels();
}
