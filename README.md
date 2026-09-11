# Engineering Portfolio

Hands-on engineering portfolio focused on mechanical design, mechatronics, composite manufacturing, and design for additive manufacturing (DFAM). These projects emphasize iterative prototyping, analytical validation, manufacturing constraints, and debugging physical systems from initial concept through tested hardware.

## Featured Work

| Project | Focus |
| :--- | :--- |
| **Sonar Sweep** | Embedded systems, mechatronics, telemetry, hardware debugging |
| **Composite Rocket Fin-Can** | Composite manufacturing, defect investigation, laminate design |
| **Planetary Gearbox** | Mechanical design, epicyclic kinematics, DFAM |
| **Rocket Nose Cone** | Composite tooling, vacuum infusion, manufacturing analysis |

---

## 1. Sonar Sweep — Ultrasonic Radar Scanner

A single-axis ultrasonic scanner combining embedded firmware, mechanical design, power-integrity debugging, signal filtering, and a live desktop visualization interface.

<p align="center">
  <img src="images/sonar_demo.gif" alt="Live Sonar Sweep Demo" width="80%" />
</p>

<div align="center">

<br>

| Assembled Hardware Setup | Sonar and Custom Servo Attachment |
| :---: | :---: |
| <img src="images/ServoSonarSetup.jpg" height="450" /> | <img src="images/Servo_Print_and_Stand.png" height="450" /> |

</div>

* **Real-Time Telemetry & Visualization:** Designed a lightweight ASCII serial protocol that streams synchronized angle and distance measurements at 9600 baud over USB to a Processing GUI rendering a live radar scope.
* **Non-Blocking Embedded Control:** Built the Arduino C/C++ firmware around `millis()` timing rather than `delay()`, allowing the servo, ultrasonic sensor, filtering, and serial transmission to operate within a consistent 25 ms sweep interval.
* **Power Integrity & Hardware Debugging:** Traced intermittent ultrasonic timing errors to servo-induced disturbances on the shared 5 V rail and added a 100 µF bulk-decoupling capacitor to stabilize sensor measurements during servo motion.
* **Mechanical Design & DFAM:** Modeled and 3D-printed a custom SolidWorks sensor bracket that centers the HC-SR04 over the servo rotational axis. Added approximately 0.2 mm of fit compensation to accommodate FDM dimensional variation and created press-fit interfaces for the sensor and servo horn.
* **Signal Processing:** Implemented an onboard 3-sample median filter using integer arithmetic to reject isolated ultrasonic multipath spikes while preserving sharp obstacle transitions.
* **Result:** Produced a stable 180° scanning system capable of continuously capturing, filtering, and visualizing spatial telemetry in real time.

**Tools:** Arduino C/C++, Processing / Java, SolidWorks, KiCad, Bambu Studio  
**Engineering Areas:** Embedded systems, serial communication, signal filtering, power-integrity debugging, DFAM, system integration  
**Files:** [`Sonar-Sweep/`](./Sonar-Sweep/)

---

## 2. Composite Rocket Fin-Can

A vacuum-infused carbon-fiber wrap-around fin-can developed with the UBC Rocket design team. During prototyping, I independently investigated a roughly 20 mm cure-induced warp in the initial test laminate, traced the defect to an asymmetric stacking sequence, and revised the layup used for the follow-up panel.

<p align="center">
  <img src="Rocket-Fins/Fin_Infusion.gif" alt="Vacuum infusion process for the composite fin" width="80%" />
</p>

<div align="center">

<br>

| Demolded Individual Fins | Integrated Composite Fin-Can |
| :---: | :---: |
| <img src="Rocket-Fins/Individual_Fins.png" alt="Demolded individual composite fin sections" height="350" /> | <img src="Rocket-Fins/Attached_Fins.png" alt="Integrated composite fin-can" height="350" /> |

</div>

* **Individual Contribution — Defect Investigation:** Reviewed the failed laminate schedule and identified asymmetric stacking as the likely source of bending-extension coupling and residual curvature during cool-down from the post-cure.
* **Layup Redesign:** Revised the 9-ply schedule to use a symmetric alternating 0°/45° reference orientation about the laminate midplane while maintaining the required quasi-isotropic reinforcement architecture.
* **Verification:** We manufactured a second test panel using the revised schedule, which cured practically flat compared with the approximately 20 mm out-of-plane deviation observed in the original panel.
* **Composite Manufacturing:** Supported production using quasi-isotropic carbon fabric, vacuum bagging, resin infusion, post-cure processing, trimming, surface preparation, and structural bonding of the continuous wrap-around fin sections.
* **Result:** Converted a visibly warped prototype laminate into a nearly flat follow-up panel through root-cause analysis and stacking-sequence redesign.

**Tools & Processes:** Vacuum infusion, carbon-fiber layup, composite tooling, resin systems, vacuum bagging  
**Engineering Areas:** Composite laminate design, manufacturing defect analysis, root-cause investigation, process improvement  
**Files:** [`Rocket-Fins/`](./Rocket-Fins/)

