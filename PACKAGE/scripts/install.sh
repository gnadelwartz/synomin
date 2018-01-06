#!/bin/sh
# bootstrap webmin after intiializing environment for DSM
# (c) https://github.com/gnadelwartz
export PATH=$PATH:/opt/bin/:/opt/sbin

PERL=`which perl`

# webmin localtions
webmin="webmin-current"
tarext="tar.gz"
MINICONF=/var/packages/webmin/target/etc/miniserv.conf

# download latest webmin
echo "<br>download latest webmin release ...<br>"
/bin/wget -nv "https://download.webmin.com/devel/tarballs/$webmin.$tarext"

# unpack and install
if [ -f "$webmin.$tarext" ]
then
    echo "<br>unpacking webmin ...<br>"
    /bin/tar -xzf "$webmin.$tarext"
    rm "$webmin.$tarext"

    echo "<br>start installation of `ls -d webmin*` ...<br>"
    cd webmin*
    install_dir=`grep "^root=" ${MINICONF}| sed 's/.*root=//'`
    config_dir=`grep "env_WEBMIN_CONFIG=" ${MINICONF}| sed 's/.*_WEBMIN_CONFIG=//'`
    var_dir=`grep "env_WEBMIN_VAR=" ${MINICONF}| sed 's/.*_WEBMIN_VAR=//'`
    atboot="NO"
    makeboot="NO"
    nouninstall="YES"
    echo $PERL >$config_dir/perl-path
    echo $var_dir >$config_dir/var-path

    export config_dir atboot nouninstall makeboot nostart
    ./setup.sh $install_dir |  /bin/tee install.log | grep -e "\*" -e "Webmin" -e "ERROR" -e "browser" -e ":10000"
    cd ..
    # copy dummy iconv to usr/loca/bin
	[ ! -f "/usr/local/bin/iconv" ] && cp iconv /usr/local/bin
    echo "<br>cleanup ...<br>"
    rm -rf webmin*
else
   echo "<p>Download of webmin failed!<p>"
   exit 1
fi
