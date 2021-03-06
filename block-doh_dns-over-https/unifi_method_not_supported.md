
Notes:

* Large IP list won't load, it isn't like a proper BSD driven router with ipset method/s.
* If using a < 10 list of IP as an example (CloudFlare, Google etc.), the method still seems to brick a unit in most (if not all) cases.
* address-group doh-group-iplist, not to use a name as 'random 25 character alphanumeric group' will apply in syntax.
* BSD can support this but the steps vary and shouldn't be used, also not to use steps from here in Unifi in this method from initial testing.

* This is a learning experience and documentation of a specific use case. Do not use this on production.


Disclaimer: I AM NOT LIABLE FOR ANYTHING SUCH AS BUT NOT LIMITED TO MISUSE OR DAMAGE OR CONSEQUENTIAL LOSSES TO YOUR EQUIPMENT

----

Remember ```DoH over TCP 443 vs DNS over UDP 53. ```

# Block Public DNS (DoH) - DNS over HTTPS

Background use case:

This did work well for some SME clients. They were using a Unifi USG or early model UDM. 

Some SME had content-blocking for staff. We know some of the SME staff had phones with "Private DNS" turned on. 

Some maybe accessing content they shouldn't over the corporate/guest provided networks. 

*Such SME uses DNS content filter along with a Web Proxy of sorts. 


----
## Things not shown in Controller GUI

The Unifi Controller GUI can not parse the data from CLI to GUI if using custom address-group, as some config.gateway.json data shows too.

Also noted is that the address-group when added via CLI, does NOT show in the GUI under > Routing & Firewall > Firewall > Groups. 

## Address Group ID

Further, as has always been the case, if you ssh on the UDM/USG (config mode) issue; 

```show firewall group address-group```
	
You'll notice the naming convention of ONLY random 25 character alphanumeric groups and the built in default types. 

## Stuck Boot Loop

This causes the Unifi device to get stuck on a boot load once you type 'save' then next reboot if trying to implement this all in Unifi gear (in our initial testing). 

Recovery is needed.



	
----

# Obtaining and implementation of iplist
	
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
Copy <source location of doh-group-iplist.txt> to /tmp/doh-group-iplist.txt on UDM

## CLI Commands for address-group creation and adding IP's
```
    echo 'set firewall group address-group doh-group-iplist description "This is my DNS over HTTPS IP list group"' > /tmp/ipgroup.sh
    sed -e 's/^/set firewall group address-group doh-group-iplist address /' /tmp/doh-group-iplist.txt >> /tmp/ipgroup.sh
    configure
    source /tmp/ipgroup.sh
    commit
    save
    exit
    rm /tmp/ipgroup.sh /tmp/doh-group-iplist.txt
```
	
Note: Source command for /tmp/ipgroup.sh may take time.