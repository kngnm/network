# Kingman Network Quick Reference

## Internet Uplink

Cloyne-Kingman Antenna:

	IP: 10.20.32.212 (static)
	Location: fire-escape outside the third floor nook
    Webconfig Port: ?
    
It is a: ?  
See [Cloyne's Network Reference](https://github.com/cloyne/network/) for more information.

## Routers

__Main Router__:

	External IP: Cloyne DHCP
    Internal IP: 192.168.88.1
    Netmask: 255.255.255.0 (/24)
    DHCP Client Range: 192.168.88.0/24
    Location: Network Closet
    
It is a [	Mikrotik RB2011UiAS-RM](https://mikrotik.com/product/RB2011UiAS-RM)

## Switches

__Edge Switch__

	IP: 192.168.88.215 (Static DHCP)
    Web Interface Port: 80
    Speed: Gigabit
    Location: Network Closet
    
It is a [Unifi Edgeswitch 24 Lite](https://dl.ubnt.com/datasheets/edgemax/EdgeSwitch_Lite_DS.pdf)

__Unmanaged Switches__

- [HP V1910-48G](http://www.fiberopticshare.com/hp-v1910-48g-je009a-switch-solution.html) - Net Closet; Gigabit
- HP 190-8g? - Study Room; ?
- Netgear ? - Dinig Room; ?

## Wireless Access Points

__Unifi (x6)__

- Basement - DHCP; auto
- Dining Room - DHCP; auto
- Study Room - DHCP; auto
- 2nd Floor - DHCP; auto
- 3rd Floor Roof Stairs - DHCP; auto
- 3rd Floor Bathroom - DHCP; auto

They are [Unifi UAP-AC-PRO](https://dl.ubnt.com/datasheets/unifi/UniFi_AC_APs_DS.pdf)

## Servers & House Computers

__Toadserver__:

	IP: 192.168.88.218 (Static DHCP)
    Operating System: Lubuntu 16.04
    Services:
    	CUPS Printserver: 631
        Unifi Controller: 8080
        SSH: 22
    Location: Network Closet
 It is a Compaq ?  
 [Cups Print Server Documentation](https://help.ubuntu.com/lts/serverguide/cups.html.en)  
 [Unifi Controller User Manual](https://dl.ubnt.com/guides/UniFi/UniFi_Controller_V5_UG.pdf)
 
 __Media Server__:
 
 	IP: 192.168.88.229 (Static DHCP)
    Operating System: Ubuntu 16.04
    Services:
    	Apache2 Web Server: 80
        Webmin: 10000
        SSH: 22
    Location: Network Closet

It is a custom built computer  
[Apache 2 Web Server Docs](https://httpd.apache.org/docs/2.4/)

__Study Room Computer__:

	IP: 192.168.88.208 (Static DHCP)
    Operating System: Windows 10 Professional
    Services:
    	LPR Spooler
        Windows Printer Sharing
    Location: Study Room
    
It is a ?

__Dining Room Computer__

	IP: 192.168.88.238 (Static DHCP)
    Operating System: Ubuntu 16.04
    Services: Spotify Premium
    Location: Dining Room

It is a custom built computer