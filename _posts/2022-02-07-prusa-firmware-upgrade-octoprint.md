---
layout: default
title: Prusa MK3S+ Firmware Upgrade via OctoPrint Docker
date: 2022-02-07 20:30:00 +0800
categories: home automation
---

# Purpose
- Upgrade Prusa MK3S+ firmware to new 3.10.1 due to upgrade reminders *every print*
- Use OctoPrint to save having to disconnect USB between server and printer

# References
- [mattwidmann.net](https://mattwidmann.net/notes/updating-prusa-i3-mk3s-firmware-with-octoprint/index.html) article showing his success
- [Prusa Firmware](https://help.prusa3d.com/en/downloads/)



# Actions
- Followed steps from [mattwidmann.net](https://mattwidmann.net/notes/updating-prusa-i3-mk3s-firmware-with-octoprint/index.html) to configure [Firmware Updater](https://github.com/OctoPrint/OctoPrint-FirmwareUpdater/blob/master/README.md) plugin for OctoPrint
- Docker CLI to OctoPrint Docker container to run `which avrdude`, finding it was at `/usr/bin/avrdude`
- Final settings as found to succeed by [Matt Widmann](https://mattwidmann.net/notes/updating-prusa-i3-mk3s-firmware-with-octoprint/index.html)

    |Setting | Value |
    |---|---|
    | Flash method | avrdude (Atmel AVR Family) |
    | AVR MCU | Atmega2560 |
    | Path to avrdude | /usr/bin/avrdude |
    | AVR Programmer Type | wiring |

- Saved plugin config
- Downloaded firmware
- Unzipped `.hex` file
- Browse, *Flash from File*
- Completed successfully
- Found I'd accidentally used the MK3 firmware not the MK3S/MK3S+ firmware
- Prusa was graceful enough to accomodate the mistake
- Reflashed with correct firmware
- All Appeared to work correctly

# Observations
- Check firmware printer model before downloading firmware
- OctoPrint is a great way to flash firmware
