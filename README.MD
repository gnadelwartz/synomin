# Synology Disc Station Webmin package

Since version 1.872 webmin supports Synology DMS 5.0+ out of the box

To be make it easyer for regular users I provide a SPK to install webmin

## build SPK

clone github repository:

`git clone https://github.com/gnadelwartz/synomin.git`

`cd synomin`

`./makespk.sh`

### history

The Package is based on QTip Webmin 1.600 SPK, but modified to automatically
download the newest webmimin packkage from webmin.com and settings are changed
to support the newest DSM Software and Addons.