---

## 3. 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gearbox modeled in SolidWorks, analytically checked in MATLAB, and fabricated through FDM 3D printing to connect theoretical gear design with practical manufacturing tolerances.

<p align="center">
  <img src="images/Gear_Asem_Exploded.gif" alt="Live Assembly Demo" width="80%"/>
</p>

<div align="center">

<br>

| Assembled Planetary Stage | Disassembled 3D-Printed Parts |
| :---: | :---: |
| <img src="images/AssembledGear.png" height="450" /> | <img src="images/DisassembledGear.png" height="450" /> |

</div>

* **Epicyclic Architecture:** Designed a single-stage reduction consisting of a sun gear, three planets spaced at 120°, a 3-pin carrier, and a stationary ring gear integrated into the outer housing.
* **Kinematic Validation:** Created MATLAB checks to verify tooth-count compatibility, concentricity (`Nr = Ns + 2*Np`), three-planet carrier symmetry, and transverse contact ratio before finalizing the CAD geometry.
* **Design for Additive Manufacturing:** Applied a 0.20 mm flank relief to the involute gear profiles to compensate for FDM dimensional error, surface roughness, and layer-related interference that could otherwise cause the printed gears to bind.
* **Carrier Design:** Added curved relief pockets to reduce print time and rotating mass while retaining material around the planet-pin interfaces and primary structural load paths.
* **Drive & Testing Interface:** Integrated hex-profile input and output features into the sun gear and carrier, allowing the mechanism to be manually driven and the reduction ratio to be checked without additional shaft hardware.
* **Result:** Produced a fully printed gearbox capable of continuous 360° rotation without tooth binding while reproducing the intended 3:1 reduction.

**Tools:** SolidWorks, MATLAB, Bambu Studio, FDM 3D Printing  
**Engineering Areas:** Epicyclic kinematics, involute gearing, tolerance design, mechanism design, DFAM  
**Files:** [`Planetary-Gearbox/`](./Planetary-Gearbox/)

---

## 4. Composite Rocket Nose Cone & Vacuum Infusion Tooling

A tangent-ogive composite nose cone developed with the UBC Rocket design team using a Fusion 360-designed, 3D-printed PETG mandrel and vacuum-infusion manufacturing process.

<p align="center">
  <img src="images/Rocket-Nose-Cone.png" alt="Finished Composite Nose Cone" width="65%" />
</p>

<div align="center">

<br>

| Disassembled Tooling | Real Nose Cone Mold |
| :---: | :---: |
| <img src="images/Rocket-Nose-Cone-Mold-Disassembled-Iso.png" alt="Disassembled nose cone mold, isometric view" height="360" /> | <img src="images/Rocket-Nose-Cone-Real-Standing.png" alt="Real nose cone mold" height="360" /> |

</div>

* **Individual Contribution:** Developed the infusion mandrel geometry and station-based sizing approach used to plan how the biaxial fiberglass sleeving would conform to the changing ogive circumference.
* **Aerodynamic Surface Modeling:** Designed a 380 mm tangent-ogive profile with a 53 mm base radius in Fusion 360 for use as the male infusion mandrel.
* **Station-Based Layup Planning:** Discretized the ogive into 20 mm vertical stations and calculated the required perimeter at each location, tapering from approximately 166.5 mm at the base toward the tip. The schedule was used to guide sleeve sizing and reduce the risk of bunching, bridging, and uneven resin distribution.
* **DFAM Tooling Design:** Designed the mandrel geometry and print orientation to minimize unsupported overhangs, then adjusted FDM shell and perimeter settings so the PETG tooling could withstand vacuum loading without collapsing.
* **Tooling Preparation:** Post-processed the printed mandrel using filler, sanding, and epoxy barrier coats to reduce surface roughness and seal FDM porosity before infusion.
* **Resin Infusion Strategy:** Used a graduated biaxial fiberglass sleeve sequence of 3" → 4" → 3" to conform the reinforcement to the changing geometry while maintaining the required finished dimensions.
* **Result:** Produced vacuum-infusion tooling and a composite layup approach that generated the intended ogive geometry and mating dimensions for integration with the rocket airframe.

**Tools:** Fusion 360, Bambu Studio, FDM 3D Printing  
**Engineering Areas:** Composite manufacturing, vacuum infusion, geometric sizing analysis, DFAM tooling, process planning  
**Files:** [`Rocket-Nose-Cone/`](./Rocket-Nose-Cone/)

---

## Engineering Focus

Across these projects, I have worked through the full engineering cycle:

**Concept → Analysis → CAD → Manufacturing → Testing → Failure Investigation → Iteration**

My main areas of interest include:
* Mechanical design and prototyping
* Mechatronics and embedded systems
* Composite manufacturing
* Design for additive manufacturing
* Manufacturing process development
* Hardware debugging and root-cause analysis