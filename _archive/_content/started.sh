#!/bin/bash
torrentid=$1
torrentname=$2
torrentpath=$3

title="$torrentname"
message="Started Downloading"

xbmc-send -a "Notification($title,$message,10000)"
