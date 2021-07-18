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
net-tools
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
/volume1/downloads \
/volume1/backup
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

# Nvidia Driver
- `apt search nvidia-driver`
- Find largest value of `nvidia-driver-XXX`
- `sudo apt install -y nvidia-driver-465`
- `sudo reboot`

# Nvidia Docker
- [Reference Article](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
- [nvidia-docker vs nvidia-docker2](https://github.com/NVIDIA/nvidia-docker/issues/1268#issuecomment-632692949)
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```
- `sudo apt update`
- `sudo apt install -y nvidia-docker2`
- Required restart of Docker engine with new runtime: `sudo systemctl restart docker`
- Test: `sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`

# Disable Swap File
- [Reference Article](https://www.tecmint.com/add-swap-space-on-ubuntu/)
- Check for swap file: `sudo swapon --show`
- `sudo swapoff -v /swap.img`
- `sudo rm -rf /swap.img`
- `sudo vim /etc/fstab`
- Remove the line starting with `/swap.img`

# Disable UI
- [Reference Article](https://linuxconfig.org/how-to-disable-enable-gui-on-boot-in-ubuntu-20-04-focal-fossa-linux-desktop)
- `sudo systemctl set-default multi-user`

# Re-Mount 2nd HDD
- Create mount point: `sudo mkdir /cctv`
- Note disk name at: `sudo fdisk -l | grep /dev/sd`
- `blkid | grep /dev/sd`
- Copy UUID (first one)
- `sudo vim /etc/fstab`
- `/dev/disk/by-uuid/83e98c09-3e5e-4125-8f5e-65fa2196858f /cctv ext4 defaults 0 0`
- `sudo mount -a`

# Restore Docker Images
- `mkdir ~/.docker && cd ~/.docker`
- `tar -xf plex.tar`
- `sudo docker-copmpose up -d`
- `sudo docker logs -f plex`
