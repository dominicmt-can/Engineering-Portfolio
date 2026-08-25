#include <Servo.h>

// Hardware Pin Configuration
Servo sateliteServo;
const int sonarTrig = 6; 
const int sonarEcho = 7; 

// State Tracking Variables for Servo Sweep
int pos = 0;
int stepDirection = 1; // 1 = moving up, -1 = moving down
unsigned long lastMoveTime = 0;
const int sweepSpeed = 25; // Delay in milliseconds between each 1-degree step

// Median Filter History Buffers
int r1 = 0; 
int r2 = 0; 
int r3 = 0; 

void setup() {
  Serial.begin(115200);     // High-speed baud rate prevents loop blocking
  sateliteServo.attach(9);   // Bind servo motor control signal to Pin 9
  pinMode(sonarTrig, OUTPUT);
  pinMode(sonarEcho, INPUT);

  // CSV Column Headers for Excel export
  Serial.println("Timestamp_ms,Angle_deg,Raw_Distance_cm,Filtered_Distance_cm");
}

void loop() {
  unsigned long currentTime = millis(); // Acts as a running stopwatch

  // Non-Blocking Timer: Executes every 25ms without pausing the processor
  if (currentTime - lastMoveTime >= sweepSpeed) {
    lastMoveTime = currentTime;

    // 1. Direct the servo to the current angle step
    sateliteServo.write(pos);
    
    // 2. Trigger the sonar sensor to fire a sonic pulse
    digitalWrite(sonarTrig, LOW);
    delayMicroseconds(2);
    digitalWrite(sonarTrig, HIGH);
    delayMicroseconds(10);
    digitalWrite(sonarTrig, LOW);
    
    // 3. Read raw flight duration (with a 20ms timeout to prevent lockups)
    long duration = pulseIn(sonarEcho, HIGH, 20000);
    int currentDistance = duration * 0.0343 / 2;

    // 4. Handle sensor dropouts (if it reads 0, maintain current queue history)
    if (currentDistance == 0) {
      currentDistance = r1; 
    }

    // 5. Shift the history queue window down
    r3 = r2;
    r2 = r1;
    r1 = currentDistance;

    // 6. True Mathematical Median Filter (Find the middle value of r1, r2, and r3)
    int filteredDistance;
    if ((r1 <= r2 && r2 <= r3) || (r3 <= r2 && r2 <= r1)) {
      filteredDistance = r2;
    } else if ((r2 <= r1 && r1 <= r3) || (r3 <= r1 && r1 <= r2)) {
      filteredDistance = r1;
    } else {
      filteredDistance = r3;
    }

    // 7. Non-blocking high-speed CSV telemetry output
    Serial.print(currentTime);
    Serial.print(",");
    Serial.print(pos);
    Serial.print(",");
    Serial.print(currentDistance);
    Serial.print(",");
    Serial.println(filteredDistance);
    
    // 8. Calculate the next angle position step state
    pos += stepDirection;
    if (pos >= 180) {
      stepDirection = -1; // Reverse direction when hitting maximum limit
    } else if (pos <= 0) {
      stepDirection = 1;  // Reverse direction when hitting minimum limit
    }
  }
}