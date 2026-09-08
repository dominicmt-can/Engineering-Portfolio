# 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, mathematically pre-validated in MATLAB, and fabricated via FDM 3D printing.

**Project Motivation:** Created to bridge theoretical gear kinematics with practical Design for Additive Manufacturing (DFAM). This project demonstrates the complete mechanical development cycle—from scripting concentric mesh equations and transverse contact ratios to applying physical clearance offsets that compensate for standard FDM manufacturing tolerances.

<br>

<p align = "center">
  <img src="../images/Gear_Asem_Exploded.gif" alt="Exploded Gear Assembly" width="80%" />
</p>

<div align = "center">

<br>

| SolidWorks Digital Assembly | Physical FDM Prototype |
| :---: | :---: |
| <img src="../images/Gear_Isometric_Asem.png" height="450" /> | <img src="../images/Gear_IRL_Iso_Asem.jpg" height="450" /> |

</div>

> **CAD Source Files:** Complete master assembly and individual part files available in [`CAD/`](./CAD/).

---

## Technical Specifications

* **Architecture:** Single-stage epicyclic (1 Sun, 3 Planets, 3-Pin Carrier, 1 Fixed Ring)
* **Reduction Ratio:** 3:1
* **Module ($m$):** 2.5 mm
* **Pressure Angle ($\phi$):** 20°
* **Drive Interface:** Integrated hex-profile input (Sun) and output (Carrier) shafts for direct hand-tool drive
* **Material:** Generic Black PLA (Fabricated on Bambu Lab A1 Mini)

---

## Hardware & Bill of Materials (BOM)

* **Actuation / Input:** Integrated manual hex-drive (Standard socket/wrench compatible)
* **Printed Components:** 
  * 1x Sun Gear (`sungear_v1.STL`)
  * 3x Planet Gears (`PlanetGear_v1.STL`)
  * 1x Carrier Plate with 3 integrated pins (`PlanetGearPlate_v1.STL`)
  * 1x Stationary Ring Gear Housing (`RingGear_v1.STL`)
* **Fasteners / Bearings:** 100% 3D printed; utilizes raw PLA-on-PLA sliding interfaces with designed clearance gaps.

---

## Key Engineering Challenges & Solutions

### 1. Kinematic Validation & Concentricity
* **Problem:** Arbitrarily picking gear tooth counts for a planetary system usually results in geometric interference, where the planets fail to mesh simultaneously with the sun and ring gears.
* **Solution:** Developed a custom MATLAB script to analytically verify the gear parameters before committing geometry to CAD, ensuring physical meshing without interference.
  * **Concentricity Verification:** Confirmed the standard epicyclic spatial constraint where the ring gear tooth count equals the sun gear plus twice the planet gear tooth count: $N_r = N_s + 2N_p$.
  * **Carrier Symmetry:** Verified that three planet gears could be equispaced at exactly 120° intervals by ensuring the sum of the sun and ring teeth is divisible by the number of planets ($P$): $\frac{N_s + N_r}{P} \in \mathbb{Z}$.
  * **Transverse Contact Ratio:** Calculated the expected contact ratio to guarantee continuous power transmission without mesh drop-outs, achieving $\epsilon = 1.511$ (exceeding the standard $\geq 1.2$ safety threshold).

> **Kinematic Script:** The raw `.m` script is available in [`tests/`](./tests/).

### 2. Design for Additive Manufacturing (DFAM)
* **Problem:** Directly translating theoretical involute curves to an FDM printer results in fused, immovable parts due to material expansion, layer squish, and machine kinematics.
* **Solution:** Modified the physical models in SolidWorks to ensure a dynamic, low-friction fit by applying a uniform -0.20 mm normal offset across all gear involute profiles. This acts as a designed-in backlash, explicitly compensating for standard PLA over-extrusion to prevent binding during hand-cranking.

<br>

<p align = "center">
  <img src="../images/DFM_Display.png" alt="Involute Profiles" width="70%" />
</p>

### 3. Structural Integrity vs. Rotational Mass
* **Problem:** Solid PLA gear faces and carrier plates take too long to print and increase rotational inertia, while poorly oriented shaft prints shear under torsional load.
* **Solution:** Integrated curved relief pockets into the carrier plates to reduce rotational mass and print time while maintaining rigidity around the planetary pin joints. Oriented all shafts, pins, and hex drives parallel to the Z-axis on the build plate to prevent shear-plane delamination.

---

## Technical Drawings & Empirical Validation

* **ASME Y14.5 Drawing Package:** Produced a formal 5-sheet engineering drawing package detailing the master assembly with a Bill of Materials (BOM), envelope dimensions, and individual component sheets featuring Module 2.5 gear parameter tables.
* **Back-Drivability & Backlash:** Verified smooth, 360° non-binding rotation under manual drive. The -0.20 mm flank thinning offset successfully accommodated FDM layer squish while maintaining minimal backlash upon rotation reversal.
* **Transmission Ratio Verification:** Confirmed the theoretical 3:1 reduction experimentally ($1 + N_r / N_s = 1 + 48 / 24 = 3$) by tracking carrier angular displacement relative to sun gear input turns.
* **Clearance Validation:** Validated the 0.40 mm radial sliding clearance between carrier pins and planet bores, achieving free rotation without excessive wobble.

