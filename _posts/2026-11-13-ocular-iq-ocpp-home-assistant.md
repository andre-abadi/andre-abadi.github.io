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
        - Domain: `[home assistant IP]
        - Port: `9000`
        - Path: `central`
        - Identity / Serial No: `Ocular-IQ-Garage`
    - Security
        - Security Profile: `ws`
    - Reference URL: `ws://[home assistant IP]:9000/central/Ocular-IQ-Garage`
- This resulted in the charger appearing in Home Assistant.

# Investigation
- Many sensors and diagnostics came through but no CT clamp.
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
- All Diagnostic sensors seemed working except `Status Firmware`, `Timestamp Config Response`, and `Tiemstamp Data Transfer`.
