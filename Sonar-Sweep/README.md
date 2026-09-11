# Sonar Sweep — Ultrasonic Radar Scanner

A single-axis scanning radar system that pairs an ultrasonic rangefinder with a servo-driven 180° sweep to stream real-time spatial mapping data over USB to a custom desktop GUI.

**Project Motivation:** Created as an independent initiative to apply manufacturing and mechatronics principles to a complete build. This project demonstrates end-to-end product development, combining custom SolidWorks CAD, power-integrity debugging, and non-blocking embedded C/C++ control to reliably capture and visualize spatial telemetry.

<p align="center">
  <img src="../images/sonar_demo.gif" alt="Live Sonar Sweep Demo" width="80%" />
</p>

<div align="center">

<br>

| Sonar and Custom Servo Attachment | Assembled Microcontroller Rig |
| :---: | :---: |
| <img src="../images/Servo_Print_and_Stand.png" height="450" /> | <img src="../images/ServoSonarSetup.jpg" height="450" /> |

</div>

---

## Technical Specifications

*   **Microcontroller:** Arduino Mega 2560
*   **Transducer:** HC-SR04 Ultrasonic Distance Sensor (Trigger Pin 6, Echo Pin 7)
*   **Actuator:** SG90 9g Micro Servo on Pin 9 (180° commanded sweep)
*   **Commanded Angular Increment:** 1°
*   **Baud Rate:** 9600 bps via USB Serial communication
*   **Sweep Update Interval:** Nominal 25 ms (`sweepSpeed = 25`)
*   **Echo Timeout:** 20 ms
*   **GUI Display Range:** 2 cm to 40 cm (`maxDistance = 40`)
*   **Software Stack:** Arduino C/C++ (Firmware), Processing / Java (GUI Scope), SolidWorks (CAD)

---

## Hardware & Bill of Materials (BOM)

*   **Microcontroller:** 1x Arduino Mega 2560
*   **Sensor:** 1x HC-SR04 Ultrasonic Distance Sensor
*   **Actuator:** 1x SG90 9g Micro Servo
*   **Passive Components:** 1x 100 µF Capacitor across the 5V/GND power rail
*   **Prototyping & Wiring:**
    *   1x Solderless Breadboard
    *   Assorted Jumper Wires
    *   1x USB 2.0 Cable for power and serial telemetry
*   **Mounting & Structure:** Custom 3D-Printed Sensor Bracket (Black PLA, printed on Bambu Lab A1 Mini)

---

## Hardware Interconnect & Breadboard Distribution

<p align="center">
  <img src="../images/Circuit_Schematic.png" alt="Circuit layout" width="60%" />
</p>

> **Schematic Source Files:** Complete KiCad project, symbol tables, and schematic sheets available in [`circuits/`](./circuits/).

| Device / Module | Pin / Signal | Connection Target | Functional Purpose |
| :--- | :--- | :--- | :--- |
| **Power Distribution** | Arduino 5V | Breadboard (+) Rail | Main 5V DC power bus |
| | Arduino GND | Breadboard (-) Rail | System common ground |
| **HC-SR04 Sonar** | VCC | Breadboard (+) Rail | Transducer power supply |
| | GND | Breadboard (-) Rail | Transducer ground return |
| | Trig | Arduino Pin 6 | 10 µs trigger pulse output |
| | Echo | Arduino Pin 7 | Return timing capture input |
| **Micro Servo** | Power (Red) | Breadboard (+) Rail | Actuator power supply |
| | Ground (Brown) | Breadboard (-) Rail | Actuator ground return |
| | PWM (Orange) | Arduino Pin 9 | Servo position command |

> **Prototype Power Note:** The servo and sensor share the Arduino's 5 V breadboard rail. This exposed the prototype to servo-induced supply disturbances during movement and directly motivated the bulk-decoupling modification described below.

---

## System Architecture & Serial Protocol

```text
[ HC-SR04 Sensor ] ---> [ Arduino Mega 2560 ] ---> [ Serial / USB ] ---> [ Processing GUI ]
  10 µs Trigger Pulse      Timed Servo Sweep         "angle,distance."       Real-Time Radar
  Echo Timing Capture      3-Sample Median Filter     9600 Baud Stream        Scope Visualizer
```

Data is streamed over USB Serial at 9600 baud using a comma-delimited ASCII message terminated with a period:

