#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Upgrade info                           #
#  Description: automatic bootstrap installer for synology nas       #
#               language nld                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2016 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.21 - 28/02/2016                                    #
#  for more information check the changelog                          #
#********************************************************************#

PKG_BSTP_UPGRADE_TITLE="Belangrijk bericht!"
PKG_BSTP_UPGRADE_DESC1="De Geïnstalleerde bootstrap Qnapware of Entware wordt niet meer ontwikkeld. De bootstraps voor armv5, armv7, x86-32 en x86-64 worden nu geleverd door een nieuw te bouwen systeem genaamd Entware-ng. Voor een update van het nieuwe systeem, moeten de volgende stappen worden uitgevoerd."
PKG_BSTP_UPGRADE_DESC2="<b>1.</b> Verwijder de oud EBI installatie zonder het verwijderen van de bootstraps<br><b>2.</b> Installatie van de EBI met de selectie 'Entware-ng' en niet geactiveerd optie 'Verwijder geïnstalleerde bootstrap(s)'<br><i>De oude bootstrap locatie is omgedoopt, afhankelijk van de geïnstalleerde bootstrap, in _qnapware_#tijdstempel# of _entware_#tijdstempel#.</i><br><b>3.</b> Installeer dezelfde pakketten als in de eerder geïnstalleerde bootstrap.<br><i>Bij het gebruik van iPKGui, kunnen ze dit te bereiken door middel van de in- en uitvoer van het pakket lijst.</i><br><b>4.</b> Migratie van de oude configuraties in de nieuwe bootstrap directory"
PKG_BSTP_UPGRADE_DESC2a="De Geïnstalleerde bootstrap Optware niet langer wordt ontwikkeld voor een lange tijd. Een nieuw te bouwen systeem genaamd Optware-ng zal worden gebruikt voor de verstrekking van armv5, armv7 en x86 bootstraps. Voor een update van het nieuwe systeem, moeten de volgende stappen worden uitgevoerd."
PKG_BSTP_UPGRADE_DESC2="<b>1.</b> Verwijder de oud EBI installatie zonder het verwijderen van de bootstraps<br><b>2.</b> Installatie van de EBI met de selectie 'Optware-ng' en niet geactiveerd optie 'Verwijder geïnstalleerde bootstrap(s)'<br><i>De oude bootstrap locatie is omgedoopt, afhankelijk van de geïnstalleerde bootstrap, in _optware_#tijdstempel#.</i><br><b>3.</b> Installeer dezelfde pakketten als in de eerder geïnstalleerde bootstrap.<br><i>Bij het gebruik van iPKGui, kunnen ze dit te bereiken door middel van de in- en uitvoer van het pakket lijst.</i><br><b>4.</b> Migratie van de oude configuraties in de nieuwe bootstrap directory"
PKG_BSTP_UPGRADE_DESC3="<span style='color:red;font-weight:bold'>Belangrijk: De conversie wordt niet uitgevoerd door EBI en moet handmatig worden uitgevoerd!</span>"
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
