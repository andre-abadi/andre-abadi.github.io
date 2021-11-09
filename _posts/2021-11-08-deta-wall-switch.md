---
layout: default
title: Deta Wall Switch
date: 2021-11-08 20:00:00 +0800
categories: home automation
---

# Purpose
- Flash ESPhome to a Deta Smart Single Switch

# References

- [Deta Grid Connect Smart Switch and Home Assistant](https://blog.mikejmcguire.com/2019/12/09/deta-grid-connect-smart-switch-and-home-assistant/) by [Mike J McGuire](https://blog.mikejmcguire.com/author/mikejmcguire/)
- [FTDI Drivers](https://ftdichip.com/drivers/)
- Mk. 2 eyeball of device and packaging:
  | Key | Value |
  | --- | --- |
  | Brand | Deta |
  | Model | 6911HA|
  | Ecosystem | Grid Connect|
  | Packaging Model Number | CPCN009308/4 |
  | Chip Model | TYWE3S |
  | Chip P/N | 6911HA |
  | Chip S/N | XXXXXXXXXXX473 |
  | ESPHome Readout | ESP8266 80MHz, 80KB RAM, 1MB Flash |

# Actions
## 2021-11-08
- `choco install tasmotizer`
- Search whole hard drive for tasmotizer
- Found it in `C:\ProgramData\chocolatey\bin` (thanks Choco, made that one easy)
- Pinned Tasmotizer to Start
- Booted Tasmotizer in normal mode, no COM3 port
- Booted Tasmotizer on administrator mode, no improvement
- Searched for FTDI drivers
- Downloaded and installed [the Windows 10 drivers](https://ftdichip.com/drivers/)
- COM3 port popped up successfully
- Downloaded [Tasmota v7.2.0](https://github.com/arendst/Tasmota/releases/tag/v7.2.0)
- Wired up FTDI to the switch via [Mike's photo](https://mikejmcguire.files.wordpress.com/2019/12/untitled.png)
- Followed instructions from [Todd Gibbons' comment](https://blog.mikejmcguire.com/2019/12/09/deta-grid-connect-smart-switch-and-home-assistant/#comment-25882) on [Mike's blog post](https://blog.mikejmcguire.com/2019/12/09/deta-grid-connect-smart-switch-and-home-assistant/)
    >- got it working.  
    >- crossed TX & RX.  
    >- used tasmotizer-1.1a for windows, on Win10. running As Administrator  
    >- used bin tasmota-basic7.1.bin  
    >- If the install fails, then disconnect the usb to serial dongle. refresh the com ports in tasmotizer. then while the device is connected and running, connect an ground lead to GPIO0, then to RST, hold for 3 sec. then release RST, wait 3 sec, then release GPIO0. Then click Tasmotize! button
Todd
- My version of the steps
  1. Wire up basic 4 (3.3V,GND,TX,RX)
  2. GND to GPIO0 and count to 3
  3. GND to RST and count to 3
  4. Remove GND from RST and count to 3
  5. Remove GND from GPIO
  6. Tasmotize
- Downloaded bin for v7.2.0 didn't work but `Release 10.0.0 tasmota.bin` did work
- Gathered below from Tasmota info while running standard v10.0.0 firmware:
    >| Key | Data |
    >| -- | -- |
    >|ESP Chip Id|1509020 (ESP8266EX)|
    >|Flash Chip Id|0x1540C8|
    >|Flash Size|2048 kB| 
    >|Program Flash Size|2048 kB|
    >|Program Size|612 kB|  
    >|Free Program Space|388 kB|
    >|Free Memory|27.6 kB|  
- Found Tasmota Wi-Fi, entered home Wi-Fi and navigated to new IP on computer
- Created ESPhome config using [template from ESPHome Devices](https://www.esphome-devices.com/devices/DETA-Grid-Connect-Smart-Switch/)
  - ESPHome threw error `GPIO Pin 16 does not support pullup pin mode. Please choose another pin.
mode: INPUT_PULLUP`
  - Checked [Tastmota Devices page for this device](https://templates.blakadder.com/deta_6911HA.html) for any info
  - Googled error code and found an exact copy of my issue on [Github](https://github.com/esphome/issues/issues/2675)
  - Issue was solved by [Otto Winter](https://github.com/OttoWinter) himself! (Creator of ESPHome)
  - Changed `mode: INPUT_PULLUP` to `mode:INPUT`
  - Error went away
- Compiled and downloaded `.bin` from ESPHome
- Tried uploading via Tasmota interface but `Error: Not enough space`
- Loaded `.bin` into Tasmotizer and flashed
- ESPHome node discovered on Home Assistant!
- Alas something went wrong before it could be adopted
- Back to Tasmotizer, tried re-flashing ESPHome binary a few times with no luck
- Reverted back to Tasmota 10.0.0 `tasmota.bin` to try to get it working
- No logger function via Tasmotizers so switched back to ESPHome on RPi4 Home Assistant for USB Logging
- Possible out of memory (OOM) issues judging by [Home Assistant Forums](https://community.home-assistant.io/t/esphome-device-wont-connect-to-wifi-after-upgrading-to-1-20-4/327756/25)
- Successfully flashed Tasmota 10, header pin wiggling seemed to help post-flash
- Further [research](https://github.com/esphome/issues/issues/1068) seems to suggest binary from ESPHome may be too big
## 2021-11-09
- Reviewed the Tasmota page on [Upgrading](https://tasmota.github.io/docs/Upgrading/)
- Noted that from v8.2 Tasmota can take an upgrade firmware in the form of a `.bin.gz`
- Used 7zip to turn `deta-switch-master-bed (4).bin` into `deta-switch-master-bed (4).bin.gz` using *Gzip* compression
- Uploaded `.gz` file using Tasmota web interface
- Upload appeared to succeed and device rebooted

# Observations
