# 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, mathematically pre-validated in MATLAB, and fabricated via FDM 3D printing.

**Project Motivation:** Created to bridge theoretical gear kinematics with practical Design for Additive Manufacturing (DFAM). This project demonstrates the complete mechanical development cycle—from selecting tooth counts that satisfy planetary meshing constraints to adapting ideal involute geometry for the dimensional behavior of an FDM-printed mechanism.

<div align="center">

<br>

| SolidWorks Digital Assembly | Physical FDM Prototype |
| :---: | :---: |
| <img src="../images/DisassembledGear.png" height="450" /> | <img src="../images/AssembledGear.png" height="450" /> |

</div>

> **CAD Source Files:** Complete master assembly and individual part files are available in [`CAD/`](./CAD/).

---

## Technical Specifications

*   **Architecture:** Single-stage epicyclic gearbox
    *   1x Sun Gear
    *   3x Planet Gears
    *   1x 3-Pin Carrier
    *   1x Fixed Ring Gear
*   **Tooth Counts:** 24T Sun / 12T Planets / 48T Ring
*   **Operating Configuration:** Sun input, fixed ring, carrier output
*   **Theoretical Reduction Ratio:** 3:1
*   **Module ($m$):** 2.5 mm
*   **Pressure Angle ($\phi$):** 20°
*   **Drive Interface:** Integrated hex-profile input and output features for direct hand-tool operation
*   **Material:** Black PLA, fabricated on a Bambu Lab A1 Mini

---

## Hardware & Bill of Materials (BOM)

*   **Actuation / Input:** Integrated manual hex drive compatible with a standard wrench or socket
*   **Printed Components:**
    *   1x Sun Gear (`sungear_v1.STL`)
    *   3x Planet Gears (`PlanetGear_v1.STL`)
    *   1x Carrier Plate with 3 integrated pins (`PlanetGearPlate_v1.STL`)
    *   1x Stationary Ring Gear Housing (`RingGear_v1.STL`)
*   **Fasteners / Bearings:** None; the prototype uses printed PLA-on-PLA sliding interfaces with designed clearance between rotating parts.

> The fully printed architecture was an intentional prototype constraint, allowing the mechanism to evaluate gear geometry and printable clearances without introducing separate bearings, shafts, or metal hardware.

---

## Key Engineering Challenges & Solutions

### 1. Kinematic Validation & Tooth-Count Selection
*   **Problem:** Planetary tooth counts must satisfy multiple geometric constraints for the sun, planets, and ring to mesh concentrically while allowing equally spaced planets.
*   **Solution:** Developed a MATLAB validation script to check the selected geometry before generating the final CAD models.

For the selected 24T sun, 12T planets, and 48T ring, the following checks were performed:

**Concentricity**
The ring gear must contain the sun gear and two planet radii:
$N_r = N_s + 2N_p$
For the selected geometry:
$48 = 24 + 2(12)$
confirming concentric sun-planet-ring meshing.

**Equal Planet Spacing**
Three planets were placed at 120° intervals. Equal spacing requires:
$\frac{N_s + N_r}{P} \in \mathbb{Z}$
where $P$ is the number of planet gears.
For this design:
$\frac{24 + 48}{3} = 24$
which satisfies the spacing condition.

**Transverse Contact Ratio**
The MATLAB script also calculated a transverse contact ratio of:
$\epsilon = 1.511$
This exceeded the design target of 1.2, providing continuous tooth engagement through the evaluated gear mesh.

> **Kinematic Script:** The MATLAB validation script is available in [`tests/`](./tests/).

### 2. Design for Additive Manufacturing (DFAM)
*   **Problem:** Ideal involute gear geometry leaves little allowance for process-specific dimensional error, first-layer deformation, and surface roughness. Directly printing nominal profiles therefore risked tooth interference and binding.
*   **Solution:** Applied a uniform -0.20 mm normal offset to the involute tooth flanks in SolidWorks, introducing deliberate backlash to improve printability and free rotation.
    *   The offset was selected as a practical manufacturing allowance for the printer/material combination rather than as a universal PLA tolerance.
    *   This modification preserved the underlying module and pressure-angle geometry while reducing interference between mating printed tooth surfaces.

### 3. Carrier Design, Material Reduction & Print Orientation
*   **Problem:** A fully solid carrier would increase material use, print time, and rotating mass, while the integrated planet pins still required sufficient surrounding material to resist bending during operation.
*   **Solution:** Added curved relief pockets in low-priority regions of the carrier while retaining material around the planet-pin supports and central output interface.
    *   The relief geometry reduced unnecessary material without removing the primary load paths around the three planet supports.
    *   Print orientation was also selected to reduce the risk of failure at highly loaded shaft and pin features. Shafts, carrier pins, and hex interfaces were oriented to keep the expected operational loading primarily within continuous printed material rather than relying unnecessarily on weak interlayer adhesion.

---

## Technical Drawings & Physical Validation

### Engineering Drawing Package
Produced a formal 5-sheet engineering drawing package containing:

*   Master assembly drawing
*   Bill of Materials
*   Overall envelope dimensions
*   Individual component drawings
*   Module 2.5 gear parameter information

The package uses standard ASME Y14.5 mechanical drawing conventions and provides the dimensions required to reproduce or inspect the design.

