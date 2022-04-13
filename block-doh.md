# THIS IS BROKEN DO NOT USE THIS CODE - FEEL FREE TO FIX AND USE AT YOUR OWN DISCRETION


# Unifi How-to block Public DNS (DoH) - DNS over HTTPS


This did work well for some SME clients. They were using a USG or UDM. Some SME had content-blocking for staff. We know some of the SME staff had phones with "Private DNS" turned on. Some maybe accessing content they shouldn't over the corporate/guest provided networks. 

*Such SME uses DNS content filter along with a Web Proxy. But yes "Never fully only use a technical solution to a management problem" I know.

	DoH over TCP 443 > DNS over UDP 53. 

The Controller GUI can not parse the data from CLI > GUI if using custom address-group, as some config.gateway.json data shows too. Stuck Boot Loops.

Further, as has always been the case, if you ssh on the UDM/USG (config mode) issue; 

	'show firewall group address-group' 
you'll notice the naming convention of ONLY random 25 character alphanumeric groups and the built in default types. This causes the Unifi device to get stuck on a boot load once you type 'save' then next reboot.


Also noted is that the address-group when added via CLI, does NOT show in the GUI under > Routing & Firewall > Firewall > Groups. 
	
	------------------------
	
Please follow this step by step guide in order.

## Download IP list text file first
Download  https://public-dns.info/nameservers-all.txt 



## Make a copy of the file.
	So we can leave the original downloaded copy as a backup for later if needed.
	Rename the copy of the file you made, rename it to doh-group-iplist.txt
	You should have two files now, the original and the copy.
	We will now be working only with this copied file doh-group-iplist.txt in further steps.

## Removing IPv6 addresses (optional).
Open the copied doh-group-iplist.txt file In notepad++ we will remove the IPv6 addresses.

In Notepad++

Search menu -> Find... -> Mark tab -> Find what: enter without quotes ":", check Bookmark Line, then Mark All. 

This will bookmark all the lines with the search term with ":" which only the IPv6 addresses have, you'll see the blue circles in the margin.

Then Search menu -> Bookmark -> Remove Bookmarked Lines. This will delete all the bookmarked lines.


## Copy File to Router
Copy <source location of doh-group-iplist.txt> to /tmp/doh-group-iplist.txt on UDM/USG/EdgeRouter

## CLI Commands for address-group creation and adding IP's

    echo 'set firewall group address-group doh-group-iplist description "This is my DNS over HTTPS IP list group"' > /tmp/ipgroup.sh
    sed -e 's/^/set firewall group address-group doh-group-iplist address /' /tmp/doh-group-iplist.txt >> /tmp/ipgroup.sh
    configure
    source /tmp/ipgroup.sh
    commit
    save
    exit
    rm /tmp/ipgroup.sh /tmp/doh-group-iplist.txt
	
	
Note: Source command for /tmp/ipgroup.sh may take time.



## I AM NOT LIABLE FOR ANYTHING SUCH AS BUT NOT LIMITED TO MISUSE OR DAMAGE OR CONSEQUENTIAL LOSSES TO YOUR EQUIPMENT
