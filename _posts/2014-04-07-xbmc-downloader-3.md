---
layout: post
title: XBMC Downloader, Part 3
categories: xbmc
---

###In a Nutshell
_Overview_
_Theory_
_Deluge_
_Daemon_
_Conclusion_

###Overview
In the last part of the guide we made a connection to our XBMC device using SSH. This time we will be using that connection to install a number of programs. We will be exploring concepts such as package managers, configuration files and daemons.

###Theory

In Windows one downloads a pre-compiled, executable file from a website and then manually runs it on the target computer. In Linux it is more common to use a package management system, which automatically sources and downloads the latest and correctly compatible files, and installs them for you.

Because there are many different versions of Linux and many different distributions, package managers are built to pick the right version, as well as any programs that yours depends on.

In Ubuntu, users that are administrators are called super users. From the command line it is very easy to destroy the operating system with an errant delete command. As such, it forces users to prepend the `sudo` command when executing potentially dangerous code. It is short for _Super User Do_.

###Deluge

Log into your XBMC and when presented by the command prompt, enter the following:

`sudo apt-get install deluged deluge-webui deluge-console`

- `sudo` allows us to run system-altering commands by elevating our user privelages for one command.
- `apt-get` is a package management system for Linux.
- `install` is the main argument, telling _apt-get_ to install packages named in the following arguments.
- `deluged` is the Deluge Daemon.
- `deluge-webui` is the Deluge Web User Interface.
- `deluge-console` is the Deluge console interface.

Observe that the apt-get takes the install command and can take any reasonable number of arguments after that. We could have installed each package separately but let us keep building our knowledge.

You will be prompted for your password, followed by a confirmation that you wish to make said changes. Have a read of the output and try to understand what it is getting at before typing `yes` and pressing _Enter_.

The package manager should automatically retrieve a number of files, and install them in the correct location.

Once completed, there is some customising to be done.

`sudo nano /etc/default/deluge-daemon`

- `sudo` does this command as a super-user.
- `nano` is a basic text editor in Linux.
- `/etc/default/deluge/daemon` is the argument for `nano` and the text file we wish to open.

Once we have opened this file, place the following text inside:
```bash
# Configuration for /etc/init.d/deluge-daemon
# The init.d script will only run if this variable non-empty.
DELUGED_USER="eagle"
# Should we run at startup?
RUN_AT_STARTUP="YES"
```
