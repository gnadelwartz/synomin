#!/bin/sh
#
# create webmin spk from repo
# (c) https://github.com/gnadelwartz

VER=`cat version`

echo "create webmin SPK version $VER"

# chreate package.tgz
echo "make webmin package.tgz ..."
cd PACKAGE
tar -czf ../SPK/package.tgz *
cd ..

# create SPK
echo "make webmin-$ver.spk ..."
cd SPK
tar -cf ../webmin-$VER.spk *
cd ..

# clean up
echo clean up ...
rm SPK/package.tgz
echo done.
