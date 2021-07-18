---
layout: default
title: Server Rebuild
date: 2021-07-18 19:03:00 +0800
---

# Rationale
- Hard drive died :(

# Particulars
- Ubuntu Server 20.04 x64 on USB
- Whole of new 500GB SSD
- Optiplex 9020 with 24GB of RAM

# Set Timezone
- `sudo timedatectl set-timezone XXXXX\XXXXX`

# Enable password-less sudo
- `sudo visudo`
  - Replace: `%sudo   ALL=(ALL:ALL) ALL`
  - With: `%sudo   ALL=(ALL:ALL) NOPASSWD:ALL`

# Netplan

- `sudo vim /etc/netplan/00-installer-config.yaml`
```
network:
  ethernets:
    eno1:
      dhcp4: false
      dhcp6: false
      addresses:
        - 10.1.1.140/24
      gateway4: 10.1.1.1
      nameservers:
        addresses:
          - 10.1.1.200
      optional: true
  version: 2
```
- `sudo netplan try` (won't work well from SSH)
- `sudo netplan apply`

# Update First
- `sudo apt full-upgrade -y && sudo apt autoremove && sudo apt autoclean -y`

# Docker
- [Reference Article](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- `sudo apt install apt-transport https ca-certificates curl gnupg lsb-release`

# NFS
- `sudo apt install -y nfs-common`

# Basic Programs
```
sudo apt install -y \
net-tools
```
