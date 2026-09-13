# Composite Rocket Nose Cone & Vacuum Infusion Tooling

A tangent-ogive nose cone for UBC Rocket's airframe, designed in Fusion 360 and manufactured by vacuum infusion over a 3D-printed PETG mandrel. The tooling geometry incorporated station-by-station laminate-thickness compensation so the cured composite outer surface would match the required tangent-ogive profile.

**Project Context & Contribution:** Developed as part of the UBC Rocket design team. I independently completed key portions of the CAD/tooling design and developed the station-by-station laminate-thickness compensation used to modify the mandrel geometry for the overlapping fiberglass layup. Mold preparation, composite layup, vacuum bagging, resin infusion, and final manufacturing were completed collaboratively by our sub-team, with my direct involvement throughout.

<p align="center">
  <img src="../images/Rocket-Nose-Cone.png" alt="Nose Cone Digital Profile" width="80%" />
</p>

> **Manufacturing Source Files:** Master CAD, STL geometry, and layup schedules are available in this directory.

---

<div align="center">

<br>

| Disassembled Mold (Isometric) | Disassembled Mold (Front) | Assembled Tooling |
| :---: | :---: | :---: |
| <img src="../images/Rocket-Nose-Cone-Mold-Disassembled-Iso.png" height="250" /> | <img src="../images/Rocket-Nose-Cone-Mold-Disassembled-Front.png" height="250" /> | <img src="../images/Rocket-Nose-Cone-Mold.png" height="250" /> |

</div>

---

## Technical Specifications

* **Architecture:** Tangent-ogive nose cone profile (tooling / male mold)
* **Base Radius:** 53.0 mm
* **Total Height:** 380.0 mm
* **Analysis Stations:** 20 mm axial increments for laminate-thickness compensation
* **Material (Tooling):** PETG, printed on a Bambu Lab X1 Carbon
* **Material (Final Part):** Biaxial fiberglass roving tubing (3" and 4" diameter schedule)

---

## Hardware & Bill of Materials (BOM)

* **Tooling / Master Pattern:**
  * 1x Fusion 360 CAD model (`UBC Rocket Nose Cone Mold.f3d`)
  * 1x Nose cone mold print geometry (`UBC Rocket Nose Cone Mold.stl`)
* **Composite Materials:**
  * Biaxial fiberglass roving tubing/sleeving (3-inch and 4-inch nominal diameters)
  * Two-part aerospace-grade infusion epoxy resin system
* **Vacuum Infusion Consumables:** Release film, peel ply, flow mesh, vacuum bagging film, tacky tape, spiral tubing (resin feed/vacuum lines), vacuum pump

---

## Key Engineering Challenges & Solutions

### 1. Laminate-Thickness Compensation

- **Problem:** The nose cone was manufactured using three overlapping biaxial fiberglass sleeves. As the sleeves conformed to the changing diameter of the tangent-ogive, the combined laminate buildup varied along the axial length. If the PETG mandrel were modeled directly to the required finished outer profile, the added fiberglass thickness would make the cured nose cone locally oversized.

- **Solution:** Divided the 380 mm tangent-ogive into 20 mm axial stations and estimated the combined local laminate thickness of the overlapping fiberglass sleeves at each location. The mandrel radius was then offset inward according to:

  $$R_{\text{mandrel}}(x)=R_{\text{outer}}(x)-t_{\text{laminate}}(x)$$

  where $R_{\text{outer}}(x)$ is the required finished nose-cone radius and $t_{\text{laminate}}(x)$ is the predicted local composite thickness. This produced a compensated tooling profile intended to build back outward toward the required tangent-ogive geometry after layup and cure.

> **Analysis Data:** Station-by-station tooling calculations are available in [`Rocket data.xlsx`](./Rocket%20data.xlsx).


### 2. Tooling Design for Vacuum Infusion (DFAM)

- **Problem:** FDM-printed tooling can leak through inter-layer porosity under vacuum, while insufficiently supported printed structures can deform under atmospheric pressure during vacuum infusion.

- **Solution:** Designed the segmented PETG tooling for manufacturability and adjusted print settings to provide sufficient wall thickness and internal support for vacuum loading. The printed surfaces were then filled, sanded, and sealed with epoxy barrier coats to reduce porosity and improve the composite surface finish.

---

## Technical Documentation & Validation

