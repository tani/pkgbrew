#!/bin/sh

set -e

PKGBREW="https://raw.githubusercontent.com/ta2gch/pkgbrew/master/pkgbrew"
PKGHOST="http://ftp.jp.netbsd.org/pub/pkgsrc/stable/pkgsrc.tar.bz2"
PKGHOME="${HOME}/.pkgbrew"
PKGSRC="${PKGHOME}/src"

download(){
    from="${1}"
    dist="${2}"
    case "${from}" in
	https://*) wget -O "${dist}" "${from}" ;;
	http://*) wget -O "${dist}" "${from}" ;;
	*) cp "${from}" "${dist}" ;;
    esac
}

main(){
    
    if [ -d "${PKGHOME}" ]; then
	echo pkgbrew already installed
	exit 1
    fi
	
    workdir=`mktemp -d`

    download "${PKGHOST}" "${workdir}/pkgsrc.tar.bz2" 

    tar --extract                \
	--verbose                \
	--bzip2                  \
	--directory "${workdir}" \
	--file "${workdir}/pkgsrc.tar.bz2"

    prev="${SH}"
    export SH="/bin/bash"
    ${workdir}/pkgsrc/bootstrap/bootstrap \
	--ignore-user-check               \
	--workdir="${workdir}/work"       \
	--prefix="${PKGHOME}"
    export SH="${prev}"

    cp --recursive "${workdir}/pkgsrc" "${PKGSRC}"
    download "${PKGBREW}" "${PKGHOME}/bin/"
    chmod +x "${PKGHOME}/bin/pkgbrew"

    cat<<EOF > "${PKGHOME}/etc/mk.conf"
# Example ${PKGHOME}/etc/mk.conf file produced by pkgbrew
# `date`

.ifdef BSD_PKG_MK	# begin pkgsrc settings

UNPRIVILEGED=		yes
PKG_DBDIR=		${PKGHOME}/var/db/pkg
LOCALBASE=		${PKGHOME}
VARBASE=		${PKGHOME}/var
PKG_TOOLS_BIN=		${PKGHOME}/sbin
PKGINFODIR=		info
PKGMANDIR=		man

TOOLS_PLATFORM.awk?=	${PKGHOME}/bin/nawk
TOOLS_PLATFORM.sh?=	/bin/bash

PKG_DEFAULT_OPTIONS=    -x11 -gtk2 -gkt3 -gnome -kde
.endif			# end pkgsrc settings
EOF
    
}

main
