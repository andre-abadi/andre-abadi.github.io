---
layout: post
title: XBMC Downloader, Part 2
categories: xbmc
---

###In a Nutshell
_Overview_
_Going Deeper_
_The Terminal Emulator_
_The Secure Shell_

###Overview

Having read Part 1 of the guide, I hope you now have an understanding of what Linux and a Command-line Interface is.

In Part 2 of this guide, we will be accessing the command line interface of our XBMC over the LAN to which it is attached.

###Going Deeper

Linux’s ancestor UNIX was developed during the time of mainframe computers. Back in those days, the mainframe computer only accepted serial binary input. What this means is that they could only accept a sequence of 1s and 0s.  During the time of punch cards and paper tape, the first Computer Terminals were developed. Instead of users having to translate their entire command into such a sequence, Computer Terminals allowed users to type a series of text-based commands, which the machine would translate into [serial binary](http://en.wikipedia.org/wiki/RS-232) signals and send that to the mainframe. When the mainframe replied, it could print the result on paper or later, on a TV screen.

With the first terminals, every keystroke was sent to the mainframe for processing. As technology developed, terminals begain to contain microprocessors, allowing them to conduct basic editing and small functions _before_ the command was sent to the mainframe. These Terminals still sent their commands to the mainframe via a serial cable or over a modem if separated geographically.

With the advancement of technology and reduction in size, eventually the mainframe was small enough to fit in the terminal, and the personal computer was born. The interface remained the same but the paradigm shifted. With the advent of the Graphical User Interface, the terminal became a thing of the past. Today the need to issue commands to our computers via text remains a powerful way in which we can interact with them.

###The Terminal Emulator

Modern operating systems don’t have terminals anymore. Most of them do, however, feature a [terminal emulator])http://en.wikipedia.org/wiki/Terminal_emulator), which is a program that emulates the terminal. Because the underlying operating system remains the same, we can still pass textual data to the operating system and have it return textual information. Modern computers can do so much more than crunch numbers and hence, so can modern terminal emulators.

The terminal emulator allows us to access the operating system’s Shell. The Shell is the layer between the user and the underlying [Machine Code](http://en.wikipedia.org/wiki/Machine_code) being executed _by_ the Kernel _on_ the Processor.

The terminal emulator is what accesses the Shell. You see the terminal (emulator) but you don’t see the Shell.  The Shell isn’t a set of programs but a conceptual place. It’s the last stop before our readable commands get turned into Machine Code gibberish. Above the Shell, you can see and understand what’s going on. Below the shell the different parts of the machine have their own language with which they converse.

When you type in a command, you type it into the terminal emulator. When you press Enter, it passes through the Shell and is received by the Kernel. The Kernel translates it into bite sized operations known as Machine Code. The Kernel puts the operations into a queue, where the operations wait to reach the processor. When they reach the processor, they are evaluated. The Kernel then takes the results, and most of the time puts them back in the queue for further processing. When it’s all done, the Kernel takes the results and puts them back in order, before spitting them back out to the terminal.

###The Secure Shell

The terminal emulation occurs inside the Graphical User Interface, which sends the commands to the Kernel.

Similarly, instead of being received from the local Graphical User Interface, moden operating systems can just as easily receive terminal commands from a network device. In fact, this is the most common method of accessing the command-line interface of most modern Unix-like operating systems.

With the increased risk of allowing remote devices to execute potentially destructive local commands, security protocols such as [SSH](http://en.wikipedia.org/wiki/Secure_Shell) were developed to allow secure _Remote Terminal Emulation_.

[PuTTY](http://en.wikipedia.org/wiki/PuTTY) is a popular, Windows-based remote terminal emulator. Primarily it is used to connect to a UNIX-like host over the network using the SSH protocol, which is a secure way to send and receive terminal commands over the network.

PuTTY is named after TTY, which is short for terminal in the UNIX world. The word TTY draws its history from the [Teletype Corporation](http://en.wikipedia.org/wiki/Teletype_Corporation) which produced some of the first telephone-based-computer terminals. Like any good terminal emulator, PuTTY can still interact with its host via a serial connection, just like in the good old days!

Had enough of history? Me too. Hopefully I’ve managed to cover off all of the names and concepts involved. It is important to understand the context of that upon we are about to embark.

In the next part, we will connect to our Linux host over the Local Area Network using PuTTY and the SSH protocol.