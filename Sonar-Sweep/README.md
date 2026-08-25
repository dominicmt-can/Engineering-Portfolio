# Sonar Sweep — Ultrasonic Radar Scanner

A single-axis scanning radar system that pairs an ultrasonic rangefinder with a continuous servo sweep to stream real-time spatial mapping data over USB to a custom desktop GUI.

<p align="center">
  <img src="../images/sonar_demo.gif" alt="Live Sonar Sweep Demo" width="80%" />
</p>

<div align="center">

| Sonar and Custom Servo Attachment | Assembled Microcontroller Rig |
| :---: | :---: |
| <img src="../images/Servo_Print_and_Stand.png" height="260" /> | <img src="../images/ServoSonarSetup.jpg" height="260" /> |

</div>

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

## Hardware & Bill of Materials (BOM)

* **Microcontroller:** 1x Arduino Mega 2560 (or standard Uno)
* **Sensor:** 1x HC-SR04 Ultrasonic Distance Sensor
* **Actuator:** 1x SG90 9g Micro Servo (180° sweep range)
* **Passive Components:** 1x Capacitor (across 5V/GND power rail)
* **Prototyping & Wiring:** 
  * 1x Solderless Breadboard
  * Assorted Jumper Wires (Male-to-Male and Male-to-Female)
  * 1x USB 2.0 Cable (Power & Serial Telemetry)
* **Mounting & Structure:** Custom 3D-Printed Sensor Bracket (Generic Black PLA, printed on Bambu Lab A1 Mini)

### Hardware Interconnect & Breadboard Distribution

| Device / Module | Pin / Signal | Connection Target | Functional Purpose |
| :--- | :--- | :--- | :--- |
| **Power Distribution** | Arduino 5V | Breadboard (+) Rail | Main 5V DC power bus |
| | Arduino GND | Breadboard (-) Rail | System common logic ground |
| **HC-SR04 Sonar** | VCC | Breadboard (+) Rail | Transducer power supply |
| | GND | Breadboard (-) Rail | Transducer ground return |
| | Trig | Arduino Pin 6 | 10 µs trigger pulse output |
| | Echo | Arduino Pin 7 | Return timing capture input |
| **Micro Servo** | Power (Red) | Breadboard (+) Rail | Actuator power supply |
| | Ground (Brown) | Breadboard (-) Rail | Actuator ground return |
| | PWM (Orange) | Arduino Pin 9 | 50 Hz PWM angle command |

---

## System Architecture & Serial Protocol

```text
[ HC-SR04 Sensor ] ---> [ Arduino Mega 2560 ] ---> [ Serial / USB ] ---> [ Processing GUI ]
  10 µs Trigger Pulse      Non-blocking Sweep         "angle,distance."       Real-Time Radar
  Echo Timing Capture      3-Sample Median Filter     9600 Baud Stream        Scope Visualizer
```

Data is streamed over USB Serial at **9600 baud** in a comma-delimited ASCII string terminated with a period:

```text
<angle_degrees>,<distance_cm>.
```

* **Angle Range:** `0` to `180` (Degrees)
* **Tracking Distance Range:** `2` to `40` (Centimeters)
* **Example Payload:** `45,28.` (Beam at 45°, target detected at 28 cm)

---

## Signal Processing & Telemetry Validation

To eliminate environmental multipath interference and high-frequency acoustic discretization noise, raw echo readings are processed through an onboard 3-sample median filter ($r_1, r_2, r_3$) executed in integer arithmetic.

<p align="center">
  <img src="../images/median_filter_plot.png" width="85%" alt="3-Point Median Filter vs Raw Telemetry" />
</p>