> **Drawing Package:** Full drawing set available in [`Drawings/Planetary_Gearbox_Drawing_Package.pdf`](./Drawings/Planetary_Gearbox_Drawing_Package.pdf).

---

## Assembly & Quick Start Guide

1. **Print Configuration:** Print all components in PLA with a 0.2 mm layer height. Ensure elephant-foot compensation is enabled in the slicer to preserve the bottom edge of the involute teeth.
2. **Post-Processing:** Use a deburring tool to lightly break sharp edges on the bottom faces of the gears and carrier pins. 
3. **Assembly Sequence:** 
   * Drop the **Sun Gear** into the center of the **Ring Gear** housing.
   * Mesh the 3 **Planet Gears** around the Sun Gear at 120° intervals.
   * Align the 3 pins on the **Carrier Plate** with the center bores of the planet gears and press firmly to seat the carrier.
4. **Testing:** Apply a hex wrench to the Sun Gear input shaft and verify that the Carrier Plate output shaft rotates at exactly $1/3$ the input speed.

---

## Future Improvements

* **Rolling Element Bearings:** Replace the direct printed pin-to-bore sliding interfaces with miniature deep-groove ball bearings (e.g., 608 or MR-series) to reduce frictional losses and pin wear under sustained load.
* **Dual-Plate Carrier Architecture:** Upgrade the single cantilevered 3-pin carrier plate to a double-sided trapped carrier cage, eliminating pin deflection and tooth misalignment during high-torque transmission.
* **Compound / Multi-Stage Configuration:** Design an interchangeable stacking interface to daisy-chain multiple epicyclic stages, allowing higher reduction ratios (9:1, 27:1) within the same outer envelope.
* **Automated Dynamometer Bench:** Build an embedded load-testing rig using an Arduino, stepper motor, and load cell to log continuous torque transmission efficiency and thermal degradation over runtime.

---

## Directory Structure

[**Planetary-Gearbox/**](./)  
├── [**CAD/**](./CAD/)  
│&nbsp;&nbsp;&nbsp;├── [`Planetarygear_Assem.SLDASM`](./CAD/Planetarygear_Assem.SLDASM) — Master SolidWorks epicyclic assembly  
│&nbsp;&nbsp;&nbsp;├── [`Planetarygear_Assem.STL`](./CAD/Planetarygear_Assem.STL) — Full assembly reference geometry  
│&nbsp;&nbsp;&nbsp;├── [`PlanetGear_v1.SLDPRT`](./CAD/PlanetGear_v1.SLDPRT) — Planet gear SolidWorks part (-0.20 mm offset)  
│&nbsp;&nbsp;&nbsp;├── [`PlanetGear_v1.STL`](./CAD/PlanetGear_v1.STL) — Planet gear slicer-ready print file  
│&nbsp;&nbsp;&nbsp;├── [`PlanetGearPlate_v1.SLDPRT`](./CAD/PlanetGearPlate_v1.SLDPRT) — 3-pin carrier plate SolidWorks part  
│&nbsp;&nbsp;&nbsp;├── [`PlanetGearPlate_v1.STL`](./CAD/PlanetGearPlate_v1.STL) — 3-pin carrier plate slicer-ready print file  
│&nbsp;&nbsp;&nbsp;├── [`RingGear_v1.SLDPRT`](./CAD/RingGear_v1.SLDPRT) — Stationary ring gear housing SolidWorks part  
│&nbsp;&nbsp;&nbsp;├── [`RingGear_v1.STL`](./CAD/RingGear_v1.STL) — Stationary ring gear housing slicer-ready print file  
│&nbsp;&nbsp;&nbsp;├── [`sungear_v1.SLDPRT`](./CAD/sungear_v1.SLDPRT) — Drive sun gear SolidWorks part  
│&nbsp;&nbsp;&nbsp;└── [`sungear_v1.STL`](./CAD/sungear_v1.STL) — Drive sun gear slicer-ready print file  
├── [**Drawings/**](./Drawings/)  
│&nbsp;&nbsp;&nbsp;├── [`Planetary_Gearbox_Drawing_Package.pdf`](./Drawings/Planetary_Gearbox_Drawing_Package.pdf) — Complete 5-sheet ASME Y14.5 drawing set  
│&nbsp;&nbsp;&nbsp;└── [`Planetarygear_Assem_Drawing.SLDDRW`](./Drawings/Planetarygear_Assem_Drawing.SLDDRW) — Master SolidWorks drawing package  
└── [**tests/**](./tests/)  
&nbsp;&nbsp;&nbsp;&nbsp;└── [`planetary_validation.m`](./tests/planetary_validation.m) — MATLAB kinematic verification script