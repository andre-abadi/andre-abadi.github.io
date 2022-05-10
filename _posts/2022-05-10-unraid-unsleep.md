---
layout: default
title: UnRaid Un-Sleep
date: 2022-03-25 11:32:00 +0800
tags:
---

# Purpose
- Get UnRaid to wake up from sleep when sending Magic Packet


# References
- [Setup Sleep (S3) and Wake on Lan (WOL)](https://wiki.unraid.net/Setup_Sleep_(S3)_and_Wake_on_Lan_(WOL))
- [Set up Wake On LAN (WOL) on CentOS 7](https://www.lisenet.com/2016/set-up-wake-on-lan-wol-on-centos-7/)
  ```
  wol p|u|m|b|a|g|s|d...
   Sets Wake-on-LAN options. Not all devices support this. The
   argument to this option is a string of characters specifying
   which options to enable.
  p Wake on PHY activity
  u Wake on unicast messages
  m Wake on multicast messages
  b Wake on broadcast messages
  a Wake on ARP
  g Wake on MagicPacket™
  s Enable SecureOn™ password for MagicPacket™
  d Disable (wake on nothing). This option clears all previous options.
  ```

# Actions
- Bought license as trial had expired (Pro, 12 devices)
- Checked that [Dynamix S3 Sleep](https://forums.unraid.net/topic/34889-dynamix-v6-plugins/) was up-to-date
- Researched WOL flags, finding [Set up Wake On LAN (WOL) on CentOS 7](https://www.lisenet.com/2016/set-up-wake-on-lan-wol-on-centos-7/)
- UnRaid terminal
  - `ethtool -s eth0 wol g`
  - `ethtool eth0 | grep Wake`
- Result
  ```
  Supports Wake-on: pumbg
          Wake-on: g
  ```
- Settings / User Settings / Sleep Settings / Set WOL options before sleep = `g`
  - Apply
- Test `sudo etherwake -D -i eno1 ##:##:##:##:##:##:##`
- Works intermittently
  - Works when manually sleeping computer
  - Doesn't seem to work when computer goes to sleep by self

# Reflections
- WOL is hard, issue does not appear completely resolved