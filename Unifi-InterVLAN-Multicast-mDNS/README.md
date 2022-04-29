# Unifi Secure IoT and LAN Multicast (Casting Things with Firewall)


In this example this is the mock up of the network.


		Default: VLAN_ID = 1, 192.168.1.1/24
		LAN-Network: VLAN_ID = 50, 192.168.50.1/24
		Media-Network: VLAN_ID = 100, 192.168.100.1/24


----

The trick is allow mDNS by interface.

Have your Media-Network when configured as "Purpose" set to Corporate, not Guest.

** This often fails above when people set their main LAN to Corporate, but their media/cast/IoT etc. network to Guest and also forget to enable mDNS on that interface/s.

![image](https://user-images.githubusercontent.com/24641464/163526824-d5259fb7-ea9d-4e6f-b878-4f1a9bce3e3b.png)





Depending on other factors, "IGMP Snooping" (Under each Network), may need to be toggled On/Off.

The same goes "Multicast and Broadcast Filtering" (under each Wireless network), may need to be toggled On/Off.

----

# Steps

Firstly Login to your Unifi Controller

## Turn on mDNS


In more recent Unifi Controller versions, mDNS in selected in 
 
Settings > Networks.

![image](https://user-images.githubusercontent.com/24641464/164644501-c5ca83a0-915a-45b1-9960-1070e756cde7.png)


* In older versions of Unifi Controller, this can be enabled by

Settings > Services > mDNS

![image](https://user-images.githubusercontent.com/24641464/164644527-09adee0a-67fc-409d-a397-d7adb4c8fb33.png)


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

----

## Create Firewall Rules

Settings > Routing and Firewall > Firewall

LAN_IN

Create some new rules, first new rule of two.

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

[Firewall, I have some doco on this in Github here](../firewall)

----

Note, If you have additional custom rules, you may need to sort these new firewall LAN_IN rules in a specific order.

Firewall rules get process by ordered number and subsequently from 2000 onwards (if before predefined rules is set).

This would be say if you have other services that the Media-Network needs to talk to your LAN-Network, for specific traffic first before any DROP.

i.e. custom server with DNS, FTP, NAS, <insert-media-server-name-here> or likewise.

