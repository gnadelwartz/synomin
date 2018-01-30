#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Upgrade info                           #
#  Description: automatic bootstrap installer for synology nas       #
#               language fre                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2016 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.21 - 28/02/2016                                    #
#  for more information check the changelog                          #
#********************************************************************#pour une longue période

PKG_BSTP_UPGRADE_TITLE="Message important!"
PKG_BSTP_UPGRADE_DESC1a="Le bootstrap actuellement installée Qnapware ou Entware ne sera plus développés. Le bootstraps pour armv5, armv7, x86-32 et x86-64 sont maintenant fournis par un nouveau système de build appelé Entware-ng. Pour une mise à jour sur le nouveau système, des étapes suivantes doivent être effectuées."
PKG_BSTP_UPGRADE_DESC1b="<b>1.</b> Désinstallez l'ancienne installation EBI sans retirer le bootstraps<br><b>2.</b> L'installation de EBI avec la sélection 'Entware-ng' et <u>non</u> pas activé l'option 'Retirer installée bootstrap(s)'<br><i>L'ancien emplacement de bootstrap est renommé, en fonction de la bootstrap installé, dans _qnapware_#horodatage# ou _entware_#horodatage#.</i><br><b>3.</b> Installez les packages de mêmes comme dans le bootstrap précédemment installé.<br><i>Lors de l'utilisation iPKGui, ils peuvent atteindre cet objectif grâce à l'exportation et l'importation de la liste des paquets.</i><br><b>4.</b> La migration des anciennes configurations dans le nouveau répertoire bootstrap"
PKG_BSTP_UPGRADE_DESC2a="Le bootstrap actuellement installée Optware ne sera plus développés pour une longue période. Un nouveau système de build appelé Optware-ng va maintenant être utilisé pour fournir les armv5, armv7 et x86 bootstraps. Pour une mise à jour sur le nouveau système, des étapes suivantes doivent être effectuées."
PKG_BSTP_UPGRADE_DESC1b="<b>1.</b> Désinstallez l'ancienne installation EBI sans retirer le bootstraps<br><b>2.</b> L'installation de EBI avec la sélection 'Optware-ng' et <u>non</u> pas activé l'option 'Retirer installée bootstrap(s)'<br><i>L'ancien emplacement de bootstrap est renommé, en fonction de la bootstrap installé, dans _optware_#horodatage#.</i><br><b>3.</b> Installez les packages de mêmes comme dans le bootstrap précédemment installé.<br><i>Lors de l'utilisation iPKGui, ils peuvent atteindre cet objectif grâce à l'exportation et l'importation de la liste des paquets.</i><br><b>4.</b> La migration des anciennes configurations dans le nouveau répertoire bootstrap"
PKG_BSTP_UPGRADE_DESC3="<span style='color:red;font-weight:bold'>Important: Le Changer est pas effectuée par EBI et doit être effectuer manuellement!</span>"
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
