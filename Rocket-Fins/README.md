# Composite Fin-Can — Symmetric Stacking, Vacuum Infusion & Laminate Validation

A continuous carbon-fiber wrap-around fin-can for **Cloudburst**, a 32,000 ft apogee rocket developed by the UBC Rocket design team and flown at the Spaceport America Cup (IREC) and Launch Canada.

The fin-can was manufactured to a team-provided structural target corresponding to a predicted maximum vehicle velocity of **Mach 2.05** and a predicted flutter velocity of **Mach 3.445**. The manufacturing process used vacuum-infused quasi-isotropic carbon fabric with a 9-ply laminate schedule.

During development, an initial test panel exhibited significant cure-induced warping. I independently led the defect investigation, identified the asymmetric stacking sequence as the primary controllable cause, revised the laminate schedule to be symmetric about the midplane, and verified the improvement through a second panel.

**Project Context & Contribution:** Developed as part of the UBC Rocket design team. I was directly involved in the broader composite manufacturing and testing workflow with the sub-team, including layup preparation, vacuum bagging, resin infusion, post-processing, integration, and representative laminate testing. I independently led the laminate-warp investigation and stacking-sequence redesign.

Unlike conventional bolt-on fins, each molded section forms one continuous composite piece: a flat fin surface transitions into a curved section matched to the airframe radius and terminates in another flat section. Adjacent sections are bonded together and to the airframe, producing a continuous wrap-around fin-can structure.

<p align="center">
  <img src="./Individual_Fins.png" alt="Demolded individual composite fin sections" height="350" />
  <img src="./Attached_Fins.png" alt="Integrated composite fin-can" height="350" />
</p>

---

## Materials & Technical Specifications

* **Reinforcement:** QISO-275-52 quasi-isotropic triaxial carbon fabric — Hexcel AS4C-GP 3K/6K, balanced 0°/±60° braid, 272 GSM
* **Matrix:** Aeropoxy PR2032/PH3663 two-part epoxy infusion system
* **Mixed Resin Viscosity:** Approximately 440 cps
* **Pot Life:** Approximately 90 minutes
* **Laminate Schedule:** 9 plies
* **Consumables:** Peel ply, flow media, vacuum bagging film, tacky tape, and spiral tubing
* **Fin Dimensions:**

  * Root chord: 30.00 cm
  * Tip chord: 3.55 cm
  * Span: 10.00 cm
  * Nominal thickness: 0.65 cm
* **Estimated Fiber Volume Fraction:** Approximately 50%

The fiber volume fraction was estimated analytically using the finished laminate geometry, ply count, reinforcement areal weight, and material density. It should therefore be treated as an engineering estimate rather than a direct material-characterization measurement.

---

## Structural Design Reference & Ply Selection

> **Important:** The following flutter analysis was supplied by UBC Rocket design managers as the structural target for the fin-can. I did not independently calculate the vehicle-level flutter values. They are included here to document the design requirements that informed the laminate.

The supplied flutter analysis used **Martin's method** to establish the expected aeroelastic operating margin.

* **Predicted Maximum Velocity:** 696.0 m/s at 3,131.5 m AGL — approximately Mach 2.05
* **Predicted Flutter Velocity:** 1181.72 m/s — approximately Mach 3.445
* **Predicted Velocity Margin:** 485.7 m/s — approximately 69.8%

Using this team-provided analysis together with previous-year fin designs, prior flight experience, and manufacturing constraints, our sub-team selected a **9-ply laminate schedule**.

The goal was to provide sufficient stiffness for the intended flight envelope while retaining a practical laminate thickness and a layup that could be manufactured consistently through vacuum infusion.

> **Reference Calculation:** The supplied flutter workbook is included as [`Fin Flutter Calc Copy.xlsx`](./Fin%20Flutter%20Calc%20Copy.xlsx).

---

## Defect Investigation — Cure-Induced Laminate Warping

The first manufacturing trial used a **12-inch square, 9-ply carbon-fiber test panel**.

After cure and post-cure, the panel exhibited approximately **20 mm of out-of-plane deformation** when placed against a leveled reference surface. The panel had cured into a pronounced saddle shape.

I independently led the investigation and corrective work described below.

### 1. Root-Cause Investigation

I compared the as-built laminate schedule against the intended ply orientations and identified that the sequence was **not symmetric about the laminate midplane**.

An asymmetric laminate can exhibit bending-extension coupling represented by non-zero terms in the laminate **[B] matrix**. During cure and subsequent cooling, thermal expansion mismatch, resin shrinkage, and laminate coupling can contribute to residual curvature.

Although tooling and cure conditions can also influence distortion, the asymmetric stacking sequence was the clearest controllable design variable associated with the observed panel warp.

