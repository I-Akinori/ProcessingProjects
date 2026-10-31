import processing.pdf.*;
LSystemRule L;
int count; 

void setup(){
  size(1000, 1000);
  colorMode(HSB, 1);
  background(0, 0, 1);
  strokeWeight(1);
  count = 0;
  L = new LSystemRule();
  /*
  L.SetTurtle(300, 200, 0);
  L.SetDistance(500);
  L.SetStrokeWeight(1);
  L.SetAngle(5);
  L.SetCode("f+++++ +++++ +++++ +++f+++++ +++++ +++++ +++f+++++ +++++ +++++ +++f");
  L.AddRule('f', "f+++++ +++++ +++++ ++ f----- ----- ----- ----- ----- ----- ----f+++++ +++++ +++++ ++ f");
  */
  L.SetTurtle(100, 300, 0);
  L.SetDistance(800);
  L.SetStrokeWeight(1);
  L.SetAngle(60);
  L.SetCode("f++f++f");
  L.AddRule('f', "f-f++f-f");
  
  /*
  L.SetTurtle(100, 500, 0);
  L.SetDistance(800);
  L.SetStrokeWeight(1);
  L.SetAngle(60);
  L.SetCode("Af");
  L.AddRule('A', "Bf-Af-B");
  L.AddRule('B', "Af+Bf+A");
  */
  L.Decode();
  println(L.GetCode());
  
}

void draw() {
}

void mouseClicked() {
  println("click");
  if (mouseButton == LEFT) {
    background(0, 0, 1);
    L.Grow();
    L.SetDistance(L.GetDistance() / 3);
    L.Decode();
    count++;
    println(L.GetCode());
  } else {
    String namePNG = "lsystem_koch_" + count + ".png";
    save(namePNG);
  }
}

class LSystemRule{
  private String code;
  private String mask;
  
  private ArrayList<Character> before;
  private ArrayList<String> after;
  
  private float rand_range_d = 0; // distance * (1 + rand_d)
  private float rand_range_a = 0; // angle + rand_a
  private ArrayList<Float> distance;
  private ArrayList<Float> angle;
  private ArrayList<Integer> stroke_weight;
  private ArrayList<Float> turtle_x;
  private ArrayList<Float> turtle_y;
  private ArrayList<Float> direction;
  private int status;
  
  public LSystemRule(){
    before = new ArrayList<Character>();
    after = new ArrayList<String>();
    
    distance = new ArrayList<Float>();
    angle = new ArrayList<Float>();
    stroke_weight = new ArrayList<Integer>();
    turtle_x = new ArrayList<Float>();
    turtle_y = new ArrayList<Float>();
    direction = new ArrayList<Float>();
    
    status = 0;
    
    code = "fx";
    mask = SerialSentence('1', code.length());
    distance.add(50f);
    angle.add(90f);
    stroke_weight.add(5);
    turtle_x.add(500f);
    turtle_y.add(500f);
    direction.add(0f);
  }
  
  public void Decode() {
    float start_x = turtle_x.get(0);
    float start_y = turtle_y.get(0);
    float start_d = direction.get(0);
    float start_dis = distance.get(0);
    int start_w = stroke_weight.get(0);
    
    for (int i = 0; i < code.length(); i++) {
      char c = code.charAt(i);
      switch (c) {
        case 'f':
        CommandF();
        break;
        case 'h':
        CommandH();
        break;
        
        case '+':
        CommandPlus();
        break;
        case '-':
        CommandMinus();
        break;
        
        case '[':
        CommandLB();
        break;
        case ']':
        CommandRB();
        break;
        
        case '*':
        TimeDistance(0.8f);
        break;
        case '/':
        DivDistance(0.9f);
        break;
        case '!':
        StrokeWeightAdd(1);
        break;
        case '?':
        StrokeWeightSub(1);
        break;
        
        default:
        break;
      }
    }
    
    turtle_x.set(0, start_x);
    turtle_y.set(0, start_y);
    direction.set(0, start_d);
    distance.set(0, start_dis);
    stroke_weight.set(0, start_w);
  }
  