> **Drawing Package:** Full drawing set available in [`Drawings/Planetarygear_Assem_Drawing.pdf`](./Drawings/Planetarygear_Assem_Drawing.pdf).

### Rotation & Backlash Check
The assembled gearbox was manually driven through repeated 360° rotations to confirm that the printed gears could complete a full cycle without binding. The -0.20 mm flank offset provided sufficient clearance for continuous rotation while retaining functional tooth engagement during direction reversal.

### Transmission Ratio Verification
For a planetary configuration with the ring fixed, sun driven, and carrier used as the output, the theoretical ratio is:
$i = 1 + \frac{N_r}{N_s}$
$i = 1 + \frac{48}{24} = 3$

The physical assembly was manually rotated and the angular motion of the sun and carrier was compared, confirming approximately one carrier revolution for every three sun revolutions.

### Pin-to-Bore Clearance
The planet gears rotate directly on printed carrier pins rather than bearings. Clearance between the carrier pins and planet bores was designed to allow free rotation while limiting visible wobble during operation. The final printed fit allowed all three planets to rotate freely without binding.

---

## Assembly & Quick Start Guide

1.  **Print Configuration:** Print all components in PLA with a 0.2 mm layer height. Enable elephant-foot compensation where required to preserve the lower edges of the gear teeth.
2.  **Post-Processing:** Lightly deburr sharp edges on the gear faces, bores, and carrier pins without significantly altering the involute tooth profiles.
3.  **Assembly Sequence:**
    *   Place the Sun Gear at the center of the Ring Gear housing.
    *   Mesh the 3 Planet Gears around the Sun Gear at 120° intervals.
    *   Align the 3 integrated carrier pins with the planet bores.
    *   Seat the Carrier Plate so each planet rotates freely on its corresponding pin.
4.  **Functional Check:** Apply a wrench or socket to the Sun Gear input and rotate the mechanism through several full revolutions. With the ring fixed, the Carrier output should rotate at approximately one-third of the Sun input speed.

---

## Future Improvements

*   **Bearing-Supported Planets:** Replace the printed pin-to-bore sliding interfaces with appropriately sized miniature bearings to reduce friction and long-term wear.
*   **Dual-Plate Carrier Architecture:** Replace the cantilevered single-plate carrier with a double-sided carrier cage to support each planet pin at both ends and reduce deflection under higher torque.
*   **Multi-Stage Gearbox:** Add an interchangeable interface that allows multiple planetary stages to be stacked for larger reduction ratios such as 9:1 or 27:1.
*   **Torque & Efficiency Test Bench:** Add a motorized input and torque/load measurement system to quantify transmitted torque, efficiency, backlash, and wear over extended operation.
*   **Tolerance Characterization:** Print dedicated clearance and gear-fit coupons to determine process-specific offsets more systematically before future gearbox iterations.

---

## Directory Structure

[**Planetary-Gearbox/**](./)<br>
├── [**CAD/**](./CAD/)<br>
│&nbsp;&nbsp;&nbsp;├── [`Planetarygear_Assem.SLDASM`](./CAD/Planetarygear_Assem.SLDASM) — Master SolidWorks epicyclic assembly<br>
│&nbsp;&nbsp;&nbsp;├── [`PlanetGear_v1.SLDPRT`](./CAD/PlanetGear_v1.SLDPRT) — Planet gear SolidWorks model with DFAM tooth clearance<br>
│&nbsp;&nbsp;&nbsp;├── [`PlanetGear_v1.STL`](./CAD/PlanetGear_v1.STL) — Slicer-ready planet gear<br>
│&nbsp;&nbsp;&nbsp;├── [`PlanetGearPlate_v1.SLDPRT`](./CAD/PlanetGearPlate_v1.SLDPRT) — 3-pin carrier plate SolidWorks model<br>
│&nbsp;&nbsp;&nbsp;├── [`PlanetGearPlate_v1.STL`](./CAD/PlanetGearPlate_v1.STL) — Slicer-ready carrier plate<br>
│&nbsp;&nbsp;&nbsp;├── [`RingGear_v1.SLDPRT`](./CAD/RingGear_v1.SLDPRT) — Stationary ring gear housing model<br>
│&nbsp;&nbsp;&nbsp;├── [`RingGear_v1.STL`](./CAD/RingGear_v1.STL) — Slicer-ready ring gear housing<br>
│&nbsp;&nbsp;&nbsp;├── [`sungear_v1.SLDPRT`](./CAD/sungear_v1.SLDPRT) — Sun gear SolidWorks model<br>
│&nbsp;&nbsp;&nbsp;└── [`sungear_v1.STL`](./CAD/sungear_v1.STL) — Slicer-ready sun gear<br>
├── [**Drawings/**](./Drawings/)<br>
│&nbsp;&nbsp;&nbsp;└── [`Planetarygear_Assem_Drawing.pdf`](./Drawings/Planetarygear_Assem_Drawing.pdf) — Engineering drawing package<br>
└── [**tests/**](./tests/)<br>
&nbsp;&nbsp;&nbsp;&nbsp;└── [`planetary_validation.m`](./tests/planetary_validation.m) — MATLAB kinematic validation script