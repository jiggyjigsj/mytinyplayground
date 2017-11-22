# Tweaks
## Everything was written on a Mac OSX Sierra, as that was my work laptop at time.

Repo dedicated to scripts that i feel are useful for daily scripting. A lot of things are specific to my current work. But the goal behidn this remove is to take that ideas and style and put it in one location for me to refer back to in future.

Files:
* [hosts.sh](#hosts.sh)
* [killapp.sh](#killapp.sh)
* [.zshrc](#.zshrc)
* [.function](#.function)

## <a name=".zshrc"></a>ZSH Profile
ZSH profile, mainly for back up but has tiny things that come handy.

## <a name=".function"></a>FUNCTIONS
List of functions I found helpful in a day to day uses.
* 1.) gitupdate - Update fork repo
* 2.) changeorg - Change chef orgs
* 3.) gitstash  - Drop unwanted files

## <a name="hosts.sh"></a>Hosts and Aliases
A flag based script used to write alias and maps client VPN IP to hostnames and FQDN to be used for scripting.

#### Features:
 * Edit /etc/hosts file to add FQDN, VPN IP and hostname
 * Add Aliases to quickly ssh into nodes **Only supports for etsops** | -f ../muns_mi.report.csv
 * Delete alias and /etc/hosts entries | -w <munsmi>
 * Delete backup files | -w -e
 * Check what shell user has installed

#### Usage:
| Flags | Outcome | Example |
|------------|------|------------------------|
| -f, -p | alias | -f ../muns_mi.report.csv -p $keys/muns_mi/etsops.pem |
| -f, -p, -e | hosts and alias | -f ../muns_mi.report.csv -p ../etsops.pem -e |
| -w | delete alias | -w munsmi |
| -w, -e | delete alias and hosts | -w munsmi -h |
| -d | delete hosts backup | -d |
| -f, -p, -w, -d. -e | Loop | -f ../muns_mi.report.csv -p $keys/muns_mi/etsops.pem -w munsmi -d -e |

##

| Flags | Outcome |
|------------|------|
| -h | Help |
| -f | [Client Csv File](https://github.cerner.com/ETS-Bespin/appliance_mapping) |
| -p | [Client pem File](https://github.cerner.com/ETS-Bespin/gps-roles) |
| -e | **Must select this option to edit /etc/hosts** Write to /etc/hosts file for vpn ip to hostname mapping |
| -w | Delete Alias and hosts ***must match hostname format** |
| -d | Delete backup copies of hosts files |

```bash
chmod +x hosts.sh
Usage: ./hosts.sh [-f <csv file> ] [-p <client.pem> ] [-w <clientmnemonics> ] -d
```

Output:

```bash
./hosts.sh -f ../muns_mi.report.csv -p ../etsops.pem -e
Password:
Sorry, try again.
Password:
7.204.108.2 munsmiprd1dns201 munsmiprd1dns201.muns-mi.cernercloud.net - Added
Writing alias munsmiprd1dns201
7.204.108.3 munsmiprd2dns202 munsmiprd2dns202.muns-mi.cernercloud.net - Added
7.204.108.2 munsmiprd1dns201 munsmiprd1dns201.muns-mi.cernercloud.net - Exists
Alias munsmiprd1dns201 already exists
```

## Kill App <font size = "4"><a font="9" name="killapp.sh"></a></font>
A menu driven script to close all app that I don't need after work.  

#### Features:
 * Kills application using signal 15 or 9
 * Quit one application at a time or all of them
 * Confirmation to kill or not
 * Refresh list without quiting script
##
| Apps | Added |
|------------|-----|
| Microsoft Lync | :heavy_check_mark: |
| Microsoft Onenote | :heavy_check_mark: |
| Citrix Receiver | :heavy_check_mark: |
| iTerm2 | :heavy_check_mark: |
| Microsoft Teams | :heavy_check_mark:|
| Sublime Text |:heavy_multiplication_x:|
| Slack |:heavy_multiplication_x:|
| Microsoft Outlook |:heavy_multiplication_x:|

#### Usage:


```bash
chmod +x killapp.sh
Usage: ./killapp.sh
```

Output:

```bash
===================================
The Killing Machine - Choose Wisely
Choose one of the options below
-----------------------------------
(Q) Quit
(R) Refresh list
(A) All Application
(1) Microsoft Lync
(2) Microsoft Teams
(3) iTerm
Select an application to close:
Thank you for using the killing machine!
```
