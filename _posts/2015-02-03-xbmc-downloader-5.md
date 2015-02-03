---
layout: post
title: XBMC Downloader, Part 5
categories: xbmc
---

###In a Nutshell
_Overview_
_Theory_
_NFS Mount_
_Installing Flexget_
_Git_
_Github SSH Keys_
_Flexget Setup_
_Flexget Guide_
_Conclusion_

###Overview



###Theory



My media library is on a different computer to my media PC (the XBMC downloader) so before we do any of that, I will quickly configure the downloader to automatically connect to the media library. If your media library is held locally, you don't need to worry about this step.

###NFS Mount

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

Do a quick reboot to make sure things are working:

`sudo reboot now`

###Git

Git is an incredibly versatile version control system. I host my Flexget configuration files on the popular [Github](http://www.github.com) site, allowing easy access and for anyone to see my work.

`sudo apt-get install git bash-completion`

You should know most of the above by now. `git` is the Git version control system, and `bash-completion` gives us a bit more flexibility when using the Tab key to complete commands when using Git.

Let's configure Git with a few useful defaults. Firstly, tell Git to always ignore compiled and other miscellaneous files that you'll be unlikely to ever want to track.

`vim /home/eagle/.gitignore_global`

Go ahead and copy the contents of [this file](https://gist.githubusercontent.com/octocat/9257657/raw/c91b435be351fcdff00f6f97f20824d0286b99ef/.gitignore) into the `.gitignore_global` file you have just opened in Vim.

Now apply the file to your Git configuration:

`git config --global core.excludesfile ~/.gitignore_global`

- `git` Git
- `config` configure Git
- `--global` configure Git across all projects
- `core.excludesfile` the universal exclude file
- `~/.gitignore_global` use the file we just created as the universal exclude file

###Github SSH Keys

If you're not going to be using Github as a backup, just go ahead and skip this section. This is mostly a self reference for the author, and only if you want to set up Github to track your Flexget configuration files.

`mkdir /home/eagle/.ssh`

- `mkdir` make a folder
- `/home/eagle/.ssh` by prepending a `.` the folder is hidden by default

`cd /home/eagle/.ssh`

- `cd` change directory
- `/home/eagle/.ssh` go to the directory we just made

`ssh-keygen -t rsa -C "dancingborg@server.fake"`

- `ssh-keygen` generate an SSH key
- `-t` type
- `RSA` make it an RSA key
- `-C` give it the following description (Comment)
- `dancingborg@server.fake` the name given to my key

Now press ENTER to generate the default files. Then enter a password for your SSH key.

Now go to your newly created SSH key and copy it into the approved list on Github.

`vim /home/eagle/.ssh/id_rsa.pub`

Add the contents of the above file as a new key to the [Github SSH Settings](https://github.com/settings/ssh) page.

Once we have added it as a key, we'll test that it is accepted.

`ssh -T git@github.com`

- `ssh` start a secure shell
- `-T` only test the shell, don't actually open it
- `git@github.com` connect to `github.com` with user `git`
