void controller() {
  cp5 = new ControlP5(this);
  cp5.addBang("Gaussian")
   .setPosition(10, 10)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("edge")
   .setPosition(10, 50)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Laplacian")
   .setPosition(10, 90)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Custom")
   .setPosition(10, 130)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Reset")
   .setPosition(10, 170)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
  cp5.addBang("Capture")
   .setPosition(10, 210)
   .setSize(50, 20)
   .setColorCaptionLabel(0)
   ;
}
