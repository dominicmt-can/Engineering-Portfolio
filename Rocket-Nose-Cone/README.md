# Composite Rocket Nose Cone & Vacuum Infusion Tooling

A tangent-ogive nose cone for UBC Rocket's airframe, designed in Fusion 360 and manufactured by vacuum infusion over a 3D-printed mandrel, with a station-by-station dimensional schedule to guide the composite layup.

<br>

<p align="center">
  <img src="../images/Rocket-Nose-Cone.png" alt="Nose Cone Digital Profile" width="80%" />
</p>

> **Manufacturing Source Files:** Master CAD, STL geometry, and layup schedules are available in this directory.

---

<p align="center">
  <img src="../images/Rocket-Nose-Cone-Mold-Disassembled-Iso.png" alt="Disassembled nose cone mold, isometric view" height="360" hspace="8" />
  <img src="../images/Rocket-Nose-Cone-Mold-Disassembled-Front.png" alt="Disassembled nose cone mold, front view" height="360" hspace="8" />
  <img src="../images/Rocket-Nose-Cone-Mold.png" alt="Rocket nose cone mold" height="360" hspace="8" />
</p>

<p align="center">
  <img src="../images/Rocket-Nose-Cone-Real-Standing.png" alt="Finished rocket nose cone standing vertically" height="360" hspace="8" />
  <img src="../images/Rocket-Nose-Cone-Real-Side.png" alt="Finished rocket nose cone side view" height="360" hspace="8" />
</p>

## Technical Specifications

* **Architecture:** Tangent-ogive nose cone profile (tooling / male mold)
* **Base Radius:** 53.0 mm
* **Total Height:** 380.0 mm
* **Manufacturing Stations:** Sliced into 20 mm height increments for layup accuracy
* **Material (Tooling):** PETG, printed on a Bambu Lab X1 Carbon
* **Material (Final Part):** Biaxial fiberglass roving tubing (6" and 4" diameter schedule)

---

## Hardware & Bill of Materials (BOM)

* **Tooling / Master Pattern:**
  * 1x Fusion 360 CAD model (`UBC Rocket Nose Cone Mold.f3d`)
  * 1x Nose cone mold print geometry (`UBC Rocket Nose Cone Mold.stl`)
* **Composite Materials:**
  * Biaxial fiberglass roving tubing/sleeving (6-inch and 4-inch nominal diameters)
  * Two-part aerospace-grade infusion epoxy resin system
* **Vacuum Infusion Consumables:** Release film, peel ply, flow mesh, vacuum bagging film, tacky tape, spiral tubing (resin feed/vacuum lines), vacuum pump

---

## Key Engineering Challenges & Solutions

### 1. Material Sizing & Biaxial Conformance
* **Problem:** Sliding tubular composite sleeves over a tapered 3D surface risks bunching at the tip or bridging across the base if sleeve diameter isn't sized correctly at each point along the profile.
* **Solution:** Built an analytical spreadsheet to slice the 380 mm profile into 20 mm vertical stations, deriving the required fiber width at each — tapering from 166.5 mm at the base to 0 mm at the tip — so the biaxial tubing pulls taut and conforms to the changing circumference without voids.

> **Layup Data:** Raw analytical data is in [`Rocket data.xlsx`](./Rocket%20data.xlsx).

### 2. Structural Thickness & Sleeve Sequencing
* **Problem:** The finished airframe needs specific internal and external clearances to mate with the body tube, while keeping enough wall thickness to handle flight loads.
* **Solution:** Used a layered sleeve schedule — 6" sleeve, then 4", then a final 6" (6" → 4" → 6") — and modeled predicted wall thickness analytically before infusion to confirm the cured part would follow the ogive profile within tolerance.

### 3. Tooling Design for Vacuum Infusion (DFAM)
* **Problem:** FDM-printed tooling can leak through porous printed layers under vacuum, and hollow printed structures can crush under atmospheric pressure.
* **Solution:** Adjusted slicer profiles for thicker walls and denser infill to resist crushing under full vacuum, then sealed the mold to achieve a fully airtight envelope for resin infusion.

---

## Technical Documentation & Empirical Validation

* **Analytical Sizing List:** Station-by-station dimensional list specifying exact sleeving dimensions and stretch requirements.
* **Clearance Validation:** Verified structural thickness calculations against the mating body tube's internal diameter for a slip-fit without excessive sanding or machining.
* **Vacuum Integrity & Surface Prep:** Post-processed the PETG mold (progressive-grit sanding, body filler, multiple resin coats) to remove FDM layer lines, seal porosity, and produce a smooth finish on the demolded part.

---

## Manufacturing Sequence & Quick Start Guide

1. **Tooling Fabrication:** Print `UBC Rocket Nose Cone Mold.stl` in PETG with a high perimeter count to withstand vacuum pressure.
2. **Tooling Post-Processing:** Sand the mold smooth to remove FDM layer lines, apply body filler where needed, buff between coats, and finish with a resin barrier coat for an airtight, non-stick surface.
3. **Material Prep:** Cut the biaxial fiberglass sleeving to length.
4. **Dry Layup & Bagging:**
   * Apply release film to the mold so the part doesn't stick.
   * Slide the biaxial sleeves over the mandrel in sequence — 6" sleeve, then 4", then 6" — pulling each layer taut to conform to the taper.
   * Apply peel ply, flow mesh, and spiral tubing for resin feed and vacuum catch.
   * Seal the assembly in a vacuum bag with tacky tape.
   * Pull a full vacuum and check for a leak-free envelope.
5. **Vacuum Infusion:** Mix the epoxy resin system, then open the feed line and let atmospheric pressure drive resin through the fiberglass matrix until fully wetted out.
6. **Demolding:** Let the part cure fully per the resin datasheet, then remove it from the mold (sliding it off directly if possible, or heating the mold until it releases the part if not).

---

## Future Improvements

* **Multi-Part Split Mold:** Move to a bolted two-piece split mold with indexing pins and integrated O-ring grooves to simplify sealing.
* **FEA Aerodynamic Simulation:** Run CFD/FEA to map pressure distribution and aerodynamic heating along the profile at Mach 1+.
* **Heated Cure Cycle:** Add an Arduino-controlled heated curing blanket to raise the resin's glass transition temperature (Tg) and improve airframe rigidity.

---

## Directory Structure

[**Rocket-Nose-Cone/**](./)  
├── [`README.md`](./README.md) — This documentation file  
├── [`Rocket data.xlsx`](./Rocket%20data.xlsx) — Station slicing and dimensional sizing data  
├── [`UBC Rocket Nose Cone Mold.f3d`](./UBC%20Rocket%20Nose%20Cone%20Mold.f3d) — Native Fusion 360 master CAD model  
└── [`UBC Rocket Nose Cone Mold.stl`](./UBC%20Rocket%20Nose%20Cone%20Mold.stl) — Exported mold geometry