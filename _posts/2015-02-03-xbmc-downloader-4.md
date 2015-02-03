---
layout: post
title: XBMC Downloader, Part 4
categories: xbmc
---

###In a Nutshell
_Overview_
_Theory_
_NFS Mount_
_Conclusion_

###Overview

In the last part, we spent most of our time installing and configuring Deluge as our torrent download program. We learnt a bit about startup scripting and added some configuration files.

Deluge is one half of our automatic downloading system. The other half, is a program called [Flexget](http://flexget.com/). Flexget *really is magic*. The limit is really your imagination, this program can download just about anything, given the right input.

###Theory

Deluge and Flexget are both written in the [Python](https://www.python.org/) language. Deluge, being much more popular, has an entry in the official Ubuntu repositories, allowing us to use a package manager to easily install it.

Flexget, being less popular, is not on the official repositories. We will use some alternative methods to automate its install process.

My media library is on a different computer to my media PC (the XBMC downloader) so before we do any of that, I will quickly configure the downloader to automatically connect to the media library. If your media library is held locally, you don't need to worry about this step.

##NFS Mount

First we create a folder (directory) where we will mount the networked media library.

`sudo mkdir /media/Series`

- `sudo` run as root
- `mkrir` make a directory (folder)
- `/media/Series` make a folder called `Series` in the `/media` folder

I have used configuration tools beyond the scope of this guide to make an NFS mount available on my media server.

Let's have a look at what we can connect to from our downloader.

`showmount -e 192.168.1.150`

- `showmount` list NFS directories that can be mounted
- `-e` external
- `192.168.1.150` at this IP address

For me it returns the following:

    Export list for 192.168.1.150:
    /volume1/MoviesSD 192.168.1.120
    /volume1/Series   192.168.1.120
    /volume1/MoviesHD 192.168.1.120

As you can see, 3 directories have been made available to this computer (192.168.1.120).

We will edit the `fstab` file to automatically connect to the `Series` folder on the media server.

`sudo vim /etc/fstab`

In this file, we will add the following line:

    192.168.1.150:/volume1/Series  /media/Series  nfs
    rsize=8192,wsize=8192,timeo=14,intr,_netdev

- `192.168.1.150:` the address from which to mount the folder
- `/volume1/Series` the folder to mount
- `/media/Series` where to mount it
- `nfs` the protocol to use
- `rsize=8192,wsize=8192,timeo=14,intr,_netdev` some optimisations
