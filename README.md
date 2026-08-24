# Engineering Portfolio

A collection of independent engineering builds spanning embedded systems, mechanical design, real-time software, and DFAM prototyping.

---

## 1. Sonar Sweep — Ultrasonic Radar Scanner

A single-axis radar scanner built from an ultrasonic rangefinder mounted on a hobby servo, integrating embedded firmware, noise filtering, and a live desktop GUI.

* **Telemetry & Real-Time Visualization:** Designed a custom serial protocol streaming synchronized angle/distance pairs over USB to a Processing GUI rendering a live radar scope.
* **Non-Blocking Control Loop:** Built control firmware in Arduino C/C++ using `millis()` timing to maintain a smooth, non-blocking 180° sweep with ~25 ms step intervals.
* **Signal Processing:** Implemented an onboard 3-sample median filter in firmware to reject ultrasonic echo dropouts and noise before transmission.
* **Hardware Debugging & Power Integrity:** Resolved power-integrity issues caused by servo PWM injecting noise into the shared 5V sensor power rail.
* **Mechanical Design & Prototyping:** Modeled and 3D-printed a custom SolidWorks sensor mount to center the transducer directly over the servo rotation axis, correcting mapping errors.

**Tools:** Arduino (C/C++), Processing (Java), SolidWorks, 3D Printing, Hardware Debugging  
**Directory:** [`Sonar-Sweep/`](./Sonar-Sweep/)

---

## 2. 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, pre-validated in MATLAB, and fabricated via FDM 3D printing.

* **Epicyclic Architecture:** Single-stage reduction utilizing a sun gear, 3 planet gears at 120° spacing, a 3-pin carrier, and a stationary ring gear that serves as the outer housing.
* **Numerical Mesh Validation:** Scripted kinematic checks to verify concentricity ($N_r = N_s + 2N_p$), equispaced carrier symmetry ($[N_s + N_r]/P \in \mathbb{Z}$), and transverse contact ratio ($\epsilon \ge 1.2$).
* **Design for Additive Manufacturing (DFAM):** Applied a uniform -0.20 mm flank thinning offset to ensure smooth meshing without thermal expansion binding. Integrated curved relief pockets in the carrier and backplate to reduce mass and print time.
* **Drive Interface:** Integrated hex-profile shaft features on the sun gear and carrier for direct hand-tool drive input and output testing.

**Tools:** SolidWorks, MATLAB, 3D Printing (FDM), Mechanism Design  
**Directory:** [`Planetary-Gearbox/`](./Planetary-Gearbox/)