---
layout: default
title: Samba Share on Ubuntu
date: 2022-05-19 21:27:00 +0800
---

# Purpose
- Expose Tdarr cache for Windows node to participate
- Do above using Samba so that location of Cache didn't have to change, so that
  - SSD on server was best utilised instead of spinners on NAS
  - Less disruption to existing setup


# References
- [AskUbuntu.com Q&A](https://askubuntu.com/a/489971)
- [Samba: How to share files for your LAN without user/password](https://www.debuntu.org/samba-how-to-share-files-for-your-lan-without-userpassword/)
- [Re: Ignoring invalid value 'share' for parameter 'security'](https://ubuntuforums.org/showthread.php?t=2336297&s=f0b2ba40bc8586a7a39b953f4bd2f463&p=13541176#post13541176)
- [Samba and User Acount Passwords](https://askubuntu.com/a/153905)

# Actions

## Part 1 - Basic Setup
- Below steps are predominantly taken from *[Samba: How to share files for your LAN without user/password](https://www.debuntu.org/samba-how-to-share-files-for-your-lan-without-userpassword/)* but recorded here for posterity of exact steps taken
1. `sudo apt install -y samba`
2. `sudo vim /etc/samba/smb.conf`
3. Uncomment:
  - `interfaces = 127.0.0.0/8 eth0`
  - `bind interfaces only = yes`
4. Append:
  ```
  security = share
  guest account = nobody
  [tdarr]
     path = /cache/tdarr-cache
     browseable = yes
     guest ok = yes
  ```
5. `testparm` returned `Ignoring invalid value 'share' for parameter 'security'`
6. Apparently `security = share` [isn't a thing anymore](https://ubuntuforums.org/showthread.php?t=2336297&s=f0b2ba40bc8586a7a39b953f4bd2f463&p=13541176#post13541176)
7. Attempted to browse to the share on Windows
  - Share seen but unable to go inside
  - *The network name could not be found*
8. Refer [this article](https://www.linuxquestions.org/questions/linux-server-73/samba-test-share-works-but-homes-returns-with-network-name-cannot-be-found-549361/)
9. Mucked up `smb.conf`
10. `sudo apt remove -y samba samba-common && sudo apt purge -y samba samba-common && sudo apt autoremove -y && sudo rm -rf /etc/samba/ /etc/default/samba`
11. `sudo apt install -y samba`
12. `sudo cp /etc/samba/smb.conf /etc/samba/backup_smb.conf`
13. `sudo vim /etc/samba/smb.conf`
14. ```
  guest account = nobody

  [tdarr-temp]
     path = /tmp/tdarr-temp
     browsable = yes
     guest ok = yes
     writable = yes
  ```
15. `sudo systemcrl restart smbd`
16. Worked

## Part 2 - Write Access
- [Reference AskUbuntu answer](https://askubuntu.com/a/153905)
1. `sudo adduser [username]`
  - Enter password
2. `sudo smbpasswd -a [username]`
3. `sudo vim /etc/samba/smb.conf`
```
[tdarr]
   path = /tmp/tdarr-temp
   browsable = yes
   guest ok = yes
   writable = yes
   read only = no
   create mark = 666
   directory mask = 777
   force user = [username]
   force group = [username]
```
4. `testparm`
5. `sudo systemctl restart smbd`
6. This did not work even when mapping drive to enter credentials :(
7. `sudo chown [username]:[username] /tmp/tdarr-temp`
8. It worked.
9. Didn't need mapping of network drive in the end

# Reflections
- Samba, tricky at first, but fairly straight forward