### Empirical Performance Metrics
* **Single-Sample Glitch Suppression:** Strips severe transient acoustic multipath reflections (e.g., rejecting an instantaneous $+20\text{ cm}$ spike at $154^\circ$) without causing trajectory corruption.
* **Baseline Jitter Elimination:** Flattens persistent $\pm 1\text{ cm}$ discretization ripple into stable planar boundaries across continuous targets ($35^\circ \text{--} 70^\circ$).
* **Step-Edge Fidelity:** Accurately tracks sharp obstacle profile transitions ($87\text{ cm} \rightarrow 43\text{ cm}$) with single-frame response latency.
* **Telemetry & Benchmarks:** Raw test data and analytical workbooks are archived in [`/arduino/tests/`](./arduino/tests/).

---

## Key Engineering Challenges & Solutions

### 1. Non-Blocking Timing Architecture
* **Problem:** Standard `delay()`-based control loops halted CPU execution during sensor reads and servo steps, causing jittery motion and dropped GUI frames.
* **Solution:** Refactored the control loop around `millis()` non-blocking timing, maintaining a smooth 180° sweep with a consistent 25 ms step interval.

### 2. Serial Synchronization & Framing Protocol
* **Problem:** Continuous serial streams risk frame desynchronization and partial payload reads on the receiver when baud rates drift or buffers overflow.
* **Solution:** Designed a lightweight, fixed-delimiter ASCII serialization protocol (`<angle>,<distance>.`) that allows the Processing client to cleanly parse frames with zero buffer overrun or trailing-byte lockups.

### 3. Power Integrity & Noise Decoupling
* **Problem:** The hobby servo injected electrical switching noise into the shared 5V VCC power rail during step transitions, intermittently corrupting HC-SR04 timing accuracy.
* **Solution:** Decoupled the sensor power rail with filtering capacitors and isolated high-current servo transients from the microcontroller logic bus.

### 4. Mechanical Alignment & Beam Mapping
* **Problem:** Initial mounting created an angular offset between the sensor face and the servo output spline, skewing target angles on the GUI map.
* **Solution:** Designed and 3D-printed a custom sensor bracket in SolidWorks that positions the ultrasonic transducer centered directly along the servo's rotational axis.

---

## Quick Start Guide

1. **Hardware Setup:** Wire the Arduino Mega, HC-SR04, and Micro Servo according to the pin mapping table. Ensure the breadboard power rails are supplied with 5V.
2. **Flash Firmware:** Open `sonar_sweep.ino` in the Arduino IDE. Install the standard `<Servo.h>` library if not already present. Select the Arduino Mega 2560 board and upload.
3. **Launch GUI:** Open `radar_scope.pde` in Processing (Java mode). The script automatically binds to the first available COM port (`Serial.list()[0]`). Run the sketch to begin live telemetry visualization.

---

## Future Improvements

* **Slip-Ring Integration:** Transition from a 180° oscillating servo to a continuous 360° slip-ring motor for uninterrupted panoramic scanning.
* **Point-Cloud Mapping:** Upgrade the Processing GUI to log persistent data points, creating a 2D room map rather than a decaying radar trail.
* **Lidar Upgrade:** Replace the acoustic HC-SR04 with a VL53L0X Time-of-Flight (ToF) laser sensor to eliminate multipath acoustic reflections and improve angular resolution.

---

## Directory Structure

* **Sonar-Sweep/**
  * `README.md` — Technical documentation
  * [`sonar_sweep.ino`](./sonar_sweep.ino) — Main embedded firmware with 3-median filter and non-blocking scheduling.
  * [`radar_scope.pde`](./radar_scope.pde) — Processing GUI script for serial decoding and dynamic polar rendering.
  * **CAD/**
    * [`sonar_bracket.STEP`](./CAD/sonar_bracket.STEP) — Universal STEP assembly model of the sensor mounting bracket.
    * [`sonar_bracket.STL`](./CAD/sonar_bracket.STL) — Slicer-ready stereolithography 3D print file.
  * **tests/**
    * [`filter_test.ino`](./tests/filter_test.ino) — Telemetry test benchmark firmware.
    * [`raw_telemetry.csv`](./tests/raw_telemetry.csv) — 150-point recorded hardware sweep dataset.
    * [`filter_analysis.xlsx`](./tests/filter_analysis.xlsx) — Excel workbook containing raw series and comparative chart.

```