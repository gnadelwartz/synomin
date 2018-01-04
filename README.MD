# Synology Disc Station Webmin package

Since version 1.872 webmin supports Synology DMS 5.0+ out of the box

To be make it easyer for regular users I provide a SPK to install webmin

## build SPK

clone github repository:

`git clone https://github.com/gnadelwartz/synomin.git`

`cd synomin`

`./makespk.sh`

## pre requisites

to install and use webmin on Synology Disc Station you have to install the Packages `Perl` and `Git server` from package center.

## installation

download webmin-xxx.spk

- open synology package center and klick on "manual installation"

- select you downloaded webmin-xxx.spk amd klick "install"

after sucessfull installation aou can access webnmin with your browser on port 10000, e.g. http://192.178.0.20:10000
```
username: admin
password: <password you set for synology user admin>
```

in case your synology admin user has a different name, create user `admin` in synology user management.

### webmin emergency user:

```
ussername: recovery
password: recovery
```

you can access the emergency user only from local network (192.178.0.0/8) or localhost
after login with emergency user you can access only webmin user module to create/modify users

### history

The Package is based on QTip Webmin 1.600 SPK, but modified to automatically
download the newest webmimin packkage from webmin.com and settings are changed
to support the newest DSM Software and Addons.
