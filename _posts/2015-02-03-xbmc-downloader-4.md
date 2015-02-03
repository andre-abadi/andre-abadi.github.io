---
layout: post
title: XBMC Downloader, Part 4
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

In the last part, we spent most of our time installing and configuring Deluge as our torrent download program. We learnt a bit about startup scripting and added some configuration files.

Deluge is one half of our automatic downloading system. The other half, is a program called [Flexget](http://flexget.com/). Flexget *really is magic*. The limit is really your imagination, this program can download just about anything, given the right input.

Two tools we will be using are the [Git](http://git-scm.com/) version control system and the [Python](https://www.python.org/) programming language. Flexget runs on Python, and I use Git to keep backups of my Flexget configuration files.

###Theory

Deluge and Flexget are both written in the [Python](https://www.python.org/) language. Deluge, being much more popular, has an entry in the official Ubuntu repositories, allowing us to use a package manager to easily install it.

Flexget, being less popular, is not on the official repositories. We will use some alternative methods to automate its install process.

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

###Installing Flexget

To install Flexget, we we need to first install some Python installation tools. Just as we use a package manager to install Deluge, we use a Python package manager to install Flexget.

`sudo apt-get install python-gdbm python-setuptools`

- `sudo` run as root
- `apt-get` package manager
- `install` command
- `python-gdbm python-setuptools` various libraries that will automate the installation process for us

Thanks to the programs we just installed, it's now as easy as:

`sudo easy_install flexget`

- `sudo` run as root
- `easy_install` the Python equivalent of `apt-get install`
- `flexget` install Flexget

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

###Flexget Setup

So it's time to set up get Flexget working for us. Flexget uses the flexible and rather sensible [YML](http://fdik.org/yml/) markup language for its settings. It's worth getting acquainted with YML because it's versatile but quite strict with indentation. If in doubt, run `flexget -v` and it will tell if and where you have made any mistakes.

Flexget is as good as its source of information. I use [showRSS](http://showrss.info/) because it is fairly quick with adding shows once they have been aired, and it gives them a nice formatting. It also does traditional torrent files (not magnets) which means you can tell it to skip the fluff files like *.jpgs* and all the other stuff that usually comes with scene torrents.

####Option 1

Don't sign up to Flexget. Use the individual feeds available publicly to check each feed for new episodes. In this case, use an [old version](https://raw.githubusercontent.com/dancingborg/.config_FlexGet/67495e11e2c74aa7a7e09af297ff6ed46b152832/config.yml) of my configuration files as a template.

####Option 2

Sign up to showRSS, add all the TV shows you want, and get a custom RSS feed with all your shows. The downside to this, is that it doesn't go back as far, in case you missed a week.

`git clone git@github.com:dancingborg/.config_FlexGet.git /home/eagle/.flexget`

- `git` Git
- `clone` copy from the server
- `git@github.com:dancingborg/.config_FlexGet.git` copy this directory
- `/home/eagle/.flexget` copy it there

Alternatively, you could do the following:

`vim /home/eagle/.flexget/config.yml`

Then copy in the contents of my [latest version](https://raw.githubusercontent.com/dancingborg/.config_FlexGet/master/config.yml) into your configuration file manually.

###Flexget Guide

The following is a walkthrough of how my Flexget configuration file works. I have formatted it in valid YML, in case you wish to use it. Comment fields describing functionality begin with the `#` symbol. Be sure to checkout the [Flexget Wiki](http://flexget.com/wiki/Plugins) to get a better understanding of how the various plugins below actually work.

      # Presets allow Flexget to apply one set of actions to multiple tasks of
      # the same type. Most importantly this means you don't type these things
      # more than once.
    presets:

        # This preset is for TV Shows.
      tvtorrent:
          # Use the exist_series plugin to recursively search through the Series
          # folder to check if the file to be downloaded already exists.
        exists_series: /media/Series/
          # Don't use magnets because they get in the way of main_file_only.
        magnets: no
          # Download the torrent using Deluge.
        deluge:
            # Self explanatory.
          user: deluge
            # Self explanatory.
          pass: deluge
            # Only download the biggest file. This means samples and jpgs
            # don't get downloaded.
          main_file_only: yes
            # Makes the torrent conform to the global torrent settings relating
            # to seed times and seed ratios.
          automanaged: true
            # Rename the biggest file in the torrent to the following:
            # EG: Mad Men - S01E01
            # Flexget automatically understands this syntax.
          content_filename: '%(series_name)s - %(series_id)s'
            # When the main file is done, move it to the appropriate folder.
            # EG: /media/Series/Mad Men/Season 1/
          movedone: /media/Series/%(series_name)s/Season %(series_season)d/
            # Finish seeding when the torrent reaches this ratio.
          ratio: 0.0001
            # Remove the torrent when it has reached this ratio.
          removeatratio: yes

        # This is for movies.
      movie:
          # Recursively search through MoviesHD to make sure that we don't
          # already have this movie in the library.
        exists_movie: /media/MoviesHD/
          # Use Deluge to download the torrent.
        deluge:
            # Self explanatory.
          user: deluge
            # Self explanatory.
          pass: deluge
            # Makes the torrent conform to the global torrent settings relating
            # to seed times and seed ratios.
          automanaged: true
            # Rename the folder according to the following criteria:
            # EG: The Interview (2014)
            # Note that due to the YTS task requiring IMDB info, Flexget
            # will automatically have all IMDB metadata on hand
          content_filename: "{{imdb_name}} ({{imdb_year}})"
            # Move the finished torrent folder to the MoviesHD folder.
          movedone: /media/MoviesHD/
            # Finish seeding when the torrent reaches this ratio.
          ratio: 0.0001
            # Remove the torrent when it has reached this ratio.
          removeatratio: yes

      # These are the actual tasks to be completed, using the presets above.
    tasks:

        # TV Show task, name is arbitrary.
      showRSS:
          # Use an RSS feed as the source. This it my custom showRSS feed.
          # Be sure that whatever Flexget is looking for is actually in
          # the RSS feed, otherwise it'll never download anything.
        rss: http://showrss.info/rss.php?user_id=227669&hd=0&proper=1&magnets=false
          # Download the listed series.
        series:
            # Each series list listed, and Flexget will check the RSS feed
            # for all entries.
          - Modern Family
          - Suits
          - Castle (2009)
          - Downton Abbey
          - Game of Thrones
          - Grey's Anatomy
          - How I Met Your Mother
          - Mad Men
          - The Blacklist
          - The Big Bang Theory
          - America's Next Top Model
          - Boardwalk Empire
          - Homeland
          - Elementary
          - Scandal (2012)
          - House of Cards (2013)
          - Glee
          - MythBusters
          - Sherlock
          - Top Gear

          # If an entry is found use the tvtorrent preset to download it.
        preset:
          - tvtorrent

        # Task name for Movies, again arbitrary.
      YTS:
          # All 1080p movies from YIFI that have an IMDB score of at least 7.
        rss: http://yts.re/rss/0/1080p/All/7
          # Download all entries, they have already been filtered.
        accept_all: yes
          # Override the accept_all and make sure that movies are not
          # downloaded if they have already been marked as downloaded by
          # Flexget
        seen_movies: strict
          # Make sure that Flexget can retrieve the full IMDB metadata
          # otherwise don't download the movie.
        imdb_required: yes
          # Apply the following IMDB filters to the list
        imdb:
          reject_genres:
            - horror
            - documentary
          # Only download 1 entry per execution of this task.
        limit_new: 1
          # Only download 1 entry per day.
        interval: 1 days
          # On accepted entries, download them using the movie preset.
        preset:
          - movie
