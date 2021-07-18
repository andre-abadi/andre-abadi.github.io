---
layout: default
title: Server Rebuild
date: 2021-07-18 19:03:00 +0800
---

# Rationale
- Hard drive died

# OS
- Ubuntu Server 20.04 x64 on USB
- Whole of new 500GB SSD

# Basic Programs
```
sudo apt install -y \
net-tools
```
# Housekeeping
## Set Timezone
- `sudo timedatectl set-timezone XXXXX\XXXXX`
## Enable password-less sudo
- `sudo visudo`
- Replace: `%sudo   ALL=(ALL:ALL) ALL'
- With: `%sudo   ALL=(ALL:ALL) NOPASSWD:ALL`
