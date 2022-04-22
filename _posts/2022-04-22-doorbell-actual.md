---
layout: default
title: Doorbell Actual 1
date: 2022-04-22 11:57:00 +0800
tags:
- 3d printing
- home automation
---

# Purpose
- Develop code for doorbell button using Home Assistant and ESPHome
- Use the button obtained for a doorbell, 5V illuminated SPST switch

# Actions
- Obtained pre-soldered D1 mini from another mothballed project
- Grabbed a DIY DuPont rail (header pins with wire soldered along back)
- Wired up button light to D1 & GND
- Wired up button press to D2 & GND
- Developed code using ESPHome documentation

# Reflections
- End result is quite haptic
  - Pressing button gets visual result (flashing)
  - Button unavailable gets visual result (remains on while `delayed-off` elapses)
  - Button becoming available again has visual cue (light on again)

# Code
```yaml
switch:
  - platform: gpio
    pin: D1
    id: d1
    name: "${friendly_name} Light"
    restore_mode: ALWAYS_ON
    internal: true

binary_sensor:
  - platform: gpio
    id: d2
    icon: mdi:radiobox-marked
    name: "${friendly_name} Button"
    #device_class: garage_door
    pin:
      number: D2
      inverted: true
      mode: INPUT_PULLUP
    filters:
      - delayed_off: 30s
    # automation when button is pressed
    on_press:
      - repeat:
          count: 15
          then:
            - switch.turn_off: d1
            - delay: 50ms
            - switch.turn_on: d1
      - switch.turn_off: d1
    on_release:
      then:
        - switch.turn_on: d1
```