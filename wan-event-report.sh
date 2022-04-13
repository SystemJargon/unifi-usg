#!/bin/bash

# File: wan-event-report.sh
# Desc: Reports WAN transistion events to the controller. This script should be configured under the
#       "load-balance group <GROUP_NAME> transition-script" config node. If the controller reporting
#       script is not found, logs to syslog

REPORT_SCRIPT=/usr/bin/mca-custom-alert.sh
NAME=wan-event
EVENT_STRING="EVT_GW_WANTransition"
IFACE=$2
STATE=$3

logger -t $NAME -- "[WAN Transition] $IFACE to state $STATE"
[ -f $REPORT_SCRIPT ] && $REPORT_SCRIPT -k event_string -v "$EVENT_STRING" -k iface -v "$IFACE" -k state -v "$STATE"
