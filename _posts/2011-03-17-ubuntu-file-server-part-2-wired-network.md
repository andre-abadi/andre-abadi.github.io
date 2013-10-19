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

At the start of each section we can see the name of the adapter (eth0, lo and wlan0). These are the names Ubuntu has given our physical adapters as well as the [loopback connection](http://en.wikipedia.org/wiki/Loopback) (lo).  We will configure the wired connection (eth0) for now.

First, a trip to the Google machine to find relevant guides. [This article](https://help.ubuntu.com/community/WifiDocs/WPAHowTo#WPA%20Supplicant) was found, but we must pay heed to the fact that it is for an older version of Ubuntu, so it may not work and may have different or primitive commands. We will now tell Ubuntu to use the wired connection and how to use it by browsing to the network interface configuration file and editing it.

{% highlight bash %}
eagle@server:~$ cd /etc/network
eagle@server:/etc/network$ sudo nano interfaces
{% endhighlight %}

Here we've used the built-in program nano to open the interfaces file, which will look something like this:

{% highlight bash %}
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto eth0
# this says to start eth0 automatically on boot
iface eth0 inet dhcp
# says that the interface (iface) eth0 should
# have an IPv4 address (inet, inet6 for IPv6)
# and should get this address from a DHCP server
{% endhighlight %}

Our addition is seen in at the bottom of the file, how it works was learnt from this page for an older Ubuntu Server release.

Now we plug in a network cable from the machine to the router and restart the networking service with the new settings.

{% highlight bash %}
eagle@server:~$ sudo /etc/init.d/networking restart
{% endhighlight %}

At this point we should be able to see output showing us the adapter procuring itself an IPv4 address from the router. We can confirm this with:

{% highlight bash %}
eagle@server:~$ ifconfig eth0
{% endhighlight %}

And look for the new IPv4 address of the machine or to greater effect:

{% highlight bash %}
eagle@server:~$ ping google.com
PING google.com (66.102.11.104) 56(84) bytes of data.
64 bytes from syd01s01-in-f104.1e100.net (66.102.11.104): icmp_req=1 ttl=53 time=79.8 ms
64 bytes from syd01s01-in-f104.1e100.net (66.102.11.104): icmp_req=2 ttl=53 time=79.3 ms
64 bytes from syd01s01-in-f104.1e100.net (66.102.11.104): icmp_req=3 ttl=53 time=86.8 ms
64 bytes from syd01s01-in-f104.1e100.net (66.102.11.104): icmp_req=4 ttl=53 time=80.0 ms
64 bytes from syd01s01-in-f104.1e100.net (66.102.11.104): icmp_req=5 ttl=53 time=79.8 ms
^C
--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4002ms
rtt min/avg/max/mdev = 79.322/81.176/86.809/2.837 ms
{% endhighlight %}

So we have now successfully set up and configured the wired network interface on our Ubuntu server by editing Ubuntu's network configuration and then connecting the machine via cable to a DHCP-serving router. In Part 3 we will look at performing the same operation but instead using a wireless network adapter through a passworded local wireless network.