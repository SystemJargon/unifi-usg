# Unifi Secure IoT and LAN Multicast (Casting Things with Firewall)


In this example this is the mock up of the network.

```
Default: VLAN_ID = 1, 192.168.1.1/24
LAN-Network: VLAN_ID = 50, 192.168.50.1/24
Media-Network: VLAN_ID = 100, 192.168.100.1/24
```



# Steps


1) Login to your Unifi Controller

2) Turn on mDNS. 

Newer Unifi Controller versions, mDNS in selected in 
 
Settings > Networks.

![image](https://user-images.githubusercontent.com/24641464/164584280-7eb6277f-1e58-40a3-b102-f3c5f312bac2.png)


----

Older versions of Unifi Controller, this can be enabled by

Settings > Services > mDNS:


![image](https://user-images.githubusercontent.com/24641464/163526824-d5259fb7-ea9d-4e6f-b878-4f1a9bce3e3b.png)




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

Depending on other factors, "IGMP Snooping" (Under each Network), may need to be toggled On/Off.

The same goes "Multicast and Broadcast Filtering" (under each Wireless network), may need to be toggled On/Off.

----


3) Create Firewall Rules

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

----

Note, you may need to sort these new firewall LAN_IN rules in a specific order, if you have additional custom rules.

This would be say if you have other services that the Media-Network needs to talk to your LAN-Network, for specific traffic first before DROP.

i.e. custom server with DNS, FTP, NAS, <insert-media-server-name-here> or likewise. Place the multicast example rule at the most top of the rule chain / order of rules.
