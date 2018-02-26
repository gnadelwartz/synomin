# Webmin for Synology Disc Station

Current  Webmin supports Synology DMS 5.0+ and IKPG package manager out of the box.
this SPK installs or upgrades to the newest Webmin version.

Webmin Version 1.880 is the first offical release with full Synonoly Disc Station support.
If the IPKG Package Manager is installed webmin uses https:// protocol (see Advanced Install).

## Click and Point installation

Login to your Disc Station on port 5000, go to Package Center and  install Synology packages `Perl` and `Git server`.
then download [webmin-1.880.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.880.spk)

- open Synology Package Center and klick on "manual installation"

- select your already download [webmin-1.880.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.880.spk)
  , then klick "install"

after sucessfull installation you can access webnmin with your browser on port 10000, e.g. http://192.178.0.20:10000

```
username: admin
password: <password you set for synology user admin>
```
Webmin is configured to support the following Synology installable packages:

- `Mail Station` (postfix, dovecot, spamassasin, roundcube)
- `Webstation` (ngix, apache, php)
- `Webalizer`

## Upgrade from older Version

To upgrade from an already installed older SPK you can simply
download [webmin-1.880.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.880.spk)
and install it. It will always download the lastest official Webmin Release.

You can upgrade also direct from Qtip's Webmin 1.600 SPK, if you want to keep your modified Webmin Settings.
Nevertheless I suggest to remove it first to get the latest default config to have as much as possible modules
enabled.

## Webmin emergency user:

```
ussername: recovery
password: webmin
```

In case you can not login as admin, login as user recovery, delete the admin user and create a new admin user to access webmin.
do not forget allowing access to all modules for new admin user.

emergency user is allowed from local network (192.178.0.0/8) or localhost only.

## Advanced install

If you want to get most out of Webmin and Synology Disc Station, install the Community Package Manager 
`ipkg` instead of standard Synology packages `Perl` and `Git Server`. installing `ipkg`
is only recommended for users with linux knowledge.

- download `Easy Bootstrap Installer` from [HERE](https://www.cphub.net/?id=40&pid=677) and install before installing Webmin.
- download [webmin-1.880.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.880.spk)
and install webmin.

Webmin automatically detects if IPKG is installed and use it.
the following packages will be installed if ipkg is installed:

`ipkg install coreutils git dstat man man-pages perl perl-net-ssleay mc lm-sensors lsof gcc`


- to enable SSH access on Synology Disc Sytation go to "System Settings -> Terminal", check `SSH Service`.
  now you can SHH login to your Synology and login as `admin`.
- to run commands as root use  `sudo <command>` using the same password as admin.

WARNING: running commands as user root can brick you Synology Disc Station!


## Build SPK

Clone github repository and run `makespk.sh`:

```
git clone https://github.com/gnadelwartz/synomin.git

cd synomin
./makespk.sh
```

To sign Package with your own Key follow the [instructions from Qtip](http://www.synology-forum.de/showthread.html?58583-HowTo-Pakete-signieren)

## Additional Packages you may install from Webmin bultin Software Package Manager:


```
bacula - 7.0.5-5 - A set of Open Source, enterprise ready, computer programs to manage backup, recovery, and verification of computer data across a network of computers of different kinds.
bzip2 - 1.0.6-2 - Very high-quality data compression program
cdrtools - 2.01-8 - low-level CD recording tools: cdrecord, mkisofs, etc.
clamav - 0.98.6-4 - Clam ANtivirus is a GPL anti-virus toolkit for UNIX
cpufrequtils - 006-2 - To make access to the Linux kernel cpufreq subsystem easier for users and cpufreq userspace tools, a cpufrequtils package was created. It contains a library used by other programs (libcpufreq), command line tools to determine current CPUfreq settings and to modify them (cpufreq-info and cpufreq-set), and debug tools.
fetchmail - 6.3.26-3 - A remote mail retrieval and forwarding utility
gconv-modules - 2.25-4 - Provides gconv modules missing from the firmware.  These are used by glibc iconv() implementation.
git-manpages - 2.9.3-2 - manpages of git
lynx - 2.8.6-2 - A text browser for the World Wide Web
lzo - 2.09-1 - Compression library
mailman - 2.1.11-1 - the GNU Mailing List Manager.
make - 4.1-2 - examines files and runs commands necessary for compilation
moe - 1.4-1 - My own editor, a powerful, 8-bit clean text editor for ISO-8859 and ASCII character encodings.
mutt - 1.5.17-3 - text mode mail client
openssl - 1.0.2h-2 - Openssl provides the ssl implementation in libraries libcrypto and libssl, and is needed by many other applications and libraries.
openvpn - 2.2.0-3 - SSL based VPN server with Windows client support
p7zip - 16.02-2 - Command line version of 7-zip for POSIX systems.
perl-db-file - 1.814-4 - A module which allows Perl programs to make use of the facilities provided by Berkeley DB version 1.
perl-dbd-mysql - 4.033-4 - DBD-mysql - The Perl Database Driver for MySQL.
perl-dbd-sqlite - 1.35-3 - The Perl Database Driver for SQLITE.
perl-dbi - 1.632-3 - DBI - The Perl Database Interface by Tim Bunce.
postgrey - 1.33-2 - a Postfix policy server implementing greylisting.
procmail - 3.22-4 - Versatile email processor.
proftpd - 1.3.4a-4 - Highly configurable FTP server with SSL-TLS
recode - 3.6-3 - The recode library converts files between character sets and usages.
screen - 4.2.1-3 - A screen manager that supports multiple logins on single terminal
sdparm - 1.07-1 - Utility for listing and potentially changing SCSI disk parameters
smartmontools - 5.40-5 - Utility programs to control and monitor (SMART) built into most modern ATA and SCSI hard disks.
sqlite - 3.8.1-3 - SQLite is a small C library that implements a self-contained, embeddable, zero-configuration SQL database engine.
unrar - 5.0.12-2 - unrar is an application that can decompress files and archives created using the RAR compression scheme
unzip - 6.0-2 - A (de)compression library for the ZIP format
xz-utils - 5.2.3-2 - A free general-purpose data compression software with high compression ratio
zip - 3.0-1 - a compression and file packaging utility.
zoo - 2.10-1 - zoo - File archiving utility with compression
```

## History

The Package is based on QTip Webmin 1.600 SPK, but heavily modified to automatically
download the newest webmimin package from webmin.com and install needed system commands. settings are changed
to support the newest DSM Software and as much Webmin modules as possible.

