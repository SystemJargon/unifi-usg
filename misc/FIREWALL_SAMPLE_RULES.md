# FIREWALL SAMPLE RULES

Sample rules, by no means run just these sample rules. 
This is more a reference, on how to ACCEPT / DROP something specific per rule if you use Unifi for routing.

Opinion: PfSense / Netgate offer better routing and firewall features.

More info about firewall rules for Unifi [here](https://help.ui.com/hc/en-us/articles/115003173168-UniFi-UDM-USG-Introduction-to-Firewall-Rules)
----

## MOST FAQ: ##

Make things work on a VLAN to cast phone > screen / mDNS / chromcast / Airplay etc.

Refer to: [Multicast DNS](https://github.com/lwsnz/unifi/tree/main/Unifi-InterVLAN-Multicast-mDNS)

----


## LAN_IN

```
Name: Permit Jumphosts to Linux Boxs SSH
Action: ACCEPT
Protocol: TCP
Source Groups: IP_Jumphosts 
Destination Groups:: IP_Linux_Boxs | Port Group: SSH (TCP 22)
```

```
Name: Deny Inter-VLAN Routing
Action: DROP
Protocol: ALL
Source Groups: NET_LAN_Subnets
Destination Groups:: RFC1918
```

** for reference RFC1918 has the follow IP addresses:
```
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

----

## LAN_LOCAL

```
Name: Deny Unifi MGMT making SSH OUT to servers
Action: DROP
Protocol: TCP
Source Groups: NET_Servers | Port Group: SSH (TCP 22)
Destination Groups:: IP_Unifi_MGMT
```

----

** Groups are following a starting naming convention of:
```
IP_ = IP address group
PORT_ == Port Group
NET_ == Network Group (using CIDR)