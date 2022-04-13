# unifi

Redirect DNS to PiHole with a USG:

https://community.ui.com/questions/Redirect-DNS-to-Pi-hole-using-a-USG/b6c330d0-7ea4-42ad-b190-f4f9792367b7

------

File on a UCK (Unifi Cloud Key) v1:

	cat /srv/unifi/data/sites/default/config.gateway.json

Other Versions of CloudKey/UDM, config.gateway.json may exist then in this location:

	cat /usr/lib/unifi/data/sites/default/config.gateway.json
	
	

# Some further reading 

https://help.ui.com/hc/en-us/articles/215458888-UniFi-USG-Advanced-Configuration-Using-config-gateway-json

https://help.ui.com/hc/en-us/articles/215458888-UniFi-How-to-further-customize-USG-configuration-with-config-gateway-json

https://hackviking.com/2020/03/17/unifi-security-gateway-json-config/
