int pivot_n = 20;
int[] pivot_id;
color[] pivot_c;
int[] index;
int num;
int num2;
int num_cell;
float rad;
int count = 0;

void setup() {
  //size(2339, 1654);
  size(1169, 827);
  colorMode(HSB, 1);
  background(0, 0, 1);
  line(0, 0, width, 0);
  line(0, 0, 0, height);
  line(width, 0, width, height);
  line(0, height, width, height);
  frameRate(2);
  
  pivot_id = new int[pivot_n + 1];
  pivot_c = new color[pivot_n + 1];
  pivot_c[0] = color(0, 0, 1);
  
  stroke(0.5);
  num = 32;
  num2 = (int)(num / sqrt(3) * 2 * width / height + 1);
  num_cell = (num + 2) * num2;
  
  index = new int[num_cell];
  
  
  for(int i = 0; i < index.length; i++) {
    index[i] = 0;
  }
  for(int i = 1; i < pivot_n + 1; i++) {
    pivot_id[i] = (int)random(num_cell);
    pivot_c[i] = random(1) < 0 ? color(0, 0, 0) : color((float)i / pivot_n, 0.5, 1);
    
    index[pivot_id[i]] = i;
    //pivot_c[i] = color(0.55, 0.2, random(1));
  }
  
  rad = height / num / 2 * (2 / sqrt(3)) * (1.2);
  
  noFill();
  
  float x = 0;
  float y = 0;
  boolean even = true;
  
  for(int i = 0; i < index.length; i++) {
    fillHex(i, index[i]);
  }
  
}

void draw(){
  if (count < 20) {
    String namePNG = "voronoi_hex_" + count + ".png";
    save(namePNG);
  }
  count++;
  
  int[] index_buffer = new int[num_cell];
  
  for(int i = 0; i < index.length; i++) {
    index_buffer[i] = index[i];
  }
  
  for(int i = 0; i < index.length; i++) {
    int X = i % num2;
    int Y = i / num2;
    if (index[i] > 0) {
      if (X != 0)
        if (index[i - 1] == 0) 
          index_buffer[i - 1] = index[i];
      if (Y != 0)
        if (index[i - num2] == 0)
          index_buffer[i - num2] = index[i];
      if (Y != num + 2 - 1)
        if (index[i + num2] == 0)
          index_buffer[i + num2] = index[i];
      if (X != num2 - 1)
        if (index[i + 1] == 0)
          index_buffer[i + 1] = index[i];
      
      if (X % 2 == 0) {
        if (X != 0 && Y != 0)
          if (index[i - 1 - num2] == 0)
            index_buffer[i - 1 - num2] = index[i];
        if (X != num2 - 1 && Y != 0)
          if (index[i + 1 - num2] == 0)
            index_buffer[i + 1 - num2] = index[i];
      } else {
        if (X != num2 - 1 && Y != num + 2 - 1)
          if (index[i + 1 + num2] == 0)
            index_buffer[i + 1 + num2] = index[i];
       
        if (X != 0 && Y != num + 2 - 1)
          if (index[i - 1 + num2] == 0)
            index_buffer[i - 1 + num2] = index[i];
      }
      index_buffer[i] *= -1;
    }
    
    index[i] = index_buffer[i];
  }
  for(int i = 0; i < index.length; i++) {
    index[i] = index_buffer[i];
    fillHex(i, index[i]);
  }

}

void fillHex(int hex_id, int c_id) {
  int j = hex_id / num2;
  int i = hex_id % num2;
  int x = (int)(3 * rad * i / 2);
  int y = (int)(sqrt(3) * rad * j);
  if (i % 2 == 1) {
    y += (int)(sqrt(3) / 2 * rad);
  }
  fill(pivot_c[abs(c_id)]);
  drawPolygon(x, y, (int)rad, 6);
}

void drawPolygon(int x, int y, int r, int vertexNum) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (int i = 0; i < vertexNum; i++) {
    vertex(r*cos(radians(360*i/vertexNum)), r*sin(radians(360*i/vertexNum)));
  }
  endShape(CLOSE);
  popMatrix();
}
