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
	/bin/ln -sf /opt/bin/cpan /bin/cpan 2>&1 1>/dev/null
fi

# where to download webmin 
webmin="webmin-current"
tarext="tar.gz"
# configuration files
MINICONF=/var/packages/webmin/target/etc/miniserv.conf

# download latest webmin, fallback to download webmin ...
/bin/echo "download latest webmin release ...<br>"
/bin/wget -nv "http://www.webmin.com/download/$webmin.$tarext"
if [ ! -f "$webmin.$tarext" ] ; then
    /bin/wget -nv "http://download.webmin.com/devel/tarballs/$webmin.$tarext"
fi

# unpack and install
if [ -f "$webmin.$tarext" ]
then
    # echo "<br>unpacking webmin ..."
    /bin/tar -xzf "$webmin.$tarext"
    /bin/rm "$webmin.$tarext"

    /bin/echo "<br>Start installation of `/bin/ls -d webmin*` ...<br>"
    
    cd webmin*
    #get enviroanment from config file and prepare non interactive install
    install_dir=`/bin/grep "^root=" ${MINICONF}| /bin/sed 's/.*root=//'`
    config_dir=`/bin/grep "env_WEBMIN_CONFIG=" ${MINICONF}| /bin/sed 's/.*_WEBMIN_CONFIG=//'`
    var_dir=`/bin/grep "env_WEBMIN_VAR=" ${MINICONF}| /bin/sed 's/.*_WEBMIN_VAR=//'`
    atboot="NO"
    makeboot="NO"
    nouninstall="YES"
    /bin/echo $PERL >$config_dir/perl-path
    /bin/echo $var_dir >$config_dir/var-path
    export config_dir atboot nouninstall makeboot nostart
    # run install script, output only Errors and important messages
	/bin/echo '<div class="list">'
    ./setup.sh $install_dir | /bin/grep -e "\*\*\*"-e "Webmin" -e "ERROR" -e ":10000" -e "s/Use your web//" -e "rowser"| /bin/sed 's/$/<br>/'
	/bin/echo '</div> <style> .list { height: 10em; overflow-y: hidden; } .list:hover { height: auto; } #sds-desktop div.active-win { left: 100px !important; top: 100px !important; }</style>'
    cd ..
    # cp addditional man pages
    /bin/mkdir -p /opt/man/man1
    /bin/cp -L ../man/man1/* /opt/man/man1/
	# add local IP to /etc/hosts+
	IP=`/bin/sed -n 's/IPADDR=//p' /etc/dhclient/ipv4/dhcpcd-eth0.info`
	/bin/grep -q "${IP}" /etc/hosts 
	if [ $? -ne 0 ] ; then
	   /bin/sed  -i "1i ${IP} `hostname`" /etc/hosts
	fi
    
    /bin/rm -rf webmin*
else
   /bin/echo "<p>Download of webmin failed!<p>"
   exit 1
fi
