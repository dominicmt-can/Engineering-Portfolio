# 3D-Printed Epicyclic Planetary Gearbox

A single-stage epicyclic gear reduction modeled in SolidWorks, mathematically pre-validated in MATLAB, and fabricated via FDM 3D printing.

**Project Motivation:** Created to bridge theoretical gear kinematics with practical Design for Additive Manufacturing (DFAM). This project demonstrates the complete mechanical development cycle—from scripting concentric mesh equations and transverse contact ratios to applying physical clearance offsets that compensate for standard FDM manufacturing tolerances.

<br>

<p align="center">
  <img src="../images/Gear_Asem_Exploded.gif" alt="Exploded Gear Assembly" width="80%" />
</p>

<div align="center">

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

## Kinematic Validation (MATLAB)

Before committing the geometry to CAD, the gear parameters were analytically verified using a custom MATLAB script to ensure physical meshing without interference.

* **Concentricity Verification:** Confirmed the standard epicyclic spatial constraint where the ring gear tooth count equals the sun gear plus twice the planet gear tooth count: 
  $N_r = N_s + 2N_p$
* **Carrier Symmetry:** Verified that three planet gears could be equispaced at exactly 120° intervals by ensuring the sum of the sun and ring teeth is divisible by the number of planets ($P$):
  $\frac{N_s + N_r}{P} \in \mathbb{Z}$
* **Transverse Contact Ratio:** Calculated the expected contact ratio to guarantee continuous power transmission without mesh drop-outs, achieving $\epsilon = 1.511$ (exceeding the standard $\geq 1.2$ safety threshold).

> **Kinematic Script:** The raw `.m` script is available in [`tests/`](./tests/).

---

## Design for Additive Manufacturing (DFAM)

Directly translating theoretical involute curves to an FDM printer results in fused, immovable parts due to material expansion and machine kinematics. The physical models were modified in SolidWorks to ensure a dynamic, low-friction fit.

<br>

<p align="center">
  <img src="../images/DisassembledGear.png" alt="Disassembled Gear Train" width="70%" />
</p>

<br>

* **Flank Thinning Offset:** Applied a uniform -0.20 mm normal offset across all gear involute profiles. This acts as a designed-in backlash, explicitly compensating for standard PLA over-extrusion and layer squish to prevent binding during hand-cranking.
* **Mass & Time Reduction:** Integrated curved relief pockets into the carrier plates. This significantly reduced rotational mass and print time while maintaining structural rigidity around the planetary pin joints.
* **Print Orientation:** Shafts, pins, and hex drives were designed and oriented parallel to the Z-axis to avoid shear-plane delamination under torsional loads.

---

## Directory Structure

[**Planetary-Gearbox/**](./)  
├── [**CAD/**](./CAD/)  
│&nbsp;&nbsp;&nbsp;└── *(CAD file tree to be added)*  
└── [**tests/**](./tests/)  
&nbsp;&nbsp;&nbsp;&nbsp;└── [`planetary_validation.m`](./tests/planetary_validation.m) — MATLAB kinematic verification script