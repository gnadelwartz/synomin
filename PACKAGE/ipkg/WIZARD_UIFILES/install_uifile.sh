#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Part 1                                 #
#  Description: automatic bootstrap installer for synology nas       #
#               language enu                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2017 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.99 - 03/12/2017                                    #
#  for more information check the changelog                          #
#********************************************************************#

PKG_BSTP_INFO_TITLE="Information"
PKG_BSTP_SELECT_TITLE="Bootstrap selection"
PKG_BSTP_SELECT_DESC1="The following Bootstraps are available for"
PKG_BSTP_SELECT_DESC2="your"
PKG_BSTP_SELECT_DESC3="your"
PKG_BSTP_SELECT_DESC4=", please choose the desired package."
PKG_BSTP_ERROR_TEXT="Please exit the installation wizard now manually. If you do not exit the wizard nevertheless, you will get a general error message after you apply the summary."
PKG_BSTP_NOUSB_TEXT="Please first install a USB flash drive or an SD card before you perform the installation."
PKG_BSTP_SERVER_NOTAVAIL_TEXT="This service is currently unreachable due to maintenance or other urgent stuff, please be patient and try again later!"
PKG_BSTP_NOBSTP_TEXT1="Sorry, no bootstrap for your"
PKG_BSTP_NOBSTP_TEXT2="Sorry, no bootstrap for your"
PKG_BSTP_NOBSTP_TEXT3="currently available!"
PKG_BSTP_REMOVE_SELECT="Remove installed bootstrap(s)"
PKG_BSTP_REMOVE_DESC1="It has been determined that a bootstrap is already installed. The currently installed bootstrap can be previously removed or deactivated by renaming the source directory (typically @optware, @qnapware or @entware)."
PKG_BSTP_REMOVE_DESC2="Attention: With activated option 'Remove installed bootstrap(s)' the determined bootstraps, with exception of the subdirectory 'VirtualBox', will be permanently removed and can not be recovered after deletion!"
PKG_BSTP_INTEGRATE_TITLE="Integration of existing files and folders"
PKG_BSTP_INTEGRATE_SELECT="Integrate existing /opt directory without package manager"
PKG_BSTP_INTEGRATE_DESC="An existing /opt directory with files and subdirectories, but without package manager, can be automatically integrated into the /opt directory of the bootstrap. If this is not desired, the existing directory will be renamed before the installation (opt_#timestamp#)."
PKG_BSTP_INTEGRATEVBOX_SELECT="Integrate existing /opt/VirtualBox directory"
PKG_BSTP_INTEGRATEVBOX_DESC="An existing /opt/VirtualBox directory are automatically integrated into the /opt directory of the bootstrap. <b>Please stop VirtualBox before you continue with the installation!</b>"
USB_SELECT_TITLE="Destination drive"
USB_SELECT_DESC1="Please select the destination drive."
USB_DESC_SDCARD="SD Card"
USB_DESC_USBDISC="USB Disk"
USB_DESC_PARTITION="Partition"
MISC_SELECT_TITLE="Misc options"
LINK_SELECT_DESC="Please select the desired link variant."
LINK_SELECT_VAR1="Symbolic Link"
LINK_SELECT_VAR2="Bind Mount (<b>Note: VirtualBox requires this link variant</b>)"
PATHPRIO_SELECT_DESC="Please select the desired Optware path priority"
PATHPRIO_SELECT_VAR1="Synology before Optware path - files in Synology path are preferred"
PATHPRIO_SELECT_VAR2="Optware before Synology path - files in Optware path are preferred"

PKG_TMP=/tmp
SYNOUNIQUE=`/bin/get_key_value /etc.defaults/synoinfo.conf unique`
SYNOMODEL=`/bin/get_key_value /etc.defaults/synoinfo.conf upnpmodelname`
SYNOARCH=`echo ${SYNOUNIQUE} | /usr/bin/cut -d "_" -f2`
USBSTATION=`/bin/get_key_value /etc.defaults/synoinfo.conf usbstation`
USBVOLUME=`/bin/get_key_value /etc.defaults/synoinfo.conf support_usb_volume`
#ARCHLISTURL=
OUTPUTERROR="false"
PKG_BSTP_ERRORMSG_TEXT=""
LINKSELECTIONSYM=true
LINKSELECTIONBIND=false
if [ -d /opt/VirtualBox ] ; then
     LINKSELECTIONSYM=false
     LINKSELECTIONBIND=true
