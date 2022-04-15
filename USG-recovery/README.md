# Recovery of USG after bad config

Pin hole reset the USG. (Power on, leave it powered 1min. Pin hole hold in for approx 10 seconds).

Connect your PC or Mac with static IP set on the adapter of it.

Ensure any switch you connect physically to is tagged to MGT VLAN or has an "ALL" switch port profile used on the port to your pc/mac.

After factory reset completes you can move onto the set inform steps below.


## Web Browser Method
	
	Open your web browser
	Visit the USG via https://192.168.1.1/#/manage/configuration
	You can set the inform URL in the USG web UI to your controller http://<controller-ip>:8080/inform

	On the Cloud Key / Controller Web UI
	Forget Device in Controller
	Click Adopt
	Wait for "Provisioning"
	The USG/UDM may reboot to apply changes

## SSH Method (more reliable)

	On the USG
	ssh ubnt@192.168.1.1 (example use Putty).
	Default password "ubnt" (no quotes).
	set-inform http://<controller-ip>:8080/inform

	On Cloud Key/Controller Web UI
	Forget Device in Controller
	Click Adopt
	Wait for "Provisioning"
	The USG/UDM may reboot to apply changes.
