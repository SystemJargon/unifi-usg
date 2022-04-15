# Unifi Secure IoT and LAN Multicast (Casting Things with Firewall)

In this example this is the mock up of the network.

```
Default: VLAN_ID = 1, 192.168.1.1/24
LAN: VLAN_ID = 50, 192.168.50.1/24
Media: VLAN_ID = 100, 192.168.100.1/24
```

The trick is allow mDNS by interface in the json file AND

Have your Media-Network when configured as "Purpose" set to Corporate, not Guest.


Depending on other factors, "IGMP Snooping" (Under each Network), may need to be toggled On/Off.

The same goes "Multicast and Broadcast Filtering" (under each Wireless network), may need to be toggled On/Off.

----

# Steps

1) Turn on mDNS.

Settings > Services > mDNS

*If this doesn't appear or you wish to use config.gateway.json try this code below on your CloudKey

```
 {
  "service": {
    "mdns": {
      "repeater": {
        "interface": [
          "eth1.50",
          "eth1.100"
        ]
      }
    }
  }
}
```

2) Create Firewall Rules

Settings > Routing and Firewall > Firewall

LAN_IN

Create some new rules, first new rule

```
Name: Multicast IP for Media Casting
Action: ACCEPT
Protocol: ALL
Source - IP address: 224.0.0.0/4
Destination - IP address: any
```

Second new rule

```
Name: Drop Media-Network to LAN-Network
Action: DROP
Protocol: ALL
NETWORK: Media-Network
NETWORK: LAN-Network
```

Note, you may need to order these new rules at your own discretion.
This would be say if you have other services that the Media-Network needs to talk to your LAN-Network,
for specific traffic first before DROP.

i.e. custom server with DNS, FTP, NAS, <insert-media-server-name-here> or likewise.
