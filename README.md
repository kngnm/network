# Kingman Network Quick Reference

## Layout Diagram

![Network Layout](https://raw.githubusercontent.com/kngnm/network/master/layout.png)

## Internet Uplink

Cloyne-Kingman Antenna:

	IP: 10.20.35.212 (Static)
	Location: fire-escape outside the third floor nook
    Webconfig Port: 80

It is a [Ubiquiti Powerbeam m5 300](https://dl.ubnt.com/datasheets/powerbeam/PowerBeam_DS.pdf)  
See [Cloyne's Network Reference](https://github.com/cloyne/network/) for more information.
Also see the [BSC Mesh Specification](https://github.com/bsc-networks/mesh).

## Routers

__Main Router__:

    External IP: 10.20.33.44 (Static DHCP)
    Internal IP: 10.20.96.1
    Netmask: 255.255.255.0 (/22)
    DHCP Client Range: 10.20.96.10-10.20.96.250
    Webconfig Port: 443 (https)
    Location: Network Closet

It is a [	Mikrotik RB2011UiAS-RM](https://mikrotik.com/product/RB2011UiAS-RM)

## Switches

__Edge Switch__

    IP: ??? (Static DHCP)
    Web Interface Port: 80
    Speed: Gigabit
    Location: Network Closet

It is a [Unifi Edgeswitch 24 Lite](https://dl.ubnt.com/datasheets/edgemax/EdgeSwitch_Lite_DS.pdf)

__Unmanaged Switches__

| Make and Model | Location | Speed |
|----------------|----------|-------|
| [HP V1910-48G](http://www.fiberopticshare.com/hp-v1910-48g-je009a-switch-solution.html) | Net Closet | Gigabit |
| HP 190-8g? | Study Room | ? |
| Netgear ? | Dinig Room | ? |

## Wireless Access Points

__Unifi (x6)__

| Room        | Location        | IP   | Channel |  
|-------------|-----------------|------|------|
| Basement    | Hallway         | DHCP | auto |
| Dining Room | Top of Cabinets | DHCP | auto |
| Study Room  | By Toner and Ink| DHCP | auto |
| 2nd Floor   | Hallway         | DHCP | auto |
| 3rd Floor   | Roof Stairs     | DHCP | auto |
| 3rd Floor   | Outside Bathroom| DHCP | auto |

They are [Unifi UAP-AC-PRO](https://dl.ubnt.com/datasheets/unifi/UniFi_AC_APs_DS.pdf)  
House Unifi Controller: https://192.168.88.218:8080

## Servers & House Computers

__Toadserver__:

    IP: 10.20.96.49 (Static DHCP)
    Operating System: Lubuntu 16.04
    Services:
        CUPS Printserver: 631
        Unifi Controller: 8080
        SSH: 22
    Location: Network Closet
 It is a Compaq Presario 061  
 [Cups Print Server Documentation](https://help.ubuntu.com/lts/serverguide/cups.html.en)  
 [Unifi Controller User Manual](https://dl.ubnt.com/guides/UniFi/UniFi_Controller_V5_UG.pdf)

 __Media Server__:

    IP: 10.20.96.52 (Static DHCP)
    Operating System: Ubuntu 16.04
    Services:
        Apache2 Web Server: 80
        Webmin: 10000
        Rocket.Chat Server: 3000
        SSH: 22
    Location: Network Closet

It is a custom built computer  
[Apache 2 Web Server Docs](https://httpd.apache.org/docs/2.4/)

__Study Room Computer__:

    IP: 10.20.96.32 (Static DHCP)
    Operating System: Windows 10 Professional
    Services:
        LPR Spooler
        Windows Printer Sharing
    Location: Study Room

It is a custom built computer

__Dining Room Computer__

    IP: 10.20.96.35 (Static DHCP)
    Operating System: Ubuntu 18.04
    Services: Spotify Premium
    Location: Dining Room

It is a custom built computer

## Printers

| Callsign | Make and Model | Wireless? | Color? | Double-Sided? | Scanning? |
|----------|----------------|-----------|--------|---------------|-----------|
| KNG-BackupPrinter | [Brother HL2240](http://download.brother.com/welcome/doc002837/cv_hl2240d_usaeng_usr_c.pdf) | No | No | No | No|
| KNG-ColorPrinter | [HP Photosmart c3180](http://www.hp.com/ctg/Manual/c00694908.pdf) | No | Yes | No | Yes |
| KNG-OldFrosty | [HP LaserJet Pro P1102w](http://h10032.www1.hp.com/ctg/Manual/c04697535) | Yes | No | No | No |
| KNG-MainPrinter | [Brother MFC9340](http://download.brother.com/welcome/doc003075/cv_mfc9130cw_use_ausr.pdf) | Yes | Yes | Yes | Yes |
