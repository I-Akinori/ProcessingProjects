ArrayList<Float> ListX = new ArrayList<Float>();
ArrayList<Float> ListY = new ArrayList<Float>();
ArrayList<Float> DrawX = new ArrayList<Float>();
ArrayList<Float> DrawY = new ArrayList<Float>();

ArrayList<Float> TargetX = new ArrayList<Float>();
ArrayList<Float> TargetY = new ArrayList<Float>();
ArrayList<Float> CenterX = new ArrayList<Float>();
ArrayList<Float> CenterY = new ArrayList<Float>();
ArrayList<Float> Radius = new ArrayList<Float>();
float CX;
float CY;

boolean moving = false;
int count = 0;

void setup() {
  //size(2736, 1824);
  size(1200, 900);
  //colorMode(HSB, 1);
  frameRate(30);
  background(255);
  smooth();
  noFill();
  Bazier(ListX, ListY);
  Marker(ListX, ListY);
}

void draw() {
  background(255);
  float s = millis() / 1000.0;
  
  //Bazier(ListX, ListY);
  //Marker(ListX, ListY);
  if (moving)
    moveline();
  DrawedCircle();
  //DrawedLine();
  Bazier(DrawX, DrawY);
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
  if (mouseButton == LEFT && moving == false) {
    DrawX.add(TXI(mouseX));
    DrawY.add(TYI(mouseY));
    CX = TXI(mouseX);
    CY = TYI(mouseX);
  }
}
void mouseDragged() {
  /*
  if (mouseButton == LEFT) {
    ListX.set(ListX.size() - 1, TXI(mouseX));
    ListY.set(ListX.size() - 1, TYI(mouseY));
  }
  */
  if (mouseButton == LEFT && moving == false) {
    DrawX.add(TXI(mouseX));
    DrawY.add(TYI(mouseY));
    int n = DrawX.size();
    CX = (CX * (n - 1) + TXI(mouseX)) / n;
    CY = (CY * (n - 1) + TYI(mouseY)) / n;
  }
}
void mouseReleased() {
  if (DrawX.size() > 16) {
    moving = true;
    int size = DrawX.size();
    for (int i = size - 1; i >= 0 ; i--) {
      if (i % (size / 16) != 0) {
        DrawX.remove(i); 
      }
    }
    
    for (int i = 0; i < DrawX.size(); i++) {
      TargetX.add(cos(PI * 2 * i * DrawX.size() / (DrawX.size() - 1)) + CX);
      TargetY.add(sin(PI * 2 * i * DrawX.size() / (DrawX.size() - 1)) + CY);
    }
  } else {
    DrawX.clear();
    DrawY.clear();
  }
}
void moveline () {
  for (int i = 0; i < DrawX.size(); i++) {
    DrawX.set(i, DrawX.get(i) + 0.1 * (TargetX.get(i) - DrawX.get(i)));
    DrawY.set(i, DrawY.get(i) + 0.1 * (TargetY.get(i) - DrawY.get(i)));
  }
  count++;
  if (count > 90) {
    moving = false;
    count = 0;
    TargetX.clear();
    TargetY.clear();
    DrawX.clear();
    DrawY.clear();
    CenterX.add(CX);
    CenterY.add(CY);
    Radius.add(2.0);
  }
}

void DrawedLine() {
  for (int i = 0; i < DrawX.size() - 1; i++) {
    line(TX(DrawX.get(i)), TY(DrawY.get(i)), TX(DrawX.get(i + 1)), TY(DrawY.get(i + 1)));
  }
}
void DrawedCircle() {
  for (int i = 0; i < CenterX.size(); i++) {
      ellipse(TX(CenterX.get(i)), TY(CenterY.get(i)), TS(Radius.get(i)), TS(Radius.get(i)));
  }
}
float TX(float x) {
  return x * 100 + 600;
}
float TXI(float X) {
  return (X - 600) / 100;
}
float TY(float y) {
  return - y * 100 + 450;
}
float TYI(float Y) {
  return (Y - 450) / (-100);
}
float TS(float s) {
  return s * 100;
}
