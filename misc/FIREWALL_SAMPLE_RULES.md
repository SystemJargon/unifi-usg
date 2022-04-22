# FIREWALL SAMPLE RULES

Sample rules, by no means run just these sample rules.
This is more a reference, on how to ACCEPT / DROP something specific per rule.

## LAN_IN
		
		Name: Permit Jumphost to Linux Boxs SSH
		Action: ACCEPT
		Protocol: TCP
		Source Groups: IP_Jumphosts 
		Destination Groups:: IP_Linux_Boxs | Port Group: SSH (TCP 22)

		Name: Deny Inter-VLAN Routing
		Action: DROP
		Protocol: ALL
		Source Groups: Your_LAN_Subnets
		Destination Groups:: RFC1918


** for reference RFC1918 has the follow IP addresses:

10.0.0.0/8

172.16.0.0/12

192.168.0.0/16

## LAN_LOCAL

		Name: Deny Unifi MGMT making SSH OUT to servers
		Action: DROP
		Protocol: TCP
		Source Groups: Your_Servers_IP | Port Group: SSH (TCP 22)
		Destination Groups:: Unifi_MGMT_IPs
