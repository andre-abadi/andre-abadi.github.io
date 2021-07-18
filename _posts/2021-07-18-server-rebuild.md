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
- `sudo timedatectl set-timezone Australia/Perth`

# Enable password-less sudo
- `sudo visudo`
  - Replace: `%sudo   ALL=(ALL:ALL) ALL`
  - With: `%sudo   ALL=(ALL:ALL) NOPASSWD:ALL`

# Netplan to Fixed IP
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

# Update Packages
- `sudo apt full-upgrade -y && sudo apt autoremove && sudo apt autoclean -y`

# NFS and Utilities
```
sudo apt install -y \
nfs-common \
net-tools \
glances \
neofetch \
glances
```

# Docker
- [Reference Article](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- `sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release`
- `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`
- `echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`
- `sudo apt update`
- `sudo apt install -y docker-ce docker-ce-cli containerd.io`

# NFS Mounts
```
sudo mkdir \
/volume1 \
/volume1/transfer \
/volume1/series \
/volume1/music \
/volume1/movies \
/volume1/homevideos \
/volume1/downloads
```
- `sudo vim /etc/fstab`
```
10.1.1.150:/volume1/transfer /volume1/transfer nfs defaults 0 0
10.1.1.150:/volume1/series /volume1/series nfs defaults 0 0
10.1.1.150:/volume1/music /volume1/music nfs defaults 0 0
10.1.1.150:/volume1/movies /volume1/movies nfs defaults 0 0
10.1.1.150:/volume1/homevideos /volume1/homevideos nfs defaults 0 0
10.1.1.150:/volume1/downloads /volume1/downloads nfs defaults 0 0
10.1.1.150:/volume1/backup /volume1/downloads nfs defaults 0 0
```

# Docker Wait for NFS
- `sudo mkdir /etc/systemd/system/docker.service.d`
- `sudo vim /etc/systemd/system/docker.service.d/override.conf`
```
[Unit]
RequiresMountsFor=/volume1/downloads /volume1/homevideos /volume1/movies /volume1/music /volume1/series /volume1/transfer
After=volume1-downloads.mount volume1-homevideos.mount volume1-movies.mount volume1-music.mount volume1-series.mount volume1-transfer.mount
Requires=volume1-downloads.mount volume1-homevideos.mount volume1-movies.mount volume1-music.mount volume1-series.mount volume1-transfer.mount
```
- `sudo service docker reload`

# Docker Compose
- `sudo apt install -y docker-compose`

# Nvidia Docker
