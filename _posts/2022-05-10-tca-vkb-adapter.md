---
layout: default
title: TCA VKB Adapter
date: 2022-05-10 17:00:00 +0800
tags:
- 3d printing
---

# Purpose
- Design an adapter to mount the VKB [GNX Front Switchboard Module – General Aviation (FSM-GA)](https://vkb-sim.com.au/collections/gnx-extension-modules-coming-soon/products/gnx-front-switchboard-module-general-aviation-fsm-ga) onto my self-designed [TCA Accessory Rail]({{ site.baseurl }}/2022/05/03/2022-05-03-tca-accessory-rail.html), which mounts onto the throttle quadrant of a [TCA Captain Pack Airbus Edition](https://www.thrustmaster.com/en-us/products/tca-captain-pack-airbus-edition/)

# References
- [Part 1: TCA Accessory Rail]({{ site.baseurl }}/2022/05/03/tca-accessory-rail.html)
- [**TinkerCAD: tca-vkb-adapter**](https://www.tinkercad.com/things/7TcH2VKYLfw)
- [**Printables: Thrustamaster TCA VKB FSM-GA Adapter**](https://www.printables.com/model/201633-thrustamaster-tca-vkb-fsm-ga-adapter)

# Design Files
- [tca-vkb-adapter](/assets/stl/2022-05-10-tca-vkb-adapter.stl)

# Actions

## V1

- Created a plug shape to fit into the socket of the accessory rail
- Added a 22.5° angle to (inadvertently) match the angle of the throttle at TO/GA
- Identified that the back of the FSM-GA had M3 screw holes recessed slightly
- Measured width of FSM-GA screw holes and width of accessory rail sockets to determine how far in from accessory rail socket the screw holes needed to be
- Iterated a few prototypes to nail down vertical spacing of screw holes
- Added 4mm holes in adapter for heat-set nuts
- Printed prototypes noticing easy fit of the plug for the accessory rail socket
- Inserted heat-set nuts and noticed that this made it difficult to pull the FSM-GA to the adapter
- Noticed that this version was very far away from the throttle quadrant, looking a bit odd and exacerbating wobble

##  V2
- Reduced length of adapter to be closer and in doing so reduce wobble
- Increased length of heat-set purchase area
- Reprinted
- Inserted heat-set nuts
- Was not able to attach the adapter to the FSM-GA
- Noticed that the heat-set nuts, being threaded, prevented the adapter from being pulled closer
- Tried drilling out the threading on the heat-set nuts but this heated up the heat-set nuts and caused them to pop out of the adapter, leaving a hole too big for just the M3 screws
- Reprinted again

## V3

- 3.5mm hole for M3 screws
- Shortened to be closer to the throttle quadrant
- No heat-set nuts
- *Print settings *
  - 0.8 nozzle
  - 0.55mm layer height
  - 4 vertical walls
  - 20% gyroid infill
  - 2 bottom and 2 top walls
- This worked perfectly

# Reflections
- Heat-set nuts in my adapter and the existing FSM-GA heat-set nuts didn't play well together as I was unable to get tension between the parts, owing to the threading they always remained a set distance apart
- PLA just bends a bit at this sort of distance, adding vertical walls didn't improve stiffness much, would have to use a stiffer plastic to aleviate this, like the original VKB adapter which is ABS or similar
- Overall very happy with the result
- Would be nice to incorporate some further cable management or room for a USB hub at the back of the quadrant to neaten the whole thing up

# Pictures
![tca-vkb-adapter](/assets/img/2022-05-10-tca-vkb-adapter.jpg)