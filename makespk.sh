#!/bin/sh
#
# create webmin spk from repo
# (c) https://github.com/gnadelwartz

VER=`cat version`

echo "create webmin SPK version ${VER}"

# update REDAME.MD
mv README.MD README.MD.bak
sed 's/download \[webmin-.*/download [webmin-'${VER}'.spk](https:\/\/github.com\/gnadelwartz\/synomin\/raw\/master\/webmin-'${VER}'.spk)/' README.MD.bak >README.MD
git add README.MD 2>&1 >/dev/null
git commit -m "update Version $VER" 2>&1 >/dev/null

# chreate package.tgz
echo "make webmin package.tgz ..."
cd PACKAGE
tar -czf ../SPK/package.tgz *
cd ..

# create SPK
echo "make webmin-${VER}.spk ..."
rm -f webmin-*.spk
cd SPK
mv INFO INFO.bak
echo "version=\"${VER}\"" >INFO; sed '/version=/d' INFO.bak >>INFO; rm -f INFO.bak
tar -cf ../webmin-${VER}.spk *
cd ..

# clean up
echo clean up ...
rm -f SPK/package.tgz README.MD.bak webmin-*.spk.bak
echo done.
