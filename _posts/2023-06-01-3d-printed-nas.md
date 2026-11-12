 ---
layout: default
title: 3D Printed NAS
date: 2023-06-01 09:00:00 +0800
tags:
- 3d printing
---

# Purpose
- A new home for my Unraid OS USB and backup 3.5" HDDs, as their current home was being reinstated as a gaming computer

# References
## MASS
- [MASS - Stackable NAS ITX Enclosure (official page)](https://modcase.com.au/products/nas)
- [Reddit post by creator of MASS](https://www.reddit.com/r/sffpc/comments/115y2dk/free_modular_nas_enclosure_stackable_drive/)
- [Reddit post of a user building the premium model](https://www.reddit.com/r/sffpc/comments/1371v7u/mass_premium_stackable_nas_itx_enclosure_printed/)
- [Imgur listing of a build using CF-PETG](https://imgur.com/a/HigwgoS/)

##MK735
- [Official sale listing on MyMiniFactory](https://www.myminifactory.com/object/3d-print-mk735-mini-server-nas-chassis-96113)
- [Blog post introducing it](https://blog.briancmoses.com/2019/03/what-about-a-3d-printed-mini-itx-nas-case.html?r=related)
- [Blog post of build](https://blog.briancmoses.com/2019/06/printing-and-assembling-the-mk735-a-3d-printed-diy-nas-case.html)
- [Official website of the MK735](https://3dwebe.com/mk735/)

# Actions

#Planning
- Purchased 2nd hand PC parts from Gumtree to keep electronic costs to a minimum

### 2nd Hand PC Parts from Gumtree
- Intel G10215-204 motherboard with IO shield
- Intel Core i3 2120 CPU
- 4GB DDR3 RAM
- PSU
- Miscellaneous SATA cables

## Enclosure Selection
- Purchased MASS premium
- Printed MASS parts
- Discovered that MASS does not fit an ATX power supply
- Checked and unable to find any second hand SFX, SFX-L or Flex ATX PSUs, too expensive new and no cases with power supplies that could substitute
- Switched to MK735 and purchased it as it was cheaper than changing power supplies

## Test Objects
- Printed test objects
- 150mm x 150mm object came out at about 149.2, so added `Filament Settings / Shrinkage (XY compensation)` of `99.5%`
- Subsequent 150mm x 150mm object came out at 150mm x 150mm
- Print-in-place hinge did not work properly and broke when attempting to loosen the spindle, appeared not enough clearance between halves of the hinge
- Reduced hinge `Filament Settings / Extrusion Multiplier` from `0.97` to `0.92`, subsequent hinge worked correctly

## Warping
- Both large objects such as `111-0-0-drive-chamber` and `110-1-0-power-supply-chamber-vented-2.stl` rather relentlessly and substantially warped (>2mm) to the point of being unlikely to fit the top plate
- Tried:
    - Increased temps 240->250 and 110-120
    - Increased chamber max temp from 55->60
- No change.
- Reduced print speed factor to 50% (which worked on kitchen scale box) with no effect.
- Bought binder clips and clipped textured PEI sheet to bed, which caused the print to lift from the PEI sheet instead of the PEI sheet from the heated bed i.e. no discernable improvement to the warping problem itself.
- New slice:
    - 10mm brim (to attempt to combat warping directly)
    - Layer height 0.2mm->0.3mm (to reduce print time)
    - Walls 4->3 (MK735 spec)
    - Infill  40%->15% (MK735 spec)
- No success
- Tried again with:
    - Moving the object to the rear of the build plate in case I had a problematic part of the mesh, bed or PEI at that location, since it kept failing on the front right corner.
    - Rotating the part 180 degrees to see if it would lift in the same area of the bed or the same part of the object (now on the left instead of the right side)
    - Upping external brim to 15mm
- Still lifted on the back left side (same as front right before 180 degree spin), suggesting it was a slicing issue
- Tried again with:
    - Seams blocked on all four corners within about 15mm
    - Seams painted/enforced both inside and outside midway on the longest side
      - Hoping the seams also interrupt any perimeters shrinking along their axis on the longest side in case this was what was causing the warping
    - Black Sunlu ABS instead of white, to see if another colour is less warp-y
- No success
- Things that haven't worked so far:
    - Hotend temp increase `240->250`
    - Chamber max temp increase `55->60`
    - Build plate max temp increase `110->120`
    - Reduce print speed to 50%
    - Binder clips on PEI sheet
    - 10mm brim
    - Layer height `02.mm->0.3mm`
    - Rotate part 180 degrees
    - Rotate part 90 degrees
    - 15mm brim
    - 10mm internal brim
    - Seams blocked on corners and enforced in middle of longest side
    - Different colour of filament (same brand)
- Having changed almost everything, realised that MK735 manual called for disabling part cooling fan but likely this advice was for PLA/PETG, not ABS, and that I had done this during test prints subsequent to many successful prints with default part cooling at 15%.
- Tried again with:
    - Default fan speed 0% -> 15%
    - Run the fan at default speed when possible





# Cost Table
- $AUD

| Item Code (SKU) | Description | Price | Shipping | Tax | Net | Running Total |
| - | 2nd Hand PC Parts* | $50 | $0 | $0 | $50 | $50 |
| - | MK735 Design & Files | USD $15.95 | $0 | - | $28.32 | $78.32 |
| - | [50xM3x12mm Self Tapping Screws](https://www.ebay.com.au/itm/374690358357) | $11.79 | $0 | $0 | $11.79 | $90.11 |
| - | [3x 80mm Case Fans Molex 4-pin](https://www.ebay.com.au/itm/114182014870?var=414435972203) | $16.50 | $0 | $0 | $ 16.50 | $106.61 |
| - | [ATX 24-pin extension cable](https://www.ebay.com.au/itm/394457717221) | $9.93 | $0 | $0 | $9.93 | $116.54 |
| - | [ATX 4-pin extension cable](https://www.ebay.com.au/itm/132657430066?var=431988186916) | $4.55 | $0 |$0 | $4.55 | $121.09 |
| - | LSI 9211-8i HBA Pre-Flashed to IT Mode | $109.88 | $0 | $0 | $109.88 | $230.97 |

## Wasted Costs
| Item Code (SKU) | Description | Price | Shipping | Tax | Net | Running Total |
| - | MASS Premium | $40 | $0 | $0 | $40 | $90 |


# Reflections

# Part print costs
- Power Supply Chamber $12.27