# Synology Disc Station Webmin package

since version 1.873 webmin supports Synology DMS 5.0+ and IKPG package manager out of the box.

to make it easyer for regular users I provide a SPK to install webmin

## build SPK

clone github repository:

`git clone https://github.com/gnadelwartz/synomin.git`

`cd synomin`

`./makespk.sh`

## pre requisites

to install and use webmin on Synology Disc Station you have to install the Packages `Perl` and `Git server` from package center.


## installation

download [webmin-1.872-ipkg-06.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.872-ipkg-06.spk)

- open synology package center and klick on "manual installation"

- select your download [webmin-1.872-ipkg-06.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.872-ipkg-06.spk)
  and klick "install"

after sucessfull installation you can access webnmin with your browser on port 10000, e.g. http://192.178.0.20:10000
```
username: admin
password: <password you set for synology user admin>
```

in case your synology admin user has a different name, create user `admin` in synology user management.

## webmin emergency user:

```
ussername: recovery
password: recovery
```

you can access the emergency user only from local network (192.178.0.0/8) or localhost
after login with emergency user you can access only webmin user module to create/modify users

## advanced install

First install all software packages recommended here, then download [webmin-1.872-ipkg-06.spk](https://github.com/gnadelwartz/synomin/raw/master/webmin-1.872-ipkg-06.spk)
and install webmin.

Webmin is configured to support the following Synology installable packages:

- `Mail Station` (postfix, dovecot, spamassasin, roundcube)
- `Webstation` (ngix, apache, php)
- `Webalizer`

`ipkg` optware-ng package manager, which provides more system commands and libs, is detected and installed automatically.
alternatively you can download `Easy Bootstrap Installer` from [HERE](https://www.cphub.net/?id=40&pid=677) and install it manually before installing webmin.

enable SSH access to your Synology under "System Setting -> Terminal" and SHH login to your Synology as `admin`.
get root access with `sudo -i` as admin using the same password.

list of installable packages with `ipkg list`, to install packages run `ipkg install <NAME>`.

the following packages will be installed automatically if ipkg is installed or detected:

`ipkg install at coreutils git dstat man man-pages perl perl-net-ssleay`

the manual page index is also automatically created (this may take a while):

`makewhatis /opt/man /opt/share/man /volume1/@optware/man /volume1/@optware/share/man`

```
at - 3.1.8-5 - Delayed job execution and batch processing.
bind - 9.11.2-2 - Bind provides a full name server package, including zone masters, slaves, zone transfers, security multiple views.  This is THE reference implementation from ISC, which has roots all the way back to the TOPS-20 original.  It is over-kill, unless you have a complex environment.  Other utilities (for debugging, remote management) are also included.  Full documentation and developers' files are included in this kit, though you may wish they weren't.
coreutils - 8.4-3 - Bunch of heavyweight *nix core utilities
git - 2.9.3-2 - GIT is a directory tree content manager that can be used for distributed revision control.
dstat - 0.7.0-1 - dstat is a versatile replacement for vmstat, iostat, netstat, nfsstat, and ifstat
man - 1.6g-1 - unix manual page reader
man-pages - 2.76-1 - unix manual pages
perl - 5.26.1-4 - Practical Extraction and Report Language.
perl-net-ssleay - 1.82-1 - Net_SSLeay - Perl extension for using OpenSSL
```

additional packages you may find useful:


```
bacula - 7.0.5-5 - A set of Open Source, enterprise ready, computer programs to manage backup, recovery, and verification of computer data across a network of computers of different kinds.
bzip2 - 1.0.6-2 - Very high-quality data compression program
cdrtools - 2.01-8 - low-level CD recording tools: cdrecord, mkisofs, etc.
clamav - 0.98.6-4 - Clam ANtivirus is a GPL anti-virus toolkit for UNIX
cpufrequtils - 006-2 - To make access to the Linux kernel cpufreq subsystem easier for users and cpufreq userspace tools, a cpufrequtils package was created. It contains a library used by other programs (libcpufreq), command line tools to determine current CPUfreq settings and to modify them (cpufreq-info and cpufreq-set), and debug tools.
fetchmail - 6.3.26-3 - A remote mail retrieval and forwarding utility
gcc - 7.2.0-1 - The GNU Compiler Collection.
gconv-modules - 2.25-4 - Provides gconv modules missing from the firmware.  These are used by glibc iconv() implementation.
git-manpages - 2.9.3-2 - manpages of git
lm-sensors - 3.3.0-2 - Linux hardware monitoring.
lsof - 4.82-1 - LiSt Open Files - a diagnostic tool.
lynx - 2.8.6-2 - A text browser for the World Wide Web
lzo - 2.09-1 - Compression library
mailman - 2.1.11-1 - the GNU Mailing List Manager.
make - 4.1-2 - examines files and runs commands necessary for compilation
mc - 4.8.17-4 - Midnight Commander File Manager
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

## history

The Package is based on QTip Webmin 1.600 SPK, but modified to automatically
download the newest webmimin package from webmin.com and settings are changed
to support the newest DSM Software and Addons.

