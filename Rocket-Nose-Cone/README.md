# Composite Rocket Nose Cone & Vacuum Infusion Tooling

A high-power rocketry aerodynamic surface model, mathematically pre-validated for physical composite manufacturing, and supported by a station-by-station dimensional schedule.

<br>

<p align="center">
  <img src="../images/Rocket_nosecone.png" alt="Nose Cone Digital Profile" width="80%" />
</p>

> **Manufacturing Source Files:** Complete master CAD, STL geometry, and analytical layup schedules are available in this directory.

---

## Technical Specifications

* **Architecture:** Tapered aerodynamic nose cone profile (Tooling / Male Mold / Tangent-Ogive)
* **Base Radius:** 53.0 mm
* **Total Height:** 380.0 mm
* **Manufacturing stations:** Cut into 20 mm height increments for layup accuracy
* **Material (Tooling):** PETG Printed on Bambu Lab x1 Carbn
* **Material (Final Part):** Fiberglass Roving Biaxial Tubing (4" and 3" diameter schedule)

---

## Hardware & Bill of Materials (BOM)

* **Tooling / Master Pattern:** 
  * 1x Fusion 360 CAD Model (`UBC Rocket Nose Cone Mold.f3d`)
  * 1x Nose Cone Mold Print Geometry (`UBC Rocket Nose Cone Mold.stl`)
* **Composite Materials:** 
  * Roving fiberglass biaxial tubing/sleeving (4-inch and 3-inch nominal diameters)
  * Two-part aerospace-grade infusion epoxy resin system
* **Vacuum Infusion Consumables:** Release film, Peel ply, infusion flow media (flow mesh), vacuum bagging film, sealant tape (tacky tape), spiral tubing (resin feed/vacuum lines) and a vacuum pump,

---

## Key Engineering Challenges & Solutions

### 1. Precise Material Sizing & Biaxial Conformance
* **Problem:** Slipping tubular composite sleeves over a highly tapered 3D surface can lead to localized bunching at the tip or severe bridging across the base if the sleeve diameter is improperly sized.
* **Solution:** Developed an analytical spreadsheet to slice the 380 mm continuous profile into discrete 20 mm vertical stations. Geometrically derived the exact required fiber width at each station—tapering down from 166.5 mm at the base to 0 mm at the tip—ensuring the biaxial tubing could be pulled taut to conform perfectly to the changing circumference without structural voids.

> **Layup Data:** The raw analytical data is available in [`Rocket data.xlsx`](./Rocket%20data.xlsx).

### 2. Structural Thickness & Sleeve Sequencing
* **Problem:** The finished composite airframe must maintain specific internal and external clearances to integrate cleanly with the rocket's primary body tube, while retaining enough wall thickness to withstand aerodynamic flight loads.
* **Solution:** Implemented a targeted multi-layer tubing schedule—specifically sliding a 6-inch sleeve, followed by a 4-inch sleeve, and finished with a final 6-inch sleeve (4" $\rightarrow$ 3" $\rightarrow$ 4"). Modeled predicted wall thicknesses analytically prior to infusion, verifying that final cured thicknesses accurately follow the tangent ogive profile required.

### 3. Tooling Design for Vacuum Infusion (DFAM)
* **Problem:** Using FDM printing for infusion tooling risks vacuum leaks through the porous printed layers, and the high pressure of the vacuum bag can crush hollow printed structures.
* **Solution:** Slicer profiles were adjusted for thick walls and dense infill to withstand atmospheric crushing forces under full vacuum. The mold was extensively sealed to ensure a 100% airtight envelope required for pulling the resin through the fiberglass matrix.

---

## Technical Documentation & Empirical Validation

* **Analytical Sizing List:** Produced a comprehensive, station-by-station dimensional list dictating the exact dimensions and stretch requirements of the biaxial sleeving.
* **Clearance Validation:** Verified structural thickness calculations against the mating body tube internal diameter to ensure a slip-fit without excessive sanding or post-machining.
* **Vacuum Integrity & Surface Preparation:** Mandated rigorous post-processing of the PETG mold (sanding with increasing grits, application of body filler, and multiple coats of resin) to eliminate FDM layer lines, seal the porosity, and guarantee an smooth finish on the demolded part.

---

## Manufacturing Sequence & Quick Start Guide

1. **Tooling Fabrication:** Print `UBC Rocket Nose Cone Mold.stl` in PETG. Ensure high perimeter count to withstand atmospheric pressure during infusion. 
2. **Tooling Post-Processing:** Sand the mold smooth to remove all FDM layer lines. Apply body filler where necessary, buffing between coats, followed by a resin to ensure an airtight, non-stick surface.
3. **Material Prep:** Cut the roving fiberglass biaxial tubing to length. 
4. **Dry Layup & Bagging:** 
   * Apply release film to nose cone mold so the mold does not stick to the part.
   * Slide the biaxial sleeves over the tooling in the defined sequence: 6-inch sleeve, then 4-inch sleeve, then 6-inch sleeve. Pull each layer taut to conform perfectly to the mandrel taper.
   * Apply peel ply, flow mesh, and spiral tubing for the resin feed and vacuum catch.
   * Seal the entire assembly in a vacuum bag using tacky tape.
   * Pull a full vacuum and test to ensure a 100% leak-free envelope.
5. **Vacuum Infusion:** Mix the epoxy resin system. Unclamp the feed line and allow atmospheric pressure to drive the resin through the biaxial fiberglass matrix until fully saturated.
6. **Demolding:** Allow to cure completely per the resin manufacturer's datasheet before carefully extracting the final composite nose cone (Sometimes the nose cone can be slid off the mold, if this cannot be done, the entire part must be heated until the mold softens and releases the composite nose cone).

---

## Future Improvements

* **Multi-Part Split Mold:** Upgrade the single-piece geometry to a bolted, two-piece split mold with indexing alignment pins and integrated silicone O-ring grooves to simplify the vacuum sealing process.
* **FEA Aerodynamic Simulation:** Run Computational Fluid Dynamics (CFD) and Finite Element Analysis (FEA) to map pressure distributions and aerodynamic heating along the 380 mm profile at Mach 1+ velocities.
* **Heated Cure Cycle:** Implement an Arduino-controlled heated curing blanket setup to raise the glass transition temperature ($T_g$) of the infused epoxy, increasing overall airframe rigidity.

---

## Directory Structure

[**Rocket-Nose-Cone/**](./)  
├── [`README.md`](./README.md) — This documentation file  
├── [`Rocket data.xlsx`](./Rocket%20data.xlsx) — Analytical station slicing and dimensional sizing data  
├── [`UBC Rocket Nose Cone Mold.f3d`](./UBC%20Rocket%20Nose%20Cone%20Mold.f3d) — Native Fusion 360 master CAD model  
└── [`UBC Rocket Nose Cone Mold.stl`](./UBC%20Rocket%20Nose%20Cone%20Mold.stl) — Exported aerodynamic surface and mold geometry  