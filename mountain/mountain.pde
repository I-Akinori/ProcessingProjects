int max_gen = 32;
void setup() {
  size(1024, 1024);
  strokeWeight(3);
  frameRate(20);
}
void draw() {
  background(255);
  loop_line(0, 0, -5, height - 5, width);
  save("loop_sample" + max_gen + ".png");
}
void loop_line(int gen, int dir, float x, float y, float len) {
  if (gen < max_gen){
    switch(dir){
      case 0:
      line(x, y, x + len, y);
      x += len;
    
      break;
      
      case 1:
      line(x, y, x, y - len);
      y -= len;
    
      break;
      
      case 2:
      line(x, y, x - len, y);
      x -= len;
    
      break;
      
      default:
      line(x, y, x, y + len);
      y += len;
      break;
    }
    len *= 0.8;
    dir = (dir + 1) % 4;
    loop_line(gen + 1, dir, x, y, len);  
  } 
}
void frac_line(int gen, int dir, float x, float y, float len) {
  // dir
  // 0: right
  // 1: up
  // 2: left
  // 3: down
  
  if (gen == max_gen){
    switch(dir){
      case 0:
      line(x, y, x + len, y);
      break;
      case 1:
      line(x, y, x, y - len);
      break;
      case 2:
      line(x, y, x - len, y);
      break;
      default:
      line(x, y, x, y + len);
      break;
    }
  }
  else {
    switch(dir){
      case 0:
      frac_line (gen + 1, dir, x, y, len / 3);
      x += len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y -= len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x += len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y += len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      break;
      
      case 1:
      frac_line (gen + 1, dir, x, y, len / 3);
      y -= len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x -= len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y -= len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x += len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      break;
      
      case 2:
      frac_line (gen + 1, dir, x, y, len / 3);
      x -= len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y += len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x -= len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y -= len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      break;
      
      default:
      frac_line (gen + 1, dir, x, y, len / 3);
      y += len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x += len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      y += len / 3;
      dir = (dir + 3) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      x -= len / 3;
      dir = (dir + 1) % 4;
      frac_line (gen + 1, dir, x, y, len / 3);
      break;
    }
    
  }
}
