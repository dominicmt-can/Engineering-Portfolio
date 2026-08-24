# Engineering Portfolio

A collection of independent engineering builds spanning embedded systems, mechanical design, real-time software, and DFAM prototyping[cite: 1].

---

## 1. Sonar Sweep — Ultrasonic Radar Scanner

A single-axis radar scanner built from an ultrasonic rangefinder mounted on a hobby servo, integrating embedded firmware, noise filtering, and a live desktop GUI[cite: 1].

<p align="center">
  <img src="images/sonar_gui.png" alt="Processing Radar GUI" width="48%" />
  <img src="images/sonar_rig.png" alt="Assembled Hardware Rig" width="48%" />
</p>

* **Telemetry & Real-Time Visualization:** Designed a custom serial protocol streaming synchronized angle/distance pairs over USB to a Processing GUI rendering a live radar scope[cite: 1].
* **Non-Blocking Control Loop:** Built control firmware in Arduino C/C++ using `millis()` timing to maintain a smooth, non-blocking 180° sweep with ~25 ms step intervals[cite: 1].
* **Signal Processing:** Implemented an onboard 3-sample median filter in firmware to reject ultrasonic echo dropouts and noise before transmission[cite: 1].
* **Hardware Debugging & Power Integrity:** Resolved power-integrity issues caused by servo PWM injecting noise into the shared 5V sensor power rail[cite: 1].
* **Mechanical Design & Prototyping:** Modeled and 3D-printed a custom SolidWorks sensor mount to center the transducer directly over the servo rotation axis, correcting mapping errors[cite: 1].

**Tools:** Arduino (C/C++), Processing (Java), SolidWorks, 3D Printing, Hardware Debugging[cite: 1]  
**Files:** [`Sonar-Sweep/`](./Sonar-Sweep/)

---

## 2. 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, pre-validated in MATLAB, and fabricated via FDM 3D printing[cite: 1].

<p align="center">
  <img src="images/gearbox_assembled.png" alt="Planetary Gearbox Assembly" width="48%" />
  <img src="images/gearbox_matlab_plot.png" alt="MATLAB Mesh Profile Validation" width="48%" />
</p>

* **Epicyclic Architecture:** Single-stage reduction utilizing a sun gear, 3 planet gears at 120° spacing, a 3-pin carrier, and a stationary ring gear that serves as the outer housing[cite: 1].
* **Numerical Mesh Validation:** Scripted kinematic checks to verify concentricity (Nr = Ns + 2*Np), equispaced carrier symmetry ((Ns + Nr)/P is an integer), and transverse contact ratio (ε ≥ 1.2).
* **Design for Additive Manufacturing (DFAM):** Applied a uniform -0.20 mm flank thinning offset to ensure smooth meshing without thermal expansion binding[cite: 1]. Integrated curved relief pockets in the carrier and backplate to reduce mass and print time[cite: 1].
* **Drive Interface:** Integrated hex-profile shaft features on the sun gear and carrier for direct hand-tool drive input and output testing[cite: 1].

**Tools:** SolidWorks, MATLAB, 3D Printing (FDM), Mechanism Design[cite: 1]  
**Files:** [`Planetary-Gearbox/`](./Planetary-Gearbox/)