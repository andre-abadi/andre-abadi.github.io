---
layout: default
title: Printer Light
date: 2021-11-01 21:00:00 +0800
categories: 3d-printing, home automation
---

# Purpose
- Repurpose an old USB LED light into something useful for the printer
- Use up some spare home automation components
- Design something nice looking

# Reference
- [ESP-01S Relay Case](https://www.thingiverse.com/thing:4705385) by [engineers_alter_ego](https://www.thingiverse.com/engineers_alter_ego/designs)
- Self made remix:
  - Thingiverse: [ESP-01S Relay LED Holder](https://www.thingiverse.com/thing:5077707)
  - Github: [ESP-01S Relay LED Holder](/assets/stl/2021-11-01-printer-light.stl)

# Actions
- Remixed in TinkerCAD
  - Widened to house wires inside the box
  - Closed off terminal block holes
  - Added space for a Micro USB port
  - Measured and added a hollow cylinder to fit the LED light bar
  - Added base of cylinder to elimenate need for supports, looked good too
- Uploaded my new design to [Thingiverse](https://www.thingiverse.com/thing:5077707)
- Added ESP-01S Relay (fitted perfectly into the design)
- Wired LED positive to relay N.O. position (circuit closes/completes when relay turned on)
- Wired in a Micro USB header board
- Hot glued everything in place
- Screwed into the back of the front left leg of the [Slack Lack](https://www.thingiverse.com/thing:3485510)

# Pictures
![printer-light](/assets/img/2021-11-01-printer-light.jpg)

# Code
```yaml
switch:
  - platform: gpio
    id: gpio0
    pin:
      number: GPIO0
    name: "${friendly_name} Switch"
    icon: "mdi:desk-lamp"
    inverted: true
```


# Observations
- Probably didn't need a relay for the amount of current in question, but thought it best to save the ESP-01S from bearing the brunt
- Made wires a bit too short making wiring up the USB port difficult
- Hot glue under the relay board caused it to sit higher up and the lid didn't close properly, next time ensure adequare pressure after applying hot glue to a well fitted part
- It worked quite well but the light source wasn't particularly bright
- Resued something I might otherwise have thrown away
