#!/bin/bash

# Echo usage if no arguments passed
if [ $# -eq 0 ]
then
  echo "Usage: $0 [interface] [email address]"
  echo "Where: [interface] is the router interface to be tested (eth0, eth1, eth2)"
  echo "       [email address] is the destination email address to be notified if the interface is not up"
  exit 0
fi

####################
# Set up variables #
####################
run=/opt/vyatta/bin/vyatta-op-cmd-wrapper  # To run router commands

# File for preserving the interface status
interface_status=/config/user-data/interface-status/$1-down

# Path to sendmail
sendmail=/usr/sbin/sendmail

# Determine interface status
status=`$run show load-balance watchdog | grep "^  $1$" -A 6 | grep "^  status:" | sed 's/^  status: \([a-zA-Z]*\) *$/\1/'`

echo "$1 in status $status"
if [ "$status" == "Running" ]
then
# The interface is up, so clear the down flag file if it exists
  rm $interface_status 2>/dev/null # We don't care about the error if the file doesn't exist

else
  if [ -e $interface_status ]
  then
    : # File exists, so we already sent an email about the router being down
      # Do nothing since we don't want to send multiple emails
  else
    echo "Sending notification email"
    datetime=`date` # Preserve date/time for the email

# Put the email message inline
      $sendmail -F "Edgemax Router" -f router@email.com $2 << EOF
To: $2
Subject: Router interface $1 is down
$datetime: Interface $1 on the Houston router is down.

EOF

    touch $interface_status
  fi
fi



# could then add instead of mail 
# curl -X POST -H "Content-Type: application/json" -d "${status}" https://maker.ifttt.com/trigger/wan_change/with/key/ABC-CHANGEME
