---
layout: post
title: XBMC Downloader, Part 2
categories: xbmc
---

#Enough History

Most people these days can run XBMC on their Raspberry Pi. I choose to run XBMC on an [AsRock Ion 330](http://www.asrock.com/nettop/spec/ion%20330.asp) purely because I have one and it leaves my Pi for tinkering.

Technicalities aside, let's get down to business. What we want to do is upgrade our device so that it can download TV shows without a touch. Sounds impossible? Well, it isn't but explaining it all may prove painful to me. Luckily for you, you can make the most of my successes without wasting near as much time.

The first thing you want to do is get your XBMC working. Make sure it is happily playing back your local (or networked) movies and can play back a few YouTube clips. Initial setup is beyond the scope of this guide.

On your XBMC interface, navigate to `System --> System Info`. On the `Summary` tab you should see the IP address of the machine.

All done here for now. Go find another computer and download [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Open it up and type in the IP address you saw on your XBMC. In my example it was `192.168.1.120`.

Here's the part where, depending on your platform, what information you enter will differ.

If you have Raspbmc, for your username type `pi` and for your password type `raspberry`

If you have XBMCbuntu, for your username type `xbmc` and leave your password blank, unless you [entered a password](http://wiki.xbmc.org/index.php?title=XBMCbuntu/FAQ#How_can_I_transfer_files_to.2Ffrom_XBMCbuntu.3F) when you first installed XBMCbuntu.

You should be met with a black window containing a 'command prompt' with something like `eagle@osiris:~$`.