import controlP5.*;
ControlP5 cp5;

float zoom_scale = 4;
float center_x = 0;
float center_y = 0;
float julia_a;// = -0.05;
float julia_b;// = -0.8;
int iteration = 100;
float time = 0;
boolean stop = false;

void setup(){
  size(1024, 1024);
  colorMode(HSB, 1);
  //background(0, 0, 1);
  frameRate(20);
  julia(0, 0, zoom_scale);
  
  controller();
}

void draw() {
  if (!stop)
    time += 0.05;
  //julia_a = sin(time * 0.23f) * 0.3 - 0.6;
  //julia_b = sin(time * 0.07f) * 0.4 + 0.3;
  julia(center_x, center_y, zoom_scale);
}

void julia(float cx, float cy, float scale) {
  loadPixels(); 
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      int index = y * width + x;
      float v = divergence(((float)x / width - 0.5) * scale + cx, ((float)y / height - 0.5) * scale + cy);
      if (v < 0)
        pixels[index] = color(0, 0, 0);
      else
        pixels[index] = color(pow(v, 0.8), 1, 1);
   
    }  
  }
  updatePixels();
}

float divergence(float x, float y) {
  float zr = x;
  float zi = y;
  float thr = 100;
  int grade = -100;
  
  for (int i = 0; i < iteration; i++) {
    float zr_nex = zr * zr - zi * zi + julia_a;
    float zi_nex = 2 * zr * zi + julia_b;
    zr = zr_nex;
    zi = zi_nex;
    if (zr * zr + zi * zi > thr) {
      grade = i;
      break;
    }
  }
  return (float) grade / iteration;
}

void HighResolution() {
  if (iteration < 500) iteration = 500;
  else iteration = 100;
  julia(center_x, center_y, zoom_scale);
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    float focus_x = ((float)mouseX / width - 0.5) * zoom_scale + center_x;
    float focus_y = ((float)mouseY / height - 0.5) * zoom_scale + center_y;
    zoom_scale /= 1.5;
    center_x = - ((float)mouseX / width - 0.5) * zoom_scale + focus_x;
    center_y = - ((float)mouseY / height - 0.5) * zoom_scale + focus_y;
    background(0, 0, 1);
    julia(center_x, center_y, zoom_scale);
  } else {
    float focus_x = ((float)mouseX / width - 0.5) * zoom_scale + center_x;
    float focus_y = ((float)mouseY / height - 0.5) * zoom_scale + center_y;
    zoom_scale *= 1.5;
    center_x = - ((float)mouseX / width - 0.5) * zoom_scale + focus_x;
    center_y = - ((float)mouseY / height - 0.5) * zoom_scale + focus_y;
    background(0, 0, 1);
    julia(center_x, center_y, zoom_scale);
    //String namePNG = "mandel" + ".png";
    //save(namePNG);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
       center_y -= 0.01 * zoom_scale;
    } else if (keyCode == DOWN) {
       center_y += 0.01 * zoom_scale;
    } else if (keyCode == LEFT) {
       center_x -= 0.01 * zoom_scale;
    } else if (keyCode == RIGHT) {
       center_x += 0.01 * zoom_scale;
    }
  } 
  if (key == ' ') {
      stop = !stop;
    }
}
