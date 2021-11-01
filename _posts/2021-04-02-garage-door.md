---
layout: default
title: Garage Door
date: 2021-04-02 10:52:00 +0800
categories: home automation
---

# Purpose
- Garage door automation and integration with Home Assistant

# Reference
- [The Frenck article that started it all](https://frenck.dev/diy-smart-doorbell-for-just-2-dollar/)
- [Debugging the ESP8266 ESP-01S Relay Module](https://cmheong.blogspot.com/2018/03/debugging-esp8266-esp-01s-relay-module.html)
- [ESP8266 GPIO Behaviour at Boot](https://rabbithole.wwwdotorg.org/2017/03/28/esp8266-gpio.html)
- [ESP-01 is a frustrating and finicky board.](https://www.reddit.com/r/esp8266/comments/macmah/comment/grsosiz/?utm_source=share&utm_medium=web2x&context=3)

# Actions
- Fixed relay module using [guide](https://cmheong.blogspot.com/2018/03/debugging-esp8266-esp-01s-relay-module.html) and a soldered 10K resistor between GPIO0 and 3.3V as shown in the aforementioned link
- Initially used a buck converter from garage door controller 30V but it blew due to overvoltage on garage door controller startup
- Swapped to USB power via input bus
- Added power LED for diagnostics
- Used minimal hot glue on relay board causing it to fall off
- Super-glued ESP-01S relay with liquid nails causing PCB damage
- Soldered another relay board using the aforementioned resistor hack
- Used more hot glue to fight gravity
- Mounted in an Altronics clear waterproof project box
- Drilled into ceiling near garage door controller


# Pictures
![garage-door](/assets/img/2021-04-02-garage-door.jpg)

# Code
```yaml
# reed switch sensor
binary_sensor:
  - platform: gpio
    id: gpio2
    name: "${friendly_name} Sensor"
    device_class: garage_door
    pin:
      number: GPIO2
      mode: INPUT_PULLUP
      inverted: true
    filters:
      - delayed_on: 1000ms
      - delayed_off: 1000ms

switch:
  # actual GPIO0 switch
  - platform: gpio
    id: gpio0
    restore_mode: ALWAYS_OFF
    pin:
      number: GPIO0
  # wrapper for GPIO0 making it a momentary switch
  - platform: template
    internal: true
    id: gpio0_momentary
    name: "${friendly_name} Button"
    icon: "mdi:light-switch"
    turn_on_action:
      - switch.turn_on: gpio0
      - delay: 250ms
      - switch.turn_off: gpio0
cover:
  - platform: template
    name: "${friendly_name}"
    id: garage_door_cover
    device_class: garage
    lambda: |-
      if (id(gpio2).state) {
        return COVER_OPEN;
      } else {
        return COVER_CLOSED;
      }
    open_action:
      - switch.turn_on: gpio0_momentary
    close_action:
      - switch.turn_on: gpio0_momentary
```

# Observations
- Liquid nails does bad things to PCBs
- Project boxes don't adhere well to hot glue
- Hot glue must cool completely before it gets all its binding effect
- ESP-01S has lots of [fiddly boot moods](https://rabbithole.wwwdotorg.org/2017/03/28/esp8266-gpio.html)
- Sometimes ESP-01S does not boot if on power restore\
- Soldering sans flux is a bad time
