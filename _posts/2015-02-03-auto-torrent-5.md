---
layout: post
title: Automatic TV Show Torrents on Kodi, Part 5
categories: tvtorrent
---

###In a Nutshell
_Overview_
_NFS Mount_
_Git_
_Github_
_Crontab_
_Notifications_
_Conclusion_

###Overview

Now that the basic functionality of the downloader is completed, this part of the guide will deal with some more advanced concepts, and is mainly a self-reference for the author to replicate the original setup, should it be necessary.

###Theory

My media library is on a different computer to my media PC (the XBMC downloader) so before we do any of that, I will quickly configure the downloader to automatically connect to the media library. If your media library is held locally, you don't need to worry about this step.

In addition, with the number of revisions I've made to my Flexget configuration, I like to keep a backup. I use Git and more specifically, Github, to enact some version control on the configuration file. This also means that my work is more public, should anyone like to see it.

I will laso use the Linux task scheduler `cron` to set up some automated cleanup of files. This prevents various directories from getting a bit clogged up. These tasks have been created as a result of my experience with the XBMC downloader over a number of months. They are entirely optional and should be used at your discretion.

Lastly, and for some extra polish, I will set up an XBMC notification for the downloads occurring on that computer. It means that when someone turns on the XBMC computer, they can immediately know if the TV show they are waiting for has been or is being downloaded.

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

    192.168.1.150:/volume1/Series  /media/Series  nfs rsize=8192,wsize=8192,timeo=14,intr,_netdev
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

###Github

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

###Crontab

Cron is a software utility in Linux that runs tasks based on a time schedule. Cron interprets the time schedule based on a *cron table*, shortened to `crontab`. In Ubuntu, instead of editing the file directly, `crontab` is wrapped in a program, so that it can be edited in a safer manner.

`sudo crontab -e`

- `sudo` run as root
- `crontab` open the cron table
- `-e` edit the cron table

Have a look at [this link]() to see my version of the file. The large portion of comments is from the default cron table, and the entries are my own. Here is a brief overview of what each of the three entries does:

1.  When the computer is started, clear out any crash logs from the home directory.
2.  When the computer is started, delete any empty folders in the torrents folder. This is useful because as Deluge only moves the main file to the correct folder in the media library, it often leaves behind empty or near empty folders.
3.  When the computer starts, run Flexget using our configuration file.

Make sure that your cron table has **at least one line at the end** otherwise it won't work. This appears simply to be an idiosyncrasy of the cron system, you'll just have to live with it and remember.

###Notifications

To add some polish to our setup, we will cause a "toaster" style notification to pop up on our XBMC interface whenever a torrent is started or finished. The use case is as follows:

> A lay person sits down on the day their favourite TV show is aired, and turns on the XBMC installation. The XBMC downloader should inform them which TV shows are being downloaded and should tell them when they are finished.

To so, we will make use of the `Execute` plugin of Deluge to execute some *Shell Scripts* when a torrent is added and when a torrent is finished.

`vim /home/eagle/.config/deluge/started.sh`

Go ahead and past the contents of [this link](https://raw.githubusercontent.com/dancingborg/dancingborg.github.io/master/_misc/started.sh) into your new shell script. Save and close the file, then recall that we have to alter its permissions so that the file can be executed:

`chmod u+x /home/eagle/.config/deluge/started.sh`

Now we'll do the same but with a script for when it is finished.

`vim /home/eagle/.config/deluge/finished.sh`

Use the contents of [this link](https://raw.githubusercontent.com/dancingborg/dancingborg.github.io/master/_misc/finished.sh).

`chmod u+x /home/eagle/.config/deluge/finished.sh`

For the last step, we need to use the Deluge GTK client available at this [link](http://dev.deluge-torrent.org/wiki/Download). Thanks to our previous work in the earlier parts, all you need to do is follow [these instructions](http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient#GTKUI) and your Deluge program will interface with the daemon running on your XBMC downloader.

In the Deluge client, click `Settings` then `Plugins`. Find the plugin called `Execute` and tick it.

Once the plugin is enabled, go `Settings` then `Execute`.

The last step is simply to add the script as the command to execute for when torrents are started and finished.

Torrent Complete: `/home/eagle/.config/deluge/finished.sh`
Torrent Added: `/home/eagle/.config/deluge/started.sh`

###Conclusion

And there you have it. That's everything I did. Hopefully you've learnt a bit along the way, as I have certainly learnt a lot in writing this guide. Thank you for taking the time to read through the guide. I hope your humble XBMC installation is now a powerful, automated TV show and movie downloader.