fi
PKG_BSTP_SELECT_DESC="${PKG_BSTP_SELECT_DESC1} ${PKG_BSTP_SELECT_DESC2}"
if [ "${SYNOARCH}" == "northstarplus" ] ; then
     PKG_BSTP_SELECT_DESC="${PKG_BSTP_SELECT_DESC1} ${PKG_BSTP_SELECT_DESC3}"
     PKG_BSTP_NOBSTP_TEXT1="${PKG_BSTP_NOBSTP_TEXT2}"
fi

[ ! -f ${PKG_TMP}/bootstraps ] && /bin/cat > ${PKG_TMP}/bootstraps <<EOF
88f5281="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armv5eabi-ng,autodetect,http://pkg.entware.net/binaries/armv5,installer/entware_install.sh"
88f6281="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armv5eabi-ng,autodetect,http://pkg.entware.net/binaries/armv5,installer/entware_install.sh"
88f6282="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armv5eabi-ng,autodetect,http://pkg.entware.net/binaries/armv5,installer/entware_install.sh"
alpine="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
alpine4k="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
apollolake="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
armada370="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
armada375="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
armada38x="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
armadaxp="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
rtd1296="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
avoton="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
braswell="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
broadwell="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
broadwellnk="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
bromolow="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
cedarview="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
comcerto2k="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
evansport="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-32,installer/entware_install.sh"
grantley="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
monaco="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
northstarplus="http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf,autodetect,http://pkg.entware.net/binaries/armv7,installer/entware_install.sh"
powerpc="http://ipkg.nslu2-linux.org/feeds/optware/ds101g/cross/unstable,autodetect,,"
ppc824x="http://ipkg.nslu2-linux.org/feeds/optware/ds101g/cross/unstable,autodetect,,"
ppc853x="http://ipkg.nslu2-linux.org/optware-ng/ct-ng-ppc-e500v2,autodetect,,"
ppc854x="http://ipkg.nslu2-linux.org/optware-ng/ct-ng-ppc-e500v2,autodetect,,"
qoriq="http://ipkg.nslu2-linux.org/optware-ng/ct-ng-ppc-e500v2,autodetect,,"
x86="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
kvmx64="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
dockerx64="http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686,autodetect,http://pkg.entware.net/binaries/x86-64,installer/entware_install.sh"
EOF

show_error() {

BS_ERROR_PAGE=`/bin/cat<<EOF
{
     "step_title": "${PKG_BSTP_INFO_TITLE}",
     "items": [{
          "type": "singleselect",
          "desc": "<br><br>",
          "subitems": [{
               "key": "OUTPUTERROR",
               "desc": "${PKG_BSTP_ERRORMSG_TEXT}<br><br>${PKG_BSTP_ERROR_TEXT}",
               "defaultValue": true
          }]
     }]
}
`

     echo "${BS_ERROR_PAGE}"
}

USB_SELECTION_BEGIN=`/bin/cat<<EOF
{
     "step_title": "${USB_SELECT_TITLE}",
     "items": [{
          "type": "singleselect",
          "desc": "${USB_SELECT_DESC1}",
          "subitems": [{
`

USB_SELECTION_FINISH=`/bin/cat<<EOF
          }]
     }]
}
`

BS_SELECTION_BEGIN=`/bin/cat<<EOF
{
     "step_title": "${PKG_BSTP_SELECT_TITLE}",
     "items": [{
          "type": "singleselect",
          "desc": "${PKG_BSTP_SELECT_DESC} <b>${SYNOMODEL}</b> ${PKG_BSTP_SELECT_DESC4}",
          "subitems": [{
`

BS_SELECTION_OPTWARE=`/bin/cat<<EOF
               "key": "select_optware",
               "desc": "Optware(-ng) iPKG®"
`

BS_SELECTION_ENTWARE=`/bin/cat<<EOF
               "key": "select_entware",
               "desc": "Entware-ng oPKG"
`

BS_SELECT_REMOVE=`/bin/cat<<EOF
     }, {
          "type": "multiselect",
          "desc": "${PKG_BSTP_REMOVE_DESC1}<br><span style='color:red;'>${PKG_BSTP_REMOVE_DESC2}</span>",
          "subitems": [{
               "key": "select_remove_bssource",
               "desc": "${PKG_BSTP_REMOVE_SELECT}"
          }]
`

SELECTION_MID=`/bin/cat<<EOF
          }, {
`

SELECTION_END=`/bin/cat<<EOF
          }]
`

SELECTION_FINISH=`/bin/cat<<EOF
     }]
}
`

