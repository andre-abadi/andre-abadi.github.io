---
layout: default
title: Kids Bedside Node
date: 2021-03-23 17:22:00 +0800
categories: home automation
---

# Purpose
- ESP-01S node for kids bedroom
- Button to activate hallway light at night
- Temp/humidity sensing would be good too

# References
[P1030 • 25 Point Solderless Breadboard Pack 7]()https://www.altronics.com.au/p/p1030-25-way-breadboards-pk7/

# Actions
- Project box from Altronics
- Mini breadboards from Altronics
- Kid chose buttons wired in parallel
- Drilled out room for the DHT11 to protrude
- Drilled out room for buttons
- Bent DHT11 to protrude from housing
- Hot glued ESP-01S relay board and buttons in place
- Used DuPont wires to set up the breadboard
- Used the [Frenck trick](https://frenck.dev/diy-smart-doorbell-for-just-2-dollar/) to get an extra GPIO from the ESP-01S
- Mounted near bed with 3M detachable adhesives
- Cut a broken ESP-01S to reduce the size of the cable hole, and hot glued that in place
- Soldered the +/- from an old iPhone charger to the DuPont wires to make the voltage rails in the breadboard

# Pictures
![printer-light](/assets/img/2021-03-23-kids-bedside-node.jpg)

# Code
```yaml
sensor:
  - platform: dht
    pin: GPIO2
    temperature:
      name: "${friendly_name} Temperature"
      filters:
        - offset: -5
    humidity:
      name: "${friendly_name} Humidity"
      filters:
        - offset: 13
    update_interval: 60s

binary_sensor:
  - platform: gpio
    id: gpio0
    name: "${friendly_name} Button"
    pin:
      number: GPIO0
      inverted: true
    filters:
      - delayed_on: 25ms
      - delayed_off: 30s
```

# Observations
- DHT11 difficult to calibrate/tune
- Filters on buttons made effective 'timeout' preventing over-use of button
- Soldering of buttons sans flux caused green button light to stop working
- Hard wiring was best known at the time, but in retrospect a micro USB port could have been more elegant
- Drilling out neat holes was difficult, [step drill bit](https://www.bunnings.com.au/craftright-10-30mm-step-drill-bit_p6290411) bought much after the fact would have been perfect
