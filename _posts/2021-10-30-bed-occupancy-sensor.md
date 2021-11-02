---
layout: default
title: Bed Occupancy Sensor
date: 2021-10-30 10:00:00 +0800
categories: 3d printing, home automation
---

# Purpose
- Detect bed occupancy for home automations
- Possibly measure weight as well
- Possibly measure number of occupants

# References
- [Smart Bed occupancy sensor](https://www.thingiverse.com/thing:4213002) by [Lukáš Porubcan](https://www.thingiverse.com/luc3as/designs)
- [Bed Occupancy Sensor Shim](https://www.thingiverse.com/thing:5083565) by me
- [Wemos D1 mini case](https://www.thingiverse.com/thing:4600198) by [holda](https://www.thingiverse.com/holda/designs)
- [Wemos D1 Mini Case for HX711 Bed Occupancy Sensor Assembly](https://www.thingiverse.com/thing:5083584) by me
- [HX711 + 4x 50kg Load Cells](https://www.aliexpress.com/item/4000215823944.html?spm=a2g0s.9042311.0.0.b4e54c4d1kwhAB)


# Actions
- Printed all of the parts for the [Smart Bed occupancy sensor](https://www.thingiverse.com/thing:4213002)
- Remixed the [Wemos D1 mini case](https://www.thingiverse.com/thing:4600198) by [holda](https://www.thingiverse.com/holda/designs) to make room for a four pin header coming from the HX711
- Printed my remix
- Wired up the load cells in a Wheatstone Bridge, per the picture in the original [thing](https://www.thingiverse.com/thing:4213002)
- Got weird values of [-8388608](https://community.home-assistant.io/t/esp8266-hx711-4-small-load-cells-giving-incorrect-values/207005)
- Researched and found out this was due to incorrect wiring of the Wheatstone Bridge
- Corrected wiring
- Mounted load cells in holder assembly using super glue (cyanoacrylate)
- Calibrated using a heavy book
- Drilled into centre of bed frame
- Realised the plates wouldn't be high enough to take any load from bed slats
- Remixed the plates from the [Smart Bed occupancy sensor](https://www.thingiverse.com/thing:4213002) and created the [Bed Occupancy Sensor Shim](https://www.thingiverse.com/thing:5083565)
- Measured distances between original plates and slats, then printed in various heights by scaling in the slicer
- Glued the shims onto the plates to achieve contact/load
- Taped loose wires to prevent snagging and to neaten up appearance
- Calibrated
- Found one side shims were too thick so reported loads to high
- Resorted so safe maximum for a binary sensor
- Automated within ESPhome to abstract high volume of sensor readings
- Interpolated raw readings to prevent incorrect readings from triggering binary sensor state change
- Final binary sensor was responsive to change without giving erroneous readings


# Pictures
![bed-occupancy-sensor](/assets/img/2021-10-30-bed-occupancy-sensor.jpg)

# Code
```yaml
sensor:
# actual input HX711
  - platform: hx711
    internal: true
    id: weight
    name: "${friendly_name} Weight"
    dout_pin: D3 # DT
    clk_pin: D4  # SCK
    gain: 128
    update_interval: 1s
    unit_of_measurement: kg
    # raw value of -29528 means sensors are effectively disconnected from hx711
    filters:
      #- calibrate_linear:
      #    - 230405 -> 0     # unladen with only 3d printed toppers
      #    - 132925 -> 4.726 # greys anatomy weight
      #
      - calibrate_linear:
          - 201800 -> 0    # mattress, sheets and summer blanket
          - 89100 -> 76.7 # point in time human male
          # 95000 = 95kg
          # 77500 = 90kg
          # 89100 = 85kg
          # 91300
      - sliding_window_moving_average:
          window_size: 10
          send_every: 10
          #send_first_at: 5
    # https://esphome.io/components/sensor/index.html#on-value
    on_value:
      - if:
          condition:
            sensor.in_range:
              id: weight
              above: 10
          then:
            # https://esphome.io/components/sensor/index.html#lambda-calls
            lambda: 'id(occupied).publish_state(true);'
      - if:
          condition:
            sensor.in_range:
              id: weight
              below: 10
          then:
            lambda: 'id(occupied).publish_state(false);'


# binary sensor to be modified by hx711
binary_sensor:
  - platform: template
    id: occupied
    name: "Master Bed Occupied"
    #device_class: presence
```

# Observations
- HX711 readings vary and do have frequent spikes requiring software smoothing, 10 sample moving average worked well
- Internal automation of ESPhome meant that readings could be taken every second without saturating Home Assistant