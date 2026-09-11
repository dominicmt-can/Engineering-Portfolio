# Engineering Portfolio

A collection of independent engineering projects spanning embedded systems, mechanical assembly, real-time software, and DFAM (Design for Additive Manufacturing) prototyping. These builds demonstrate end-to-end product development and cross-disciplinary mechatronics.

---

## 1. Sonar Sweep — Ultrasonic Radar Scanner

A single-axis radar scanner built from an ultrasonic rangefinder mounted on a hobby servo, demonstrating full-system integration of embedded firmware, hardware noise filtering, and a live desktop GUI.

<p align="center">
  <img src="images/sonar_demo.gif" alt="Live Sonar Sweep Demo" width="80%" />
</p>

<div align="center">

<br>

| Assembled Hardware Setup | Sonar and Custom Servo Attachment |
| :---: | :---: |
| <img src="images/ServoSonarSetup.jpg" height="450" /> | <img src="images/Servo_Print_and_Stand.png" height="450" /> |

</div>

* **Telemetry & Real-Time Visualization:** Designed a lightweight ASCII serial protocol, streaming synchronized angle/distance pairs at 9600 baud over USB to a Processing GUI rendering a live radar scope.
* **Non-Blocking Control Loop:** Built control firmware in Arduino C/C++ using `millis()` timing to maintain a smooth, non-blocking 180° sweep with precise 25 ms step intervals.
* **Power Integrity & Noise Decoupling:** Resolved hardware timing corruption by decoupling the shared 5V sensor power rail with a 100 µF capacitor, effectively isolating the microcontroller from high-current servo PWM switching transients.
* **Mechanical Design & Prototyping:** Modeled and 3D-printed a custom SolidWorks sensor mount to center the transducer directly over the servo rotational axis. Factored in 0.2 mm PLA shrinkage and designed press-fit tolerances for the transducer and servo horn.
* **Signal Processing:** Implemented an onboard 3-sample median filter in integer arithmetic to actively reject ultrasonic multipath dropouts and environmental acoustic noise.

<p align="center">
  <img src="images/median_filter_plot.png" width="85%" alt="3-Point Median Filter vs Raw Telemetry" />
</p>

**Tools:** Arduino (C/C++), Processing (Java), SolidWorks, 3D Printing, KiCad, Hardware Debugging  
**Files:** [`Sonar-Sweep/`](./Sonar-Sweep/)

---

## 2. 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, mathematically pre-validated for concentric meshing, and fabricated via FDM 3D printing.

<br>

<p align = "center">
  <img src="images/Gear_Asem_Exploded.gif" alt = "Live Assembly Demo" width = "80%"/>
</p>

<div align="center">

<br>

| Assembled Planetary Stage | Disassembled 3D-Printed Parts |
| :---: | :---: |
| <img src="images/AssembledGear.png" height="450" /> | <img src="images/DisassembledGear.png" height="450" /> |

</div>

* **Epicyclic Architecture:** Single-stage reduction utilizing a sun gear, 3 planet gears at 120° spacing, a 3-pin carrier, and a stationary ring gear that serves as the outer housing.
* **Kinematic Validation:** Scripted analytical checks to verify concentricity (`Nr = Ns + 2*Np`), equispaced carrier symmetry (`(Ns + Nr)/P` is an integer), and transverse contact ratios.
* **Design for Additive Manufacturing (DFAM):** Applied a uniform -0.20 mm flank thinning offset across the involute profiles to ensure smooth meshing and prevent thermal expansion binding. Integrated curved relief pockets in the carrier to reduce rotating mass.
* **Drive Interface:** Integrated hex-profile shaft features on the sun gear and carrier for direct hand-tool drive input and dynamic output testing.

**Tools:** SolidWorks, Kinematic Analysis, 3D Printing (FDM), Mechanism Design  
**Files:** [`Planetary-Gearbox/`](./Planetary-Gearbox/)

---

## 3. Composite Rocket Nose Cone & Vacuum Infusion Tooling

A tangent-ogive nose cone for UBC Rocket's airframe, designed in Fusion 360 and manufactured by vacuum infusion over a 3D-printed mandrel.

<p align="center">
  <img src="images/Rocket-Nose-Cone.png" alt="Finished Composite Nose Cone" width="65%" />
