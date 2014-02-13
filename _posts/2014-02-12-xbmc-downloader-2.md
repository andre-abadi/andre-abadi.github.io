---
layout: post
title: XBMC Downloader, Part 2
categories: xbmc
---

###In a Nutshell
_Overview_
_Making the Connection_
_Trying It Out_
_Conclusion_

###Overview

Having read Part 1 of the guide, I hope you now have an understanding of what Linux and a Command-line Interface is.

In Part 2 of this guide, we will be accessing the command line interface of our XBMC over the LAN to which it is attached.

###Making the Connection

All computer operating systems have at their core a terminal interface. Remember the command-line interface from Part 1? The terminal interface is an example of one! Modern operating systems are able to “paint” over this with a [Graphical User Interface](http://en.wikipedia.org/wiki/Graphical_user_interface). All the GUI does is abstract the text layer most of the time, but if the GUI can’t start or if something goes wrong, you’re probably familiar with crashing back down to the terminal, such as the [Blue Screen of Death](http://en.wikipedia.org/wiki/Blue_Screen_of_Death) or the [Recovery Console](http://en.wikipedia.org/wiki/Recovery_Console) in Windows.

What if you want the power of a terminal while working within the ease of a GUI? The answer is a [terminal emulator](http://en.wikipedia.org/wiki/Terminal_emulator). It allows you to pass textual commands to the operating system, just like if you were using the native terminal but from the comfort of the GUI. It’s called an emulator because it’s not the actual terminal but emulates the behaviour.

If we can emulate a terminal from a graphical user interface, then why not a network interface? In fact we can. All we need to do is add a layer of security so that not anybody can delete all our files from anywhere on the network. The most common method of securely emulating a terminal over the network is known as [SSH](http://en.wikipedia.org/wiki/Secure_Shell), the Secure SHell. Don’t be confused by the shell. Just like the desktop is a program within which other programs are run, the shell is the program within which we issue textual commands.

[PuTTY](http://en.wikipedia.org/wiki/PuTTY) is a popular, Windows-base terminal emulator. Most commonly it is used to connect to a host over the network using the SSH protocol. PuTTY is a program that runs within the Windows GUI. It uses the SSH protocol to make a connection with an UNIX-like host and once connected is able to interact with its shell program. These text-based interactions are displayed in a terminal-like manner. It is emulating a terminal remotely; a _remote_ _terminal_ _emulator_.

Go ahead and [download PuTTY](http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe) to somewhere you can easily get to. Open it up and take a moment to look around because you’ll be seeing this screen often.

![PuTTY]({{ site.url }}/_img/PuTTY.jpg)

Here are the 3 things that are important, the rest is just bells and whistles.

1.  `Host Name (or IP address)` is the network address to which you will connect.
2.  `Port` should remain `22` unless you know it to be otherwise.
3.  `Connection type` should always be SSH.

You can see that I have saved some sessions (`osiris` and `raspberrypi`). They are just there to save me time, but try figuring that out yourself once you are more comfortable with things.

Now head over to your XBMC and go to `System` then `System Info`. Here you should be able to observe the IP address that your local router has assigned the device running XBMC. For me it was `192.168.1.120` but for you it might be different.

Go back to your computer and open up PuTTY. Remember that `SSH` and Port `22` are default values. I entered the following details but remember to replace my example IP with the one for your XBMC device.

	Host Name (or IP address):  192.168.1.120
	Port: 22
	Connection type: SSH 



###Trying It Out

###Conclusion

Had enough of history? Me too. Hopefully I’ve managed to cover off all of the names and concepts involved. It is important to understand the context of that upon we are about to embark.

In the next part, we will connect to our Linux host over the Local Area Network using PuTTY and the SSH protocol.