LINK_SELECTION=`/bin/cat<<EOF
{
     "step_title": "${MISC_SELECT_TITLE}",
     "items": [{
          "type": "singleselect",
          "desc": "${LINK_SELECT_DESC}",
          "subitems": [{
               "key": "select_symlink",
               "desc": "${LINK_SELECT_VAR1}",
               "defaultValue": ${LINKSELECTIONSYM}
          },{
               "key": "select_mountbind",
               "desc": "${LINK_SELECT_VAR2}",
               "defaultValue": ${LINKSELECTIONBIND}
          }]
`

PATHPRIO_SELECTION=`/bin/cat<<EOF
     }, {
          "type": "singleselect",
          "desc": "${PATHPRIO_SELECT_DESC}",
          "subitems": [{
               "key": "select_sbo",
               "desc": "${PATHPRIO_SELECT_VAR1}",
               "defaultValue": true
          },{
               "key": "select_obs",
               "desc": "${PATHPRIO_SELECT_VAR2}"
          }]
`

BS_SELECT_INTEGRATE=`/bin/cat<<EOF
     }, {
          "type": "multiselect",
          "desc": "${PKG_BSTP_INTEGRATE_DESC}",
          "subitems": [{
               "key": "select_integrate_bssource",
               "desc": "${PKG_BSTP_INTEGRATE_SELECT}",
               "defaultValue": true
          }]
`

BS_SELECT_INTEGRATEVBOX=`/bin/cat<<EOF
     }, {
          "type": "singleselect",
          "desc": "${PKG_BSTP_INTEGRATEVBOX_DESC}",
          "subitems": [{
               "key": "select_integratevbox",
               "desc": "${PKG_BSTP_INTEGRATEVBOX_SELECT}",
               "defaultValue": true
          }]
`

check_bootstrap() {
     local FOUND=""
     FOUND=`/usr/bin/find /volume?/@optware/bin /volume?/@qnapware/opt/bin /volume?/@entware/bin /volumeUSB?/usbshare*/@???ware/bin -type f -iname ?pkg 2> /dev/null`
     if [ -n "${FOUND}" ] ; then
          echo "true"
     else
          echo "false"
     fi
}

determine_bootstrap() {
     # online variant
     #[ ! -f ${PKG_TMP}/bootstraps ] && /usr/bin/wget -qO ${PKG_TMP}/bootstraps ${ARCHLISTURL}
     if [ -f ${PKG_TMP}/bootstraps -a -s ${PKG_TMP}/bootstraps ] ; then
          BOOTSTRAPS=`/bin/get_key_value ${PKG_TMP}/bootstraps ${SYNOARCH}`
          OPTFEED=`echo ${BOOTSTRAPS} | /usr/bin/cut -d "," -f1`
          ENTFEED=`echo ${BOOTSTRAPS} | /usr/bin/cut -d "," -f3`
          ENTINSTALLER=`echo ${BOOTSTRAPS} | /usr/bin/cut -d "," -f4`
          ENTFILE="`/usr/bin/basename ${ENTINSTALLER}`"
          if [ -n "${OPTFEED}" -a -z "${ENTFEED}" ] ; then
               echo "optware"
          elif [ -n "${ENTFEED}" -a -z "${OPTFEED}" ] ; then
               echo "entware"
          elif [ -z "${ENTFEED}" -a -z "${OPTFEED}" ] ; then
               echo "none"
          else
               echo "optent"
          fi
     else
          echo "false"
     fi
}