</p>

* **Aerodynamic Surface Modeling:** Designed a 380 mm tangent-ogive profile with a 53 mm base radius in Fusion 360, used as the male mandrel for vacuum infusion.

<p align="center">
  <img src="images/Rocket-Nose-Cone-Mold-Disassembled-Iso.png" alt="Disassembled nose cone mold, isometric view" height="360" hspace="8" />
  <img src="images/Rocket-Nose-Cone-Mold.png" alt="Rocket nose cone mold" height="360" hspace="8" />
</p>

* **Analytical Station Layup Schedule:** Discretized the ogive into 20 mm vertical stations to derive target perimeter reductions (166.5 mm at the base tapering to 0 mm at the tip), preventing localized bunching and resin starvation in the biaxial sleeving.
* **DFAM Mandrel Engineering:** Tuned FDM perimeter density and shell thickness in Bambu Studio so the mold could withstand full atmospheric vacuum (-101 kPa) without collapsing, then sealed PETG porosity with filler and epoxy barrier coats.
* **Resin Infusion Strategy:** Sequenced a graduated biaxial fiberglass sleeve layup (3" → 4" → 3") over a release film covered mandrel, achieving uniform wet-out and clearances that mate cleanly with the primary airframe body tube.

<br>
  
**Tooling & Manufacturing Process**

1. **Tooling Fabrication:** Print `UBC Rocket Nose Cone Mold.stl` in PETG with a high perimeter count and ~ 30% infill to withstand vacuum pressure.

<p align="center">
  <img src="images/Rocket-Nose-Cone-Real-Standing.png" alt="Raw composite nose cone post-infusion" width="65%" />
</p>

2. **Tooling Post-Processing:** Sand the mold smooth to remove FDM layer lines, apply body filler where needed, buff between coats, and finish with a resin barrier coat for an airtight, non-stick surface.
3. **Material Prep:** Cut the biaxial fiberglass sleeving to length.
4. **Dry Layup & Bagging:**
   * Apply release film to the mold so the part doesn't stick.
   * Slide the biaxial sleeves over the mandrel in sequence — 3" sleeve, then 4", then 3" — pulling each layer taut to conform to the taper.
   * Apply peel ply, flow mesh, and spiral tubing for resin feed and vacuum catch.
   * Seal the assembly in a vacuum bag with tacky tape.
   * Pull a full vacuum and check for a leak-free envelope.
5. **Vacuum Infusion:** Mix the epoxy resin system, then open the feed line and let atmospheric pressure drive resin through the fiberglass matrix until fully wetted out.
6. **Demolding:** Let the part cure fully per the resin datasheet, then remove it from the mold (sliding it off directly if possible, or heating the mold until it releases the part if not).

**Tools:** Fusion 360, Composites Manufacturing, Vacuum Infusion, FDM 3D Printing, Geometric Sizing Analysis  
**Files:** [`Rocket-Nose-Cone/`](./Rocket-Nose-Cone/)

---

## 4. Composite Rocket Fin-Can

A continuous carbon-fiber wrap-around fin-can manufactured through vacuum infusion, with a symmetric stacking sequence developed to eliminate cure-induced warping.

<p align="center">
  <img src="Rocket-Fins/Fin_Infusion.gif" alt="Vacuum infusion process for the composite fin" width="80%" />
</p>

<div align="center">

<br>

| Demolded Individual Fins | Integrated Composite Fin-Can |
| :---: | :---: |
| <img src="Rocket-Fins/Individual_Fins.png" alt="Demolded individual composite fin sections" height="350" /> | <img src="Rocket-Fins/Attached_Fins.png" alt="Integrated composite fin-can" height="350" /> |

</div>

* **Defect Resolution:** Independently diagnosed the asymmetric laminate layup as the cause of a 20 mm cure-induced warp, implemented a symmetric 0°/45° schedule, and verified the follow-up panel cured nearly flat.
* **Manufacturing:** Designed and manufactured with the UBC Rocket sub-team using quasi-isotropic carbon fabric, vacuum bagging, resin infusion, and post-cure processing.

**Tools:** Composite Manufacturing, Vacuum Infusion, Carbon Fiber Layup, Laminate Analysis<br>
**Files:** [`Rocket-Fins/`](./Rocket-Fins/)