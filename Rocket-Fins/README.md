# Composite Fin-Can — Symmetric Stacking & Vacuum Infusion

A continuous carbon-fiber wrap-around fin for Cloudburst, a 32,000 ft apogee rocket developed by the UBC Rocket design team and flown at the Spaceport America Cup (IREC) and Launch Canada. Manufactured via vacuum-infused quasi-isotropic carbon fabric layup, this fin-can is designed to easily survive peak dynamic pressure at Mach 2.05 with a flutter velocity of Mach 3.445. 

Unlike bolt-on fins, this geometry relies on structural continuity and epoxy. Each mold produces one continuous piece — a flat fin section, transitioning into a curved wrap section matched to the body tube radius, terminating in another flat section. Adjacent fins are epoxied to one another and curved sections are epoxied to the rocket body, forming a continuous tip-to-tip wrap-around fin-can.

<p align="center">
	<img src="./Individual_Fins.png" alt="Demolded individual composite fin sections" width="48%" />
	<img src="./Attached_Fins.png" alt="Integrated composite fin-can" width="48%" />
</p>

---

## Bill of Materials (BOM) & Technical Specifications

*   **Reinforcement:** QISO-275-52 Quasi-Isotropic Triaxial Carbon Fabric — Hexcel AS4C-GP 3K/6K, balanced 0°/±60° braid, 272 GSM. 
*   **Matrix:** Aeropoxy PR2032/PH3663 two-part epoxy infusion system. Features a 440 cps mixed viscosity and a 90-minute pot life.
*   **Consumables:** Peel ply, flow media mesh, vacuum bagging film, tacky tape, spiral tubing.
*   **Manufacturer Limits (55% $V_f$):** ~107 ksi 0° tensile, ~85 ksi 0° compressive, ~47 ksi in-plane shear.
*   **Dimensions:** 30.00 cm root chord, 3.55 cm tip chord, 10.00 cm span, 0.65cm thickness
*   **Achieved Fiber Volume Fraction:** Estimated at ~50%. This was calculated analytically using the part thickness, material density, ply count, and areal weight, indicating a highly efficient infusion with minimal excess resin.

---

## Reference: Flutter Margin & Ply Determination 