- **Laminate-Compensation Schedule:** Developed a station-by-station analysis relating the required finished outer radius, predicted local laminate buildup, and compensated mandrel radius at 20 mm axial intervals.
- **Airframe Interface:** Checked the tooling and predicted composite geometry against the required nose-cone/base interface dimensions before manufacturing.
- **Manufacturing Validation:** Successfully manufactured the fiberglass nose cone over the compensated PETG tooling and verified that the finished component achieved the required overall profile and airframe-interface fit.
- **Vacuum Integrity & Surface Preparation:** Post-processed the PETG mandrel using filler, progressive sanding, and epoxy barrier coats to reduce FDM surface roughness and seal print porosity prior to infusion.

--- 

<div align="center">

<br>

| Finished Nose Cone (Standing) | Finished Nose Cone (Side View) |
| :---: | :---: |
| <img src="../images/Rocket-Nose-Cone-Real-Standing.png" height="400" /> | <img src="../images/Rocket-Nose-Cone-Real-Side.png" height="400" /> |

</div>

---

## Manufacturing Sequence & Quick Start Guide

1. **Tooling Fabrication:** Print `UBC Rocket Nose Cone Mold.stl` in PETG with a high perimeter count to withstand vacuum pressure.
2. **Tooling Post-Processing:** Sand the mold smooth to remove FDM layer lines, apply body filler where needed, buff between coats, and finish with a resin barrier coat for an airtight, non-stick surface.
3. **Material Prep:** Cut the biaxial fiberglass sleeving to length.
4. **Dry Layup & Bagging:**
   * Apply release film to the mold so the part doesn't stick.
   * Install the biaxial fiberglass sleeves over the compensated mandrel in the 3" → 4" → 3" sequence, conforming each layer to the tangent-ogive surface.
   * Apply peel ply, flow mesh, and spiral tubing for resin feed and vacuum catch.
   * Seal the assembly in a vacuum bag with tacky tape.
   * Pull a full vacuum and check for a leak-free envelope.
5. **Vacuum Infusion:** Mix the epoxy resin system, then open the feed line and let atmospheric pressure drive resin through the fiberglass matrix until fully wetted out.
6. **Demolding:** Let the part cure fully per the resin datasheet, then remove it from the mold (sliding it off directly if possible, or heating the mold until it releases the part if not).

---

## Future Improvements

- **Split Tooling Architecture:** Develop a multi-piece split mold or mandrel with positive indexing features to simplify demolding and improve repeatability between manufactured parts.
- **Dimensional Validation:** Measure the cured nose-cone profile at the same axial stations used in the tooling analysis and compare the measured radii against the predicted finished geometry.
- **Refined Laminate Model:** Replace the initial thickness estimates with measured cured-ply thickness data from representative infused specimens to improve the accuracy of the mandrel compensation model.
- **Controlled Cure Cycle:** Evaluate a controlled post-cure cycle in accordance with the resin manufacturer's recommendations to improve cure consistency and thermal performance.

---

## Directory Structure

[**Rocket-Nose-Cone/**](./)<br>
├── [`README.md`](./README.md) — This documentation file<br>
├── [`Rocket data.xlsx`](./Rocket%20data.xlsx) — Station-based laminate-thickness and mandrel-compensation analysis<br>
└── [**CAD/**](./CAD/)<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`UBC Rocket Nose Cone Mold.f3d`](./CAD/UBC%20Rocket%20Nose%20Cone%20Mold.f3d) — Native Fusion 360 master CAD model<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`UBC Rocket Nose Cone Mold - lower.f3d`](./CAD/UBC%20Rocket%20Nose%20Cone%20Mold%20-%20lower.f3d) — Lower mold section<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`UBC Rocket Nose Cone Mold - middle.f3d`](./CAD/UBC%20Rocket%20Nose%20Cone%20Mold%20-%20middle.f3d) — Middle mold section<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`UBC Rocket Nose Cone Mold - upper.f3d`](./CAD/UBC%20Rocket%20Nose%20Cone%20Mold%20-%20upper.f3d) — Upper mold section<br>
&nbsp;&nbsp;&nbsp;&nbsp;├── [`UBC Rocket Nose cone plug.f3d`](./CAD/UBC%20Rocket%20Nose%20cone%20plug.f3d) — Nose cone plug model<br>
&nbsp;&nbsp;&nbsp;&nbsp;└── [`UBC Rocket Nose Cone Mold.stl`](./CAD/UBC%20Rocket%20Nose%20Cone%20Mold.stl) — Exported mold geometry