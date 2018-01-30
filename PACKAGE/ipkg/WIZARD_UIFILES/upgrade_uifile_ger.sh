#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Upgrade info                           #
#  Description: automatic bootstrap installer for synology nas       #
#               language ger                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2016 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.21 - 28/02/2016                                    #
#  for more information check the changelog                          #
#********************************************************************#

PKG_BSTP_UPGRADE_TITLE="Wichtige Mitteilung!"
PKG_BSTP_UPGRADE_DESC1a="Der zur Zeit installierte Bootstrap Qnapware oder Entware wird nicht mehr weiterentwickelt. Die Bootstraps für armv5, armv7, x86-32 und x86-64 werden nun durch ein neues Build-System namens Entware-ng bereitgestellt. Für eine Aktualisierung auf das neue System müssen die folgenden Schritte durchgeführt werden."
PKG_BSTP_UPGRADE_DESC1b="<b>1.</b> Deinstallation der alten EBI Installation ohne Entfernung des Bootstraps<br><b>2.</b> Installation von EBI mit Auswahl 'Entware-ng' und <u>nicht</u> aktivierter Option 'Entfernen der installierten Bootstrap(s)'<br><i>Das alte Bootstrap-Verzeichnis wird, je nach installiertem Bootstrap, in _qnapware_#timestamp# oder _entware_#timestamp# umbenannt.</i><br><b>3.</b> Installieren der gleichen Pakete wie im zuvor installierten Bootstrap.<br><i>Bei Verwendung von iPKGui, können sie dies über den Export und Import der Paketliste erreichen.</i><br><b>4.</b> Migration der alten Konfigurationen in das neue Bootstrap-Verzeichnis"
PKG_BSTP_UPGRADE_DESC2a="Der zur Zeit installierte Bootstrap Optware wird seit längerer Zeit nicht mehr weiterentwickelt. Ein neues Build-System namens Optware-ng wird nun für die Bereitstellung der armv5, armv7 and x86 Bootstraps verwendet. Für eine Aktualisierung auf das neue System müssen die folgenden Schritte durchgeführt werden."
PKG_BSTP_UPGRADE_DESC2b="<b>1.</b> Deinstallation der alten EBI Installation ohne Entfernung des Bootstraps<br><b>2.</b> Installation von EBI mit Auswahl 'Optware-ng' und <u>nicht</u> aktivierter Option 'Entfernen der installierten Bootstrap(s)'<br><i>Das alte Bootstrap-Verzeichnis wird, je nach installiertem Bootstrap, in _optware_#timestamp# umbenannt.</i><br><b>3.</b> Installieren der gleichen Pakete wie im zuvor installierten Bootstrap.<br><i>Bei Verwendung von iPKGui, können sie dies über den Export und Import der Paketliste erreichen.</i><br><b>4.</b> Migration der alten Konfigurationen in das neue Bootstrap-Verzeichnis"
PKG_BSTP_UPGRADE_DESC3="<span style='color:red;font-weight:bold'>Wichtig: Die Umstellung wird nicht von EBI durchgeführt und muss manuell erfolgen!</span>"
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
