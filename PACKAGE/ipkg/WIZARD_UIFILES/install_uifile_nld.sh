#!/bin/sh
#********************************************************************#
#  Easy Bootstrap Installer - Part 1                                 #
#  Description: automatic bootstrap installer for synology nas       #
#               language nld                                         #
#  Author:      QTip from the german Synology support forum          #
#  Copyright:   2015-2017 by QTip                                    #
#  License:     GNU GPLv3 (see LICENSE)                              #
#  ----------------------------------------------------------------  #
#  Version:     0.99 - 02/10/2017                                    #
#  for more information check the changelog                          #
#********************************************************************#

PKG_BSTP_INFO_TITLE="Informatie"
PKG_BSTP_SELECT_TITLE="Bootstrap selectie"
PKG_BSTP_SELECT_DESC1="De volgende bootstraps zijn beschikbaar voor"
PKG_BSTP_SELECT_DESC2="uw"
PKG_BSTP_SELECT_DESC3="uw"
PKG_BSTP_SELECT_DESC4=", kies dan het gewenste pakket."
PKG_BSTP_ERROR_TEXT="Gelieve de installatiewizard nu handmatig af te sluiten. Als u de wizard niet toch niet af te sluiten, krijgt u een algemene foutmelding krijgt nadat u de samenvatting van toepassing."
PKG_BSTP_NOUSB_TEXT="Installeer een USB-stick of een SD-kaart voordat u de installatie uit te voeren."
PKG_BSTP_SERVER_NOTAVAIL_TEXT="Deze service is momenteel niet bereikbaar wegens onderhoud of andere dringende dingen, wees geduldig en probeer het later opnieuw!"
PKG_BSTP_NOBSTP_TEXT1="Sorry, geen bootstraps voor"
PKG_BSTP_NOBSTP_TEXT2="Sorry, geen bootstraps voor"
PKG_BSTP_NOBSTP_TEXT3="momenteel beschikbaar!"
PKG_BSTP_REMOVE_SELECT="Verwijder geïnstalleerde bootstrap(s)"
PKG_BSTP_REMOVE_DESC1="Er werd vastgesteld dat een bootstrap is geïnstalleerd. De momenteel geïnstalleerde bootstrap kunnen vooraf worden verwijderd of uitgeschakeld en herbenaam de bronmap (algemeen @optware, @qnapware of @entware)."
PKG_BSTP_REMOVE_DESC2="Voorzichtig: Met geactiveerde optie 'Verwijder geïnstalleerde bootstrap(s)', de vastgestelde bootstrap(s), met uitzondering van de submap 'VirtualBox', permanent worden verwijderd en kan niet worden hersteld na het wissen!"
PKG_BSTP_INTEGRATE_TITLE="Integratie van bestaande bestanden en mappen"
PKG_BSTP_INTEGRATE_SELECT="Integreer bestaande /opt map zonder pakketbeheerder"
PKG_BSTP_INTEGRATE_DESC="Een bestaande / opt map met submappen, maar zonder pakketbeheerder, kan automatisch worden geïntegreerd in de map /opt van de bootstrap. Indien dit niet gewenst is, de bestaande /opt map kan voor het installeren omgedoopt (opt_#tijdstempel#)."
PKG_BSTP_INTEGRATEVBOX_SELECT="Integreer bestaande /opt/VirtualBox map"
PKG_BSTP_INTEGRATEVBOX_DESC="Een bestaande /opt/VirtualBox map wordt automatisch geïntegreerd in de map /opt van de bootstrap. <b>Gelieve te stoppen VirtualBox voordat u verder gaat met de installatie!</b>"
USB_SELECT_TITLE="Doelstation"
USB_SELECT_DESC1="Selecteer het gewenste doelstation."
USB_DESC_SDCARD="SD Kaart"
USB_DESC_USBDISC="USB-Schijf"
USB_DESC_PARTITION="Partitie"
MISC_SELECT_TITLE="Diversen opties"
LINK_SELECT_DESC="Selecteer de gewenste verbinding variant."
LINK_SELECT_VAR1="Symbolische Link"
LINK_SELECT_VAR2="Bind Mount (<b>Opmerking: Opmerking: VirtualBox nodig deze verbinding variant</b>)"
PATHPRIO_SELECT_DESC="Selecteer de gewenste Optware prioriteit pad"
PATHPRIO_SELECT_VAR1="Synology voordat Optware pad - bestanden in Synology pad hebben de voorkeur"
PATHPRIO_SELECT_VAR2="Optware voordat Synology pad - bestanden in Optware pad hebben de voorkeur"

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
