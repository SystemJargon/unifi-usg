# Unifi Video

Mostly now dead because of Unifi Protect and their future products/services. It still works but now EoL. No official support by Ubiquiti.

----

## Final releases of Unifi Video (Debian) and Camera Firmware.


Unifi Video for Debian / Ubuntu: v3.10.13 
    
[Release notes](https://community.ui.com/releases/UniFi-Video-3-10-13/7cca7ae9-f4ff-4844-a7c4-b8163bb81f21)

[Firmware Download](https://dl.ubnt.com/firmwares/ufv/v3.10.13/unifi-video.Ubuntu18.04_amd64.v3.10.13.deb)

----

Unifi Video Camera Firmware: v4.23.8.67 (do not use v4.30 it won't work).
 
Firmware Download [here](https://github.com/lwsnz/unifi/raw/main/unifi-video/camera_firmware/G3_Flex/uvc.s2l.v4.23.8.bin)


----


## Install Unifi Video on Debian/Ubuntu

Source guide below and original [here](https://gist.github.com/pdrok/0b8f65032892b4e5fdb7c85b8d72cdd6#file-unifi-video-ubuntu-18-04-md)

## Steps

log in as root: `sudo su`
if you don't have MongoDB already installed: 

`sudo apt-get install mongodb mongodb-server openjdk-8-jre-headless=8u162-b12-1 jsvc`

Open terminal (go to your apps and type in terminal, or push the windows key and type in terminal)
Type the following commands:

```
sudo mv /usr/bin/mongod /usr/bin/mongod.bin
cd /usr/bin/
sudo vi mongod
```

A new window will appear where you need to paste the following:

```
#!/bin/bash
cleaned_args=$(echo $* | sed -e 's/--nohttpinterface//')
/usr/bin/mongod.bin ${cleaned_args}
```
Then press ESC on your keybard and type `:wq` then enter.
Now type this command in terminal

`sudo chmod +x mongod`

## Download unifi video:

`wget https://dl.ubnt.com/firmwares/ufv/v3.10.13/unifi-video.Ubuntu18.04_amd64.v3.10.13.deb`

Install unifi-video

`dpkg -i unifi-video.Ubuntu18.04_amd64.v3.10.13.deb`

Restart your computer to restart the Unifi-Video service. It should now run.

open the follow url on a browser tab :
`https://localhost:7443` or `https://server:7443`

[Source](https://www.reddit.com/r/Ubiquiti/comments/l30jm5/unifi_video_31013_not_compatible_with_openjdk_180/)

[Source_2](https://community.ui.com/questions/unifi-video-wont-start-anymore-FIX-INSIDE/297dbfc0-7e04-4a50-92b8-dab4acf50a03#answer/0ff74ac7-e7db-4e7c-a64c-ee6ceaf9afde)

[Source_3](https://community.ui.com/questions/How-to-install-Unifi-Video-on-Ubuntu-18-04-Now-Supported/6dbb2c6b-af93-4150-9659-4fa0a72ca847)
