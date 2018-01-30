#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Upgrade info                           #
#  Description: automatic bootstrap installer for synology nas       #
#               language enu                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2016 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.21 - 28/02/2016                                    #
#  for more information check the changelog                          #
#********************************************************************#

PKG_BSTP_UPGRADE_TITLE="Important message!"
PKG_BSTP_UPGRADE_DESC1a="The currently installed bootstrap Qnapware or Entware is no longer being developed. The bootstraps for armv5, armv7, x86-32 and x86-64 are now provided by a new build system called Entware-ng. For an update to the new bootstrap, the following steps must be performed."
PKG_BSTP_UPGRADE_DESC1b="<b>1.</b> Uninstall the old EBI installation without removing the bootstrap<br><b>2.</b> Installation of EBI with selection 'Entware-ng' and <u>unchecked</u> option 'Remove installed bootstrap(s)'<br><i>The old bootstrap location will be renamed, depending on the installed bootstrap, in _qnapware_#timestamp# or _entware_#timestamp#.</i><br><b>3.</b> Install the same packages as in the previously installed bootstrap.<br><i>When using iPKGui, you can achieve this through the export and import of the package list.</i><br><b>4.</b> Migration of the old configurations in the new bootstrap directory"
PKG_BSTP_UPGRADE_DESC2a="The Currently installed bootstrap Optware is no longer being developed for a long time. A new build system called Optware-ng will now be used to provide the armv5, armv7 and x86 bootstraps. For an update to the new bootstrap, the following steps must be performed."
PKG_BSTP_UPGRADE_DESC2b="<b>1.</b> Uninstall the old EBI installation without removing the bootstrap<br><b>2.</b> Installation of EBI with selection 'Optware-ng' and <u>unchecked</u> option 'Remove installed bootstrap(s)'<br><i>The old bootstrap location will be renamed, depending on the installed bootstrap, in _optware_#timestamp#.</i><br><b>3.</b> Install the same packages as in the previously installed bootstrap.<br><i>When using iPKGui, you can achieve this through the export and import of the package list.</i><br><b>4.</b> Migration of the old configurations in the new bootstrap directory"
PKG_BSTP_UPGRADE_DESC3="<span style='color:red;font-weight:bold'>Important: The change will not be accomplished by EBI and must be performed manually!</span>"
PKG_BSTP_UPGRADE_TEXT1=""
PKG_BSTP_UPGRADE_TEXT2=""

PKG_TMP=/tmp
OUTPUTERROR="false"

show_upgrade() {

BS_UPGRADE_INFO=`/bin/cat<<EOF
{
     "step_title": "${PKG_BSTP_UPGRADE_TITLE}",
     "items": [{
          "type": "singleselect",
          "desc": "${PKG_BSTP_UPGRADE_TEXT1}",
          "subitems": [{
               "key": "upgrade_info",
               "desc": "${PKG_BSTP_UPGRADE_TEXT2}<br>${PKG_BSTP_UPGRADE_DESC3}",
               "defaultValue": true
          }]
     }]
}`
     echo "${BS_UPGRADE_INFO}"
}

main()
{
     # fix for wrong identification file
     if [ `/bin/grep -ic "optware-ng.zyxmon.org" /opt/etc/ipkg/feeds.conf` -eq 1 ] ; then
          /bin/mv -f ${SYNOPKG_PKGDEST}/optware_ipkg_installed ${SYNOPKG_PKGDEST}/optware-ng_ipkg_installed
     fi
     local OUTPUTPAGE=""
     # display only if entware or qnapware installed
     if [ -f ${SYNOPKG_PKGDEST}/entware_opkg_installed -a -d /volume?/@optware ] ; then
          PKG_BSTP_UPGRADE_TEXT1="${PKG_BSTP_UPGRADE_DESC1a}"
          PKG_BSTP_UPGRADE_TEXT2="${PKG_BSTP_UPGRADE_DESC1b}"
          OUTPUTPAGE=$(show_upgrade)
          echo ${OUTPUTPAGE} >> /root/upgrade_bs
     elif [ -f ${SYNOPKG_PKGDEST}/qnapware_opkg_installed -a -d /volume?/@qnapware ] ; then
          PKG_BSTP_UPGRADE_TEXT1="${PKG_BSTP_UPGRADE_DESC1a}"
          PKG_BSTP_UPGRADE_TEXT2="${PKG_BSTP_UPGRADE_DESC1b}"
          OUTPUTPAGE=$(show_upgrade)
          echo ${OUTPUTPAGE} >> /root/upgrade_bs
     elif [ -f ${SYNOPKG_PKGDEST}/optware_ipkg_installed -a -d /volume?/@optware ] ; then
          PKG_BSTP_UPGRADE_TEXT1="${PKG_BSTP_UPGRADE_DESC2a}"
          PKG_BSTP_UPGRADE_TEXT2="${PKG_BSTP_UPGRADE_DESC2b}"
          OUTPUTPAGE=$(show_upgrade)
          echo ${OUTPUTPAGE} >> /root/upgrade_bs
     else
          exit 0
     fi

/bin/cat > ${SYNOPKG_TEMP_LOGFILE} <<EOF
[${OUTPUTPAGE}]
EOF

     exit 0
}

main "$@"