`<angle_degrees>,<distance_cm>.`

*   **Angle Range:** 0 to 180 degrees
*   **GUI Display Range:** 2 to 40 cm
*   **Example Payload:** `45,28.` — beam commanded to 45° with a measured target distance of 28 cm

ASCII framing was selected instead of a packed binary protocol because the required data rate is low, while human-readable packets simplify serial debugging and Processing-side parsing.

---

## Signal Processing & Telemetry Validation

Raw ultrasonic measurements contain isolated range spikes and small measurement jitter. To reduce these disturbances without excessively smoothing sharp obstacle transitions, the firmware applies an onboard 3-sample median filter ($r_1, r_2, r_3$) using integer arithmetic.

A median filter was selected instead of a moving average because isolated outliers were the dominant observed error mode. The median operation rejects a single extreme sample while preserving sudden range transitions more effectively than averaging neighboring values.

<p align="center">
  <img src="../images/median_filter_plot.png" width="85%" alt="3-Point Median Filter vs Raw Telemetry" />
</p>

> **Test Data Files:** Raw test data and testing code are available in [`tests/`](./tests/).

### Empirical Performance Observations

*   **Isolated Outlier Rejection:** Rejects single-sample range spikes, including an observed approximately +20 cm outlier near 154°.
*   **Baseline Jitter Reduction:** Reduces persistent approximately ±1 cm variation across nominally planar target regions, including the 35°–70° section of the recorded sweep.
*   **Step-Edge Preservation:** Tracks sharp obstacle-range transitions, including an observed 87 cm → 43 cm step, without the broader smoothing that would be expected from a moving-average filter.

*(Testing Range: Filtering tests used the HC-SR04's raw measurement output and were not limited by the GUI's 40 cm visualization window. Telemetry Archive: Raw measurements and analytical workbooks are available in [`tests/`](./tests/).)*

---

## Key Engineering Challenges & Solutions

### 1. Timing Architecture
*   **Problem:** Initial `delay()`-based servo control paused processor execution during each movement step, producing less responsive motion and telemetry updates.
*   **Solution:** Replaced servo-control delays with `millis()`-based scheduling, allowing the sweep to advance on a nominal 25 ms interval without deliberately pausing the processor between servo commands.
    *   *Note:* The ultrasonic echo measurement remains bounded by a 20 ms timeout, preventing an absent echo from stalling the control loop indefinitely.

### 2. Serial Synchronization & Framing Protocol
*   **Problem:** Serial data may be received beginning at an arbitrary byte boundary, so the Processing application needs an unambiguous way to identify complete angle-distance measurements.
*   **Solution:** Used comma-separated angle and distance fields with a period terminator (`<angle>,<distance>.`). This allows the receiver to identify complete measurements and resynchronize at the next valid frame if partial input is encountered.

**Core Firmware Implementation — Timing & Serial Framing:**

```cpp
unsigned long currentTime = millis();

// Unsigned subtraction keeps interval timing valid across millis() rollover.
if (currentTime - lastMoveTime >= sweepSpeed) {
  lastMoveTime = currentTime;

  /* ... [Hardware actuation and sensor read logic abstracted] ... */

  // Serialize telemetry as: <angle>,<distance>.
  Serial.print(pos);
  Serial.print(",");
  Serial.print(filteredDistance);
  Serial.print(".");
}
```

### 3. Power Integrity & Supply Decoupling
*   **Problem:** Servo movement introduced current transients onto the shared 5 V supply rail, coinciding with intermittent instability in HC-SR04 timing measurements.
*   **Solution:** Added a 100 µF bulk capacitor across the shared 5 V/GND rail to reduce supply droop and transient noise caused by servo current demand.
    *   *Result:* The modification improved supply behavior without requiring a separate servo supply, while keeping the prototype electrically simple.

### 4. Mechanical Alignment & Beam Mapping
*   **Problem:** Initial mounting introduced an angular offset between the ultrasonic sensor face and the servo rotational axis, skewing target locations on the GUI.
*   **Solution:** Designed and 3D-printed a custom SolidWorks bracket that centers the HC-SR04 transducers over the servo's rotational axis.
    *   *DFAM Considerations:* A 0.2 mm dimensional allowance was applied to relevant mating features to account for FDM dimensional variation. Press-fit interfaces were used for the HC-SR04 housing and servo horn to avoid additional fasteners while preserving simple, easy-to-print geometry.

