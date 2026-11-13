---
layout: default
title: Ocular IQ CT Clamp Readings in Home Assistant
date: 2026-11-13 07:19:00 +0800
tags:
- home automation
- electric vehicle
---

# Purpose
- Replicate Ocular IQ smart charging modes in Home Assistant via local OCPP.

# References
- [Ocular LTE Plus V3 Home Assistant Integration Guide](https://evse.com.au/wp-content/uploads/Ocular-LTE-Plus-V3-Home-Assistant-Integration-Guide.pdf)
- [Ocular IQ Home Solar Installation Guide](https://ocularcharging.com.au/wp-content/uploads/2025/09/IQ-Home-Solar-Installation-Guide-v2.7.pdf)
- [Home Assistant OCPP Documentation](https://home-assistant-ocpp.readthedocs.io/en/latest/)

# Current Setup
- Ocular IQ Single Phase with CT clamp
- Fully provisioned to work with Ocular IQ app showing CT clamp readings.

# Initial OCPP Cutover
- Installed [OCPP](https://github.com/lbbrhzn/ocpp) via Home Assistant Marketplace.
    - Default settings.
- Accessed the web interface at `http://IP`
    - Username: `install`
    - Password: either `installer123` or `Evcharging123` (the latter if your provisioner changed it per the Installation Guide).
- Made no changes to `Advanced / OCPP`
- Under `Basic / Server`:
    - Endpoint
        - Domain: `[HASS-IP]
        - Port: `9000`
        - Path: `central`
        - Identity / Serial No: `Ocular-IQ-Garage`
    - Security
        - Security Profile: `ws`
    - Reference URL: `ws://[HASS-IP]:9000/central/Ocular-IQ-Garage`
- This resulted in the charger appearing in Home Assistant.

# Investigation

- Primary Controls seemed working:
    - `Availability` toggle
    - `Charge Control` toggle (unknown function)
    - `Maximum Current` slider 0-32A (for my single phase charger)
    - `Session Current Limit` greeyed our slider no values (possibly only active during charge or a read-only sensor?)
- All sensors came up as Unknown:
    - `Current Import`
    - `Current Offered`
    - `Energy Active Import Register`
    - `Energy Meter Start`
    - `Energy Session`
    - `SoC`
    - `Stop Reason`
    - `Temperature`
    - `Time Session`
    - `Transation Id`
    - `Voltage`
- Configuration options:
    - `Reset` button
    - `Unlock` button
- All Diagnostic sensors seemed working except `Status Firmware`, `Timestamp Config Response`, and `Tiemstamp Data Transfer`.
- **Many sensors and diagnostics came through but no CT clamp.**
- Ran `Tools/Actions` and the following YAML action:
    ```yaml
    action: ocpp.get_configuration
    data:
        devid: charger
    ```
- Found matching OCPP configs from the frontend:
    - `sDomain: [HASS-IP]`
    - `sPort: '9000'`
    - `sURL: /central`
    - `Id: Ocular-IQ-Garage`
- Disappointingly found my Wifi password in plaintext under `wPwd`.
- Found the following 'b' OCPP server settings not exposed in the web interface:
    - `bsDomain: ocpp.ocularcharging.com.au`
    - `bsPort: '9113'`
    - `bsURL: /ocpp/energy`
    - `bId: [SERIAL]`

- Appears to be like like my [Solaredge Modbus Multi](https://github.com/WillCodeForCats/solaredge-modbus-multi) the CT clamp or its submodule are seperate devices that are just combined for the purpose of the user.
    - Inverter shows up as `SE5000H-[SERIAL]` device
    - Meter shows up as `WND-3Y-400-MB` device
- Tried configuring `bsDomain` to its existing value:
    ```yaml
    action: ocpp.configure
    data:
      devid: charger
      ocpp_key: bsDomain
      value: ocpp.ocularcharging.com.au
    ```
    - Response: `reboot_required: false`
- Tried configuring it to my Home Assistant IP, not yet full cutover but just to see what a value change would do.
    ```yaml
    action: ocpp.configure
    data:
    devid: charger
    ocpp_key: bsDomain
    value: "[HASS-IP]"
    ```
    - Response: `reboot_required: true`
- Rebooted via web interface
- Hass get config
    ```yaml
    action: ocpp.get_configuration
    data:
        devid: charger
    ```
    - `bsDomain: [HASS-IP]`
- Also set the `bsPort`, `bsURL` to match non-*b* entries.
- Set `bId` to `Ocular-IQ-Meter`
- Reboot via web interface
- Nothing new on Home Assistant OCPP debug
- Try matching `bsecurityProfile` from 2 to 0 to match `securityProfile` key.
    ```yaml
    action: ocpp.configure
    data:
    devid: charger
    ocpp_key: bsecurityProfile
    value: 0
    ```
- Reboot via web interface
- Home Assistant debug logs show `[custom_components.ocpp] Charger websocket path=/central/Ocular-IQ-Meter`
- OCPP integration shows option to add new `Open Charge Point Protocol (OCPP)` device so I added it with configuration:
    - Charge point identity: `meter`
    - Everything else default.
- Controls, Sensors and Configuration all unavailable or inapplicable, so disabled them.
- Substantial Diagnostic values do appear suggesting some basic functionality e.g. `Latency Ping` and `Latency Pong` just like the charger itself.

# Interim Findings
- The meter connects as a separate OCPP device and sends vendor-specific `meterValue` data containing CT current, grid power, eco mode, and solar-enabled status.
- The first-phase CT current matched my SolarEdge Modbus reading. Positive `powerToGrid` matched solar export in watts; negative values are assumed to represent import, pending confirmation.
- The existing OCPP integration receives the data but does not expose these values as live sensors. Integration changes are needed to surface them in Home Assistant.
- The meter exposes an `EcoMode` configuration key. Ideally this would become a writable control, but its values and write behaviour still need investigation.
- Next step is to:
    - Render the vendor data in Home Assistant frontend via integration.
    - Ideally make any adjustable settings adjustable in Home Assistant.
