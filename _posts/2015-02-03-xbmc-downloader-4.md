---
layout: post
title: XBMC Downloader, Part 4
categories: xbmc
---

###In a Nutshell
_Overview_
_Theory_
_Installing Flexget_
_Flexget Setup_
_Flexget Guide_
_Conclusion_

###Overview

In the last part, we spent most of our time installing and configuring Deluge as our torrent download program. We learnt a bit about startup scripting and added some configuration files.

Deluge is one half of our automatic downloading system. The other half, is a program called [Flexget](http://flexget.com/). Flexget *really is magic*. The limit is really your imagination, this program can download just about anything, given the right input.

###Theory

Deluge and Flexget are both written in the [Python](https://www.python.org/) language. Deluge, being much more popular, has an entry in the official Ubuntu repositories, allowing us to use a package manager to easily install it.

Flexget, being less popular, is not on the official repositories. We will use some alternative methods to automate its install process.

My media library is on a different computer to my media PC (the XBMC downloader) so before we do any of that, I will quickly configure the downloader to automatically connect to the media library. If your media library is held locally, you don't need to worry about this step.

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

###Flexget Setup

So it's time to set up get Flexget working for us. Flexget uses the flexible and rather sensible [YML](http://fdik.org/yml/) markup language for its settings. It's worth getting acquainted with YML because it's versatile but quite strict with indentation. If in doubt, run `flexget -v` and it will tell if and where you have made any mistakes.

Flexget is as good as its source of information. I use [showRSS](http://showrss.info/) because it is fairly quick with adding shows once they have been aired, and it gives them a nice formatting. It also does traditional torrent files (not magnets) which means you can tell it to skip the fluff files like *.jpgs* and all the other stuff that usually comes with scene torrents.

####Option 1

Don't sign up to Flexget. Use the individual feeds available publicly to check each feed for new episodes. In this case, use an [old version](https://raw.githubusercontent.com/dancingborg/.config_FlexGet/67495e11e2c74aa7a7e09af297ff6ed46b152832/config.yml) of my configuration files as a template.

####Option 2

Sign up to showRSS, add all the TV shows you want, and get a custom RSS feed with all your shows. The downside to this, is that it doesn't go back as far, in case you missed a week. Once you're done with this, start a new configuration for Flexget.

`vim /home/eagle/.flexget/config.yml`

Then copy in the contents of my [latest version](https://raw.githubusercontent.com/dancingborg/.config_FlexGet/master/config.yml) into your configuration file manually.

###Flexget Guide

The following is a walkthrough of how my Flexget configuration file works. I have formatted it in valid YML, in case you wish to use it. Comment fields describing functionality begin with the `#` symbol. Be sure to checkout the [Flexget Wiki](http://flexget.com/wiki/Plugins) to get a better understanding of how the various plugins below actually work.

Use [this link]() to see an annotated example of a configuration for Flexget.

###Conclusion

In this part of the guide, we have installed Flexget using Python install tools, installed Git and cloned by personal Flexget configurations to the local directory. You can spend hours configuring Flexget for optimal downloads, and I certainly have done so. It's worth spending time with Flexget. It's a powerful tool.