<p align="center">
  <img src="../images/Isometric_Assembly.png" alt="CAD Assembly" width="60%" />
</p>

> **CAD Source Files:** All CAD components and assembly files are available in [`CAD/`](./CAD/).

---

## Quick Start Guide

1.  **Hardware Setup:** Wire the Arduino Mega, HC-SR04, and SG90 servo according to the pin-mapping table. Supply the breadboard rails from the Arduino's 5 V and GND pins.
2.  **Flash Firmware:** Open `sonar_sweep.ino` in the Arduino IDE. Install the standard `<Servo.h>` library if required, select the Arduino Mega 2560, and upload the firmware.
3.  **Launch GUI:** Open `radar_scope.pde` in Processing using Java mode and run the sketch to begin live telemetry visualization.

*(Current Limitation: The Processing GUI assumes the Arduino is the first enumerated serial device using `Serial.list()[0]`. A more robust implementation would expose manual port selection or identify the device automatically.)*

---

## Future Improvements

*   **360° Scanning:** Replace the oscillating positional-servo architecture with a continuous-rotation drive and slip ring to enable unrestricted scanning without winding the sensor wiring.
*   **Persistent Mapping:** Extend the Processing GUI to retain measured points and construct a basic 2D room map rather than displaying only a decaying radar trail.
*   **Time-of-Flight Sensor Upgrade:** Replace the HC-SR04 with a VL53L0X or similar optical ToF sensor to reduce sensitivity to acoustic multipath and provide a narrower sensing field.
*   **Serial Port Selection:** Add a user-selectable device menu rather than relying on `Serial.list()[0]`.
*   **Dedicated Servo Supply:** Separate actuator power from the sensor and microcontroller rail for improved power integrity in a more permanent implementation.

---

## Directory Structure

[**Sonar-Sweep/**](./)<br>
├── [`README.md`](./README.md) — Technical documentation and system architecture breakdown<br>
├── [`sonar_sweep.ino`](./sonar_sweep.ino) — Arduino C/C++ firmware with median filtering<br>
├── [`radar_scope.pde`](./radar_scope.pde) — Processing GUI visualizer for real-time polar sweep rendering<br>
├── [**CAD/**](./CAD/)<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Assembly.SLDASM`](./CAD/Servo_Assembly.SLDASM) — Master SolidWorks assembly with exploded configuration<br>
│&nbsp;&nbsp;&nbsp;├── [`sonar_bracket.STEP`](./CAD/sonar_bracket.STEP) — Universal STEP exchange model<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Assembly - sonar_bracket-1.STL`](./CAD/Servo_Assembly%20-%20sonar_bracket-1.STL) — Slicer-ready bracket 3D print file<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Assembly - servoarm-1.STL`](./CAD/Servo_Assembly%20-%20servoarm-1.STL) — Servo horn interface geometry<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Assembly - HC-SR04_UltraSonic Sensor<2>.STL`](./CAD/Servo_Assembly%20-%20HC-SR04_UltraSonic%20Sensor%3C2%3E.STL) — Ultrasonic transducer reference model<br>
│&nbsp;&nbsp;&nbsp;└── [`Servo_Assembly - SERVO_SG90.stp-1.STL`](./CAD/Servo_Assembly%20-%20SERVO_SG90.stp-1.STL) — SG90 servo reference geometry<br>
├── [**circuits/**](./circuits/)<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Sweep_Circuit.kicad_sch`](./circuits/Servo_Sweep_Circuit.kicad_sch) — Schematic with decoupling and pin mapping<br>
│&nbsp;&nbsp;&nbsp;├── [`Servo_Sweep_Circuit.kicad_pro`](./circuits/Servo_Sweep_Circuit.kicad_pro) — KiCad project file<br>
│&nbsp;&nbsp;&nbsp;└── [`sym-lib-table`](./circuits/sym-lib-table) — Local symbol-library mapping table<br>
└── [**tests/**](./tests/)<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`filter_test.ino`](./tests/filter_test.ino) — Telemetry logging benchmark firmware<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`raw_telemetry.csv`](./tests/raw_telemetry.csv) — Recorded hardware sweep dataset<br>
&nbsp;&nbsp;&nbsp;&nbsp;└── [`filter_analysis.xlsx`](./tests/filter_analysis.xlsx) — Raw-versus-filtered comparison workbook