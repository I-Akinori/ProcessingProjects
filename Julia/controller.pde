void controller() {
  cp5 = new ControlP5(this);
  cp5.addSlider("julia_a")
   .setPosition(10, 10)
   .setSize(100, 20)
   .setRange(-1, 1)
   .setValue(-0.3)
   .setColorCaptionLabel(0)
   ;
   cp5.addSlider("julia_b")
   .setPosition(10, 50)
   .setSize(100, 20)
   .setRange(-1, 1)
   .setValue(-0.63)
   .setColorCaptionLabel(0)
   ;
   cp5.addBang("HighResolution")
   .setPosition(10, 90)
   .setSize(100, 30)
   .setColorCaptionLabel(0)
   ;
}