main()
{
     # detect device with usb enabled volumes (synology router rt1900ac)...
     local USBSELECTOR=""
     if [ "${USBSTATION}" == "yes" -a "${USBVOLUME}" == "yes" ] ; then
          # ...and determine valid install drives
          SELCOUNT=0
          cd /sys/block
          DRIVES=`/bin/ls -1 sd? 2> /dev/null`
          for DRV in ${DRIVES} ; do
               MPOINTS=`/bin/mount | /bin/grep "${DRV}" | /usr/bin/cut -d ' ' -f3`
               SYNOCARD=`/bin/cat /sys/block/${DRV}/device/syno_cardreader`
               if [ "${SYNOCARD}" == "1" ] ; then
                    DESC=${USB_DESC_SDCARD}
               else
                    DESC=${USB_DESC_USBDISC}
               fi
               for MP in ${MPOINTS} ; do
                    MP_=`echo ${MP:1} | /bin/sed 's/-/_/;s/\//\./g'`
                    PT=`echo ${MP} | /bin/sed 's/.*usbshare//;s/-/ '${USB_DESC_PARTITION}' /'`
                    USBSELECTOR=${USBSELECTOR}'"key": "'${MP_}'","desc": "'${DESC}' '${PT}'"'
                    USBSELECTOR="${USBSELECTOR}${SELECTION_MID}"
                    SELCOUNT=$((SELCOUNT+1))
               done
          done
          if [ ${SELCOUNT} -gt 0 ] ; then
               LEN=${#USBSELECTOR}
               USBSELECTOR=${USBSELECTOR::$((LEN-4))}
          fi
     fi
     local OUTPUTPAGE=""
     local RENAMESELECT=""
     # step1: check if optware, entware or qnapware always installed
     if [ $(check_bootstrap) == "true" ] ; then
          RENAMESELECT="${BS_SELECT_REMOVE}"
     fi
     # step2: determine bootstrap by synology arch
     BTRET=$(determine_bootstrap)
     if [ "${BTRET}" == "false" ] ; then
          /bin/rm -f ${PKG_TMP}/bootstraps
          PKG_BSTP_ERRORMSG_TEXT="${PKG_BSTP_SERVER_NOTAVAIL_TEXT}"
          OUTPUTPAGE=$(show_error)
          OUTPUTERROR="true"
     elif [ "${BTRET}" == "none" ] ; then
          PKG_BSTP_ERRORMSG_TEXT="${PKG_BSTP_NOBSTP_TEXT1} <b>${SYNOMODEL}</b> ${PKG_BSTP_NOBSTP_TEXT3}"
          OUTPUTPAGE=$(show_error)
          OUTPUTERROR="true"
     elif [ "${USBSTATION}" == "yes" -a "${USBVOLUME}" == "yes" -a ${SELCOUNT} -eq 0 ] ; then
          PKG_BSTP_ERRORMSG_TEXT="${PKG_BSTP_NOUSB_TEXT}"
          OUTPUTPAGE=$(show_error)
          OUTPUTERROR="true"
     fi
     if [ "${OUTPUTERROR}" == "false" ] ; then
          if [ "${USBSTATION}" == "yes" -a "${USBVOLUME}" == "yes" -a -n "${USBSELECTOR}" ] ; then
               OUTPUTPAGE="${USB_SELECTION_BEGIN}${USBSELECTOR}${USB_SELECTION_FINISH},"
          fi
          if [ "${BTRET}" == "optware" ] ; then
               OUTPUTPAGE="${OUTPUTPAGE}${BS_SELECTION_BEGIN}${BS_SELECTION_OPTWARE}${SELECTION_END}${RENAMESELECT}${SELECTION_FINISH}"
          elif [ "${BTRET}" == "entware" ] ; then
               OUTPUTPAGE="${OUTPUTPAGE}${BS_SELECTION_BEGIN}${BS_SELECTION_ENTWARE}${SELECTION_END}${RENAMESELECT}${SELECTION_FINISH}"
          elif [ "${BTRET}" == "optent" ] ; then
               OUTPUTPAGE="${OUTPUTPAGE}${BS_SELECTION_BEGIN}${BS_SELECTION_OPTWARE}${SELECTION_MID}${BS_SELECTION_ENTWARE}${SELECTION_END}${RENAMESELECT}${SELECTION_FINISH}"
          fi
          OUTPUTPAGE="${OUTPUTPAGE},${LINK_SELECTION}"
          if [ "${BTRET}" == "optware" -o "${BTRET}" == "optent" ] ; then
               OUTPUTPAGE="${OUTPUTPAGE}${PATHPRIO_SELECTION}"
          fi
          if [ -d /opt/VirtualBox ] ; then
               OUTPUTPAGE="${OUTPUTPAGE}${BS_SELECT_INTEGRATEVBOX}"
          fi
          if [ -e /opt ] && [ $(check_bootstrap) == "false" -o -f /Apps/opt/bin/opkg ] ; then
               OPTIN=`/bin/ls -1 /opt | /bin/grep -v "VirtualBox" | /bin/wc -w`
               [ "${OPTIN}" -gt 0 ] && OUTPUTPAGE="${OUTPUTPAGE}${BS_SELECT_INTEGRATE}"
          fi
          OUTPUTPAGE="${OUTPUTPAGE}${SELECTION_FINISH}"
     fi

/bin/cat > ${SYNOPKG_TEMP_LOGFILE} <<EOF
[${OUTPUTPAGE}]
EOF

     exit 0
}

main "$@"
