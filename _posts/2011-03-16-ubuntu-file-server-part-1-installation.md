---
layout: post
title:  "Ubuntu File Server Part 1: Installation"
date:   2011-03-16 09:07:00
categories: ubuntu-file-server
---

The following posts will document my journey to replace a Windows 7 torrent and file serving machine with Ubuntu 10.10 Server x64.

I was inspired to try this after reading a [post in the Ubuntu forums](http://ubuntuforums.org/showthread.php?t=1663597) about an user's attempt at an Ubuntu based file server.

A great reference moving forward from here is the [Ubuntu Server Guide](https://help.ubuntu.com/lts/serverguide/). When linking there, always check you're looking at the right release of Ubuntu Server; I've found myself on articles for previous versions many times and wondered why I wasn't getting any joy. The Ubuntu server guide has large gaps, but is overall, a good place to begin any project.

I began by installing Ubuntu Desktop x64 hoping that I might be able to rely on the GUI if my CLI skills were not up to the task of configuring the machine. I soon found out that the desktop edition requires significant tweaking to work headless.

As it turns out, [Teamviewer](http://teamviewer.com)'s Linux version runs under wine, working only as a window and not a service. I had intended to use Teamviewer to remote-desktop into the machine if CLI wasn't working out. Teamviewer can be added to the startup program list but then the machine would have to be configured to login to my account automatically. Most importantly, Ubuntu desktop edition is very unhappy (as of the time of this post) running without a monitor physically plugged in.

I am with the [Internode ISP](http://www.internode.on.net/) who host their own [Ubuntu mirror](http://mirror.internode.on.net/), so a trip here yielded the relevant .iso file for download. The machine was booted into the Ubuntu installer. Nothing unusual here, just keyboard choice (USA) and user names.I decided to ignore the network setup and configure it manually to learn how things worked. I then decided to format the entire system drive and to configure LVM. Although I'm not sure of the benefits of the LVM choice, it sounded like the option that might give more flexibility. I didn't install any extra packages (SAMBA, OpenSSH) because I didn't want the installer holding my hand.

After this, the installation process just takes time to complete. The CD gets ejected and a reboot is done. You'll be booted into the terminal login screen.

At this point the machine has had Ubuntu 10.10 Server x64 installed onto it but was not providing any services nor was it connected to any networks.

The Ubuntu Server is really quick, mostly because no assumptions have been made about how you intend to use the server and what it is for. Because of this, we have to install and configure any functionality we desire, past the basic terminal interface and the bare essential programs to use the terminal interface. In Part 2 we will set up a basic wired network connection to get our server connected to the internet.
