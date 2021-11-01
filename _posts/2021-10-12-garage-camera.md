---
layout: default
title: Garage Camera
date: 2021-10-12 16:033:00 +0800
categories: 3d-printing, home automation
---

# Purpose
- Self made sensor node
  - PIR
  - Temp/Humidity (SHT31)
  - Status LED

# Reference
- [Case with kodak thread for ESP32CAM + CH340](https://www.thingiverse.com/thing:4839587)
- [ESP32 Camera Component](https://esphome.io/components/esp32_camera.html#configuration-for-ai-thinker-camera)

# Actions
- Printed [case]((https://www.thingiverse.com/thing:4839587) in PolyMaker PolyTerra PLA black.
- Flashed ESP32-CAM-CH340 with ESPHome
- Zip-tied to convenient location in garage

# Pictures
![garage-camera](/assets/img/2021-10-12-garage-camera.jpg)

# Code
```yaml
# https://www.esphome-devices.com/devices/ESP32-CAM
esp32_camera:
  external_clock:
    pin: GPIO0
    frequency: 20MHz
  i2c_pins:
    sda: GPIO26
    scl: GPIO27
  data_pins: [GPIO5, GPIO18, GPIO19, GPIO21, GPIO36, GPIO39, GPIO34, GPIO35]
  vsync_pin: GPIO25
  href_pin: GPIO23
  pixel_clock_pin: GPIO22
  power_down_pin: GPIO32
  # image quality settings
  # https://sequr.be/blog/2021/03/home-automation-esp32-cam-and-esphome/
  #
  resolution: 800x600
  name: "${friendly_name}"
  max_framerate: 5 fps
  idle_framerate: 0.2fps
  jpeg_quality: 10
  vertical_flip: false
  horizontal_mirror: false
```

# Observations
- Worked
- Could have removed unused camera thread
- Ventilation at rear was both functional and aesthetically pleasing
