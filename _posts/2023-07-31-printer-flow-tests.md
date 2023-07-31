---
layout: default
title: 3D Printer Volumetric Flow Measurements
date: 2023-07-24 20:45:00 +0800
tags:
- 3d printing
---

# Purpose
- Evaluate the real world performance of currently fitted copper plated 0.4mm nozzle on Dragon HF hotend
- Test new 0.4mm Bondtech CHT nozzle and quantify any improvement instead of continuing to guess at maximum volumetric flow rates

# References
- [Ellis's Determining Maximum Volumetric Flow Rate](https://ellis3dp.com/Print-Tuning-Guide/articles/determining_max_volumetric_flow_rate.html)

# Method
- Klipper UI Extuder section used to determine volumetric flow rate for a given feedrate
- To test existing nozzle followed by new nozzle

# Actions

## Phaetus 0.4mm Nickel Plated Copper Nozzle
- Test 0.4mm copper plated nozzle that came with Dragon HF hotend
- In each case the following values were used
  - Pressure Advance of 0.035s
  - Smooth Time of 0.04s
  - Filamen Length of 100mm

| Temperature (°C) | Feedrate (mm/s) | Flow Rate (mm³/s) | Actual Extrusion Distance (mm/%) |
| - | - | - | - |
| 240 | 4 | 9.6 | 100 |
| 240 | 5 | 12  | 100 |
| 240 | 7 | 16.8 | 99 |
| 240 | 8 | 19.2 | 98 |
| 240 | 8.5 | 20.4 | 96 |
| 240 | 9 | 21.6 | 85* |
| 250 | 8 | 19.2 | 98 |
| 250 | 8.5 | 20.4 | 99 |
| 250 | 9 | 21.6 | 96 |
| 250 | 9 | 21.6 | 96 |
| 260 | 9 | 21.6 | 98 |
| 260 | 9.5 | 22.9 | 98 |
| 260 | 9.75 | 23.5 | 94* |

- * Denotes extruder clicking (skipping)
- Max volumetric flow at 240°C is 19mm³/s, less than the 21 I had believed to be the case given Ellis quoting 25mm³/s for a Dragon HF hotend as I have
- Max volumetric flow at 260°C is 22mm³/s, which gives more weight to temperature than I had expected

## Bondtech CHT 0.4mm Nickel Plated Brass Nozzle
- OG CHT series nozzle (BTB subsequent hardened or copper cored in existence)
- In each case the following values were used
  - Pressure Advance of 0.035s
  - Smooth Time of 0.04s
  - Filamen Length of 100mm

| Temperature (°C) | Feedrate (mm/s) | Flow Rate (mm³/s) | Actual Extrusion Distance (mm/%) |
| - | - | - | - |
| 240 | 9.75 | 23.5 | 99 |
| 240 | 10 | 24.1 | 97 |
| 250 | 10 | 24.1 | 98 |
| 250 | 10.4 | 25 | 98 |
| 250 | 11 | 26.5 | 94 |
| 260 | 10.4 | 25 | 99 |
| 260 | 10.4 | 25 | 99 |
| 260 | 10.8 | 26 | 99 |
| 260 | 11 | 26.5 | 99 |
| 260 | 11.21 | 27 | 97 |
| 260 | 11.45 | 27.5 | 96* |
| 260 | 11.65 | 28 | 94* |
| 260 | 12.05 | 29 | 98** |
| 260 | 12.46 | 30 | 98** |

- * Denotes extruder gears clicking (skipping)
- ** Denotes highly irregular 'wiggly' extrusions, as well as extruder gears clicking (skipping)

# Reflections

- CHT increases max volumetric flow noticably
  - At 240°C from 19mm³/s to 24mm³/s, which is a 26% improvement
  - At 250°C from 21mm³/s to 25mm³/s, which is a 19% improvement
  - At 260°C from 22mm³/s to 26.5mm³/s, which is a 20% improvement
- Overall the 0.4mm CHT nozzle is 20% faster than the nickel plated copper nozzle

