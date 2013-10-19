---
layout: post
title:  "Ubuntu File Server Part 2: Wired Network"
date:   2011-03-17 16:57:00
categories: ubuntu-file-server
---

Continuing from Part 1 of this series have now installed Ubuntu 10.10 Server x64 using a monitor and keyboard but the machine isn't actually providing any services at all, and is not connected to any networks. In Part 1 I decided against the automatic configuration of my network in an attempt to learn how the process works.

In the following pages, it is important to remember to backup your current configurations before attempting to meddle on the command line. To this effect I will be playing with the network interfaces configuration file and hence, will back it up first.


{% highlight bash %}
dancingborg@server:~$ cd /etc/network
eagle@server:/etc/network$ ls
if-down.d  if-post-down.d  if-pre-up.d  if-up.d  interfaces
dancingborg@server:/etc/network$ sudo cp interfaces interfaces.bak
dancingborg@server:/etc/network$ ls
if-down.d  if-post-down.d  if-pre-up.d  if-up.d  interfaces  interfaces.bak
{% endhighlight %}

Also beware the sudo command. In these cases the files are in restricted parts of the file system such that an ordinary used (without sudo privelages) cannot mess up your finely tuned configuration files. Don't trust me, make sure you understand EVERY command you enter into your server.

Ubuntu will have detected most if not all network adapters present during installation. If yours is not you will have to use a network adapter that does work to install the correct drivers for the adapter that wasn't detected. This is, however, outside the scope of this post. In my case both the wired and wireless adapters were detected. We check using:

{% highlight bash %}
eagle@server:~$ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:15:60:9e:2a:c7
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:17

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1920 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1920 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:315198 (315.1 KB)  TX bytes:315198 (315.1 KB)

wlan0     Link encap:Ethernet  HWaddr d8:5d:4c:a3:a8:1e
          inet addr:192.168.1.200  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::da5d:4cff:fea3:a81e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3127 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1208 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:589915 (589.9 KB)  TX bytes:741627 (741.6 KB)
{% endhighlight %}
