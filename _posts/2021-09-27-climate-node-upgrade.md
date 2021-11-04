---
layout: default
title: Climate Node Upgrade
date: 2021-09-27 20:42:00 +0800
categories: 3d printing, home automation
---

# Purpose
- Upgrade an ESP-01 DHT11 board with an SHT31

# References
- Can't remember the enclosure

# Actions
- Cut off the DHT11
- Solder in the SHT31
- Re-assemble the housing

# Pictures
![climate-node-upgrade](/assets/img/2021-09-27-climate-node-upgrade.jpg)

# Code
```yaml
i2c:
  scl: GPIO0
  sda: GPIO2
  scan: true
  id: bus_a
sensor:    
  - platform: sht3xd
    temperature:
      name: "${friendly_name} Temperature"
      filters:
        - offset: -9.9
    humidity:
      name: "${friendly_name} Humidity"
      filters:
        - offset: 21.9
```

# Observations
- SHT31 wasn't _that_ much better than the DHT11, still needed calibrating
- Appeared to be mostly placebo upgrade compared to the DHT11 in the other room's readings
