---
layout: default
title: Doorbell Actual 2
date: 2022-04-30 21:57:00 +0800
tags:
- 3d printing
- home automation
---

# Purpose
- Create a from-scratch, smart doorbell, ESPHome for Home Assistant integrations
- Finalise build log for Doorbell Actual, after starting on part 1 of the project

# References
- [**First Post: Doorbell Actual**]({{ site.baseurl }}/2022/04/22/doorbell-actual.html)
- [**TinkerCAD: doorbell-actual**](https://www.tinkercad.com/things/5F97d7ne5wT)
- **Printables: Doorbell** [TBA]
- [AliExpress: *Yamin electric store* Metal Push Button - White, 40mm, 3-6V](https://www.aliexpress.com/item/4000310874353.html?spm=a2g0o.order_list.0.0.6ef01802MIGp6L)

# Design Files
- [`doorbell-actual.stl`](/assets/stl/2022-04-30-doorbell-actual.stl)

# Actions
- Printed the STL *face* down
  - 0.6mm nozzle, 0.4mm layer height, 15% gyroid infill
- Soldered some DuPont socket cables to the Push Button
- Mounted the Push Button
  - Hole too small
  - Bastard file to widen hole by 0.5mm
- Wired up to the Push Button to a Wemos D1 Mini
- Tested using code from [**First Post: Doorbell Actual**]({{ site.baseurl }}/2022/04/22/doorbell-actual.html)
- Code worked
- DuPont crimped a three wire socket and plug to 8m of CAT5e UTP (blue, green, brown)
- This meant that D1 Mini's pinout necessitated using `GND`, `D4`, and `D3` instead of `GND`, `D1`, and `D2`
- Rewrote code so that DuPont headers could be put onto the D1 Mini
- Desktop tests
  - 8m cable did not affect function (thankfully, had not been certain this would be the case)
  - Change in pins did not affect function
- Drilled a hole in external brickwork
- Chain down, pulled cable through to garage where USB power readily available
- Attached button to DuPont header on doorbell side
- Attached DuPont header to D1 Mini in enclosure on garage-side
- Function test succeeded
- Drilled screw holes for doorbell fixture
- Added roof silicone (leftover from previous project) to back of doorbell fixture for waterproofing
- Screwed in the fixture
- Further function test successful (flicker of light on press made this easy)
- Packed up
- Wrote automation (see Code section below)
- Everything worked!

# Reflections
- Crimping DuPont is amazing, even with a set of pliers (thanks Joseph Prusa!)
- Crimping DuPont would be even more amazing with a crimper (bought a Engineer PAD-11 since)
- Design of doorbell fixture looks amazing
- Tested a strobe effect when button not pressed but it would only work after first press, and this seemed inelegant so was scrapped, but archived below


# Pictures
![doorbell-actual-2](/assets/img/279463964_726958922077418_3741837197563331713_n.jpg)

# Code

## ESPHome
- Updated on-press strobe-effect timings
- Updated pins to suit headers off network cable

```yaml
logger:
  logs:
    switch: INFO
switch:
  - platform: gpio
    pin: D4
    id: light
    name: "${friendly_name} Light"
    restore_mode: ALWAYS_ON
    internal: true

binary_sensor:
  - platform: gpio
    id: bin
    icon: mdi:radiobox-marked
    name: "${friendly_name} Button"
    #device_class: garage_door
    pin:
      number: D3
      inverted: true
      mode: INPUT_PULLUP
    filters:
      - delayed_off: 30s
    # automation when button is pressed
    on_press:
      - repeat:
          count: 15
          then:
            - switch.turn_off: light
            - delay: 50ms
            - switch.turn_on: light
      - switch.turn_off: light
    on_release:
      then:
        - switch.turn_on: light
```

## Unused Un-Pressed Strobe
```yaml
        
         slow strobe when not pressed,
         but only after first press
        
        - while:
            condition:
              binary_sensor.is_off: bin
            
            
            then:
              - switch.turn_off: light
              - delay: 100ms
              - switch.turn_on: light
              - delay: 1s
              
```

## Automation
```yaml
- id: '1651317777505'
  alias: Doorbell Actual
  description: Ring the doorbell at 25% after 6pm before 6am, otherwise 75%. Notify
    all apps if house unoccupied.
  trigger:
  - platform: state
    entity_id: binary_sensor.doorbell_actual_button
    to: 'on'
  condition: []
  action:
  - choose:
    - conditions:
      - condition: time
        before: '18:00:00'
        after: 06:00:00
      sequence:
      - service: media_player.volume_set
        data:
          volume_level: 0.75
        target:
          entity_id: media_player.living_room_speaker
    default:
    - service: media_player.volume_set
      data:
        volume_level: 0.35
      target:
        entity_id: media_player.living_room_speaker
  - service: media_player.play_media
    data:
      media_content_id: media-source://media_source/local/doorbell.mp3
      media_content_type: audio/mp3
    target:
      entity_id: media_player.living_room_speaker
  - choose:
    - conditions:
      - condition: state
        entity_id: binary_sensor.occupancy
        state: 'off'
        for:
          minutes: 5
      sequence:
      - service: notify.all_hass_apps
        data:
          data:
            clickAction: /lovelace-cctv/main
          title: 🔔 The Doorbell Rang
          message: Tap to see CCTV summary.
    default: []
  mode: single

```