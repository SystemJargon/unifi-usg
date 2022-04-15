This topic has been talked about a lot of places, an example being
 https://community.ui.com/questions/Redirect-DNS-to-Pi-hole-using-a-USG/b6c330d0-7ea4-42ad-b190-f4f9792367b7


Log into unifi controller web UI

Go to Settings

Select Routing & Firewall

Select Firewall

Select Groups

Hit "Create new Group"

Enter all your DNS servers here you want to be allowed on the local LAN (Eg, mine is 192.168.1.1 - gateway, 192.168.1.14 - pi-hole)

Name this "Allowed DNS Servers"

Hit OK

SSH into the Gateway - NOT the CloudKey (username/password is whatever you set up)

do this: 'mca-ctrl -t dump-cfg > config.txt'

edit the new file, config.txt 'vi config.txt'

Look for something that has the description field: "description": "customized-Allowed DNS Servers"

Write down/copy aside the key associated that (mine is: 5d50c3764fd01c0ad01a6938) This is the Group ID for your group

Now you need your 'interfaces' - meaning all your vlans and such.
----------------------  ----------- 

The way to find out your interfaces is ssh into the gateway and issue: show interfaces Output is:

	Codes: S - State, L - Link, u - Up, D - Down, A - Admin Down
	InterfaceIP AddressS/L  Description 
----------------------  ----------- 
	eth0 XX.X.XXX.XXX/24   u/u  WAN 
	eth1 192.168.1.1/24   u/u  LAN 
	eth1.2   192.168.2.1/24   u/u  
	eth1.80  192.168.80.1/24  u/u  
	eth1.90  192.168.90.1/24  u/u  
	eth1.100 192.168.100.1/24 u/u  
	eth2 - A/D  
	eth3 - A/D  
	eth4 - A/D  
	eth5 - u/D  
	eth6 - u/D  
	eth7 - u/D  
	eth8 - u/D  
	lo   127.0.0.1/8   u/u  
	::1/128  

Note down all the eth1, eth1.2, - eth1.100 for each active VLAN you care about doing this too (all?)

Either open up your config.json on the CloudKey or learn how to edit/make one here: https://help.ubnt.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration

--------------


%DNS_SERVER%, replace with your DNS server's IP address not including % symbol

%IOT_VLAN%, replace with the VLAN you wish to target to have DNS DNAT redirection

Some graphical explaination of this by someone else is available at https://www.missingremote.com/guide/2018/07/unifi-usg-dnat-rule-for-pi-hole-or-other-dns-redirection

```

{
	"service": {
		"nat": {
			"rule": {
				"1": {
					"description": "DNS Redirect IoT",
					"destination": {
						"port": "53"
					},
					"inbound-interface": "%IOT_VLAN%",
					"inside-address": {
						"address": "%DNS_SERVER%"
					},
					"log": "disable",
					"protocol": "tcp_udp",
					"source": {
						"address": "!%DNS_SERVER%"
					},
					"type": "destination"
				},
				"5501": {
					"description": "Translate IoT DNS to Internal",
					"destination": {
						"address": "%DNS_SERVER%",
						"port": "53"
					},
					"log": "disable",
					"outbound-interface": "%IOT_VLAN%",
					"protocol": "tcp_udp",
					"type": "masquerade"
				}
			}
		}
	}
}
```

Copy this template for each of your VLANs/interfaces above to the nat/rule section, ensure a new rule number each time and it doesn't exist already!

Validate the json using the tool of your choice

Go back to Unifi Controller web app

Go to the devices tab

Select your USG

Hit Settings on it

Scroll down and find "Force Provision"

A great way to verify this is to: 'dig @1.1.1.1 test.points.local' where the address I'm looking up doesn't exist in a public space (just my local DNS)

----------------