  public void Grow(){
    mask = SerialSentence('1', code.length());
    for (int i = 0; i < before.size(); i++) {
      for (int j = 0; j < code.length(); j++) {
        if (code.charAt(j) == before.get(i) & mask.charAt(j) == '1') {
          StringBuilder sbC = new StringBuilder();
          sbC.append(code); 
          sbC.replace(j, j + 1, after.get(i));
          code = sbC.toString();
          
          StringBuilder sbM = new StringBuilder();
          sbM.append(mask);
          
          sbM.replace(j, j + 1, SerialSentence('0', after.get(i).length()));
          mask = sbM.toString();
        }
      }
    }
  }
  
  public void Grow(int gen) {
    for (int i = 0; i < gen; i++)
      Grow();
  }
  
  public String SerialSentence(char c, int num) {
    String S = "";
    for (int i = 0; i < num; i++)
      S += c;
    return S;
  }
  
  public float GetDistance() {
    return distance.get(status);
  }
  public float GetAngle() {
    return angle.get(status);
  }
  public void SetDistance(float d) {
    distance.set(status, d);
  }
  public void SetAngle(float a) {
    angle.set(status, a);
  }
  public void SetStrokeWeight(int w) {
    stroke_weight.set(status, w);
  }
  public void SetCode(String c) {
    code = c;
  }
  public void SetTurtle(float x, float y, float d) {
    SetTurtlePos(x, y);
    SetTurtleDir(d);
  }
  public void SetTurtlePos(float x, float y) {
    turtle_x.set(status, x);
    turtle_y.set(status, y);
  }
  public void SetTurtleDir(float d) {
    direction.set(status, d);
  }
  public String GetCode() {
    return code;
  }
  public void AddAngle(float delta){
    angle.set(status, angle.get(status) + delta);
  }
  public void SubAngle(float delta){
    angle.set(status, angle.get(status) - delta);
  }
  public void DivDistance(float delta){
    distance.set(status, distance.get(status) / delta);
  }
  public void TimeDistance(float delta){
    distance.set(status, distance.get(status) * delta);
  }
  public void StrokeWeightAdd(int delta){
    stroke_weight.set(status, stroke_weight.get(status) + delta);
  }
  public void StrokeWeightSub(int delta){
    stroke_weight.set(status, stroke_weight.get(status) - delta);
  }
  public void CommandF(){
    strokeWeight(stroke_weight.get(status));
    float a = direction.get(status);
    float d = distance.get(status) * (1 + random(-rand_range_d, rand_range_d));
    float end_x = turtle_x.get(status) + d * cos(PI * a / 180); 
    float end_y = turtle_y.get(status) + d * sin(PI * a / 180);
    line(turtle_x.get(status), turtle_y.get(status), end_x, end_y);
    turtle_x.set(status, end_x);
    turtle_y.set(status, end_y);
  }
  public void CommandH(){
    strokeWeight(stroke_weight.get(status));
    float a = direction.get(status);
    float d = distance.get(status) * (1 + random(-rand_range_d, rand_range_d)) / 2;
    float end_x = turtle_x.get(status) + d * cos(PI * a / 180); 
    float end_y = turtle_y.get(status) + d * sin(PI * a / 180);
    line(turtle_x.get(status), turtle_y.get(status), end_x, end_y);
    turtle_x.set(status, end_x);
    turtle_y.set(status, end_y);
  }
  public void CommandPlus(){
    float a = angle.get(status) + random(-rand_range_a, rand_range_a);
    direction.set(status, direction.get(status) + a);
  }
  public void CommandMinus(){
    float a = angle.get(status) + random(-rand_range_a, rand_range_a);
    direction.set(status, direction.get(status) - a);
  }
  public void CommandLB(){
    distance.add(distance.get(status));
    angle.add(angle.get(status));
    stroke_weight.add(stroke_weight.get(status));
    turtle_x.add(turtle_x.get(status));
    turtle_y.add(turtle_y.get(status));
    direction.add(direction.get(status));
    status++;
  }
  public void CommandRB(){
    distance.remove(status);
    angle.remove(status);
    stroke_weight.remove(status);
    turtle_x.remove(status);
    turtle_y.remove(status);
    direction.remove(status);
    status--;
  }
  public void AddRule(char c, String S){
    before.add(c);
    after.add(S);
  }
}
