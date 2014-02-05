---
layout: post
title: XBMC Downloader, Part 1
categories: xbmc
---

The purpose of this guide is to modify a Linux-based XBMC distribution into an automated downloading station. I will do my best to explain every command and concept at the most basic level possible.

So you just finished installing [XBMC](http://xbmc.org/about/). It works a treat and you have configured it to playback your carefully pruned media library of Movies and TV Shows.

I will assume that you are using one of the following platforms.

-   XBMCbuntu
-   Raspbmc

Here's a quick primer on all the names:

-Linux (or GNU/Linux... don't get me [started](http://en.wikipedia.org/wiki/GNU/Linux_naming_controversy) is an open source operating system closely related to but not [Unix](http://www.cyberciti.biz/faq/what-is-the-difference-between-linux-and-unix/).

  - [Debian](http://www.debian.org/intro/about); is a powerful, balanced distribution of linux.
  
    - [Ubuntu](http://www.ubuntu.com/desktop) is a popular, easy to use spin-off linux distibution that is built upon Debian.
    
      -[XBMCbuntu](http://wiki.xbmc.org/index.php?title=XBMCbuntu/FAQ) is mostly Ubuntu with XBMC pre-installed and set to run on startup.
      
    - [Raspbian](http://www.raspbian.org/) is a version of Debian compiled for the unique processor ([ARM](http://en.wikipedia.org/wiki/ARM_architecture)) contained within the [Raspberry Pi](http://www.raspberrypi.org/about).
    
      - [Raspbmc](http://www.raspbmc.com/about/) is mostly Raspbian with XBMC pre-installed and set to run on startup.

As you can see, both XBMC and Raspbmc operate on a Debian core. This means that commands and programs are mostly identical for our purposes.

Most people these days can run XBMC on their Raspberry Pi. I choose to run XBMC on an [Asrock Ion 300](http://www.asrock.com/nettop/spec/ion%20330.asp) purely because I have one and it leaves my Pi for tinkering.

Technicalities aside, let's get down to business. What we want to do is upgrade our device so that it can download TV shows without a touch. Sounds impossible? Well, it isn't but explaining it all may prove painful to mee. Luckily for you, you can make the most of my successes without wasting near as much time.

The first thing you want to do is get your XBMC checked out. Make sure it is happily playing back your local (or networked) movies and can play back a few YouTube clips.

On your XBMC interface, navigate to `System --> System Info`. On the `Summary` tab you should see the IP address of the machine.

All done here for now. Go find another computer and download [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Open it up and type in the IP address you saw on your XBMC. In my example it was `192.168.1.120`.

Here's the part where, depending on your platform, what information you enter will differ.

If you have a Raspberry Pi, when asked for a username, type in `pi`. When asked for a password, type in `raspberry.'

If you have XBMCbuntu
