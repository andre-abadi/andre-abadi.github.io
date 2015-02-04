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

All computer operating systems have at their core a terminal interface. Modern operating systems are able to draw over this with a [Graphical User Interface](http://en.wikipedia.org/wiki/Graphical_user_interface). The GUI normally sits in front of the terminal, but if the GUI can’t start or if something goes wrong, you’re probably familiar with crashing back down to a terminal, such as the [Blue Screen of Death](http://en.wikipedia.org/wiki/Blue_Screen_of_Death).

Ending the GUI to access the terminal is a hassle, so modern operating systems have [terminal emulators](http://en.wikipedia.org/wiki/Terminal_emulator) that emulate the terminal behaviour from within the GUI.

Modern operating systems also allow terminals to be emulated over the network. The most common method of securely emulating a terminal over the network is known as [SSH](http://en.wikipedia.org/wiki/Secure_Shell), the Secure SHell. Don’t be confused by the shell. Just like the desktop is a program within which other programs are run, the shell is the program within which we issue textual commands.

[PuTTY](http://en.wikipedia.org/wiki/PuTTY) is a popular, Windows-based terminal emulator. Most commonly it is used to connect to a host over the network using the SSH protocol. PuTTY is a program that runs within the Windows GUI. It uses the SSH protocol to make a connection with an UNIX-like host and once connected is able to interact with its shell program. These text-based interactions are displayed in a terminal-like manner. It is emulating a terminal remotely; a _remote_ _terminal_ _emulator_.

###Trying It Out

Go ahead and [download PuTTY](http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe) to somewhere you can easily get to. Open it up and take a moment to look around because you’ll be seeing this screen often.

[![PuTTY](https://raw.github.com/dancingborg/dancingborg.github.io/master/_img/PuTTY.jpg)](https://raw.github.com/dancingborg/dancingborg.github.io/master/_img/PuTTY.jpg)

Here are the 3 things that are important, the rest is just bells and whistles.
- `Host Name (or IP address)` is the network address to which you will connect.
- `Port` should remain `22`.
- `Connection type` is `SSH`.

Now head over to your XBMC and go to `System` then `System Info`. Here you should be able to observe the IP address that your local router has assigned the device running XBMC. For me it was `192.168.1.120` but for you it might be different.

Go back to your computer and open up PuTTY. Remember that `SSH` and Port `22` are default values. Enter the IP address you found on XBMC into the `Host Name (or IP address)` field.

1.  Click `Open`
2.  If a pop-up window appears, click `Yes`.
3.  A black window should appear.
4.  Inside will appear a prompt asking for your username.
  - If you have *Raspbmc*, type in `pi`
  - If you have *XBMCbuntu*, type in `xbmc`
5. A prompt will ask for you password.
  - If you have *Raspbmc*, type in ‘raspberry’
  - If you have *XBMCbuntu*, just press enter (no password).
6. A series of messages should appear

PuTTY, using a username and password for security, just connected to your Linux device via SSH over the network and started a shell program. That shell program, once started, returned a command prompt, which was sent back over the network to PuTTY, which displayed it on your screen. PuTTY is now emulating the terminal of your Linux device over the network.

That’s the shell program on the host computer giving you a command prompt right there. Try typing in `who` and press enter. As mentioned in Part 1, we just passed a command to the shell program on the Linux device. It returned certain information pertaining to your current login, and once completed, returned to you another command prompt.

Type in `exit` and press enter. The connection between you and the host computer has been terminated and the Shell program ended. It is now safe to end the terminal emulation program and close PuTTY.

###Conclusion

Well done, you have just connected to your Linux device running XBMC, and remotely emulated a text terminal. With an understanding of the command-line interface, at the prompt you entered a command to the shell program, receiving a textual result back from the shell program. Once it finished executing the command, it returned to you another command prompt.

You then safely closed the remote connection to the shell program and ended the terminal emulation locally.

We won’t go into quite as much detail in subsequent parts of this guide, but I felt it was important to give a good grounding in the very basics of what we are doing. The rest of the guide will all be done via SSH, hence it is important to understand the concepts involved in doing so.

Next time we will learn about software packages in Linux and will practise this understanding by installing the world’s best text editor; Vim.
