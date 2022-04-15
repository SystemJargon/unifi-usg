#!/bin/bash

# import into USG NOT CLOUDKEY, Place into /config directory on USG
# chmod +x so it can execute like any other script of course too.
# rights rwxr-xr-x

pidof igmpproxy >/dev/null
if [[ $? -ne 0 ]] ; then
    echo "restarting igmp-proxy"
    /bin/vbash -ic 'restart igmp-proxy'
fi