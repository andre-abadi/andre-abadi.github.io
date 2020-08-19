---
layout: post
title: Automatic TV Show Torrents on Kodi, Part 3
categories: tvtorrent
---

###In a Nutshell
_Overview_
_Theory_
_Deluge_
_Daemon_
_Startup_
_Console Config_
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

###Daemon

Once completed, there is some customising to be done. First we will edit the settings of the Deluge daemon.

`sudo nano /etc/default/deluge-daemon`

- `sudo` does this command as a super-user.
- `nano` is a basic text editor in Linux.
- `/etc/default/deluge/daemon` is the argument for `nano` and the text file we wish to open.

Once we have opened this file, place the following text inside:

    # Configuration for /etc/init.d/deluge-daemon
    # The init.d script will only run if this variable non-empty.
    # This tells the Deluge daemon which user it will run its process as
    DELUGED_USER="eagle"
    # Should we run at startup?
    RUN_AT_STARTUP="YES"

This tells the Deluge daemon to run with the same permissions as us, and to run at startup.

###Startup

In the world of command line Linux, setting a service (background program) to run at startup isn't quite as easy as putting a shortcut in the Startup folder on Windows.

In Linux, a program runs on startup if there exists a script to tell it so. These scripts are held in the `init.d` directory, and they start almost all essential services when your Linux operating system boots up.

We're going to create an *init* script for the Deluge daemon.

`sudo vim /etc/init.d/deluge-daemon`

- `sudo` run as root
- `vim` run the Vim text editor
- `/etc/init.d/deluge-daemon` tells Vim to open the deluge-deamon file in the /etc/init.d/ directory. In this case, the file doesn't exist, so Vim will create a new file that will have this name and location when we hit save.

Click on [this link](http://raw.githubusercontent.com/dancingborg/dancingborg.github.io/master/_content/deluge-daemon.txt), copy the contents of the file and paste them into Vim on your Linux computer. There's no need to understand the contents of this file. All you need to know is that it conducts a number of checks and starts the Deluge daemon.

Linux is a lot more strict (and therefore secure) than Windows with regard to file permissions. By default, no file you create is executable. We are going to change the permissions of the *init* script we just created, so that it can be executable.

`sudo chmod a+x /etc/init.d/deluge-daemon`

- `sudo` run as root
- `chmod` modify file permissions
- `a+x` access and execute
- `/etc/init.d/deluge-daemon` the file whose permissions to modify

The above code has altered the permissions of our *init* script so that it can be executed, and the code within it to be run on startup.

Just because it's in the `init.d` directory and executable, doesn't mean Linux will run it automatically. We tell the operating system to updated its list of startup services in `rc.d` with our new `deluge-daemon` startup script.

`sudo update-rc.d deluge-daemon defaults`

- `sudo` run as root
- `update-rc.d` update startup service list
- `deluge-daemon` use the named file (notice that `update-rc.d` knows to look in `/etc/init.d/` for this file)
- `defaults` use default settings for this command

Time to reboot and see if it all worked.

`sudo reboot now`

- `sudo` run as root
- `reboot` restart the computer
- `now` ...now

Once you're back, check to see if the Deluge daemon is running.

`top | grep deluged`

- `top` list all running processes
- `|` run the following command on the output of the `top` command
- `grep` find the text following this command
- `deluged` name of the Deluge daemon process

Hopefully, you should get a result something like this:

    1184 eagle     20   0 50952  16m 6552 S   6.1  0.9   2:44.42 deluged
    1184 eagle     20   0 50952  16m 6552 S   2.7  0.9   2:44.50 deluged
    1184 eagle     20   0 50952  16m 6552 S   2.0  0.9   2:44.56 deluged
    1184 eagle     20   0 50952  16m 6552 S   2.7  0.9   2:44.64 deluged
    1184 eagle     20   0 50952  16m 6552 S   2.0  0.9   2:44.70 deluged
    1184 eagle     20   0 50952  16m 6552 R   2.7  0.9   2:44.78 deluged
    1184 eagle     20   0 50952  16m 6552 S   2.3  0.9   2:44.85 deluged

That means that your Deluge daemon service started correctly. Well done!

###Console Config

Deluge is almost ready for use. A few last bits to make life easier is to configure it to allow remote connections.

`deluge-console`

This starts the command-line Deluge interface, from where we can conduct some configuration.

`config -s allow_remote True`

- `config` make a configuration change
- `-s allow_remote` modify the permission of connections to the program from outside the current computer
- `True` allow connections from other computers

Now we check the change with the following command, still in the command line Deluge interface.

`config allow_remote`

This should return the following:

    >>> config allow_remote
      allow_remote: True

As you can see, Deluge has modified the setting, allowing connections to the program from outside the computer it's running on.

Just hit `exit` and you're out of there. Now we'll halt the daemon process and modify some settings.

`sudo pkill deluged`

- `sudo` ...run as root
- `pkill` kill the process
- `deluged` with this name, i.e. our Deluge daemon

Once the daemon has been halted, we can modify its settings. If you skip this step, you can change the settings but they won't actually be applied.

First we add a user to the authorised users file:

`vim /home/eagle/.config/deluge/auth`

Add the following line to the file:

`username:password:10`

The above line use a username, password and privelege level. I'm keeping things simple for the purposes of demonstration.

Now we'll modify some of the behaviour of the web interface.

`vim /home/eagle/.config/deluge/web.conf`

Find the line with `"default_daemon":",` and change it to `"default_daemon": "127.0.0.1:58846",`. This tells the web interface to look for a local daemon on port 58846 and attempt to connect to it, instead of asking you every time you log in to the web interface.

Now you can go and download the Deluge [Windows client](http://dev.deluge-torrent.org/wiki/Download), and follow the directions [here](http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient#GTKUI) to connect it to the Daemon you just set up.

Having the native Windows GUI allows you to use and change settings on the daemon with ease similar to if it were running on your Windows computer.

###Conclusion

In this part of the guide, we have used a package manager to install a number of packages related to the Deluge torrent program. We then modified some configuration files, created a startup script and configured it to run the service automatically at startup.
