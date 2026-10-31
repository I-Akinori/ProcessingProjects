ArrayList<PVector> Possible = new ArrayList<PVector>();
ArrayList<PVector> Impossible = new ArrayList<PVector>();
float distance = 0.1;
float rad_scale = 0.5;
float scale = 100;

boolean moving = false;
int count = 0;

void setup() {
  size(1200, 900);
  //colorMode(HSB, 1);
  frameRate(30);
  background(255);
  //smooth();
  noStroke();
  colorMode(HSB, 1);
  strokeWeight(2);
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
  
  print(Impossible.size());
  for (int i = 0; i < Impossible.size(); i++) {
    //println(Impossible.get(i));
    fill(color(random(1), 1, 1));
    ellipse(TX(Impossible.get(i).x), TY(Impossible.get(i).y), TS(distance * rad_scale), TS(distance * rad_scale));
  }
}

void draw() {
  //background(255);
  float s = millis() / 1000.0;

}

void Bazier(ArrayList<Float> X, ArrayList<Float> Y) {
  float xa = 0; 
  float ya = 0;
  float xb, yb;
  if (X.size() > 0)
  {
    xa = X.get(0);
    ya = Y.get(0);
  }
  for (float t = 0; t < X.size(); t += 0.01) {
    xb = 0;
    yb = 0;
    for (int i = -2; i < X.size() + 2; i++) {
      if (i < 0) {
        xb += BasisWeight2(i, t) * X.get(0);
        yb += BasisWeight2(i, t) * Y.get(0);
      } else if (i > X.size() - 1) {
        xb += BasisWeight2(i, t) * X.get(X.size() - 1);
        yb += BasisWeight2(i, t) * Y.get(X.size() - 1);
      } else {
        xb += BasisWeight2(i, t) * X.get(i);
        yb += BasisWeight2(i, t) * Y.get(i);
      }
      
    }
    line(TX(xa), TY(ya), TX(xb), TY(yb));
    xa = xb;
    ya = yb;
  }
}

void Marker(ArrayList<Float> X, ArrayList<Float> Y){
  for (int i = 0; i < X.size(); i++) {
    ellipse(TX(X.get(i)), TY(Y.get(i)), 5, 5);
  }
}

float BasisWeight2(int basisT, float t) {
  float ret = 0;
  float nt;
  if (t < (basisT - 1.5)) {
  
  } else if (t < (basisT - 0.5)) {
     nt = (t - (basisT - 1.5));
     ret = 0.5 * nt * nt;
  } else if (t < (basisT + 0.5)) {
     nt = (t - basisT);
     ret = 0.75 - (nt * nt);
  } else if (t < (basisT + 1.5)) {
     nt = (t - (basisT + 1.5));
     ret = 0.5 * nt * nt;
  }
  return ret;
}
void mousePressed() {
   String namePNG = "PoissonDisk" + Impossible.size() + ".png";
   save(namePNG);
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