### 2. Revised Stacking Sequence

I redesigned the 9-ply schedule to be symmetric about the laminate midplane.

Because each QISO ply already contains balanced **0°/±60° fibers**, the fabric reference direction was alternated between **0° and 45°**, then mirrored through the thickness to preserve laminate symmetry.

This retained the intended quasi-isotropic reinforcement characteristics while eliminating the asymmetric through-thickness sequence.

### 3. Verification

Our sub-team manufactured a second test panel using the revised symmetric schedule.

Using the same reference-surface and straightedge inspection method, the follow-up panel showed **no meaningful visible out-of-plane deviation** compared with the approximately 20 mm deformation of the original panel.

This provided practical confirmation that the stacking-sequence revision addressed the dominant source of the original warping defect.

---

## Representative Laminate Testing & Validation

To supplement the team-provided flutter analysis with physical material data, our sub-team manufactured a **flat 9-ply carbon-fiber specimen representative of the laminate used in the flat portion of the fin** and tested it under **ASTM D3039 axial tension**.

### Tensile Test Results

| Property                         | Measured Result |
| :------------------------------- | --------------: |
| Specimen Width                   |        25.40 mm |
| Specimen Thickness               |         4.57 mm |
| Cross-Sectional Area             |         116 mm² |
| Gauge Length                     |          150 mm |
| Ultimate Tensile Strength        |     **572 MPa** |
| Reported Ultimate Tensile Strain |       **4.90%** |

The specimen was loaded axially to failure and reached **572 MPa ultimate tensile strength**. Because strain was derived from machine displacement rather than a dedicated extensometer, the strength result is treated as the more reliable comparison metric.

### Comparison with Manufacturer Reference

The manufacturer's reference tensile strength was approximately **738 MPa (107 ksi)** at **55% fiber volume fraction**, while our laminate was estimated at approximately **50% \(V_f\)**.

Our measured strength therefore reached approximately:

$$
\frac{572}{738}\times100 \approx 77.5\%
$$

of the published reference value.

This is not a direct one-to-one comparison because fiber volume fraction, cure conditions, void content, specimen preparation, and manufacturing method differ between the reference laminate and our manufactured part. However, the result showed that our laminate retained a substantial portion of the expected tensile capability of the material system and did not perform drastically below the properties used to inform the design process.

### Overall Validation

The fin design was supported by several complementary forms of evidence:

* **Flutter analysis:** Predicted **Mach 3.445 flutter velocity** versus **Mach 2.05 maximum flight velocity**, corresponding to a **69.8% predicted velocity margin**.
* **Physical laminate testing:** The representative 9-ply coupon reached **572 MPa ultimate tensile strength**.
* **Manufacturer comparison:** The measured strength was approximately **77.5% of the published 738 MPa reference value**, despite the lower estimated fiber volume fraction.
* **Previous UBC Rocket experience:** The laminate design was informed by previous-year fin configurations and prior flight/manufacturing experience.
* **Manufacturing validation:** Production parts were inspected for dry reinforcement, visible voids, resin-rich regions, surface defects, abnormal distortion, and incomplete cure. The revised symmetric laminate also eliminated the approximately **20 mm warp** observed in the original test panel.

Taken together, these results gave our sub-team confidence that the manufactured fins were consistent with the expected structural performance for the intended flight conditions.

### Validation Boundary

The tensile test and flutter analysis validate **different aspects of the design**.

The flutter model addresses **aeroelastic stability**, while the ASTM D3039 test measures the **axial tensile strength of the manufactured laminate**. The 572 MPa tensile result therefore cannot be directly compared with the Mach 3.445 flutter velocity.

A more complete structural validation would compare the measured laminate strength against the **maximum predicted fin stress during flight** and would ideally include a full-scale fin or fin-can load test covering the curved sections, bonded interfaces, and fin-to-airframe load path.

---

## Manufacturing Process — Vacuum Infusion

The final production components were manufactured collaboratively by our UBC Rocket sub-team using pre-form cutting, vacuum bagging, resin infusion, curing, finishing, and structural integration.

<p align="center">
  <img src="./Fin_Infusion.gif" alt="Vacuum infusion process for the composite fin" width="80%" />
</p>

### 1. Tool Preparation

Prepare and seal the mold surface and apply the appropriate release system before layup.

The mold and bagging surfaces are inspected for contamination, surface defects, and potential leak paths before composite material is introduced.

### 2. Ply Preparation & Layup

Cut **9 plies of QISO fabric per mold half** and stack them according to the revised symmetric schedule.

Fabric reference orientations are alternated between 0° and 45° while maintaining symmetry about the laminate midplane.

Care is taken to preserve fiber orientation and avoid wrinkles, folds, or local bridging during placement.

