---
layout: default
title: Home Assistant Local Media Cast
date: 2022-03-29 15:56:00 +0800
tags:
- home automation
---

# Purpose
- Home Assistant 2022.3 broke local media cast, even though there was no change in service call format
- Casting `doorbell.mp3` was no longer working for virtual doorbell
- Repair broken local media cast to Google nest audio speaker


# References
- [Media_play does not work](https://community.home-assistant.io/t/media-play-does-not-work/241696/36)
- [Media_source integration](https://www.home-assistant.io/integrations/media_source/)
- [media_dirs](https://www.home-assistant.io/docs/configuration/basic/#media_dirs)

# Error Message
```yaml
Failed to cast media http://XXX.XXX.XXX.XXX:8123/media/local/doorbell.mp3?authSig=XXXXXXXXX from internal_url (http://XXX.XXX.XXX.XXX:8123). Please make sure the URL is: Reachable from the cast device and either a publicly resolvable hostname or an IP address
```

# Actions
- Lots of dead ends trying to identify the cause of the aforementioned error message
- [Charx](https://community.home-assistant.io/u/Charx) on the Home Assistant forums seemed closest to a solution on [this post](https://community.home-assistant.io/t/media-play-does-not-work/241696/36)
- The media folder appeared to have changed from `media` to `local` in some unknown capacity
- The solution was in the UI under `Settings / General / Internal URL` to change the `Internal URL` from `http://homeassistant.local:8123` to `http://XXX.XXX.XXX.XXX:8123`
- Restarted server
- Tested media play using `Developer Tools / Service`

# Reflections
- Very frustrating to fix, no mention of it on a brief glean of the play media section of breaking changes
- Additional sub-folders (had had mp3 in an mp3 folder) added degree of difficulty to finding the fix


# Code

## Service Call
```yaml
service: media_player.play_media
data:
  media_content_id: media-source://media_source/local/doorbell.mp3
  media_content_type: media/mp3
target:
  entity_id: media_player.living_room_speaker
```

## Automation
```yaml
- id: 'XXXXX'
  alias: Virtual Doorbell
  description: 'If expecting arrival, ring doorbells'
  trigger:
  - platform: mqtt
    topic: frigate/events
  condition:
    - condition: or
      conditions:
        - condition: state
          entity_id: binary_sensor.XXXXX_person_motion
          state: 'on'
        - condition: state
          entity_id: binary_sensor.XXXXX_person_motion
          state: 'on'
  action:
    - service: media_player.volume_set
      data:
        volume_level: 0.75
      target:
        entity_id: media_player.living_room_speaker
    - service: media_player.play_media
      data:
        media_content_id: media-source://media_source/local/doorbell.mp3
        media_content_type: audio/mp3
      target:
        entity_id: media_player.living_room_speaker
  mode: single
```