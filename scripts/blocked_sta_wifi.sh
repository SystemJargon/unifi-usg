#!/bin/bash

# cd ~/cfg

# look for blocked_sta MAC addresses in files below

cat ~/cfg/blocked_sta
cat /var/etc/persistent/cfg/blocked_sta
cat /tmp/macs.blocked_sta

# /usr/etc/syswrapper.sh 

# to unblock a mac address uncomment this
# /usr/etc/syswrapper.sh unblock-sta 00:00:00:00:00:00
# /usr/etc/syswrapper.sh apply-config
