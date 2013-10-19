---
layout: post
title:  "Ubuntu File Server Part 3: Wireless Network"
date:   2011-03-20 09:00:00
categories: ubuntu-file-server
---

In Part 2 we looked at manually setting up our Ubuntu 10.10 Server x64 with basic wired networking configuration. To configure modern wireless networking with encryption and passwords another few packages are needed, wpasupplicant and wireless-tools. As always a decent guide was first found, and in this case fellow Blogger user Jeroen had [just the guide I needed.](http://bendingmcp.blogspot.com/2011/02/ubuntu-1010-ralink-rt2561rt61-pci-wifi.html)

Jeroen makes the good point of updating Ubuntu's package list before installing anything to make sure we are getting the most up-to-date version of the software we desire. This process will use the wired network adapter that we configured previously.

{% highlight console %}
eagle@server:~$ sudo apt-get update
eagle@server:~$ sudo apt-get install wireless-tools wpasupplicant
{% endhighlight %}

Now we have the necessary packages to configure the wireless network and tell our machine to connect to it.  Before we can go any further we must find out if Ubuntu can see our adapter and if so, what it has named our adapter. Unknown adapter driver installation is beyond the scope of this guide.

{% highlight console %}
eagle@server:~$ lspci
{% endhighlight %}

Here we are looking for Network Controllers. Ethernet controllers are Ubuntu's way of describing wired adapters and it should show the brand of your network controller as well as its model. Ubuntu makes finding what we want in the big list of adapters easy, using the command line. Here I am using the grep command to return only lines that contain the String "Network"

{% highlight console %}
eagle@server:~$ lspci | grep Network
05:09.0 Network controller: Atheros Communications Inc. AR5008 Wireless Network Adapter (rev 01)
{% endhighlight %}

Having found the adapter to be detected here, we go on to find out what it is listed as. Ubuntu uses the logical system of naming wireless adapters starting from wlan0 upward. We check this by using a command to show the current setup of the wireless controllers:

{% highlight console %}
eagle@server:~$ iwconfig
lo no wireless extensions.

eth0 no wireless extensions.

wlan0 IEEE 802.11bgn ESSID:"Name"
          Mode:Managed Frequency:2.432 GHz Access Point: 00:04:ED:AC:28:6E
          Bit Rate=243 Mb/s Tx-Power=20 dBm
          Retry long limit:7 RTS thr:off Fragment thr:off
          Power Management:off
          Link Quality=42/70 Signal level=-68 dBm
          Rx invalid nwid:0 Rx invalid crypt:0 Rx invalid frag:0
          Tx excessive retries:0 Invalid misc:0 Missed beacon:0
{% endhighlight %}

Note that my wireless controller is already connected and your details may differ. The iwconfig command will only show the wireless configurations, so you can see it has ignored the loopback and ethernet adapters. Now we know what Ubuntu has called our wireless network adapter.

Next we will edit the Ubuntu network interface configuration file, which we already modified in Part 1 of this series. We navigate there and open it up:

{% highlight console %}
eagle@server:~$ cd /etc/network
eagle@server:/etc/network$ sudo vim interfaces
{% endhighlight %}

In the file that we have opened, we can see the entries that we previously made and those in green we will add now:

{% highlight console %}
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet dhcp
          wireless-ssid Name
          #this seems to tell the wpa supplicant to boot when connecting
          pre-up wpa_supplicant -B -Dwext -iwlan0 -c/etc/wpa_supplicant.conf
          #and this seem to tell it to die when disconnecting
          post-down killall -q wpa_supplicant
{% endhighlight %}

Above you can see a similar thing happens for the wireless adapter as for the wired adapter, except that we tell our machine to use the wpasupplicant program to supply the security settings for the network.

To this effect we need to configure the security setting that our machine will use to connect to the network of our choice. At the start of this part of the series we install the wpasupplicant package and this will supply the security settings to our adapter in order to connect to the wireless network.

Our wpasupplicant program is able to pull settings from a file that we create in the /etc/ directory and we will do this by browsing there and then creating a new file:

{% highlight console %}
eagle@server:~$ cd /etc/
eagle@server:/etc$ sudo vim wpa_supplicant.conf
{% endhighlight %}

Inside this file we will write the following:

{% highlight console %}
network={
          ssid="same_as_we_entered_into_interfaces_config_file"
          proto=RSN          key_mgmt=WPA-PSK          pairwise=CCMP TKIP                 group=CCMP TKIP          psk="wireless_password"}
{% endhighlight %}

And now we can test our configuration to make sure that it works by using the command:

{% highlight console %}
eagle@server:~$ cd /etc/init.d/networking restart
{% endhighlight %}

And now we have configured our server to connect to our local wireless network. In Part 4 we will look at how to configure package lists and remote control to our server.