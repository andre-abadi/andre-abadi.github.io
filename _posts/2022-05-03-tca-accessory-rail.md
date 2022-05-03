---
layout: default
title: TCA Accessory Rail
date: 2022-05-03 19:37:00 +0800
tags:
- 3d printing
---

# Purpose
- Mount a VKB [GNX Front Switchboard Module – General Aviation (FSM-GA)](https://vkb-sim.com.au/collections/gnx-extension-modules-coming-soon/products/gnx-front-switchboard-module-general-aviation-fsm-ga) on the throttle quadrant of a [TCA Captain Pack Airbus Edition](https://www.thrustmaster.com/en-us/products/tca-captain-pack-airbus-edition/)
- Not buy a VKB [GNX-MFH (Multi-Functional Holder)](https://vkb-sim.com.au/products/gnx-mfh-multi-functional-holder) because it would look janky sitting next to but not integrated into my setup
- Try using heat-set nuts in a design
- Make a design that could potentially incorporate a desk clamp at some point

# References
- VKB [GNX Front Switchboard Module – General Aviation (FSM-GA)](https://vkb-sim.com.au/collections/gnx-extension-modules-coming-soon/products/gnx-front-switchboard-module-general-aviation-fsm-ga)
  - Also had to buy a [GNX USB Controller (HID-Main)](https://vkb-sim.com.au/collections/gnx-extension-modules-coming-soon/products/gnx-usb-controller-hid-main)
- VKB [GNX-MFH (Multi-Functional Holder)](https://vkb-sim.com.au/products/gnx-mfh-multi-functional-holder)
- Thrustmaster [TCA Captain Pack Airbus Edition](https://www.thrustmaster.com/en-us/products/tca-captain-pack-airbus-edition/)
- [100pcs Thread Knurled Brass Threaded Heat Set Heat Resistant Insert Embedment Nut For 3D Printer](https://www.aliexpress.com/item/4001185849382.html?spm=a2g0o.order_list.0.0.21ef1802UVm33C)
- [**TinkerCAD: tca-accessory-rail**](https://www.tinkercad.com/things/aDb05zaWdzm)
- [**Printables: tca-accessory-rail**](https://www.printables.com/model/191964-tca-accessory-rail)

# Design Files

- [`2022-05-03-tca-accessory-rail.stl`](/assets/stl/2022-05-03-tca-accessory-rail.stl)

# Actions
- Calipers and TinkerCAD
- Numerous (~58) prototypes

## V1
- Started by modelling the screw hole fixtures
- Quickly realised that the *plugs* next to the screw holes were not particularly needed, not sure why Thrustmaster included them in their designs
- Adjusted for slight outward tilt of chassis
- Adjusted for chamfered corners
- Achieved good fitment of both screw holes and mounting *fillets*
- Created a *frame socket* at the top to eventually mount the rest of the frame

## V2
- Adjusted so that the whole rail would sit flush to the desk
- This was so that there was less room for it to bend, in theory because it was effectively at desk level
- Many prototypes of front section to get heights right
- Added a chamfer for screw to sit inside design rather than protrude

## Fastenings
- Most shed screws were either too long or too narrow
- Settled on some standard computer case screws
- These were slightly too wide for the TCA quadrant but bit in well and offered good purchase
- Pulled out packet of M3 heat-sets to attempt incorporating

## V2 Continued
- Happy with
  - Mounting fillet distances
  - Mounting fillet fits
  - Frame socket design
  - Overall size of design
- Continued feathering fillet height so it was flush, taking into account rubber feet of throttle quadrant
- Slightly adjusted chamfer offset to maintain flush fit to side of throttle quadrant chassis
- More prototypes, done by exporting from TinkerCAD and then cutting design down to front mounting fillet and contour around throttle quadrant chassis
- Some trouble with the chamfter and fit of the screw holes
  - Eventually settled on a cone slightly wider and much taller than the hole itself
  - This fitted the 7mm head of the case screw

## Heat Set
- Measured and added holes for heat-set nuts (4mm wide by 6mm deep)
- First time worked a charm, heat set tests worked perfectly

## Printing
- Most prototypes done with *eggshell* profile
  - 0.6 nozzle
  - 0.4mm layers
  - 1 vertical wall
  - 10% gyroid infill
  - 2 top layers
  - 2 bottom layers
- Final design
  - 0.6 nozzle
  - 0.4mm layers
  - 4 vertical wall
  - 15% gyroid infill
  - 3 top layers
  - 3 bottom layers
  - Mirrored an instance along X-axis to create matching pair in PrusaSlicer
  - **Increased printing temp to 225°C to reduce under-extrusion seen at corners after long runs along primary axis**

# Reflections
- Sits 0.25-0.5mm off the table so that the squish of the throttle quadrant's soft rubber feet causes it to *bottom out* but still allow rubber feet to provide grip
- Frame socket design is open ended to enable easy prototyping of the latter part of the holder
- Heat-sets will make it easy (hopefully) to add a desk clamp in future
- Overhanging inset holes (smaller hole above a bigger hole) print very badly
- To remedy the above, a chamfer of less than 45° prints easily but needs some tweaking to give the right diameter at the right height
- 3D printing means iterating this design from haphazard to a closely fitting piece was very enjoyable and had a very encouraging rate of progress
- At such high print speeds (Dragon HF PLA ~ 20mms³) some underextrusion was apparent on corners of rail, increasing temp to 225°C helped and a profile adjustment might be needed
  - Would only be needed when hitting full print speeds, so perhaps on a needs-basis and not to the profile itself

# Pictures
~[tca-accessory-rail-1](/assets/img/2022-05-03-tca-accessory-rail-1.jpg)
