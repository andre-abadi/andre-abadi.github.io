---
layout: default
title: Irrigation Interrupt
date: 2021-04-02 11:36:00 +0800
categories: home automation
---

# Purpose
- Synthetic rain sensor
- Make use of a buck converter for outboard power from irrigation system

# Actions
- Identified that irrigation controller ran at 24V AC
- Used a low voltage AC-DC converted to get 5V DC
- ESP-01S Relay (with fix)
- Used surface ducting to get two sets of telephone wire from irrigation controller to outside ensuite
  - One for switching
  - One for power

# Pictures
![printer-light](/assets/img/2021-04-02-irrigation-interrupt.jpg)

# Code
```yaml
switch:
  # actual GPIO0 switch
  - platform: gpio
    name: "Irrigtation Interrupt Switch"
    id: gpio0
    icon: "mdi:light-switch"
    restore_mode: ALWAYS_OFF
    pin:
      number: GPIO0
```

# Observations
- Locating it above/near irrigation controller put it out of range
- Voltage from AC/DC converter was quite stable
- Lessons learned from garage controller paid off
  - Liberal hot glue
  - Status LED helps
- ESP-01S Wi-Fi range heavily dependant on height, likes to be high up where signal could possibly go over the walls