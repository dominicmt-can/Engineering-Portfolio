import processing.serial.*;

Serial myPort;
String data = "";
float angle = 0;
float distance = 0;
int maxDistance = 40; 

void setup() {
  size(800, 500);
  smooth();
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('.'); 
  background(0);
}

void draw() {
  // Glow trail fade effect
  fill(0, 12); 
  noStroke();
  rect(0, 0, width, height);
  
  pushMatrix();
  translate(width/2, height - 60); // Centered at bottom axis point
  
  // Draw the circular boundary grids
  noFill();
  strokeWeight(1);
  stroke(0, 100, 0); // Muted dark background grid green
  arc(0, 0, width-100, width-100, PI, TWO_PI);
  arc(0, 0, (width-100)*0.66, (width-100)*0.66, PI, TWO_PI);
  arc(0, 0, (width-100)*0.33, (width-100)*0.33, PI, TWO_PI);
  line(-(width/2-50), 0, width/2-50, 0); 
  
  // Draw Angular Grid Crosshairs (30, 60, 90, 120, 150 degrees)
  stroke(0, 80, 0, 100);
  for (int a = 30; a <= 150; a += 30) {
    float radGrid = radians(a);
    line(0, 0, (width/2-50) * cos(-radGrid), (width/2-50) * sin(-radGrid));
  }
  
  // Draw Outer Perimeter Telemetry Labels
  fill(0, 180, 0);
  textSize(12);
  textAlign(CENTER, CENTER);
  for (int a = 0; a <= 180; a += 30) {
    float radLabel = radians(a);
    // Push the text labels slightly past the outer ring line (+30 pixels out)
    float textX = ((width/2-50) + 30) * cos(-radLabel);
    float textY = ((width/2-50) + 30) * sin(-radLabel);
    text(a + "°", textX, textY);
  }

  // Draw Dynamic Sweeping Active Line
  float rad = radians(angle);
  strokeWeight(4);
  stroke(0, 255, 0, 220); // Vibrant scanning green
  line(0, 0, (width/2-50) * cos(-rad), (width/2-50) * sin(-rad));
  
  // Draw Target Blip if within tracking bounds
  if (distance > 2 && distance < maxDistance) {
    float displayDist = map(distance, 0, maxDistance, 0, width/2-50);
    float targetX = displayDist * cos(-rad);
    float targetY = displayDist * sin(-rad);
    
    // Target Mark: A crisp red dot with an outer tracking warning circle
    fill(255, 0, 0, 200); 
    noStroke();
    ellipse(targetX, targetY, 14, 14);
    
    noFill();
    stroke(255, 0, 0, 100);
    strokeWeight(1);
    ellipse(targetX, targetY, 25, 25);
  }
  popMatrix();
  
  // HUD Text Overlay Top Mask Panel
  fill(0); rect(0, 0, width, 40);
  fill(0, 255, 0);
  textSize(14);
  textAlign(LEFT, TOP);
  text("SYSTEM OK  |  BEAM ANGLE: " + int(angle) + "°  |  RANGE DATA: " + (distance > 2 && distance < maxDistance ? int(distance) + " cm" : "SCANNING..."), 20, 15);
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length()-1); 
  
  String[] list = split(data, ',');
  if (list.length == 2) {
    angle = float(list[0]);
    distance = float(list[1]);
  }
}