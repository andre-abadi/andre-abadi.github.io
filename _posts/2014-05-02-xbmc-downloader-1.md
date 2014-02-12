---
layout: post
title: XBMC Downloader, Part 1
categories: xbmc
---

#In a Nutshell

_Introduction_
_The Command-line Interface_
_XBMC in the world of Linux_
_Conclusion_

#Introduction

The purpose of this guide as a whole is to modify a Linux-based XBMC distribution into an automated downloading station.

I thought I'd write this guide as a sort of beginner's-cookbook into the world of Linux, teaching the basics with the goal of adding sophisticated functionality to a popular program available on Linux; XBMC.

This first post will be an introduction into the Linux world, how it works and where your project will fit in.

#The Command-line Interface

[UNIX](http://en.wikipedia.org/wiki/Unix) is a computer operating system designed to be operated from a command-line interface. It is one of the oldest operating systems and most modern operating systems are based upon it and its [philosophy](http://en.wikipedia.org/wiki/Unix_philosophy).

A [command-line interface](http://en.wikipedia.org/wiki/Command-line_interface) is one where the user enters textual commands to the operating system, which executes commands and in turn displays the results in text form. In the Microsoft Windows environment, this is known as 'CMD' or the '[Command Prompt](http://en.wikipedia.org/wiki/Command_Prompt)'.

Don't worry about trying these. For now, look past the specifics and observe the commonalities.

1. A sequence of characters, known as a [string](http://bit.ly/1juXrS1) 'prompts' the user for input. Examples include:

  a. `C:\Users\Microsoft>` in Microsoft Windows.
  b. `TiBook:~/Desktop taylor$` in Apple's Mac OS.
  c. `[12:59] daniel@arch ~ $` in Arch, a flavour of Linux.
  d. `sh-2.05b$` in Unix.

The prompt will usually contain pertinent information, followed by an uncommon character such as `$` showing where your input begins. In the above examples you may notice information such as; the current time, current username, computer name and the current working directory. Because there is no desktop, these textual cues replace the visual ones you may be accustomed to in a Graphical User Interface.

2. The user enters a command, followed by one or more [arguments](http://en.wikipedia.org/wiki/Command-line_interface#Arguments), also known as parameters. For example:

  a. `ls -a` in UNIX or Linux lists all files including hidden ones.
  b. `del Document1.doc` in Windows or MS-DOS deletes said file.
  c. `ping google.com` in UNIX or Linux pings Google.

3. The operating system executes the command and may or may not return text, depending on the command.

  a. Deleting a file may not return any text.
  b. Deleting a protected file may return a confirmation prompt.
  c. Pinging Google may return information about the command.

4. Once the operating system has completed the command and is ready for another, it will return the command prompt on a new line. From here you go back to step 1.

All command-line interfaces operate with the above syntax and grammar. It is important to understand this most basic language as it applies to all operating systems. Don’t worry, with this skill we will _learn by doing_ and I’ll explain each command and its arguments for you.

#XBMC in the world of Linux

The two most popular ways of running XBMC are:

1. Downloading an ISO and running it as an operating system.
2. Downloading it to your SD card and running it on your Raspberry Pi.

[GNU/Linux](http://en.wikipedia.org/wiki/Linux) is [free and open source](http://en.wikipedia.org/wiki/Free_and_open_source_software) family of operating systems that operate in a [very similar manner to UNIX](http://en.wikipedia.org/wiki/Unix-like).

Linux itself is only a [Kernel](http://bit.ly/1lziWQ7) (the core of the operating system) and not the whole. Groups and companies build software around the Linux Kernel, creating whole operating systems known as Linux Distributions. There are many flavours of Linux but no original.

[Debian](http://en.wikipedia.org/wiki/Debian) is a Linux Distribution containing only free software of the [GPL License](http://en.wikipedia.org/wiki/GNU_General_Public_License) type. It is one of the most common and widespread Linux Distributions. As such it is a Jack-of-all-trades but doesn’t excel at any one task. One example is its spartan [Graphical User Interface](http://en.wikipedia.org/wiki/Graphical_user_interface). This [link](http://upload.wikimedia.org/wikipedia/commons/0/0c/Debian_6.0.2.1.png) shows a very un-sophisticated desktop.

[Ubuntu](http://bit.ly/1iNj9hf) is a Linux Distribution based on Debian. Read that last sentence again. Think of Ubuntu as adding a well-polished surface to a Debian core. Ubuntu is popular because of its ease of use, installation and compatibility, and the way it builds an attractive and usable interface onto the proven Debian distribution.

- [XBMCbuntu](http://wiki.xbmc.org/index.php?title=XBMCbuntu/FAQ) is a re-mix of Ubuntu. It has added media codecs and the XBMC program and instead of booting to the Ubuntu desktop, it boots straight into XBMC program interface.

[Raspbian](http://www.raspbian.org/) is a version of Debian compiled for the unique [ARM](http://en.wikipedia.org/wiki/ARM_architecture) processor contained within the [Raspberry Pi](http://www.raspberrypi.org/about). It is otherwise identical to ‘ordinary’ Debian.

- [Raspbmc](http://www.raspbmc.com/about/) is to Raspbian what XBMCbuntu is to Ubuntu. The Ubuntu step is missed for the sake of performance on the not-so-powerful Raspberry Pi.

#Conclusion

Hopefully this initial theory lesson has given you a picutre of where in the world of computing you are operating and how the system with which you are interacting came to be.

In the next part of this guide we will learn how to log into our Linux computer and issue some commands on the CLI.