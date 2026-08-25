# Sonar Sweep — Ultrasonic Radar Scanner

A single-axis scanning radar system that pairs an ultrasonic rangefinder with a continuous servo sweep to stream real-time spatial mapping data over USB to a custom desktop GUI.

<p align="center">
  <img src="../images/sonar_demo.gif" alt="Live Sonar Sweep Demo" width="80%" />
</p>

| Live Scope GUI Display | Assembled Microcontroller Rig |
| :---: | :---: |
| <img src="../images/Servo_Print_and_Stand.png" height="230" /> | <img src="../images/ServoSonarSetup.jpg" height="230" /> |

---

## Technical Specifications

* **Microcontroller:** Arduino Mega 2560
* **Transducer:** HC-SR04 Ultrasonic Distance Sensor (Trigger Pin 6, Echo Pin 7)
* **Actuator:** Micro Servo on Pin 9 (180° sweep range, 1° resolution steps)
* **Baud Rate:** 9600 bps via USB Serial communication
* **Loop Timing:** 25 ms non-blocking interval (`sweepSpeed = 25`) with a 20 ms echo pulse timeout
* **Tracking Range:** 2 cm to 40 cm GUI visualization window (`maxDistance = 40`)
* **Software Stack:** Arduino C/C++ (Firmware), Processing / Java (GUI Scope), SolidWorks (CAD)

---

## System Architecture

```text
[ HC-SR04 Sensor ] ---> [ Arduino Mega 2560 ] ---> [ Serial / USB ] ---> [ Processing GUI ]
  10 µs Trigger Pulse      Non-blocking Sweep         "angle,distance."       Real-Time Radar
  Echo Timing Capture      3-Sample Median Filter     9600 Baud Stream        Scope Visualizer
```

### Hardware Interconnect & Breadboard Distribution

| Device / Module | Pin / Signal | Connection Target | Functional Purpose |
| :--- | :--- | :--- | :--- |
| **Power Distribution** | Arduino 5V | Breadboard (+) Rail | Main $5\text{V}$ DC power bus |
| | Arduino GND | Breadboard (-) Rail | System common logic ground |
| **HC-SR04 Sonar** | VCC | Breadboard (+) Rail | Transducer power supply |
| | GND | Breadboard (-) Rail | Transducer ground return |
| | Trig | Arduino Pin 6 | 10 µs trigger pulse output |
| | Echo | Arduino Pin 7 | Return timing capture input |
| **Micro Servo** | Power (Red) | Breadboard (+) Rail | Actuator power supply |
| | Ground (Brown) | Breadboard (-) Rail | Actuator ground return |
| | PWM (Orange) | Arduino Pin 9 | 50 Hz PWM angle command |

---

## Key Engineering Challenges & Solutions

### 1. Non-Blocking Timing Architecture
* **Problem:** Standard `delay()`-based control loops halted CPU execution during sensor reads and servo steps, causing jittery motion and dropped GUI frames.
* **Solution:** Refactored the control loop around `millis()` non-blocking timing, maintaining a smooth 180° sweep with a consistent 25 ms step interval.

### 2. Signal Processing & Glitch Rejection
* **Problem:** Acoustic multipath reflections and sensor echo dropouts periodically injected zero or out-of-bounds readings into the telemetry stream.
* **Solution:** Embedded an onboard 3-sample median filter (`r1`, `r2`, `r3`) into the firmware before data packet serialization, rejecting outliers before transmission to the GUI.

### 3. Power Integrity & Noise Decoupling
* **Problem:** The hobby servo injected electrical switching noise into the shared 5V VCC power rail during step transitions, intermittently corrupting HC-SR04 timing accuracy.
* **Solution:** Decoupled the sensor power rail with filtering capacitors and isolated high-current servo transients from the microcontroller logic bus.

### 4. Mechanical Alignment & Beam Mapping
* **Problem:** Initial mounting created an angular offset between the sensor face and the servo output spline, skewing target angles on the GUI map.
* **Solution:** Designed and 3D-printed a custom sensor bracket in SolidWorks that positions the ultrasonic transducer centered directly along the servo's rotational axis.

---

## Serial Protocol Definition

Data is streamed over USB Serial at **9600 baud** in a comma-delimited ASCII string terminated with a period:

```text
<angle_degrees>,<distance_cm>.
```

* **Angle Range:** `0` to `180` (Degrees)
* **Tracking Distance Range:** `2` to `40` (Centimeters)
* **Example Payload:** `45,28.` (Beam at 45°, target detected at 28 cm)

---

## Directory Structure

```text
Sonar-Sweep/
├── README.md           # Technical documentation
├── sonar_sweep.ino     # Arduino Mega C/C++ firmware
├── radar_scope.pde     # Processing Java GUI visualizer
└── CAD/
    ├── sonar_bracket.STEP  # Universal CAD model
    └── sonar_bracket.STL   # Interactive 3D preview & 3D print file
```