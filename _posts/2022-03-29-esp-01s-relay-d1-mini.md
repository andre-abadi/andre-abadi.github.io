---
layout: default
title: ESP-01S-Relay with D1 Mini
date: 2022-03-29 16:40:00 +0800
tags:
- home automation
---

# Purpose
- Run an ESP-01S-Relay board with a D1 Mini


# References
- [ESP-01 and ESP-01S: How program and use the Pins and Leds](https://www.forward.com.au/pfod/ESP8266/GPIOpins/ESP8266_01_pin_magic.html)
- [Which gpio are pull-up on Wemos D1 mini ?](https://www.reddit.com/r/esp8266/comments/5yzlt5/which_gpio_are_pullup_on_wemos_d1_mini/)
- [What’s the difference? – ‘Active High’ and ‘Active Low’ Relay Boards](https://iacselectronics.com/2019/04/20/activehighlowmistake/)
- [ESP-01S Relay v1.0 Schematic.pdf](https://github.com/IOT-MCU/ESP-01S-Relay-v1.0/blob/master/ESP-01S%20Relay%20v1.0%20Schematic.pdf)

# Actions
- Powered the relay with its usual 5V
- Wired D2 from the mini to GPIO0 on the socket board of the relay
- Used the below code:
```yaml
switch:
  - platform: gpio
    name: "Garage Door Relay"
    restore_mode: ALWAYS_OFF
    pin: D1
```
- This did not toggle the relay
- Enabled internal pullup resistor from readings of Active High references
```yaml
switch:
  - platform: gpio
    name: "Garage Door Relay"
    restore_mode: ALWAYS_OFF
    pin:
      number: D1
      mode: INPUT_PULLUP
```
- Tried D2, no change, hence it does not appear to be related to the pinout of the mini

# Reflections



# Pictures


# Code