**Note: The following flutter velocity analysis (Martin's method, NACA TN 4917) was supplied by our design managers as the structural target this fin was designed against. Our sub-team did not independently calculate or validate these numbers; they are included here strictly as a reference for the stiffness requirement the ply schedule was built to meet.** 

Using this provided flutter data, we compared the current numbers to previous years' flutter data to determine the optimal ply count and orientation, establishing an initial 9-ply stacking count.

*   **Predicted Max Velocity:** 696.0 m/s at 3,131.5 m AGL (Mach 2.05)
*   **Flutter Velocity ($V_f$):** 1181.72 m/s
*   **Safety Margin:** 485.7 m/s (69.8%)

*   **Validation Approach:** Because the manufactured fin-can passed rigorous visual inspection for defects or voids, and the calculated safety margin was exceptionally high (69.8%), physical static load testing was bypassed. Historical flight data utilizing this safety factor provided sufficient confidence in the structural integrity of the fins.

*(The raw calculation file `Flutter_Reference.xlsx` is included in the directory for reference.)*

---

## Defect Resolution: Thermal-Mechanical Warping

Our sub-team designed and manufactured the first 12" square test panel using the calculated 9 plies of QISO fabric. After curing, the panel emerged from the mold warped: a straightedge placed against a leveled reference surface revealed ~20mm of out-of-plane deviation, with the panel cured into a saddle shape. I independently led the defect investigation and resolution described below.

*   **Root Cause Diagnosis (my work):** I reviewed the as-built schedule against the stacking sequence and identified that it was not symmetric about the midplane. This asymmetric layup produced non-zero bending-extension coupling (the $[B]$ matrix terms). As the laminate cooled from its 150°F post-cure, this coupling drove the residual curvature that caused the warp.
*   **Implemented Fix (my work):** I revised the schedule to alternate the ply orientation (0°/45°) symmetrically about the midplane across all 9 layers. Because each ply of the triaxial fabric is already quasi-isotropic on its own, alternating the reference angle enforced symmetry without changing the target in-plane stiffness.
*   **Verification (my work):** Our sub-team manufactured a subsequent test panel using the revised symmetrical schedule, and I verified the result. It cured practically flat, displaying near-zero measured deviation.

---

## Manufacturing Process (Vacuum Infusion)

The final production components were manufactured using a pre-form cuting, vacuum bagging, resin infusion, and demolding workflow:

<p align="center">
	<img src="./Fin_Infusion.gif" alt="Vacuum infusion process for the composite fin" width="80%" />
</p>

1.  **Tool Prep:** Apply lower vacuum bagging to mold to act as release agent and to properly seal the part under vacuum.
2.  **Layup:** Cut 9 plies of QISO fabric per mold half and stack in the symmetric 0°/45° alternating orientation.
3.  **Bagging:** Apply peel ply, flow media, and spiral tubing with matching curved connectors. Seal the assembly with tacky tape and vacuum bag, pull to -29 inHg, and drop-test for a leak-free envelope.
4.  **Infusion:** Mix the Aeropoxy PR2032/PH3663, let it sit in vacuum to release caught air in mixture, open the feed line, and let the resin wet out the part.
5.  **Cure:** 24 hours at room temperature.
6.  **Assembly:** Demold, trim the flash, and check for defects such as voids and under/over cure. Check surface roughness and perform wet sanding followed by a clear coat to minimize drag. To prepare for structural integration, scuff the bonding surfaces with 120-grit sandpaper and wipe thoroughly with acetone. Finally, use the standard infusion epoxy to bond the curved bases to the airframe and the flat fin segments to one another so adjacent sections form the continuous fin-can hoop.

---

## Health & Safety Controls

*   **Particular Hazards:** Wet-sanding was strictly utilized to mitigate airborne carbon fiber dust. Appropriate particulate respirators were required during any dry trimming or edge profiling.
*   **Chemical Hazards:** Nitrile gloves were worn during all resin mixing and handling. Vapor PPE was utilized during the application of the clear coat to protect against solvent exposure in a well-ventilated space.
*   **Environemental Controls:** As a student design team, the infusion was performed under ambient shop conditions without strict climate or humidity controls. Because temperature variations dictate pot life and viscosity, visual monitoring of the epoxy during the wet-out phase was critical.

---

## Future Improvements

To avoid similar defects and improve the composites layup workflow in future iterations, the following standard practices should be implemented:

*   **Standard Symmetry Check:** Formalize a stacking-sequence review step before any new ply schedule goes to production layup, based directly on the warping defect encountered during this build.
*   **Repeatable Warp Measurement:** Use a dial indicator across the span instead of a visual/straightedge check for higher precision.
*   **Exotherm Tracking:** Utilize a dedicated cure oven equipped with thermocouple logging to track the composite exotherming process in real-time, allowing us to manage internal resin temperatures during thicker layups, prevent thermal degradation or runaway exothermic reactions and to get a more precise fiber volume fraction allowing higher strength-weight.

---

## Directory Structure

[**Rocket-Fins/**](./)<br>
├── [`README.md`](./README.md) — Technical documentation and aerostructural analysis<br>
├── [`Attached_Fins.png`](./Attached_Fins.png) — Photo of the final integrated composite fin-can<br>
├── [`Fin_Infusion.gif`](./Fin_Infusion.gif) — Timelapse/demo of the vacuum infusion process<br>
├── [`Individual_Fins.png`](./Individual_Fins.png) — Photo of demolded individual fin sections prior to integration<br>
└── [`Fin Flutter Calc Copy.xlsx`](./Fin%20Flutter%20Calc%20Copy.xlsx) — Flutter margin calculation, provided by design managers