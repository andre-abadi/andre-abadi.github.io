---
layout: default
title: Master Bed Node
date: 2021-09-14 21:23:00 +0800
categories: 3d-printing, home automation
---

# Purpose
- Self made sensor node
  - PIR
  - Temp/Humidity (SHT31)
  - Status LED
- Basis for automations

# Reference
- [ESP8266-D1mini-DHT22-HC-SR501](https://www.thingiverse.com/thing:4725408)
- [SHT31](https://www.aliexpress.com/item/4000086614422.html?spm=a2g0s.9042311.0.0.27424c4d1Glhog)
- [SHT3X-D Temperature+Humidity Sensor](https://esphome.io/components/sensor/sht3xd.html)
- [Wemos D1 Mini](https://www.aliexpress.com/item/32816149164.html?spm=a2g0s.9042311.0.0.27424c4dpPWUMb)

# Actions
- Printed [parts](https://www.thingiverse.com/thing:4725408) as listed
- Dupont cables to connect everything
- Hot glued everything in place
- Flashed Wemos D1 Mini

# Pictures

![Picture](/assets/img/2021-09-14-master-bed-node.jpg)

# Code
```yaml
switch:
  # actual GPIO0 switch
  - platform: gpio
    id: d7
    name: "${friendly_name} LED"
    restore_mode: ALWAYS_ON
    pin:
      number: D7
    icon: 'mdi:led-variant-on'

sensor:
  - platform: uptime
    name: "${friendly_name} Uptime"
  - platform: wifi_signal
    name: "${friendly_name} Wi-Fi Signal"
    update_interval: 60s
    
  - platform: sht3xd
    temperature:
      name: "${friendly_name} Temperature"
      filters:
        - offset: -2.9
    humidity:
      name: "${friendly_name} Humidity"
      filters:
      - offset: 8.3

binary_sensor:
  - platform: gpio
    pin: D4
    name: "${friendly_name} Motion"
    device_class: motion
    filters:
      delayed_off: 10s
```

# Observations
- Case over-engineered, more plastic than necessary
- 100% infill used more plastic than necessary
- Case was larger than necessary
- Case did not adapt well to SHT31
- Lid did not close nicely