### 3. Vacuum Bagging

Apply:

* Peel ply
* Flow media
* Spiral tubing
* Resin-feed lines
* Vacuum lines
* Vacuum bagging film
* Tacky-tape perimeter seal

The completed bag is evacuated to approximately **-29 inHg**.

The vacuum line is then isolated and monitored for pressure decay to identify significant leaks before infusion.

### 4. Resin Preparation & Infusion

Mix the Aeropoxy PR2032/PH3663 resin system according to the required ratio.

The mixed resin is vacuum-degassed before infusion to reduce entrained air.

Once stable vacuum is established, the feed line is opened and the pressure differential draws resin through the flow media and reinforcement.

The wet-out front is visually monitored throughout the infusion to identify dry regions, race tracking, or abnormal resin flow.

### 5. Cure

Allow the laminate to cure for approximately **24 hours at room temperature** before demolding and subsequent processing.

### 6. Demolding & Inspection

After cure:

* Remove the vacuum bagging materials
* Demold the composite section
* Trim excess flash
* Inspect for visible voids, dry regions, surface defects, and incomplete cure
* Check the resulting geometry for abnormal warping or distortion

### 7. Surface Finishing & Airframe Integration

Wet-sand the composite surfaces where required to reduce surface roughness while controlling airborne carbon dust.

Before structural bonding:

* Abrade bonding surfaces with approximately **120-grit sandpaper**
* Clean prepared surfaces with acetone
* Apply the specified epoxy bonding system

The curved base sections are bonded to the airframe while neighboring flat fin segments are bonded together, producing the continuous wrap-around fin-can structure.

---

## Health & Safety Controls

Composite manufacturing involves both carbon-fiber particulate hazards and chemical exposure.

* **Carbon Fiber Dust:** Wet sanding was used wherever practical to minimize airborne conductive carbon dust. Appropriate particulate PPE was used during dry cutting, trimming, or profiling.
* **Resin Handling:** Nitrile gloves were used while mixing and handling epoxy.
* **Solvent / Coating Exposure:** Appropriate ventilation and PPE were used during acetone cleaning and clear-coat application.
* **Shop Conditions:** Infusion was performed under ambient student-shop conditions rather than tightly controlled industrial temperature and humidity conditions. Resin behavior and wet-out progression were therefore monitored throughout the process.

---

## Future Improvements

* **Full-Scale Structural Test:** Develop a representative fin-load fixture to test the complete fin geometry, including the curved wrap and bonded interfaces.
* **Flight-Load Stress Correlation:** Determine the maximum predicted laminate stress during the flight envelope and compare it directly against the measured **572 MPa tensile strength** to calculate a physical factor of safety.
* **Additional Tensile Coupons:** Test multiple specimens from the production laminate to quantify sample-to-sample variation and improve statistical confidence.
* **In-Plane Shear Testing:** Perform a dedicated composite shear test to characterize shear response and obtain data more directly relevant to torsional stiffness.
* **Elastic Modulus Measurement:** Repeat tensile testing with an extensometer or strain gauges to obtain a more reliable laminate modulus for comparison against structural and flutter-model assumptions.
* **Quantitative Warp Measurement:** Replace the straightedge inspection with a dial indicator or height-gauge measurement across a fixed surface plate.
* **Formal Laminate Symmetry Review:** Add a mandatory stacking-sequence symmetry check before any new laminate schedule is released for manufacturing.
* **Cure Temperature Monitoring:** Use thermocouples during cure to record laminate temperature and identify unexpected exothermic behavior.
* **Fiber Volume Fraction Characterization:** Record laminate mass, thickness, and cured geometry systematically—or use destructive coupon testing—to improve confidence in the estimated fiber volume fraction.
* **Process Documentation:** Record vacuum decay, resin mass, ambient temperature, infusion time, and wet-out duration for each production run.

---

## Directory Structure

[**Rocket-Fins/**](./)<br>
├── [`README.md`](./README.md) — Technical documentation, manufacturing process, defect investigation, and validation<br>
├── [`Attached_Fins.png`](./Attached_Fins.png) — Final integrated composite fin-can<br>
├── [`Fin_Infusion.gif`](./Fin_Infusion.gif) — Vacuum-infusion process demonstration<br>
├── [`Individual_Fins.png`](./Individual_Fins.png) — Demolded composite fin sections before integration<br>
├── [`Fin Flutter Calc Copy.xlsx`](./Fin%20Flutter%20Calc%20Copy.xlsx) — Team-provided flutter-analysis reference workbook<br>
└── [`UBC Rocket Tensile_1_1_1.csv`](./Test%20Data/UBC%20Rocket%20Tensile_1_1_1.csv) — Raw representative-laminate ASTM D3039 tensile-test output
