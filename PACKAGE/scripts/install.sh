#!/bin/sh
# bootstrap webmin after initialising environment for DSM
# (c) https://github.com/gnadelwartz
export PATH=$PATH:/opt/bin/:/opt/sbin

# get path to perl executable
PERL=`which perl`
if [ -x /opt/bin/perl ]
then
	# use ipkg perl if installed
	PERL="/opt/bin/perl"
	ln -s /opt/bin/cpan /bin/cpan
fi

# where to download webmin 
webmin="webmin-current"
tarext="tar.gz"
# configuration files
MINICONF=/var/packages/webmin/target/etc/miniserv.conf

# download latest webmin
echo "download latest webmin release ...<br>"
/bin/wget -nv "https://download.webmin.com/devel/tarballs/$webmin.$tarext"

# unpack and install
if [ -f "$webmin.$tarext" ]
then
    # echo "<br>unpacking webmin ..."
    /bin/tar -xzf "$webmin.$tarext"
    rm "$webmin.$tarext"

    echo "<br>Start installation of `ls -d webmin*` ...<br>"
    
    cd webmin*
    #get enviroanment from config file and prepare non interactive install
    install_dir=`grep "^root=" ${MINICONF}| sed 's/.*root=//'`
    config_dir=`grep "env_WEBMIN_CONFIG=" ${MINICONF}| sed 's/.*_WEBMIN_CONFIG=//'`
    var_dir=`grep "env_WEBMIN_VAR=" ${MINICONF}| sed 's/.*_WEBMIN_VAR=//'`
    atboot="NO"
    makeboot="NO"
    nouninstall="YES"
    echo $PERL >$config_dir/perl-path
    echo $var_dir >$config_dir/var-path
	[ "$WMLANG" != '' ] && echo "$WNLANG" >>$config_dir/config
    export config_dir atboot nouninstall makeboot nostart
    # run install script, output only Errors and important messages
    ./setup.sh $install_dir | grep -e "Webmin" -e "ERROR" -e ":10000" | sed 's/$/<br>/'
    cd ..
    
    # copy dummy iconv to usr/local/bin
	rm -f /opt/bin/iconv
    # cp addditional man pages
    mkdir -p /opt/man/man1
    cp ../man/man1/* /opt/man/man1/
	# add local IP to /etc/hosts+
	IP=`sed -n 's/IPADDR=//p' /etc/dhclient/ipv4/dhcpcd-eth0.info`
	grep -q "${IP}" /etc/hosts 
	if [ $? -ne 0 ] ; then
	   sed  -i "1i ${IP} `hostname`" /etc/hosts
	fi
    
    echo "Cleanup ..."
    rm -rf webmin*
else
   echo "<p>Download of webmin failed!<p>"
   exit 1
fi
