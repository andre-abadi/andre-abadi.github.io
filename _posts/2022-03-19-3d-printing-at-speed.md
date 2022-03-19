---
layout: default
title: Reflections on 3D Printing at Speed
date: 2022-03-19 21:00:00 +0800
tags:
- home automation
---

# Purpose
- Reflect on causes of failure in quality of recent prints
- Prints were functional and extremely fast but had cosmetic imperfections that caused dissatisfaction
- Find a better balance between speed and quality

# References
- Hardware
  - [Prusa MK3S+](https://www.prusa3d.com/category/original-prusa-i3-mk3s/)
  - [Delta P Fan Duct V2R2](https://www.prusaprinters.org/prints/62523-delta-p-fan-duct-v2-r2-for-mk3s-extruder)
  - [Trianglelab Dragon HF](https://www.aliexpress.com/item/1005002629698126.html?spm=a2g0o.store_pc_groupList.8148356.3.21d65dafTg5jy1)
  - [Dragon Hotend Adapter](https://www.prusaprinters.org/prints/67418-dragon-hotend-adapter-phaetustrianglelab)
  - [Trianglelab Hardened Steel 0.6mm Nozzle](https://www.aliexpress.com/item/32850756758.html?spm=a2g0o.order_list.0.0.21ef1802k8CR0X)
- Software
  - PrusaSlicer
  - Summary of changes vs `0.4mm DRAFT @0.6 Nozzle MK3`
    | Setting | Modded | Default |
    | --- | --- | --- |
    | Bottom solid layers | 2 | 3 |
    | Minimum bottom shell thickness | 0.7 | 0.6 |
    | Top solid layers | 1 | 4 |
    | Minimum top shell thickness | 0.8 | 0.9|
    | Layer height | 0.5 | 0.4 |
    | Bridge flow ratio | 0.8 | 0.95 |
    | Elephan foot compensation | 0 | 0.2 |
    | External perimeters | 0.55 | 0.68 |
    | Default extrusion width | 0.8 | 0.65 |
    | First layer | 0.6 | 0.65 |
    | Infill | 0.55 | 0.68 |
    | Perimeters | 0.8 | 0.68 |
    | Solid infill | 0.8 | 0.68 |
    | Top solid infill | 0.55 | 0.6 |
    | Max print speed | 500 | 100 |
    | **All** Speeds | 0 | *various* <70 |

# Pictures
![top surface](/assets/img/2022-03-19-3d-printing-at-speed-1.jpg)
![bridges](/assets/img/2022-03-19-3d-printing-at-speed-2.jpg)

# Observations
- Close study of finished print parts follows:
- Parts were pleasingly light in terms of weight expected from a plastic item of their size
  - As compared to previous ones which felt... heavy for their size?
  - The quality of those wasn't great either, so perhaps not a good indicator of quality
- Vertical walls were of good quality
- Layer lines, even on horizontal surfaces, did not cause problems or detract from functionality
- Squeezing larger surface areas by hand resulted in yield not unlike other plastic toys
- Significant stringing visible on smaller parts
- Top layers showed signs of nozzle drag
- Bridging failed quite badly, had to snip off filament that had failed in all directions
  - Fortunately this did not cause the print to fail
- Slightly too much squish on first layer causing first layer too wide
- Consistent areas of holes in top layer (**main concerns**)
  - Occurred on areas with very gradual slop
  - Appears that solid infill collapsed over infill during laying of filament, causing solid infill to never connect with the perimeter walls
- Unable to find a default profile that had much similarity with the modded profile
  - Prusa did release a profile update since modding of the initial profile began

# Reflections
- Speed itself does not appear to be the main problem
- Bridging
  - Appears that outer perimeters were not wide enough to properly make contact with the non-outer perimteres and hence fell off the wall
  - Reducing layer height solved this issue on previous occasions, likely because it meant that the layers were wider than they are tall and hence had more contact area with layer below
  - Insufficient bottom layers caused some holes to remain, where another layer would easily have covered it and made it look a lot better
  - Default profile `0.4mm DRAFT @0.6 Nozzle MK3` has 0.4mm layer  height and 0.68mm external perimeter width, so the width is 1.7x the layer height
  - Custom profile had 0.5mm layer height and 0.55mm external perimeter width, so the width was only 1.1x the layer height
  - Unsurprising that bridging performance is hence reduced, because default profile allows substantially more of the layer width to come into contact with the one below, where custom profile allowed barely any
- Top Surface
  - Insufficient top layers caused any failures not to be covered over
  - Insufficient top layers cause too much reliance on solid infill meeting perimters over 5% rectilinear infill
  - The top solid infill was also the solid infill in many cases
  - This meant that surface finish was relying on a single layer over infill
  - TOp solid infill width of 0.55 (versus 0.6 default) meant that each time the layer line stopped and turned around on the diagnoal, there was even less contact to be made with the perimeter, in addition to only having one layer to get it right
  - Unsure whether to play with minimum shell thickness values as it seems to be more about how many layers rather than a minimum height
    - Suggest overall minimum height would be more of a structural rigidity issue
    - Might not help with covering of gaps

# Outcomes
- Archive custom profile
- Export config
- Delete old profile
- Rebase a new custom profile from a safe default
- Top surface solution
  - Minimum **3** `Bottom solid layers`
  - Minimum **3** `Top solid layers`
- Bridging solution
  - External perimeters minimum **1.5x** layer height
  - **1.7x** layer height probably better
    - At 0.5mm height this would mean external perimeters at 0.85mm