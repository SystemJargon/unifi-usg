# Unifi

Things relating to Unifi networking equipment, may also include other products and services by Ubiquiti.


* Most of the guides apply to the USG (Unifi Security Gateway), as config.gateway.json does NOT apply/NOT work with the UDM series gear (UDR possibly too).


----
# config.gateway.json 

## File Location

config.gateway.json file on a UCK (Unifi Cloud Key) v1:

```/srv/unifi/data/sites/default/config.gateway.json```

Other Versions of CloudKey (or EdgeOS), config.gateway.json may exist then in this location if not above:

```/usr/lib/unifi/data/sites/default/config.gateway.json```
	
## Dump Contents of file
mca-ctrl -t dump-cfg > config.json

----

# Some further reading / links

[Any of my UDM & UDR specific content](UDM_UDR)

[Unifi Releases](https://community.ui.com/releases)

[Unifi Community Site](https://community.ui.com/)

[Hostifi](https://www.hostifi.com/) 

https://help.ui.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration-Using-config-gateway-json

https://help.ui.com/hc/en-us/articles/215458888-UniFi-How-to-further-customize-USG-configuration-with-config-gateway-json

https://hackviking.com/2020/03/17/unifi-security-gateway-json-config/


----

Disclaimer: I am not sponsored, employed nor paid by Ubiquiti, Hostifi or any other companies that maybe mentioned within this repo.
