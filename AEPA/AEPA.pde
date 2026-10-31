ArrayList<Float> ListX = new ArrayList<Float>();
ArrayList<Float> ListY = new ArrayList<Float>();
ArrayList<ArrayList<Float>> DrawX = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> DrawY = new ArrayList<ArrayList<Float>>();

ArrayList<ArrayList<Float>> TargetX = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> TargetY = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> AEPAX = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> AEPAY = new ArrayList<ArrayList<Float>>();

ArrayList<Float> CenterX = new ArrayList<Float>();
ArrayList<Float> CenterY = new ArrayList<Float>();
ArrayList<Float> Radius = new ArrayList<Float>();
float CX;
float CY;
float VX;
float VY;
float R;

boolean moving = false;
int count = 0;

void setup() {
  //size(2736, 1824);
  size(1200, 900);
  //colorMode(HSB, 1);
  frameRate(30);
  background(255);
  strokeWeight(2);
  smooth();
  noFill();
  Bazier(ListX, ListY);
  Marker(ListX, ListY);
  
  ArrayList<Float> LX = new ArrayList<Float>();
  ArrayList<Float> LY = new ArrayList<Float>();
  LX.add(-1.8f);LX.add(-2.5f);LX.add(-2.5f);LX.add(0f);LX.add(1f);LX.add(2.5f);LX.add(2.2f);
  LY.add(-3f);LY.add(-1f);LY.add(1f); LY.add(2f);  LY.add(2.2f);LY.add(1f);LY.add(-3.2f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(-2f);LX.add(-2.5f);LX.add(-2f);LX.add(-1.5f);LX.add(-1f);;
  LY.add(1.1f);LY.add(2f); LY.add(3f); LY.add(3f);LY.add(1.7f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(-1.5f);LX.add(-0.5f);LX.add(-1.8f);LX.add(-1.0f);LX.add(-1.4f);LX.add(-0.8f);
  LY.add(0.5f);LY.add(0.4f); LY.add(0.3f); LY.add(0.5f);LY.add(0.3f);LY.add(0.5f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(1.5f);LX.add(1.5f);LX.add(2.5f);LX.add(3f);LX.add(3f);LX.add(2.3f);
  LY.add(1.8f);LY.add(3f); LY.add(3.5f); LY.add(3f);LY.add(1.3f);LY.add(0.5f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(0.5f);LX.add(1.5f);LX.add(0.5f);LX.add(1.8f);LX.add(1.0f);LX.add(1.4f);LX.add(0.8f);
  LY.add(0.4f);LY.add(0.5f);LY.add(0.3f); LY.add(0.6f); LY.add(0.5f);LY.add(0.6f);LY.add(0.5f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(-0.2f);LX.add(-0.3f);LX.add(-0.2f);LX.add(-0.3f);LX.add(-0.2f);LX.add(0f);LX.add(-0.2f);LX.add(0.1f);
  LY.add(-0.4f);LY.add(-0.5f);LY.add(-0.7f); LY.add(-0.6f);LY.add(-0.7f); LY.add(-0.8f);LY.add(-0.8f);LY.add(-0.8f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  LX.clear(); LY.clear();
  LX.add(-0.7f);LX.add(-0.2f);LX.add(1.0f); LX.add(0.2f); LX.add(-0.5f); LX.add(1.2f); LX.add(0.2f);LX.add(-1.0f);LX.add(0.1f);LX.add(0.8f);LX.add(0.2f);LX.add(-0.8f);
  LY.add(-1.5f);LY.add(-1.8f);LY.add(-1.3f);LY.add(-1.6f);LY.add(-1.6f); LY.add(-1.2f);LY.add(-1.6f); LY.add(-1.7f);LY.add(-1.5f);LY.add(-1.6f);LY.add(-1.6f);LY.add(-1.7f);
  AEPAX.add(new ArrayList<Float>(LX));
  AEPAY.add(new ArrayList<Float>(LY));
  
  //Convert(AEPAX, AEPAY, DrawX, DrawY, 1, 1, 0.5);
  DrawX.add(new ArrayList<Float>());
  DrawY.add(new ArrayList<Float>());
}

void draw() {
  background(255);
  float s = millis() / 1000.0;
  
  //Bazier(ListX, ListY);
  //Marker(ListX, ListY);
  if (moving)
    moveline();
  DrawAEPAs();
  //DrawedLine();
  for (int i = 0; i < DrawX.size(); i++) {
    Bazier(DrawX.get(i), DrawY.get(i));
    //Marker(DrawX.get(i), DrawY.get(i));
  }
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
    DrawX.get(0).add(TXI(mouseX));
    DrawY.get(0).add(TYI(mouseY));
    CX = TXI(mouseX);
    CY = TYI(mouseX);
    VX = pow(TXI(mouseX), 2);
    VY = pow(TYI(mouseX), 2);
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
    DrawX.get(0).add(TXI(mouseX));
    DrawY.get(0).add(TYI(mouseY));
    int n = DrawX.get(0).size();
    CX = (CX * (n - 1) + TXI(mouseX)) / n;
    CY = (CY * (n - 1) + TYI(mouseY)) / n;
    VX = (VX * (n - 1) + pow(TXI(mouseX), 2)) / n;
    VY = (VY * (n - 1) + pow(TYI(mouseY), 2)) / n;
  }
}
void mouseReleased() {
  if (DrawX.get(0).size() > numelement(AEPAX))
  {
    moving = true;
    int size = DrawX.get(0).size();
    for (int i = size - 1; i >= 0 ; i--) {
      if (i % (size / numelement(AEPAX)) != 0) {
        DrawX.get(0).remove(i);
        DrawY.get(0).remove(i);
      }
    }
    
    ArrayList<Float> LX = new ArrayList<Float>(DrawX.get(0));
    ArrayList<Float> LY = new ArrayList<Float>(DrawY.get(0));
    DrawX.clear();
    DrawY.clear();
    int c = 0;
    for (int i = 0; i < AEPAX.size(); i++) {
      DrawX.add(new ArrayList<Float>());
      DrawY.add(new ArrayList<Float>());
      for (int j = 0; j < AEPAX.get(i).size(); j++) {
        DrawX.get(i).add(LX.get(c));
        DrawY.get(i).add(LY.get(c));
        c++;
      }  
    }
    println(VX - CX * CX + VY - CY * CY);
    println(CX * CX + CY * CY);
    R = sqrt(VX - CX * CX + VY - CY * CY) / 3;
    
    Convert(AEPAX, AEPAY, TargetX, TargetY, CX, CY, R);
  } else {
    DrawX.clear();
    DrawY.clear();
    DrawX.add(new ArrayList<Float>());
    DrawY.add(new ArrayList<Float>());
  }
}
void moveline () {
  for (int i = 0; i < DrawX.size(); i++) {
    for (int j = 0; j < DrawX.get(i).size(); j++) {
      DrawX.get(i).set(j, DrawX.get(i).get(j) + 0.1 * (TargetX.get(i).get(j) - DrawX.get(i).get(j)));
      DrawY.get(i).set(j, DrawY.get(i).get(j) + 0.1 * (TargetY.get(i).get(j) - DrawY.get(i).get(j)));
    }
  }
  count++;
  if (count > 60) {
    moving = false;
    count = 0;
    TargetX.clear();
    TargetY.clear();
    DrawX.clear();
    DrawY.clear();
    DrawX.add(new ArrayList<Float>());
    DrawY.add(new ArrayList<Float>());
    CenterX.add(CX);
    CenterY.add(CY);
    Radius.add(R);
  }
}

void DrawedLine() {
  for (int i = 0; i < DrawX.size() - 1; i++) {
    //line(TX(DrawX.get(i)), TY(DrawY.get(i)), TX(DrawX.get(i + 1)), TY(DrawY.get(i + 1)));
  }
}
void DrawedCircle() {
  for (int i = 0; i < CenterX.size(); i++) {
      ellipse(TX(CenterX.get(i)), TY(CenterY.get(i)), TS(Radius.get(i)), TS(Radius.get(i)));
  }
}
void Convert(ArrayList<ArrayList<Float>> X, ArrayList<ArrayList<Float>> Y, ArrayList<ArrayList<Float>> X2, ArrayList<ArrayList<Float>> Y2, float dx, float dy, float s) {
  X2.clear();Y2.clear();
  for (int i = 0; i < X.size(); i++) {
    ArrayList<Float> LX = new ArrayList<Float>(X.get(i));
    ArrayList<Float> LY = new ArrayList<Float>(Y.get(i));
    for (int j = 0; j < X.get(i).size(); j++) {
        LX.set(j, X.get(i).get(j) * s + dx);
        LY.set(j, Y.get(i).get(j) * s + dy);
    }
    X2.add(LX);
    Y2.add(LY);
  }
}
void drawAEPA(float x, float y, float s) {
  ArrayList<ArrayList<Float>> drawAEPAX = new ArrayList<ArrayList<Float>>();
  ArrayList<ArrayList<Float>> drawAEPAY = new ArrayList<ArrayList<Float>>();
  
  Convert(AEPAX, AEPAY, drawAEPAX, drawAEPAY, x, y, s);
  for (int i = 0; i < drawAEPAX.size(); i++) {
    Bazier(drawAEPAX.get(i), drawAEPAY.get(i));
  }
}
void DrawAEPAs() {
  for (int i = 0; i < CenterX.size(); i++) {
      drawAEPA(CenterX.get(i), CenterY.get(i), Radius.get(i));
  }
}
int numelement(ArrayList<ArrayList<Float>> X) {
  int num = 0;
  for (int i = 0; i < X.size(); i++) {
    num += X.get(i).size();
  }
  return num;
}
int numelement(ArrayList<ArrayList<Float>> X, int i) {
  return X.get(i).size();
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
