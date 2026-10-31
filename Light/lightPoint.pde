void lightPoint(float x, float y, color col, float rad, float lum) {
  int itr = 16 * (int) log(rad * lum);
  color coli = col;
  fill(coli);
  float radi;
  
  for (int i = 0; i < itr; i++) {
    //float ratio = 0.1 * exp(- (itr * itr) / (128 * lum));
    float ratio = pow(0.95, 2 * i);
    coli = color(red(col) * ratio, green(col) * ratio, blue(col) * ratio);
    fill(coli);
    radi = rad * i / itr;
    ellipse(x, y, radi, radi);
  }
}
