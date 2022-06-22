---
layout: default
title: Unraid Turbo Write
date: 2022-06-22 20:44:00 +0800
tags:
---

# Purpose
- Improve 20-30MB/s write speed to Unraid server running
  - 1x WD 2TB Green
  - 2x WD 1TB Black
  - 2x WD 2TB Red


# References
- [GlennLeving.Dk - Increase UnRAID write speeds with reconstruct write](https://glennleving.dk/index.php/en/2021/01/20/increase-unraid-write-speeds-with-reconstruct-write/)
- [JOHNKEEN.TECH - unRAID Writes Speed Boost Without Cache Disk](https://www.johnkeen.tech/unraid-writes-speed-boost-without-cache-disk/)

# Actions
- Installed Unraid app `Auto Turbo Write Mode`
  - Enable Automatic Turbo Mode: Yes
  - Disks Allowed To Be Spun Down Before Invoking Turbo Mode: 0
  - Polling Time In Seconds: 300
  - Additional Debugging Logging: No
  - No schedules defined
- Write speeds got up to ~60MB/s

# Reflections
- Auto Turbo Write seems to work well, catches sustained writes and enables the mode
- Could see why it would be a bad thing to enable by default on a large number of drives but really hampers write speeds
- Didn't want to use a cache as this server was designed to sleep after receiving backups, hence the mover would likely not correctly invoke a wakeup etc etc and so probably wouldn't work very well